'''
bumps version & generates the changelog
'''

# get environment variables
travis_branch = $TRAVIS_BRANCH
github_token = $GITHUB_PERSONAL_ACCESS_TOKEN
repo_name = $TRAVIS_REPO_SLUG

COMMIT_MESSAGE = "Updating CHANGELOG.md and bumping the version [skip ci]"

if [ $travis_branch == "develop" ]; then

    # Bumps the version
    echo "Bump version"
    node pm_cicd/bump_dev_version.js

    # Generates the changelog
    echo "Generate Changelog"
    node pm_cicd/generate_changelog.js
  
    commit_file() {
      git add *
      git commit --message $COMMIT_MESSAGE
    }

    upload_files() {
      git push "https://policyme:${github_token}@github.com/${repo_name}.git" HEAD:${travis_branch}
    }

    echo "commit & push to git"
    commit_file
    upload_files

fi