# Tatubot

This is a tailored version of GitHub's [hubot](https://hubot.github.com/).

## Capabilities

- release any commit of [tatu-web](https://github.com/stateshifters/tatu-web)
to the respective [beta site](http://beta.tailored-tunes.com) for verification purposes

## Usage
1. Deploy tatu-bot as you like [instructions on hubot's site](https://github.com/github/hubot/tree/master/docs)
2. Set up the required environment variables:
```
HEROKU_TOKEN - The heroku platform api token to use for deploys
GITHUB_USER - The github user who will be able to access the tatu-web repo
GITHUB_TOKEN - The api key associated with the github user
```
3. via the configured adapter, issue:
```
tatubot put <commit_hash> into beta
```
