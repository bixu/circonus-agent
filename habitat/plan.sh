pkg_name=circonus-agent
pkg_origin=bixu
pkg_maintainer="Blake Irvin <blake.irvin@gmail.com>"
pkg_license=("BSD-3")
pkg_source="https://github.com/circonus-labs/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}_${pkg_version}_linux_64-bit.tar.gz"
pkg_shasum="e04eb36dff44f6c6e103337d158fef135f887536cca7c79fe9d3003e25b5159b"
pkg_deps=(
  core/cacerts
  core/coreutils
  core/go
  core/grep
  core/runit
  core/sed
)
pkg_build_deps=()
pkg_bin_dirs=(bin)
pkg_svc_user="root"

pkg_version() {
  git tag --sort="version:refname" | tail --lines=1 | cut --delimiter=v --fields=2
}

do_setup_environment() {
  set_runtime_env SSL_CERT_DIR $(pkg_path_for core/cacerts)/ssl/certs/
  return $?
}

do_build() {
do_before() {
  update_pkg_version
  return $?
}
  return 0
}

do_install() {
  cp -pr $HAB_CACHE_SRC_PATH/sbin/*  $pkg_prefix/bin
  cp -pr $HAB_CACHE_SRC_PATH/etc     $pkg_prefix/etc
  cp -pr $HAB_CACHE_SRC_PATH/plugins $pkg_prefix/plugins
  return $?
}
