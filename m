Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE92D6E41
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942342; cv=none; b=oBXMk6BHPzBayxLJUYaBn+OQ5GNsqTe8kOqI+lLjTllqEhmCLKKCmnZbK+iNn6MSFoEPDFa7LZnuXs/YjUX4X19dDskmZpAkzZ5yPdkAEkv5KrB610sXHmYrO+mE7We38uAAS8t/ysFxAgnU5R25OXbs0Vvez5Bj1aXu5g7+Yao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942342; c=relaxed/simple;
	bh=OAwZaF4rLyfGIGQVRxqd47pTkyI2aWPQ+WWsz0crgWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKEi9/idwKUl2yIcHg136iSZrFLmUYoKt/gaKb6DekuZZcRZtDhv4rmFf6t8Lq/fubfytIM4u4Wf/2FZ2gc6kmyI4bv0tThmECE6rjHK3LQ3mZmS4tc2wjKbNuw7sxCKGQPKH24+LdvCztXEaKdO+IUN4/ZCyNinjiwoMz2GPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 916D01F68E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] build: Add meson build system
Date: Mon, 11 Aug 2025 21:53:43 +0200
Message-ID: <20250811195850.1775759-3-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250811195850.1775759-1-hadess@hadess.net>
References: <20250811195850.1775759-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeffeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpefgveekjedvgeeluddtfeffudehkedukeduvdffheduheejkeehleeiffetudelkeenucffohhmrghinhepmhgvshhonhgsuhhilhgurdgtohhmpdhsvghrvhhitggvrdhinhdpsghluhgviidrnhgvthifohhrkhdpsghluhgviidrmhgvughirgdprhhsthdrihhnnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

The options default were selected to try and match the existing
autotools default as best as possible. Further commits will likely
change those defaults, but at least it should be clear what defaults
were changed from.

However, a number of options were removed:

--enable-pie is replaced by the meson base option "b_pie":
https://mesonbuild.com/Builtin-options.html#base-options

--enable-maintainer-mode is replaced by the "debug" build-types:
https://mesonbuild.com/Builtin-options.html#core-options

--enable-debug and --disable-optimization are replaced by the
debug build type:
https://mesonbuild.com/Builtin-options.html#details-for-buildtype

Each of the sanitisers have their own b_sanitize option:
- asan: b_sanitize=address
- lsan: b_sanitize=leak
- ubsan: b_sanitize=address,undefined
https://mesonbuild.com/Builtin-options.html#base-options

--enable-coverage is replaced by the b_coverage option:
https://mesonbuild.com/Builtin-options.html#base-options

--enable-valgrind can be replicated by running the test suite with:
meson test --setup valgrind
---
 attrib/meson.build           |  17 ++
 btio/meson.build             |   1 +
 client/meson.build           |  54 ++++++
 completion/meson.build       |   3 +
 doc/meson.build              |  41 +++++
 emulator/meson.build         |  34 ++++
 gdbus/meson.build            |  19 ++
 gobex/meson.build            |   8 +
 lib/meson.build              |  55 ++++++
 mesh/meson.build             |  75 ++++++++
 meson.build                  | 281 +++++++++++++++++++++++++++++
 meson_options.txt            |  51 ++++++
 monitor/meson.build          |  47 +++++
 obexd/meson.build            | 121 +++++++++++++
 peripheral/meson.build       |  13 ++
 plugins/meson.build          |  29 +++
 profiles/meson.build         | 170 ++++++++++++++++++
 src/meson.build              | 102 +++++++++++
 src/shared/meson.build       |  80 +++++++++
 test/meson.build             |  41 +++++
 tools/mesh/meson.build       |  16 ++
 tools/meson.build            | 339 +++++++++++++++++++++++++++++++++++
 tools/mpris-proxy.service.in |   2 +-
 unit/meson.build             | 111 ++++++++++++
 24 files changed, 1709 insertions(+), 1 deletion(-)
 create mode 100644 attrib/meson.build
 create mode 100644 btio/meson.build
 create mode 100644 client/meson.build
 create mode 100644 completion/meson.build
 create mode 100644 doc/meson.build
 create mode 100644 emulator/meson.build
 create mode 100644 gdbus/meson.build
 create mode 100644 gobex/meson.build
 create mode 100644 lib/meson.build
 create mode 100644 mesh/meson.build
 create mode 100644 meson.build
 create mode 100644 meson_options.txt
 create mode 100644 monitor/meson.build
 create mode 100644 obexd/meson.build
 create mode 100644 peripheral/meson.build
 create mode 100644 plugins/meson.build
 create mode 100644 profiles/meson.build
 create mode 100644 src/meson.build
 create mode 100644 src/shared/meson.build
 create mode 100644 test/meson.build
 create mode 100644 tools/mesh/meson.build
 create mode 100644 tools/meson.build
 create mode 100644 unit/meson.build

diff --git a/attrib/meson.build b/attrib/meson.build
new file mode 100644
index 000000000000..0b7bc97933db
--- /dev/null
+++ b/attrib/meson.build
@@ -0,0 +1,17 @@
+attrib_sources = files(
+  'att.c',
+  'gatt.c',
+  'gattrib.c'
+)
+
+gatttool_sources = files(
+  'gatttool.c',
+  'att.c',
+  'gatt.c',
+  'gattrib.c',
+  'interactive.c',
+  'utils.c',
+  '../client/display.c',
+  '../btio/btio.c',
+  '../src/log.c'
+)
diff --git a/btio/meson.build b/btio/meson.build
new file mode 100644
index 000000000000..46ae5691f1d8
--- /dev/null
+++ b/btio/meson.build
@@ -0,0 +1 @@
+btio_sources = files('btio.c')
diff --git a/client/meson.build b/client/meson.build
new file mode 100644
index 000000000000..52397d1e17de
--- /dev/null
+++ b/client/meson.build
@@ -0,0 +1,54 @@
+executable('bluetoothctl',
+  sources: [
+    'main.c',
+    'print.c',
+    'display.c',
+    'agent.c',
+    'advertising.c',
+    'adv_monitor.c',
+    'gatt.c',
+    'admin.c',
+    'player.c',
+    'mgmt.c',
+    'assistant.c',
+    'hci.c',
+  ],
+  dependencies: [
+    libbluetooth_internal_dep,
+    libgdbus_internal_dep,
+    libshared_glib_dep,
+    glib_dep,
+    udevlib_dep,
+    dbus_dep,
+    readline_dep
+  ],
+  install: true,
+)
+
+client_man_pages = [
+  'bluetoothctl.1',
+  'bluetoothctl-mgmt.1',
+  'bluetoothctl-monitor.1',
+  'bluetoothctl-admin.1',
+  'bluetoothctl-advertise.1',
+  'bluetoothctl-endpoint.1',
+  'bluetoothctl-gatt.1',
+  'bluetoothctl-player.1',
+  'bluetoothctl-scan.1',
+  'bluetoothctl-transport.1',
+  'bluetoothctl-assistant.1',
+  'bluetoothctl-hci.1'
+]
+
+if get_option('manpages').enabled()
+  foreach man_page: client_man_pages
+    man_page_name = man_page.substring(0, -2)
+    custom_target(man_page,
+      input: man_page_name + '.rst',
+      output: man_page,
+      command: rst2man_command,
+      install: true,
+      install_dir: get_option('mandir') / 'man1'
+    )
+  endforeach
+endif
diff --git a/completion/meson.build b/completion/meson.build
new file mode 100644
index 000000000000..24b71518c67d
--- /dev/null
+++ b/completion/meson.build
@@ -0,0 +1,3 @@
+install_data('zsh/_bluetoothctl',
+  install_dir: zshcompletiondir
+)
diff --git a/doc/meson.build b/doc/meson.build
new file mode 100644
index 000000000000..87bf5bb2a09b
--- /dev/null
+++ b/doc/meson.build
@@ -0,0 +1,41 @@
+man_pages = [
+  'hci.7',
+  'iso.7',
+  'mgmt.7',
+  'l2cap.7',
+  'rfcomm.7',
+  'sco.7',
+  'org.bluez.Adapter.5',
+  'org.bluez.Bearer.LE.5',
+  'org.bluez.Bearer.BREDR.5',
+  'org.bluez.Device.5',
+  'org.bluez.DeviceSet.5',
+  'org.bluez.AgentManager.5',
+  'org.bluez.Agent.5',
+  'org.bluez.ProfileManager.5',
+  'org.bluez.Profile.5',
+  'org.bluez.NetworkServer.5',
+  'org.bluez.Network.5',
+  'org.bluez.Input.5',
+  'org.bluez.BatteryProviderManager.5',
+  'org.bluez.BatteryProvider.5',
+  'org.bluez.Battery.5',
+  'org.bluez.AdminPolicySet.5',
+  'org.bluez.AdminPolicyStatus.5',
+  'org.bluez.Media.5',
+  'org.bluez.MediaControl.5',
+  'org.bluez.MediaPlayer.5',
+  'org.bluez.MediaFolder.5'
+]
+
+foreach man_page: man_pages
+  man_page_name = man_page.substring(0, -2)
+  man_section = man_page.substring(-1)
+  custom_target(man_page,
+    input: man_page_name + '.rst',
+    output: man_page,
+    command: rst2man_command,
+    install: true,
+    install_dir: get_option('mandir') / 'man@0@'.format(man_section)
+  )
+endforeach
diff --git a/emulator/meson.build b/emulator/meson.build
new file mode 100644
index 000000000000..59c72c4dbd4d
--- /dev/null
+++ b/emulator/meson.build
@@ -0,0 +1,34 @@
+emulator_sources = files(
+  'hciemu.c',
+  'vhci.c',
+  'btdev.c',
+  'bthost.c',
+  'smp.c',
+)
+
+if get_option('tests')
+  executable('btvirt',
+    sources: [ 'main.c',
+      'serial.c',
+      'server.c',
+      'vhci.c',
+      'btdev.c',
+      'bthost.c',
+      'smp.c',
+      'phy.c',
+      'le.c' ],
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, glib_dep ]
+  )
+
+  executable('b1ee',
+    sources: 'b1ee.c',
+    include_directories: '../lib',
+    dependencies: libshared_mainloop_dep
+  )
+
+  executable('hfp',
+    sources: 'hfp.c',
+    dependencies: libshared_mainloop_dep
+  )
+endif
+
diff --git a/gdbus/meson.build b/gdbus/meson.build
new file mode 100644
index 000000000000..dc7f2887a60f
--- /dev/null
+++ b/gdbus/meson.build
@@ -0,0 +1,19 @@
+gdbus_sources = [
+  'gdbus.h',
+  'mainloop.c',
+  'watch.c',
+  'object.c',
+  'client.c',
+  'polkit.c'
+]
+
+libgdbus_internal = static_library('gdbus_internal',
+  sources: gdbus_sources,
+  dependencies: [ glib_dep, dbus_dep ],
+  install: false
+)
+
+libgdbus_internal_dep = declare_dependency(
+  dependencies: dbus_dep,
+  link_with: libgdbus_internal
+)
diff --git a/gobex/meson.build b/gobex/meson.build
new file mode 100644
index 000000000000..0ff6238a7b8c
--- /dev/null
+++ b/gobex/meson.build
@@ -0,0 +1,8 @@
+gobex_sources = files(
+  'gobex.c',
+  'gobex-defs.c',
+  'gobex-packet.c',
+  'gobex-header.c',
+  'gobex-transfer.c',
+  'gobex-apparam.c'
+)
diff --git a/lib/meson.build b/lib/meson.build
new file mode 100644
index 000000000000..ef0c7669c273
--- /dev/null
+++ b/lib/meson.build
@@ -0,0 +1,55 @@
+lib_sources = [
+  'bluetooth/bluetooth.c',
+  'bluetooth/hci.c',
+  'bluetooth/sdp.c',
+]
+
+lib_extra_sources = [
+  'bluetooth/uuid.c'
+]
+
+lib_headers = [
+  'bluetooth/bluetooth.h',
+  'bluetooth/hci.h',
+  'bluetooth/hci_lib.h',
+  'bluetooth/sco.h',
+  'bluetooth/l2cap.h',
+  'bluetooth/sdp.h',
+  'bluetooth/sdp_lib.h',
+  'bluetooth/rfcomm.h',
+  'bluetooth/bnep.h',
+  'bluetooth/cmtp.h',
+  'bluetooth/hidp.h'
+  ]
+
+if get_option('library')
+  lib_bluetooth = shared_library('bluetooth',
+    sources: lib_headers + lib_sources,
+    version: '3.19.15',
+    install: true
+  )
+
+  install_headers(lib_headers,
+    subdir: 'bluetooth'
+  )
+
+  pkgconfig = import('pkgconfig')
+  pkgconfig.generate(
+    name: 'bluez',
+    description: 'Bluetooth protocol stack for Linux',
+    version: meson.project_version(),
+    libraries: lib_bluetooth,
+    # FIXME
+    # license: 'GPL-2.0-or-later'
+  )
+endif
+
+libbluetooth_internal = static_library('bluetooth_internal',
+  sources: lib_headers + lib_sources + lib_extra_sources,
+  install: false
+)
+
+libbluetooth_internal_dep = declare_dependency(
+  link_with: libbluetooth_internal,
+  include_directories: '.'
+)
diff --git a/mesh/meson.build b/mesh/meson.build
new file mode 100644
index 000000000000..8c6f5631a9db
--- /dev/null
+++ b/mesh/meson.build
@@ -0,0 +1,75 @@
+if get_option('datafiles')
+  install_data('bluetooth-mesh.conf',
+    install_dir: dbusdir)
+  install_data('mesh-main.conf',
+    install_dir: configdir)
+endif
+
+if get_option('systemd')
+  configure_file(
+    input: 'bluetooth-mesh.service.in',
+    output: 'bluetooth-mesh.service',
+    install: true,
+    install_dir: systemdsystemunitdir,
+    configuration: service_conf
+  )
+  install_data('org.bluez.mesh.service',
+    install_dir: dbussystembusdir
+  )
+endif
+
+executable('bluetooth-meshd',
+  sources: [
+    builtin_h,
+    'main.c',
+    'mesh.c',
+    'net-keys.c',
+    'mesh-io.c',
+    'mesh-mgmt.c',
+    'mesh-io-unit.c',
+    'mesh-io-mgmt.c',
+    'mesh-io-generic.c',
+    'net.c',
+    'crypto.c',
+    'friend.c',
+    'appkey.c',
+    'node.c',
+    'model.c',
+    'cfgmod-server.c',
+    'remprv-server.c',
+    'mesh-config-json.c',
+    'util.c',
+    'dbus.c',
+    'agent.c',
+    'prov-acceptor.c',
+    'prov-initiator.c',
+    'manager.c',
+    'pb-adv.c',
+    'keyring.c',
+    'rpl.c',
+    'prvbeac-server.c'
+  ],
+  include_directories: '../lib',
+  dependencies: [ libshared_ell_dep, jsonc_dep ],
+  c_args: [
+    '-DCONFIGDIR="@0@"'.format(configdir),
+    '-DMESH_STORAGEDIR="@0@"'.format(meshstoragedir)
+  ],
+  install: true,
+  install_dir: pkglibexecdir
+)
+
+if get_option('manpages').enabled()
+  bluetooth_meshd_rst = configure_file(
+    input: 'bluetooth-meshd.rst.in',
+    output: 'bluetooth-meshd.rst',
+    configuration: man_conf
+  )
+  custom_target(
+    input: bluetooth_meshd_rst,
+    output: 'bluetooth-meshd.8',
+    command: rst2man_command,
+    install: true,
+    install_dir: get_option('mandir') / 'man8'
+  )
+endif
diff --git a/meson.build b/meson.build
new file mode 100644
index 000000000000..74af6ac10dc4
--- /dev/null
+++ b/meson.build
@@ -0,0 +1,281 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+project(
+  'bluez', 'c',
+  version: '5.83',
+  license: 'LGPL-2.1-or-later AND GPL-2.0-or-later',
+  meson_version: '>= 1.3.0'
+)
+
+datadir = get_option('datadir')
+storagedir = get_option('localstatedir') / 'lib/bluetooth'
+configdir = get_option('sysconfdir') / 'bluetooth'
+pkglibdir = get_option('libdir') / 'bluetooth'
+pkglibexecdir = get_option('libexecdir') / 'bluetooth'
+meshstoragedir = storagedir / 'mesh'
+
+service_conf = configuration_data()
+service_conf.set('PKGLIBEXECDIR', pkglibexecdir)
+
+add_project_arguments('-DHAVE_CONFIG_H', language: 'c')
+config_h = configuration_data()
+
+cc = meson.get_compiler('c')
+
+required_funcs = [
+  'explicit_bzero',
+  'getrandom',
+  'rawmemchr',
+  'signalfd',
+]
+
+foreach func: required_funcs
+  cc.has_function(func, required: true)
+endforeach
+
+required_lib_funcs = [
+  [ 'clock_gettime', 'rt' ],
+  [ 'pthread_create', 'pthread' ],
+  [ 'dlopen', 'dl' ]
+]
+
+foreach func: required_lib_funcs
+  dep = cc.find_library(func[1], required: true)
+  cc.has_function(func[0], dependencies: dep, required: true)
+endforeach
+
+required_headers = [
+  'stdarg.h',
+  'stdio.h',
+  'string.h',
+  'linux/types.h',
+  'linux/if_alg.h',
+  'linux/uinput.h',
+  'linux/uhid.h',
+  'sys/random.h'
+]
+
+foreach header: required_headers
+  cc.has_header(header, required: true)
+endforeach
+
+# basename may be only available in libgen.h with the POSIX behavior,
+# not desired here
+config_h.set10('HAVE_DECL_BASENAME',
+  cc.has_function('basename', prefix: '#define _GNU_SOURCE 1\n#include <string.h>'))
+
+# Maintainer mode
+if get_option('buildtype').contains('debug')
+  test_cflags = [
+    '-Wno-unused-parameter',
+    '-Wno-missing-field-initializers',
+    '-Wdeclaration-after-statement',
+    '-Wmissing-declarations',
+    '-Wredundant-decls',
+    '-Wcast-align',
+    '-Wswitch-enum',
+    '-Wformat',
+    '-Wformat-security',
+    '-Wstringop-overflow',
+  ]
+
+  if get_option('buildtype') == 'debugoptimized'
+    test_cflags += '-D_FORTIFY_SOURCE=3'
+  endif
+
+  common_flags = [
+    '-DG_DISABLE_DEPRECATED',
+    '-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_36',
+    '-DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_36'
+  ]
+
+  common_flags += cc.get_supported_arguments(test_cflags)
+
+  add_project_arguments(common_flags, language: 'c')
+
+  if get_option('valgrind')
+    config_h.set('HAVE_VALGRIND_MEMCHECK_H',
+      cc.has_header('valgrind/memcheck.h', required: false))
+  endif
+endif
+
+test_cflags = [
+  '-ffunction-sections',
+  '-fdata-sections'
+]
+
+add_project_arguments(cc.get_supported_arguments(test_cflags), language: 'c')
+add_project_arguments('-I' + meson.project_build_root(), language: 'c')
+add_project_arguments('-I' + meson.project_source_root(), language: 'c')
+add_project_link_arguments('-Wl,--gc-sections', language: 'c')
+
+dummy_dep = dependency('dummy', required: false)
+glib_dep = dependency('glib-2.0', version: '>= 2.36')
+dbus_dep = dependency('dbus-1', version:'>= 1.10')
+
+cc.check_header('elfutils/libdwfl.h', required: get_option('backtrace'))
+backtrace_dep = cc.find_library('dw', required: get_option('backtrace'))
+config_h.set('HAVE_BACKTRACE_SUPPORT', backtrace_dep.found())
+
+config_h.set10('HAVE_DECL_SOF_TIMESTAMPING_TX_COMPLETION',
+  cc.has_header_symbol('linux/net_tstamp.h', 'SOF_TIMESTAMPING_TX_COMPLETION'))
+config_h.set10('HAVE_DECL_SCM_TSTAMP_COMPLETION',
+  cc.has_header_symbol('linux/errqueue.h', 'SCM_TSTAMP_COMPLETION', prefix: '#include <time.h>'))
+
+udev_required = get_option('udev').enabled() or
+    get_option('sixaxis') or
+    get_option('hid2hci')
+udev_dep = dependency('udev', version:'>= 196', required: udev_required)
+udevlib_dep = dependency('libudev', required: udev_required)
+
+cups_dep = dependency('cups', required: get_option('cups'))
+jsonc_dep = dependency('json-c', version: '>= 0.13', required: get_option('mesh'))
+alsa_dep = dependency('alsa', required: get_option('midi'))
+ical_dep = dependency('libical', required: get_option('obex'))
+readline_dep = dependency('readline',
+  required: get_option('client').enabled() or
+    get_option('mesh').enabled())
+systemd_dep = dependency('systemd', required: get_option('systemd'))
+libsystemd_dep = dependency('libsystemd', required: get_option('systemd'))
+ell_dep = dependency('ell',
+  version: '>= 0.39',
+  required: get_option('btpclient') or get_option('mesh').enabled(),
+  fallback : ['ell', 'libell_dep'],
+  default_options: [
+    'default_library=static',
+    'tests=false',
+    'cert-tests=false'
+  ]
+)
+
+rst2man = find_program('rst2man', 'rst2man.py', required: get_option('manpages'))
+if rst2man.found()
+  rst2man_command = [
+    rst2man,
+    '--strict',
+    '--no-raw',
+    '--no-generator',
+    '--no-datestamp',
+    '@INPUT@',
+    '@OUTPUT@'
+  ]
+endif
+
+man_conf = configuration_data()
+man_conf.set('CONFIGDIR', get_option('prefix') / configdir)
+man_conf.set('MESH_STORAGEDIR', get_option('prefix') / meshstoragedir)
+
+if get_option('phonebook') == 'ebook'
+  ebook_dep = dependency('libebook-1.2', '>= 3.3', required: true)
+  edataserver_dep = dependency('libedataserver-1.2', '>= 3.3', required: true)
+else
+  ebook_dep = dummy_dep
+  edataserver_dep = dummy_dep
+endif
+
+plugindir = get_option('libdir') / 'bluetooth/plugins'
+
+dbusconfdir = get_option('dbusconfdir')
+if dbusconfdir == ''
+  dbusconfdir = dbus_dep.get_variable('datadir')
+endif
+dbusdir = dbusconfdir / 'dbus-1/system.d'
+
+dbussystembusdir = get_option('dbussystembusdir')
+if dbussystembusdir == ''
+  dbussystembusdir = dbus_dep.get_variable('system_bus_services_dir')
+endif
+
+dbussessionbusdir = get_option('dbussessionbusdir')
+if dbussessionbusdir == ''
+  dbussessionbusdir = dbus_dep.get_variable('session_bus_services_dir')
+endif
+
+service_in = configuration_data()
+service_in.set_quoted('PKGLIBEXECDIR', get_option('prefix') / pkglibexecdir)
+
+if systemd_dep.found()
+  systemdsystemunitdir = get_option('systemdsystemunitdir')
+  if systemdsystemunitdir == ''
+    systemdsystemunitdir = systemd_dep.get_variable('systemdsystemunitdir')
+  endif
+  systemduserunitdir = get_option('systemduserunitdir')
+  if systemduserunitdir == ''
+    systemduserunitdir = systemd_dep.get_variable('systemduserunitdir')
+  endif
+endif
+
+zshcompletiondir = get_option('zsh-completion-dir')
+if zshcompletiondir == ''
+  zshcompletiondir = datadir / 'zsh/site-functions'
+endif
+
+fs = import('fs')
+zsh_completions = fs.is_dir(zshcompletiondir)
+
+if udev_dep.found()
+  udevdir = get_option('udevdir')
+  if udevdir == ''
+    udevdir = udev_dep.get_variable('udevdir')
+  endif
+endif
+
+if cups_dep.found()
+  cups_serverbin = get_option('cups_serverbin')
+  if cups_serverbin == ''
+    cups_serverbin = cups_dep.get_variable('cups_serverbin')
+  endif
+endif
+
+external_plugins_link_args = get_option('external-plugins') ? '-Wl,--export-dynamic' : ''
+
+config_h.set('HAVE_A2DP', get_option('a2dp'))
+config_h.set('HAVE_AVRCP', get_option('avrcp'))
+config_h.set('HAVE_ASHA', get_option('asha'))
+config_h.set10('EXTERNAL_PLUGINS', get_option('external-plugins'))
+config_h.set_quoted('VERSION', meson.project_version())
+
+configure_file(
+  output: 'config.h',
+  configuration: config_h
+)
+
+subdir('lib')
+subdir('gdbus')
+subdir('attrib')
+subdir('btio')
+subdir('plugins')
+subdir('profiles')
+subdir('src')
+subdir('client')
+if get_option('monitor')
+  subdir('monitor')
+endif
+subdir('emulator')
+subdir('gobex')
+subdir('tools')
+subdir('peripheral')
+if get_option('obex').enabled()
+  subdir('obexd')
+endif
+if zsh_completions
+  subdir('completion')
+endif
+if get_option('mesh').enabled()
+  subdir('mesh')
+endif
+if get_option('manpages').enabled()
+  subdir('doc')
+endif
+if get_option('tests')
+  subdir('test')
+  subdir('unit')
+endif
+
+# Fix permissions on install
+install = find_program('install')
+sh = find_program('sh')
+meson.add_install_script(sh, '-c', 'install -dm755 ${DESTDIR}/' + configdir)
+meson.add_install_script(sh, '-c', 'install -dm700 ${DESTDIR}/' + storagedir)
+if get_option('mesh').enabled()
+  meson.add_install_script(sh, '-c', 'install -dm700 ${DESTDIR}/' + meshstoragedir)
+endif
diff --git a/meson_options.txt b/meson_options.txt
new file mode 100644
index 000000000000..2d9231b120ca
--- /dev/null
+++ b/meson_options.txt
@@ -0,0 +1,51 @@
+option('valgrind', type: 'boolean', value: false, description: 'Enable valgrind memory checks')
+option('backtrace', type: 'boolean', value: false, description: 'Enable backtrace support')
+option('library', type: 'boolean', value: true, description: 'Install Bluetooth library')
+option('examples', type: 'boolean', value: false, description: 'Enable test/example scripts')
+option('tests', type: 'boolean', value: false, description: 'Enable testing tools')
+option('tools', type: 'boolean', value: true, description: 'Enable Bluetooth tools')
+option('monitor', type: 'boolean', value: true, description: 'Enable Bluetooth monitor')
+option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
+option('systemd', type: 'boolean', value: true, description: 'Enable systemd integration')
+option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support')
+option('datafiles', type: 'boolean', value: true, description: 'Install configuration and data files')
+option('manpages', type: 'feature', value: 'auto', description: 'Enable building of manual pages')
+option('experimental', type: 'boolean', value: false, description: 'Enable experimental tools')
+option('deprecated', type: 'boolean', value: false, description: 'Enable deprecated tools')
+option('external-plugins', type: 'boolean', value: true, description: 'Enable support for external plugins')
+
+option('dbusconfdir', type: 'string', value: '', description: 'D-Bus configuration directory')
+option('dbussystembusdir', type: 'string', value: '', description: 'D-Bus system bus services dir')
+option('dbussessionbusdir', type:'string', value: '', description: 'D-Bus session bus services dir')
+option('systemdsystemunitdir', type: 'string', value: '', description: 'path to systemd system unit directory')
+option('systemduserunitdir', type: 'string', value: '', description: 'systemd user unit dir')
+option('zsh-completion-dir', type:'string', value: '', description: 'Path to install zsh completions')
+option('udevdir', type: 'string', value: '', description: 'udev directory')
+option('cups_serverbin', type: 'string', value: '', description: 'CUPS directory')
+
+option('nfc', type: 'boolean', value: false, description: 'Enable NFC pairing')
+option('sap', type: 'boolean', value: false, description: 'Enable SAP profile')
+option('a2dp', type: 'boolean', value: true, description: 'Enable A2DP profile')
+option('avrcp', type: 'boolean', value: true, description: 'Enable AVRCP profile')
+option('network', type: 'boolean', value: true, description: 'Enable network profiles')
+option('hid', type: 'boolean', value: true, description: 'Enable HID profile')
+option('hog', type: 'boolean', value: true, description: 'Enable HoG profile')
+option('health', type: 'boolean', value: false, description: 'Enable health profiles')
+option('bap', type: 'boolean', value: true, description: 'Enable BAP profile')
+option('bass', type: 'boolean', value: true, description: 'Enable BASS service')
+option('mcp', type: 'boolean', value: true, description: 'Enable MCP profile')
+option('ccp', type: 'boolean', value: true, description: 'Enable CCP profile')
+option('vcp', type: 'boolean', value: true, description: 'Enable VCP profile')
+option('micp', type: 'boolean', value: true, description: 'Enable MICP profile')
+option('csip', type: 'boolean', value: true, description: 'Enable CSIP profile')
+option('asha', type: 'boolean', value: true, description: 'Enable ASHA support')
+option('cups', type: 'feature', value: 'auto', description: 'Enable CUPS printer support')
+option('mesh', type: 'feature', value: 'auto', description: 'Enable Mesh profile support')
+option('midi', type: 'feature', value: 'auto', description: 'Enable MIDI support')
+option('obex', type: 'feature', value: 'auto', description: 'Enable OBEX profile support')
+option('btpclient', type: 'boolean', value: true, description: 'Enable BTP client')
+option('sixaxis', type: 'boolean', value: true, description: 'Enable sixaxis plugin')
+option('hid2hci', type: 'boolean', value: true, description: 'Enable hid2hci tool')
+option('logger', type: 'boolean', value: false, description: 'Enable HCI logger service')
+option('admin', type: 'boolean', value: true, description: 'Enable admin policy plugin')
+option('phonebook', type: 'combo', choices: [ 'dummy', 'ebook' ], value: 'dummy', description: 'Obexd phonebook plugin')
diff --git a/monitor/meson.build b/monitor/meson.build
new file mode 100644
index 000000000000..ad78e176d978
--- /dev/null
+++ b/monitor/meson.build
@@ -0,0 +1,47 @@
+executable('btmon',
+  sources: [
+    'main.c',
+    'display.c',
+    'hcidump.c',
+    'ellisys.c',
+    'control.c',
+    'packet.c',
+    'vendor.c',
+    'lmp.c',
+    'crc.c',
+    'll.c',
+    'l2cap.c',
+    'sdp.c',
+    'avctp.c',
+    'avdtp.c',
+    'a2dp.c',
+    'rfcomm.c',
+    'bnep.c',
+    'hwdb.c',
+    'keys.c',
+    'analyze.c',
+    'intel.c',
+    'broadcom.c',
+    'msft.c',
+    'jlink.c',
+    'att.c',
+    '../src/log.c',
+    '../src/textfile.c',
+    '../src/settings.c'
+  ],
+  c_args: [
+    '-DSTORAGEDIR="@0"'.format(storagedir)
+  ],
+  dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, udevlib_dep, glib_dep ],
+  install: true
+)
+
+if get_option('manpages').enabled()
+  custom_target(
+    input: 'btmon.rst',
+    output: 'btmon.1',
+    command: rst2man_command,
+    install: true,
+    install_dir: get_option('mandir') / 'man1'
+  )
+endif
diff --git a/obexd/meson.build b/obexd/meson.build
new file mode 100644
index 000000000000..cb658b24ed08
--- /dev/null
+++ b/obexd/meson.build
@@ -0,0 +1,121 @@
+if get_option('datafiles')
+  install_data('src/obex.conf',
+    install_dir: dbusconfdir / 'dbus-1/system.d'
+  )
+endif
+
+if get_option('systemd')
+  configure_file(
+    input: 'src/obex.service.in',
+    output: 'obex.service',
+    install: true,
+    install_dir: systemduserunitdir,
+    configuration: service_conf
+  )
+  configure_file(
+    input: 'src/org.bluez.obex.service.in',
+    output: 'org.bluez.obex.service',
+    install: true,
+    install_dir: dbussessionbusdir,
+    configuration: service_conf
+  )
+  install_symlink('dbus-org.bluez.obex.service',
+    pointing_to: dbussessionbusdir / 'org.bluez.obex.service',
+    install_dir: systemduserunitdir
+  )
+endif
+
+obexd_builtin_modules = [
+  'filesystem',
+  'bluetooth',
+  'opp',
+  'ftp',
+  'irmc',
+  'pbap',
+  'mas',
+  'mns'
+]
+
+obexd_builtin_sources = [
+  'plugins/filesystem.c',
+  'plugins/bluetooth.c',
+  'plugins/opp.c',
+  'plugins/ftp.c',
+  'plugins/irmc.c',
+  'plugins/pbap.c',
+  'plugins/vcard.c',
+  'plugins/phonebook-@0@.c'.format(get_option('phonebook')),
+  'plugins/mas.c',
+  'plugins/messages-dummy.c',
+  'client/mns.c',
+]
+
+if get_option('experimental')
+  obexd_builtin_modules += 'pcsuite'
+  obexd_builtin_sources += 'plugins/pcsuite.c'
+endif
+
+obex_plugindir = get_option('libdir') / 'obex/plugins'
+
+obexd_genbuiltin = find_program('src/genbuiltin')
+obexd_builtin_h = custom_target('obexd-builtin.h',
+  output: 'builtin.h',
+  capture: true,
+  command: [ obexd_genbuiltin, obexd_builtin_modules ]
+)
+
+executable('obexd',
+  sources: [
+    btio_sources,
+    gobex_sources,
+    obexd_builtin_sources,
+    obexd_builtin_h,
+    'src/main.c',
+    'src/plugin.c',
+    'src/log.c',
+    'src/logind.c',
+    'src/manager.c',
+    'src/obex.c',
+    'src/mimetype.c',
+    'src/service.c',
+    'src/transport.c',
+    'src/server.c',
+    'client/manager.c',
+    'client/session.c',
+    'client/bluetooth.c',
+    'client/sync.c',
+    'client/pbap.c',
+    'client/ftp.c',
+    'client/opp.c',
+    'client/map.c',
+    'client/bip.c',
+    'client/bip-common.c',
+    'client/map-event.c',
+    'client/transfer.c',
+    'client/transport.c',
+    'client/driver.c'
+  ],
+  dependencies: [
+    libbluetooth_internal_dep,
+    libgdbus_internal_dep,
+    libshared_glib_dep,
+    ical_dep,
+    dbus_dep,
+    ebook_dep,
+    edataserver_dep,
+    glib_dep,
+    libsystemd_dep.found() ? libsystemd_dep : dummy_dep
+  ],
+  c_args: [
+    '-DOBEX_PLUGIN_BUILTIN',
+    '-DPLUGINDIR="@0@"'.format(obex_plugindir),
+    '-D_FILE_OFFSET_BITS=64',
+    '-DCONFIGDIR="@0@"'.format(configdir),
+    get_option('systemd') ? '-DSYSTEMD' : ''
+  ],
+  link_args: external_plugins_link_args,
+  install: true,
+  install_dir: pkglibexecdir,
+)
+
+
diff --git a/peripheral/meson.build b/peripheral/meson.build
new file mode 100644
index 000000000000..21d6296829ea
--- /dev/null
+++ b/peripheral/meson.build
@@ -0,0 +1,13 @@
+if get_option('tests')
+  executable('btsensor',
+    sources: [
+      'main.c',
+      'efivars.c',
+      'attach.c',
+      'log.c',
+      'gap.c',
+      'gatt.c',
+    ],
+    dependencies: [ libshared_mainloop_dep, libbluetooth_internal_dep ]
+  )
+endif
diff --git a/plugins/meson.build b/plugins/meson.build
new file mode 100644
index 000000000000..019e7083df16
--- /dev/null
+++ b/plugins/meson.build
@@ -0,0 +1,29 @@
+builtin_modules = [
+  'hostname',
+  'autopair',
+  'policy',
+]
+
+builtin_sources = files(
+  'hostname.c',
+  'autopair.c',
+  'policy.c'
+)
+
+builtin_deps = []
+
+if get_option('admin')
+  builtin_modules += 'admin'
+  builtin_sources += files('admin.c')
+endif
+
+if get_option('nfc')
+  builtin_modules += 'neard'
+  builtin_sources += files('neard.c')
+endif
+
+if get_option('sixaxis')
+  builtin_modules += 'sixaxis'
+  builtin_sources += files('sixaxis.c')
+  builtin_deps += udev_dep
+endif
diff --git a/profiles/meson.build b/profiles/meson.build
new file mode 100644
index 000000000000..8ac37b9e6cc8
--- /dev/null
+++ b/profiles/meson.build
@@ -0,0 +1,170 @@
+builtin_modules += [
+  'gap',
+  'scanparam',
+  'deviceinfo',
+  'battery'
+]
+
+builtin_sources += files(
+  'audio/media.c',
+  'audio/transport.c',
+  'audio/player.c',
+  'gap/gas.c',
+  'scanparam/scan.c',
+  'deviceinfo/deviceinfo.c',
+  'battery/battery.c'
+)
+
+if get_option('sap')
+  builtin_modules += 'sap'
+  builtin_sources += files(
+    'sap/main.c',
+    'sap/manager.c',
+    'sap/server.c',
+    'sap/sap-dummy.c'
+  )
+endif
+
+if get_option('a2dp')
+  builtin_modules += 'a2dp'
+  builtin_sources += files(
+    'audio/source.c',
+    'audio/sink.c',
+    'audio/a2dp.c',
+    'audio/avdtp.c'
+  )
+endif
+
+if get_option('avrcp')
+  builtin_modules += 'avrcp'
+  builtin_sources += files(
+    'audio/control.c',
+    'audio/avctp.c',
+    'audio/avctp.c',
+    'audio/avrcp.c'
+  )
+endif
+
+if get_option('network')
+  builtin_modules += 'network'
+  builtin_sources += files(
+    'network/manager.c',
+    'network/bnep.c',
+    'network/server.c',
+    'network/connection.c'
+  )
+  install_data('network/network.conf',
+    install_dir: configdir
+  )
+endif
+
+if get_option('hid')
+  builtin_modules += 'input'
+  builtin_sources += files(
+    'input/manager.c',
+    'input/server.c',
+    'input/device.c'
+  )
+
+  install_data('input/input.conf',
+    install_dir: configdir
+  )
+endif
+
+if get_option('hog')
+  builtin_modules += 'hog'
+  builtin_sources += files(
+    'input/hog.c',
+    'input/hog-lib.c',
+    'deviceinfo/dis.c',
+    'battery/bas.c',
+    'scanparam/scpp.c',
+    'input/suspend-none.c'
+  )
+endif
+
+if get_option('health')
+  builtin_modules += 'health'
+  builtin_sources += files(
+    'health/mcap.c',
+    'health/hdp_main.c',
+    'health/hdp_manager.c',
+    'health/hdp.c',
+    'health/hdp_util.c'
+  )
+endif
+
+if get_option('midi').enabled()
+  builtin_modules += 'midi'
+  builtin_sources += files(
+    'midi/midi.c',
+    'midi/libmidi.c'
+  )
+  builtin_deps += alsa_dep
+endif
+
+if get_option('bap')
+  builtin_modules += 'bap'
+  builtin_sources += files('audio/bap.c')
+endif
+
+if get_option('bass')
+  builtin_modules += 'bass'
+  builtin_sources += files('audio/bass.c')
+endif
+
+if get_option('mcp')
+  builtin_modules += 'mcp'
+  builtin_sources += files('audio/mcp.c')
+endif
+
+if get_option('vcp')
+  builtin_modules += 'vcp'
+  builtin_sources += files('audio/vcp.c')
+endif
+
+if get_option('micp')
+  builtin_modules += 'micp'
+  builtin_sources += files('audio/micp.c')
+endif
+
+if get_option('ccp')
+  builtin_modules += 'ccp'
+  builtin_sources += files('audio/ccp.c')
+endif
+
+if get_option('csip')
+  builtin_modules += 'csip'
+  builtin_sources += files('audio/csip.c')
+endif
+
+if get_option('asha')
+  builtin_modules += 'asha'
+  builtin_sources += files('audio/asha.c')
+endif
+
+if get_option('tools')
+  executable('iapd',
+    sources: 'iap/main.c',
+    dependencies: [ libgdbus_internal_dep, glib_dep, dbus_dep ]
+  )
+endif
+
+if get_option('cups').enabled()
+  executable('bluetooth',
+    sources: [
+      'cups/main.c',
+      'cups/sdp.c',
+      'cups/spp.c',
+      'cups/hcrp.c'
+    ],
+    dependencies: [
+      libbluetooth_internal_dep,
+      libgdbus_internal_dep,
+      glib_dep,
+      dbus_dep
+    ],
+    install: true,
+    install_dir: cups_serverbin / 'backend'
+  )
+endif
diff --git a/src/meson.build b/src/meson.build
new file mode 100644
index 000000000000..3466357bb4e9
--- /dev/null
+++ b/src/meson.build
@@ -0,0 +1,102 @@
+subdir('shared')
+
+if get_option('datafiles')
+  install_data('bluetooth.conf',
+    install_dir: dbusconfdir / 'dbus-1/system.d'
+  )
+  install_data('main.conf',
+    install_dir: configdir
+  )
+endif
+
+if get_option('systemd')
+  configure_file(
+    input: 'bluetooth.service.in',
+    output: 'bluetooth.service',
+    install: true,
+    install_dir: systemdsystemunitdir,
+    configuration: service_conf
+  )
+
+  install_data('org.bluez.service',
+    install_dir: dbussystembusdir
+  )
+endif
+
+genbuiltin = find_program('genbuiltin')
+builtin_h = custom_target('src-builtin.h',
+  output: 'builtin.h',
+  capture: true,
+  command: [ genbuiltin, builtin_modules ]
+)
+
+executable('bluetoothd',
+  sources: [ builtin_sources,
+    attrib_sources,
+    btio_sources,
+    builtin_h,
+    'main.c',
+    'log.c',
+    'backtrace.c',
+    'rfkill.c',
+    'sdpd-server.c',
+    'sdpd-request.c',
+    'sdpd-service.c',
+    'sdpd-database.c',
+    'gatt-database.c',
+    'sdp-xml.c',
+    'sdp-client.c',
+    'textfile.c',
+    'uuid-helper.c',
+    'plugin.c',
+    'storage.c',
+    'advertising.c',
+    'agent.c',
+    'bearer.c',
+    'error.c',
+    'adapter.c',
+    'profile.c',
+    'service.c',
+    'gatt-client.c',
+    'device.c',
+    'dbus-common.c',
+    'eir.c',
+    'adv_monitor.c',
+    'battery.c',
+    'settings.c',
+    'set.c' ],
+  dependencies: [
+    libbluetooth_internal_dep,
+    libgdbus_internal_dep,
+    libshared_glib_dep,
+    backtrace_dep,
+    glib_dep,
+    dbus_dep,
+    udevlib_dep,
+    builtin_deps
+  ],
+  c_args: [
+    '-DBLUETOOTH_PLUGIN_BUILTIN',
+    '-DPLUGINDIR="@0@"'.format(plugindir),
+    '-DSTORAGEDIR="@0@"'.format(storagedir),
+    '-DCONFIGDIR="@0@"'.format(configdir)
+  ],
+  link_args: external_plugins_link_args,
+  install: true,
+  install_dir: pkglibexecdir
+)
+
+if get_option('manpages').enabled()
+  bluetoothd_rst = configure_file(
+    input: 'bluetoothd.rst.in',
+    output: 'bluetoothd.rst',
+    configuration: man_conf
+  )
+  custom_target(
+    input: bluetoothd_rst,
+    output: 'bluetoothd.8',
+    command: rst2man_command,
+    install: true,
+    install_dir: get_option('mandir') / 'man8'
+  )
+endif
diff --git a/src/shared/meson.build b/src/shared/meson.build
new file mode 100644
index 000000000000..5a7f3317ad43
--- /dev/null
+++ b/src/shared/meson.build
@@ -0,0 +1,80 @@
+shared_sources = [
+  'queue.c',
+  'util.c',
+  'mgmt.c',
+  'crypto.c',
+  'ecc.c',
+  'ringbuf.c',
+  'hci.c',
+  'hci-crypto.c',
+  'hfp.c',
+  'uhid.c',
+  'pcap.c',
+  'btsnoop.c',
+  'ad.c',
+  'att.c',
+  'gatt-helpers.c',
+  'gatt-client.c',
+  'gatt-server.c',
+  'gatt-db.c',
+  'gap.c',
+  'log.c',
+  'bap.c',
+  'bap-debug.c',
+  'mcp.c',
+  'vcp.c',
+  'micp.c',
+  'csip.c',
+  'bass.c',
+  'ccp.c',
+  'asha.c'
+]
+
+if readline_dep.found()
+  shared_sources += [ 'shell.c' ]
+endif
+
+libshared_glib = static_library('libshared-glib',
+  sources: [ shared_sources,
+    'io-glib.c',
+    'timeout-glib.c',
+    'mainloop-glib.c',
+    'mainloop-notify.c',
+    'tester.c' ],
+  include_directories: '../../lib',
+  dependencies: glib_dep
+)
+
+libshared_glib_dep = declare_dependency(
+  link_with: libshared_glib,
+  dependencies: glib_dep
+)
+
+libshared_mainloop = static_library('libshared-mainloop',
+  sources: [ shared_sources,
+    'io-mainloop.c',
+    'timeout-mainloop.c',
+    'mainloop.c',
+    'mainloop-notify.c' ],
+  include_directories: '../../lib',
+  dependencies: glib_dep
+)
+
+libshared_mainloop_dep = declare_dependency(
+  link_with: libshared_mainloop
+)
+
+if ell_dep.found()
+  libshared_ell = static_library('libshared-ell',
+    sources: [ shared_sources,
+      'io-ell.c',
+      'timeout-ell.c',
+      'mainloop-ell.c' ],
+    include_directories: [ '../..', '../../lib' ],
+    dependencies: [ glib_dep, ell_dep ]
+  )
+  libshared_ell_dep = declare_dependency(
+    link_with: libshared_ell,
+    dependencies: ell_dep
+  )
+endif
diff --git a/test/meson.build b/test/meson.build
new file mode 100644
index 000000000000..2dad8138865e
--- /dev/null
+++ b/test/meson.build
@@ -0,0 +1,41 @@
+test_scripts = [
+  'sap_client.py',
+  'bluezutils.py',
+  'dbusdef.py',
+  'monitor-bluetooth',
+  'list-devices',
+  'test-discovery',
+  'test-manager',
+  'test-adapter',
+  'test-device',
+  'simple-agent',
+  'simple-endpoint',
+  'test-sap-server',
+  'test-network',
+  'test-profile',
+  'test-health',
+  'test-health-sink',
+  'service-record.dtd',
+  'service-did.xml',
+  'service-spp.xml',
+  'service-opp.xml',
+  'service-ftp.xml',
+  'simple-player',
+  'test-nap',
+  'test-hfp',
+  'opp-client',
+  'ftp-client',
+  'pbap-client',
+  'map-client',
+  'example-advertisement',
+  'example-gatt-server',
+  'example-gatt-client',
+  'test-gatt-profile',
+  'test-mesh',
+  'agent.py'
+]
+
+install_data(
+  sources: test_scripts,
+  install_dir: pkglibdir / 'tests'
+)
diff --git a/tools/mesh/meson.build b/tools/mesh/meson.build
new file mode 100644
index 000000000000..85bfb00977f3
--- /dev/null
+++ b/tools/mesh/meson.build
@@ -0,0 +1,16 @@
+if get_option('tools') and readline_dep.found()
+  executable('mesh-cfgclient',
+    sources: [ '../mesh-cfgclient.c',
+      'cfgcli.c',
+      'keys.c',
+      'util.c',
+      'remote.c',
+      'agent.c',
+      'mesh-db.c',
+      '../../mesh/util.c',
+      '../../mesh/crypto.c',
+    ],
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, ell_dep, dbus_dep, jsonc_dep, readline_dep ],
+    install: true
+  )
+endif
diff --git a/tools/meson.build b/tools/meson.build
new file mode 100644
index 000000000000..59e4f7d52824
--- /dev/null
+++ b/tools/meson.build
@@ -0,0 +1,339 @@
+tools_man_pages = []
+
+if get_option('logger')
+  executable('btmon-logger',
+    [ 'btmon-logger.c' ],
+    dependencies: libshared_mainloop_dep,
+    include_directories: '../lib/',
+    install_dir: pkglibexecdir
+  )
+
+  if get_option('systemd')
+    configure_file(
+      input: 'bluetooth-logger.service.in',
+      output: 'bluetooth-logger.service',
+      configuration: service_in,
+      install: true,
+      install_dir: systemdsystemunitdir
+    )
+  endif
+endif
+
+executable('3dsp',
+  sources: '3dsp.c',
+  dependencies: libshared_mainloop_dep
+)
+
+tester_tools = [
+  'mgmt',
+  'mesh',
+  'l2cap',
+  'rfcomm',
+  'bnep',
+  'smp',
+  'gap',
+  'sco',
+  'userchan',
+  'iso',
+  'ioctl',
+  'hci'
+]
+
+if get_option('tests')
+  foreach tool: tester_tools
+    executable(tool + '-tester',
+      sources: [ tool + '-tester.c', emulator_sources ],
+      dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, libgdbus_internal_dep, glib_dep ]
+    )
+  endforeach
+endif
+
+if get_option('btpclient')
+  executable('btpclient',
+    sources: [ 'btpclient.c', '../src/shared/btp.c' ],
+    include_directories: '..',
+    dependencies: [ libbluetooth_internal_dep, libshared_ell_dep ],
+  )
+  executable('btpclientctl',
+    sources: [ 'btpclientctl.c', '../client/display.c' ],
+    dependencies: [
+      libshared_mainloop_dep,
+      libshared_glib_dep,
+      libbluetooth_internal_dep,
+      readline_dep
+    ]
+  )
+endif
+
+if get_option('hid2hci')
+  executable('hid2hci',
+    sources: 'hid2hci.c',
+    dependencies: udevlib_dep,
+    install: true,
+    install_dir: udevdir
+  )
+  install_data('hid2hci.rules',
+    install_dir: udevdir / 'rules.d',
+    rename: '97-hid2hci.rules'
+  )
+  if get_option('manpages').enabled()
+    tools_man_pages += 'hid2hci.1'
+  endif
+endif
+
+tools_names = [
+  'avinfo',
+  'avtest',
+  'scotest',
+  'hwdb',
+  'hcieventmask',
+  'btinfo',
+  'btconfig',
+  'btsnoop',
+  'btproxy',
+  'cltest',
+  'oobtest',
+  'advtest',
+  'seq2bseq',
+  'nokfw',
+  'rtlfw',
+  'create-image',
+  'eddystone',
+  'ibeacon',
+]
+
+inst_tools_names = [
+  'rctest',
+  'l2test',
+  'l2ping',
+  'bluemoon',
+  'hex2hcd',
+  'mpris-proxy',
+  'btattach',
+  'isotest'
+]
+
+if get_option('tools')
+  foreach tool: tools_names
+    executable(tool,
+      sources: tool + '.c',
+      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep ]
+    )
+  endforeach
+
+  foreach tool: inst_tools_names
+    executable(tool,
+      sources: tool + '.c',
+      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, libgdbus_internal_dep, dbus_dep, glib_dep ],
+      install: true
+    )
+  endforeach
+
+  if get_option('manpages').enabled()
+    tools_man_pages += [
+      'rctest.1',
+      'l2ping.1',
+      'btattach.1',
+      'isotest.1',
+      'btmgmt.1',
+    ]
+  endif
+
+  executable('bdaddr',
+    sources: [ 'bdaddr.c', '../src/oui.c' ],
+    dependencies: [ libbluetooth_internal_dep, udevlib_dep ]
+  )
+  executable('btiotest',
+    sources: [ 'btiotest.c', btio_sources ],
+    dependencies: [ libbluetooth_internal_dep, glib_dep ]
+  )
+  executable('mcaptest',
+    sources: [ 'mcaptest.c', btio_sources, '../src/log.c', '../profiles/health/mcap.c' ],
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, glib_dep ]
+  )
+  executable('bneptest',
+    sources: [ 'bneptest.c', btio_sources, '../src/log.c', '../profiles/network/bnep.c' ],
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, glib_dep ]
+  )
+  executable('btgatt-client',
+    sources: [ 'btgatt-client.c', '../src/uuid-helper.c' ],
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep ]
+  )
+  executable('btgatt-server',
+    sources: [ 'btgatt-server.c', '../src/uuid-helper.c' ],
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep ]
+  )
+  executable('gatt-service',
+    sources: 'gatt-service.c',
+    dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, glib_dep, libgdbus_internal_dep, udevlib_dep ]
+  )
+
+  if readline_dep.found()
+    executable('btmgmt',
+      sources: [ 'btmgmt.c', '../src/uuid-helper.c', '../client/display.c', '../client/mgmt.c' ],
+      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, readline_dep ]
+    )
+    executable('obex-client-tool',
+      sources: [ 'obex-client-tool.c', gobex_sources, btio_sources ],
+      dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep, glib_dep ]
+    )
+    executable('obex-server-tool',
+      sources: [ 'obex-server-tool.c', gobex_sources, btio_sources ],
+      dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, glib_dep ]
+    )
+    executable('bluetooth-player',
+      sources: [ 'bluetooth-player.c', '../client/print.c', '../client/player.c' ],
+      dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, libgdbus_internal_dep, readline_dep ]
+    )
+    executable('obexctl',
+      sources: [ 'obexctl.c' ],
+      dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, libgdbus_internal_dep, readline_dep ]
+    )
+    if get_option('mesh').enabled()
+      executable('mesh-cfgtest',
+        sources: 'mesh-cfgtest.c',
+        dependencies: [ libbluetooth_internal_dep, dbus_dep, ell_dep ],
+        include_directories: '..',
+        install: true
+      )
+      if get_option('deprecated')
+        executable('meshctl',
+          sources: [
+            'meshctl.c',
+            'mesh/agent.c',
+            'mesh-gatt/node.c',
+            'mesh-gatt/gatt.c',
+            'mesh-gatt/crypto.c',
+            'mesh-gatt/net.c',
+            'mesh-gatt/prov.c',
+            'mesh-gatt/util.c',
+            'mesh-gatt/prov-db.c',
+            'mesh-gatt/config-client.c',
+            'mesh-gatt/config-server.c',
+            'mesh-gatt/onoff-model.c'
+            ],
+          dependencies: [
+            libgdbus_internal_dep,
+            libshared_glib_dep,
+            libbluetooth_internal_dep,
+            glib_dep,
+            dbus_dep,
+            jsonc_dep,
+            readline_dep
+            ],
+          install: true
+        )
+      endif
+    endif
+  endif
+
+  if get_option('deprecated')
+    executable('gatttool',
+      sources: gatttool_sources,
+      dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep ],
+    )
+    executable('hciattach',
+      sources: [
+        'hciattach.c',
+        'hciattach_st.c',
+        'hciattach_ti.c',
+        'hciattach_tialt.c',
+        'hciattach_ath3k.c',
+        'hciattach_qualcomm.c',
+        'hciattach_intel.c',
+        'hciattach_bcm43xx.c'
+      ],
+      dependencies: libbluetooth_internal_dep,
+      install: true
+    )
+    executable('hcidump',
+      sources: [
+        'hcidump.c',
+        'parser/parser.c',
+        'parser/lmp.c',
+        'parser/hci.c',
+        'parser/l2cap.c',
+        'parser/smp.c',
+        'parser/att.c',
+        'parser/sdp.c',
+        'parser/rfcomm.c',
+        'parser/bnep.c',
+        'parser/cmtp.c',
+        'parser/hidp.c',
+        'parser/hcrp.c',
+        'parser/avdtp.c',
+        'parser/avctp.c',
+        'parser/avrcp.c',
+        'parser/sap.c',
+        'parser/obex.c',
+        'parser/capi.c',
+        'parser/ppp.c',
+        'parser/tcpip.c',
+        'parser/ericsson.c',
+        'parser/csr.c',
+        'parser/bpa.c'
+      ],
+      dependencies: libbluetooth_internal_dep,
+      install: true
+    )
+    executable('hcitool',
+      sources: [ 'hcitool.c', '../src/oui.c' ],
+      dependencies: [ libbluetooth_internal_dep, udevlib_dep ],
+      install: true
+    )
+    executable('sdptool',
+      sources: [ 'sdptool.c', '../src/sdp-xml.c' ],
+      dependencies: [ libbluetooth_internal_dep, glib_dep ],
+      install: true
+    )
+    deprecated_tools = [
+      'ciptool',
+      'hciconfig',
+      'rfcomm'
+    ]
+    foreach tool: deprecated_tools
+      executable(tool,
+        sources: tool + '.c',
+        dependencies: libbluetooth_internal_dep,
+        install: true
+      )
+    endforeach
+
+    if get_option('manpages').enabled()
+      tools_man_pages += [
+        'hciattach.1',
+        'hciconfig.1',
+        'hcitool.1',
+        'hcidump.1',
+        'rfcomm.1',
+        'sdptool.1',
+        'ciptool.1',
+      ]
+    endif
+  endif
+
+  if get_option('systemd')
+    configure_file(
+      input: 'mpris-proxy.service.in',
+      output: 'mpris-proxy.service',
+      configuration: service_in,
+      install: true,
+      install_dir: systemduserunitdir
+    )
+  endif
+endif
+
+if get_option('mesh').enabled()
+  subdir('mesh')
+endif
+
+foreach man_page: tools_man_pages
+  man_page_name = man_page.substring(0, -2)
+  custom_target(man_page,
+    input: man_page_name + '.rst',
+    output: man_page,
+    command: rst2man_command,
+    install: true,
+    install_dir: get_option('mandir') / 'man1'
+  )
+endforeach
diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
index 6ae56c6720b9..a55f0254014a 100644
--- a/tools/mpris-proxy.service.in
+++ b/tools/mpris-proxy.service.in
@@ -8,7 +8,7 @@ ConditionUser=!@system
 
 [Service]
 Type=simple
-ExecStart=@PKGBINDIR@/mpris-proxy
+ExecStart=@PKGLIBEXECDIR@/mpris-proxy
 
 [Install]
 WantedBy=default.target
diff --git a/unit/meson.build b/unit/meson.build
new file mode 100644
index 000000000000..cf3e80d69439
--- /dev/null
+++ b/unit/meson.build
@@ -0,0 +1,111 @@
+
+tests1 = [
+  [ 'test-tester.c' ],
+  [ 'test-uuid.c' ],
+  [ 'test-eir.c', '../src/eir.c', '../src/uuid-helper.c' ],
+  [ 'test-sdp.c', '../src/sdpd-database.c', '../src/log.c', '../src/sdpd-service.c', '../src/sdpd-request.c' ],
+  [ 'test-avrcp.c', '../src/log.c', 'avctp.c', 'avrcp-lib.c' ],
+  [ 'test-lib.c' ],
+  [ 'test-gatt.c' ],
+  [ 'test-bap.c' ],
+  [ 'test-micp.c' ],
+  [ 'test-bass.c' ],
+  [ 'test-vcp.c' ],
+  [ 'test-hog.c',
+    btio_sources,
+    '../profiles/input/hog-lib.c',
+    '../profiles/scanparam/scpp.c',
+    '../profiles/battery/bas.c',
+    '../profiles/deviceinfo/dis.c',
+    '../src/log.c',
+    '../attrib/att.c',
+    '../attrib/gatt.c',
+    '../attrib/gattrib.c'
+  ],
+]
+
+foreach t: tests1
+  test_name = t[0].substring(0, -2)
+  exe = executable(test_name,
+    sources: t,
+    dependencies: [ libshared_glib_dep, libbluetooth_internal_dep ],
+  )
+  test(test_name, exe)
+endforeach
+
+tests2 = [
+  [ 'test-textfile.c', '../src/textfile.c' ],
+  [ 'test-crc.c', '../monitor/crc.c' ],
+  [ 'test-crypto.c' ],
+  [ 'test-ecc.c' ],
+  [ 'test-ringbuf.c' ],
+  [ 'test-queue.c' ],
+  [ 'test-mgmt.c' ],
+  [ 'test-uhid.c' ],
+  [ 'test-hfp.c' ],
+  [ 'test-avdtp.c', '../src/log.c', 'avdtp.c' ],
+  [ 'test-avctp.c', '../src/log.c', 'avctp.c' ],
+]
+
+if get_option('obex').enabled()
+  tests2 += [
+    [ 'test-gobex.c', 'util.c', gobex_sources ],
+    [ 'test-gobex-packet.c', 'util.c', gobex_sources ],
+    [ 'test-gobex-header.c', 'util.c', gobex_sources ],
+    [ 'test-gobex-transfer.c', 'util.c', gobex_sources ],
+    [ 'test-gobex-apparam.c', 'util.c', gobex_sources ],
+  ]
+endif
+
+foreach t: tests2
+  test_name = t[0].substring(0, -2)
+  exe = executable(test_name,
+    sources: t,
+    c_args: [ '-DSTORAGEDIR="@0"'.format(storagedir) ],
+    include_directories: '../lib',
+    dependencies: libshared_glib_dep
+  )
+  test(test_name, exe)
+endforeach
+
+# FIXME
+# run under 'dbus-run-session --' if available
+exe = executable('test-gdbus-client',
+  sources: 'test-gdbus-client.c',
+  dependencies: [ libgdbus_internal_dep, libshared_glib_dep ]
+)
+test('test-gdbus-client', exe)
+
+exe = executable('test-gattrib',
+  sources: [ 'test-gattrib.c', '../attrib/gattrib.c', btio_sources, '../src/log.c' ],
+  dependencies: [ libshared_glib_dep, libbluetooth_internal_dep ]
+)
+test('test-gattrib', exe)
+
+if get_option('midi').enabled()
+  exe = executable('test-midi',
+    sources: [ 'test-midi.c', '../profiles/midi/libmidi.c' ],
+    c_args: [ '-DMIDI_TEST' ],
+    dependencies: [ libshared_glib_dep, alsa_dep ]
+  )
+  test('test-midi', exe)
+endif
+
+if get_option('mesh').enabled()
+  exe = executable('test-mesh-crypto',
+    sources: [ 'test-mesh-crypto.c' ],
+    dependencies: [ ell_dep ]
+  )
+  test('test-mesh-crypto', exe)
+endif
+
+add_test_setup(
+  'valgrind',
+  exe_wrapper: [
+    'valgrind', '--quiet', '--leak-check=full', '--trace-children=yes',
+    '--suppressions=@0@'.format(meson.current_source_dir() / 'valgrind.supp'),
+    '--num-callers=30', '--show-reachable=no', '--error-exitcode=1',
+  ],
+  # default timeout in meson is 30s
+  timeout_multiplier: 4,
+)
-- 
2.50.0

