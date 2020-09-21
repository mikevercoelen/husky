# Exit on error
set -eu

function title {
  echo
  echo "-------------------"
  echo "+ $1"
  echo "-------------------"
  echo
}

# Create $1 and install tgz
function install_tgz {
  # generated by pretest script
  tgz="./husky-*.tgz"

  # Create directory
  mkdir -p $1

  # Install
  cp $tgz $1
  cd $1 && npm init -y && npm install $tgz
}

function init_git {
  git init
  git config user.email "test@test"
  git config user.name "test"
}

function test_hooksPath {
  readonly hooksPath=`git config core.hooksPath`
  if [ "$hooksPath" != "$1" ]; then
    echo -e "\e[0;31mERROR:\e[m core.hooksPath should be $1, was $hooksPath"
    exit 1
  fi
}
