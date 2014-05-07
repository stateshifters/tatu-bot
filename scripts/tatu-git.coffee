# Description:
#   [TATU]: allows the team to release to beta without the need to know how to release
#
# Dependencies:
#   None
#
# Configuration:
#   HEROKU_TOKEN - The heroku platform api token
#   GITHUB_USER - The github user who will be able to access the repo
#   GITHUB_TOKEN - The api key associated with the github user
#
# Commands:
#   hubot put <commit_hash> into beta - [TATU] Deploys the given commit to beta
#
# Notes:
#   None
#
# Author:
#   meza

heroku_token = process.env.HEROKU_TOKEN
github_user = process.env.GITHUB_USER
github_token = process.env.GITHUB_TOKEN

module.exports = (robot) ->

  robot.respond /put ([^\\s]*) into beta/i, (msg) ->
    commit = msg.match[1]

    data = JSON.stringify({
      source_blob: {
        url: "https://"+github_user+":"+github_token+"@github.com/stateshifters/tatu-web/archive/"+commit+".tar.gz",
        version: commit
      }
    })


    robot.http("https://api.heroku.com/apps/tatu-stage/builds")
      .header("Authorization", heroku_token)
      .header("Accept", "application/vnd.heroku+json; version=3")
      .header("Content-Type", "application/json")
      .post(data) (err, res, body) ->
        if err
          msg.send "Encountered an error :( #{err}"
          return
        if res.statusCode isnt 201
          msg.send "Sorry, I couldn't deploy :("
          return
        msg.send "Build in progress... May the odds be ever in your favour!"
