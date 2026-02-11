Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC02212FAD
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813970; cv=none; b=JJhhGXFIwx+bMl5YinLoyu1O43PL7LoQjwQRrLSm7p8DXAsn3c69WazneE3CTgD6k/yVpI7/XJz+sY8NYI5CXjDWOgYRqGqO3qDDkvPppDPhtFjzViIKMsV9CNX0flYc+FGXPYjIN0MzT99i/GSEEyBv5ThsjYYY6/EjATYvg30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813970; c=relaxed/simple;
	bh=IWhqpV6NSL5IGpoiSzUW2B2KgmBEM7goNKmObPNGq5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swnExWvUyBY4VJxQ/XQ9OjYEDO+b0XjMaf00P1y7DagRTEsy4tFV0A1F57vcPI6ZuQ6D8XxN70bzSZC5XDpawxjimHGWvZDzArPGsxBZlbaNlKuHJz40S5t22SIEXLjwqDROqw9Pu2G03vvThtMI0Zzd1u2S/RBmvynMIkH5ay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19BFE441EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:46:00 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 03/15] build: Make more use of 'feature' options
Date: Wed, 11 Feb 2026 13:41:59 +0100
Message-ID: <20260211124550.3830639-4-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211124550.3830639-1-hadess@hadess.net>
References: <20260211124550.3830639-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevhfffgffgjeekueeihfdtffefuefgkefhieehfeevhedtvdejfeevvdfffeefveenucffohhmrghinhepshgvrhhvihgtvgdrihhnnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepudeluefhgfeggedugfetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

This allows finer control around what is built and what is not,
trying to build as much as possible by default.

This also makes it easier to enable all the "auto" features which would
then fail if dependencies are missing (maximalist builds, for testing),
or disable everything by default, and only enable select options, which
minimises side-effects for distributions.
---
 doc/meson.build        |  8 +++---
 emulator/meson.build   |  2 +-
 lib/meson.build        |  2 +-
 mesh/meson.build       |  4 +--
 meson.build            | 28 +++++++++----------
 meson_options.txt      | 62 +++++++++++++++++++++---------------------
 obexd/meson.build      |  8 +++---
 peripheral/meson.build |  2 +-
 plugins/meson.build    |  6 ++--
 profiles/meson.build   | 30 ++++++++++----------
 src/meson.build        |  4 +--
 tools/mesh/meson.build |  2 +-
 tools/meson.build      | 36 ++++++------------------
 unit/meson.build       |  4 +--
 14 files changed, 89 insertions(+), 109 deletions(-)

diff --git a/doc/meson.build b/doc/meson.build
index ca9fbb4e6fdb..a991dfe26195 100644
--- a/doc/meson.build
+++ b/doc/meson.build
@@ -64,7 +64,7 @@ endif
 
 monitor_man_pages = [ 'btmon.1' ]
 
-if get_option('monitor')
+if get_option('monitor').enabled()
   man_pages += monitor_man_pages
 endif
 
@@ -78,7 +78,7 @@ tools_man_pages = [
 
 noinst_tools_man_pages = [ 'btmgmt.1' ]
 
-if get_option('tools')
+if get_option('tools').enabled()
   man_pages += tools_man_pages
   man_pages += noinst_tools_man_pages
 endif
@@ -93,13 +93,13 @@ deprecated_tools_man_pages = [
   'ciptool.1',
 ]
 
-if get_option('deprecated')
+if get_option('deprecated').enabled()
   man_pages += deprecated_tools_man_pages
 endif
 
 hid2hci_man_pages = [ 'hid2hci.1' ]
 
-if get_option('hid2hci')
+if get_option('hid2hci').enabled()
   man_pages += 'hid2hci.1'
 endif
 
diff --git a/emulator/meson.build b/emulator/meson.build
index 59c72c4dbd4d..bc038becc567 100644
--- a/emulator/meson.build
+++ b/emulator/meson.build
@@ -6,7 +6,7 @@ emulator_sources = files(
   'smp.c',
 )
 
-if get_option('tests')
+if get_option('tests').enabled()
   executable('btvirt',
     sources: [ 'main.c',
       'serial.c',
diff --git a/lib/meson.build b/lib/meson.build
index f31c8c3a58c5..aac809ab1c70 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -22,7 +22,7 @@ lib_headers = [
   'bluetooth/hidp.h'
   ]
 
-if get_option('library')
+if get_option('library').enabled()
   lib_bluetooth = shared_library('bluetooth',
     sources: lib_headers + lib_sources,
     version: '3.19.15',
diff --git a/mesh/meson.build b/mesh/meson.build
index ac01b7025457..b954dccfe1ef 100644
--- a/mesh/meson.build
+++ b/mesh/meson.build
@@ -1,11 +1,11 @@
-if get_option('datafiles')
+if get_option('datafiles').enabled()
   install_data('bluetooth-mesh.conf',
     install_dir: dbusdir)
   install_data('mesh-main.conf',
     install_dir: configdir)
 endif
 
-if get_option('systemd')
+if systemd_dep.found()
   configure_file(
     input: 'bluetooth-mesh.service.in',
     output: 'bluetooth-mesh.service',
diff --git a/meson.build b/meson.build
index 3473ed64ee90..c4b48194b62a 100644
--- a/meson.build
+++ b/meson.build
@@ -95,10 +95,8 @@ if get_option('buildtype').contains('debug')
 
   add_project_arguments(common_flags, language: 'c')
 
-  if get_option('valgrind')
-    config_h.set('HAVE_VALGRIND_MEMCHECK_H',
-      cc.has_header('valgrind/memcheck.h', required: false))
-  endif
+  config_h.set('HAVE_VALGRIND_MEMCHECK_H',
+    cc.has_header('valgrind/memcheck.h', required: get_option('valgrind').enabled()))
 endif
 
 test_cflags = [
@@ -124,7 +122,7 @@ config_h.set10('HAVE_DECL_SOF_TIMESTAMPING_TX_COMPLETION',
 config_h.set10('HAVE_DECL_SCM_TSTAMP_COMPLETION',
   cc.has_header_symbol('linux/errqueue.h', 'SCM_TSTAMP_COMPLETION', prefix: '#include <time.h>'))
 
-udev_required = get_option('udev').enabled() or get_option('sixaxis') or get_option('hid2hci')
+udev_required = get_option('udev').enabled() or get_option('sixaxis').enabled() or get_option('hid2hci').enabled()
 udev_dep = dependency('udev', version:'>= 196', required: udev_required)
 udevlib_dep = dependency('libudev', required: udev_required)
 
@@ -139,7 +137,7 @@ systemd_dep = dependency('systemd', required: get_option('systemd'))
 libsystemd_dep = dependency('libsystemd', required: get_option('systemd'))
 ell_dep = dependency('ell',
   version: '>= 0.39',
-  required: get_option('btpclient') or get_option('mesh').enabled(),
+  required: get_option('btpclient').enabled() or get_option('mesh').enabled(),
   fallback : ['ell', 'libell_dep'],
   default_options: [
     'default_library=static',
@@ -228,18 +226,18 @@ if cups_dep.found()
 endif
 
 external_plugins_link_args = ''
-if get_option('external-plugins')
+if get_option('external-plugins').enabled()
   external_plugins_link_args = [
     '-Wl,--export-dynamic',
     '-Wl,--version-script=' + meson.project_source_root() / 'src/bluetooth.ver'
   ]
 endif
 
-config_h.set('HAVE_A2DP', get_option('a2dp'))
-config_h.set('HAVE_AVRCP', get_option('avrcp'))
-config_h.set('HAVE_ASHA', get_option('asha'))
-config_h.set('HAVE_VCP', get_option('vcp'))
-config_h.set10('EXTERNAL_PLUGINS', get_option('external-plugins'))
+config_h.set('HAVE_A2DP', get_option('a2dp').enabled())
+config_h.set('HAVE_AVRCP', get_option('avrcp').enabled())
+config_h.set('HAVE_ASHA', get_option('asha').enabled())
+config_h.set('HAVE_VCP', get_option('vcp').enabled())
+config_h.set10('EXTERNAL_PLUGINS', get_option('external-plugins').enabled())
 config_h.set_quoted('VERSION', meson.project_version())
 
 configure_file(
@@ -255,7 +253,7 @@ subdir('plugins')
 subdir('profiles')
 subdir('src')
 subdir('client')
-if get_option('monitor')
+if get_option('monitor').enabled()
   subdir('monitor')
 endif
 subdir('emulator')
@@ -271,10 +269,10 @@ endif
 if get_option('mesh').enabled()
   subdir('mesh')
 endif
-if get_option('manpages').enabled()
+if rst2man.found()
   subdir('doc')
 endif
-if get_option('tests')
+if not get_option('tests').disabled()
   subdir('test')
   subdir('unit')
 endif
diff --git a/meson_options.txt b/meson_options.txt
index c0a2d35e3b84..66abdcb1c145 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,18 +1,18 @@
-option('valgrind', type: 'boolean', value: false, description: 'Enable valgrind memory checks')
-option('backtrace', type: 'boolean', value: false, description: 'Enable backtrace support')
-option('library', type: 'boolean', value: true, description: 'Install Bluetooth library')
-option('examples', type: 'boolean', value: false, description: 'Enable test/example scripts')
-option('tests', type: 'boolean', value: false, description: 'Enable testing tools')
-option('tools', type: 'boolean', value: true, description: 'Enable Bluetooth tools')
-option('monitor', type: 'boolean', value: true, description: 'Enable Bluetooth monitor')
+option('valgrind', type: 'feature', value: 'disabled', description: 'Enable valgrind memory checks')
+option('backtrace', type: 'feature', value: 'disabled', description: 'Enable backtrace support')
+option('library', type: 'feature', value: 'enabled', description: 'Install Bluetooth library')
+option('examples', type: 'feature', value: 'auto', description: 'Enable test/example scripts')
+option('tests', type: 'feature', value: 'auto', description: 'Enable testing tools')
+option('tools', type: 'feature', value: 'enabled', description: 'Enable Bluetooth tools')
+option('monitor', type: 'feature', value: 'enabled', description: 'Enable Bluetooth monitor')
 option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
-option('systemd', type: 'boolean', value: true, description: 'Enable systemd integration')
+option('systemd', type: 'feature', value: 'enabled', description: 'Enable systemd integration')
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support')
-option('datafiles', type: 'boolean', value: true, description: 'Install configuration and data files')
+option('datafiles', type: 'feature', value: 'enabled', description: 'Install configuration and data files')
 option('manpages', type: 'feature', value: 'auto', description: 'Enable building of manual pages')
-option('experimental', type: 'boolean', value: false, description: 'Enable experimental tools')
-option('deprecated', type: 'boolean', value: false, description: 'Enable deprecated tools')
-option('external-plugins', type: 'boolean', value: true, description: 'Enable support for external plugins')
+option('experimental', type: 'feature', value: 'disabled', description: 'Enable experimental tools')
+option('deprecated', type: 'feature', value: 'disabled', description: 'Enable deprecated tools')
+option('external-plugins', type: 'feature', value: 'enabled', description: 'Enable support for external plugins')
 
 option('dbusconfdir', type: 'string', value: '', description: 'D-Bus configuration directory')
 option('dbussystembusdir', type: 'string', value: '', description: 'D-Bus system bus services dir')
@@ -23,20 +23,20 @@ option('zsh-completion-dir', type:'string', value: '', description: 'Path to ins
 option('udevdir', type: 'string', value: '', description: 'udev directory')
 option('cups_serverbin', type: 'string', value: '', description: 'CUPS directory')
 
-option('nfc', type: 'boolean', value: false, description: 'Enable NFC pairing')
-option('a2dp', type: 'boolean', value: true, description: 'Enable A2DP profile')
-option('avrcp', type: 'boolean', value: true, description: 'Enable AVRCP profile')
-option('network', type: 'boolean', value: true, description: 'Enable network profiles')
-option('hid', type: 'boolean', value: true, description: 'Enable HID profile')
-option('hog', type: 'boolean', value: true, description: 'Enable HoG profile')
-option('bap', type: 'boolean', value: true, description: 'Enable BAP profile')
-option('bass', type: 'boolean', value: true, description: 'Enable BASS service')
-option('mcp', type: 'boolean', value: true, description: 'Enable MCP profile')
-option('ccp', type: 'boolean', value: true, description: 'Enable CCP profile')
-option('vcp', type: 'boolean', value: true, description: 'Enable VCP profile')
-option('micp', type: 'boolean', value: true, description: 'Enable MICP profile')
-option('csip', type: 'boolean', value: true, description: 'Enable CSIP profile')
-option('asha', type: 'boolean', value: true, description: 'Enable ASHA support')
+option('nfc', type: 'feature', value: 'disabled', description: 'Enable NFC pairing')
+option('a2dp', type: 'feature', value: 'auto', description: 'Enable A2DP profile')
+option('avrcp', type: 'feature', value: 'auto', description: 'Enable AVRCP profile')
+option('network', type: 'feature', value: 'auto', description: 'Enable network profiles')
+option('hid', type: 'feature', value: 'auto', description: 'Enable HID profile')
+option('hog', type: 'feature', value: 'auto', description: 'Enable HoG profile')
+option('bap', type: 'feature', value: 'auto', description: 'Enable BAP profile')
+option('bass', type: 'feature', value: 'auto', description: 'Enable BASS service')
+option('mcp', type: 'feature', value: 'auto', description: 'Enable MCP profile')
+option('ccp', type: 'feature', value: 'auto', description: 'Enable CCP profile')
+option('vcp', type: 'feature', value: 'auto', description: 'Enable VCP profile')
+option('micp', type: 'feature', value: 'auto', description: 'Enable MICP profile')
+option('csip', type: 'feature', value: 'auto', description: 'Enable CSIP profile')
+option('asha', type: 'feature', value: 'auto', description: 'Enable ASHA support')
 option('cups', type: 'feature', value: 'auto', description: 'Enable CUPS printer support')
 option('mesh', type: 'feature', value: 'auto', description: 'Enable Mesh profile support')
 option('midi', type: 'feature', value: 'auto', description: 'Enable MIDI support')
@@ -44,9 +44,9 @@ option('obex', type: 'feature', value: 'auto', description: 'Enable OBEX profile
 option('tmap', type: 'feature', value: 'auto', description: 'Enable TMAP profile support')
 option('gmap', type: 'feature', value: 'auto', description: 'Enable GMAP profile support')
 option('hfp', type: 'feature', value: 'auto', description: 'Enable HFP profile support')
-option('btpclient', type: 'boolean', value: true, description: 'Enable BTP client')
-option('sixaxis', type: 'boolean', value: true, description: 'Enable sixaxis plugin')
-option('hid2hci', type: 'boolean', value: true, description: 'Enable hid2hci tool')
-option('logger', type: 'boolean', value: false, description: 'Enable HCI logger service')
-option('admin', type: 'boolean', value: true, description: 'Enable admin policy plugin')
+option('btpclient', type: 'feature', value: 'auto', description: 'Enable BTP client')
+option('sixaxis', type: 'feature', value: 'auto', description: 'Enable sixaxis plugin')
+option('hid2hci', type: 'feature', value: 'auto', description: 'Enable hid2hci tool')
+option('logger', type: 'feature', value: 'disabled', description: 'Enable HCI logger service')
+option('admin', type: 'feature', value: 'auto', description: 'Enable admin policy plugin')
 option('phonebook', type: 'combo', choices: [ 'dummy', 'ebook' ], value: 'dummy', description: 'Obexd phonebook plugin')
diff --git a/obexd/meson.build b/obexd/meson.build
index cb658b24ed08..30952590f54d 100644
--- a/obexd/meson.build
+++ b/obexd/meson.build
@@ -1,10 +1,10 @@
-if get_option('datafiles')
+if get_option('datafiles').enabled()
   install_data('src/obex.conf',
     install_dir: dbusconfdir / 'dbus-1/system.d'
   )
 endif
 
-if get_option('systemd')
+if systemd_dep.found()
   configure_file(
     input: 'src/obex.service.in',
     output: 'obex.service',
@@ -50,7 +50,7 @@ obexd_builtin_sources = [
   'client/mns.c',
 ]
 
-if get_option('experimental')
+if get_option('experimental').enabled()
   obexd_builtin_modules += 'pcsuite'
   obexd_builtin_sources += 'plugins/pcsuite.c'
 endif
@@ -111,7 +111,7 @@ executable('obexd',
     '-DPLUGINDIR="@0@"'.format(obex_plugindir),
     '-D_FILE_OFFSET_BITS=64',
     '-DCONFIGDIR="@0@"'.format(configdir),
-    get_option('systemd') ? '-DSYSTEMD' : ''
+    libsystemd_dep.found() ? '-DSYSTEMD' : ''
   ],
   link_args: external_plugins_link_args,
   install: true,
diff --git a/peripheral/meson.build b/peripheral/meson.build
index 21d6296829ea..31e5435763ef 100644
--- a/peripheral/meson.build
+++ b/peripheral/meson.build
@@ -1,4 +1,4 @@
-if get_option('tests')
+if get_option('tests').enabled()
   executable('btsensor',
     sources: [
       'main.c',
diff --git a/plugins/meson.build b/plugins/meson.build
index 019e7083df16..5485ef8eca44 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -12,17 +12,17 @@ builtin_sources = files(
 
 builtin_deps = []
 
-if get_option('admin')
+if get_option('admin').enabled()
   builtin_modules += 'admin'
   builtin_sources += files('admin.c')
 endif
 
-if get_option('nfc')
+if get_option('nfc').enabled()
   builtin_modules += 'neard'
   builtin_sources += files('neard.c')
 endif
 
-if get_option('sixaxis')
+if get_option('sixaxis').enabled()
   builtin_modules += 'sixaxis'
   builtin_sources += files('sixaxis.c')
   builtin_deps += udev_dep
diff --git a/profiles/meson.build b/profiles/meson.build
index 9d4c39c78a52..c77687a04e8e 100644
--- a/profiles/meson.build
+++ b/profiles/meson.build
@@ -18,7 +18,7 @@ builtin_sources += files(
   'ranging/rap.c',
 )
 
-if get_option('a2dp')
+if get_option('a2dp').enabled()
   builtin_modules += 'a2dp'
   builtin_sources += files(
     'audio/source.c',
@@ -28,7 +28,7 @@ if get_option('a2dp')
   )
 endif
 
-if get_option('avrcp')
+if get_option('avrcp').enabled()
   builtin_modules += 'avrcp'
   builtin_sources += files(
     'audio/control.c',
@@ -38,7 +38,7 @@ if get_option('avrcp')
   )
 endif
 
-if get_option('network')
+if get_option('network').enabled()
   builtin_modules += 'network'
   builtin_sources += files(
     'network/manager.c',
@@ -51,7 +51,7 @@ if get_option('network')
   )
 endif
 
-if get_option('hid')
+if get_option('hid').enabled()
   builtin_modules += 'input'
   builtin_sources += files(
     'input/manager.c',
@@ -64,7 +64,7 @@ if get_option('hid')
   )
 endif
 
-if get_option('hog')
+if get_option('hog').enabled()
   builtin_modules += 'hog'
   builtin_sources += files(
     'input/hog.c',
@@ -85,42 +85,42 @@ if get_option('midi').enabled()
   builtin_deps += alsa_dep
 endif
 
-if get_option('bap')
+if get_option('bap').enabled()
   builtin_modules += 'bap'
   builtin_sources += files('audio/bap.c')
 endif
 
-if get_option('bass')
+if get_option('bass').enabled()
   builtin_modules += 'bass'
   builtin_sources += files('audio/bass.c')
 endif
 
-if get_option('mcp')
+if get_option('mcp').enabled()
   builtin_modules += 'mcp'
   builtin_sources += files('audio/mcp.c')
 endif
 
-if get_option('vcp')
+if get_option('vcp').enabled()
   builtin_modules += 'vcp'
   builtin_sources += files('audio/vcp.c')
 endif
 
-if get_option('micp')
+if get_option('micp').enabled()
   builtin_modules += 'micp'
   builtin_sources += files('audio/micp.c')
 endif
 
-if get_option('ccp')
+if get_option('ccp').enabled()
   builtin_modules += 'ccp'
   builtin_sources += files('audio/ccp.c')
 endif
 
-if get_option('csip')
+if get_option('csip').enabled()
   builtin_modules += 'csip'
   builtin_sources += files('audio/csip.c')
 endif
 
-if get_option('asha')
+if get_option('asha').enabled()
   builtin_modules += 'asha'
   builtin_sources += files('audio/asha.c')
 endif
@@ -140,14 +140,14 @@ if get_option('hfp').enabled()
   builtin_sources += files('audio/telephony.c', 'audio/hfp-hf.c')
 endif
 
-if get_option('tools')
+if get_option('tools').enabled()
   executable('iapd',
     sources: 'iap/main.c',
     dependencies: [ libgdbus_internal_dep, glib_dep, dbus_dep ]
   )
 endif
 
-if get_option('cups').enabled()
+if cups_dep.found()
   executable('bluetooth',
     sources: [
       'cups/main.c',
diff --git a/src/meson.build b/src/meson.build
index c82085b8a519..bf2155e13d89 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,6 +1,6 @@
 subdir('shared')
 
-if get_option('datafiles')
+if get_option('datafiles').enabled()
   install_data('bluetooth.conf',
     install_dir: dbusconfdir / 'dbus-1/system.d'
   )
@@ -9,7 +9,7 @@ if get_option('datafiles')
   )
 endif
 
-if get_option('systemd')
+if systemd_dep.found()
   configure_file(
     input: 'bluetooth.service.in',
     output: 'bluetooth.service',
diff --git a/tools/mesh/meson.build b/tools/mesh/meson.build
index 85bfb00977f3..eb4039909b5c 100644
--- a/tools/mesh/meson.build
+++ b/tools/mesh/meson.build
@@ -1,4 +1,4 @@
-if get_option('tools') and readline_dep.found()
+if get_option('tools').enabled() and readline_dep.found()
   executable('mesh-cfgclient',
     sources: [ '../mesh-cfgclient.c',
       'cfgcli.c',
diff --git a/tools/meson.build b/tools/meson.build
index 194016a49d2e..e945fcaed953 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -1,22 +1,4 @@
-tools_man_pages = [
-  'hid2hci.1',
-  'rctest.1',
-  'l2ping.1',
-  'btattach.1',
-  'isotest.1',
-  'btmgmt.1',
-  'hciattach.1',
-  'hciconfig.1',
-  'hcitool.1',
-  'hcidump.1',
-  'rfcomm.1',
-  'sdptool.1',
-  'ciptool.1',
-]
-
-inst_tools_man_pages = []
-
-if get_option('logger')
+if get_option('logger').enabled()
   executable('btmon-logger',
     [ 'btmon-logger.c' ],
     dependencies: libshared_mainloop_dep,
@@ -24,7 +6,7 @@ if get_option('logger')
     install_dir: pkglibexecdir
   )
 
-  if get_option('systemd')
+  if systemd_dep.found()
     configure_file(
       input: 'bluetooth-logger.service.in',
       output: 'bluetooth-logger.service',
@@ -56,7 +38,7 @@ tester_tools = [
   '6lowpan',
 ]
 
-if get_option('tests')
+if get_option('tests').enabled()
   foreach tool: tester_tools
     executable(tool + '-tester',
       sources: [ tool + '-tester.c', emulator_sources ],
@@ -65,7 +47,7 @@ if get_option('tests')
   endforeach
 endif
 
-if get_option('btpclient')
+if get_option('btpclient').enabled()
   executable('btpclient',
     sources: [ 'btpclient.c', '../src/shared/btp.c' ],
     include_directories: '..',
@@ -82,7 +64,7 @@ if get_option('btpclient')
   )
 endif
 
-if get_option('hid2hci')
+if get_option('hid2hci').enabled()
   executable('hid2hci',
     sources: 'hid2hci.c',
     dependencies: udevlib_dep,
@@ -127,7 +109,7 @@ inst_tools_names = [
   'isotest'
 ]
 
-if get_option('tools')
+if get_option('tools').enabled()
   foreach tool: tools_names
     executable(tool,
       sources: tool + '.c',
@@ -199,7 +181,7 @@ if get_option('tools')
         include_directories: '..',
         install: true
       )
-      if get_option('deprecated')
+      if get_option('deprecated').enabled()
         executable('meshctl',
           sources: [
             'meshctl.c',
@@ -230,7 +212,7 @@ if get_option('tools')
     endif
   endif
 
-  if get_option('deprecated')
+  if get_option('deprecated').enabled()
     executable('gatttool',
       sources: gatttool_sources,
       dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep ],
@@ -303,7 +285,7 @@ if get_option('tools')
     endforeach
   endif
 
-  if get_option('systemd')
+  if systemd_dep.found()
     configure_file(
       input: 'mpris-proxy.service.in',
       output: 'mpris-proxy.service',
diff --git a/unit/meson.build b/unit/meson.build
index b53568ccb76d..1e9b7020c089 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -52,7 +52,7 @@ tests2 = [
   [ 'test-avctp.c', '../src/log.c', 'avctp.c' ],
 ]
 
-if get_option('obex').enabled()
+if ical_dep.found()
   tests2 += [
     [ 'test-gobex.c', 'util.c', gobex_sources ],
     [ 'test-gobex-packet.c', 'util.c', gobex_sources ],
@@ -96,7 +96,7 @@ exe = executable('test-profile',
 )
 test('test-profile', exe)
 
-if get_option('midi').enabled()
+if alsa_dep.found()
   exe = executable('test-midi',
     sources: [ 'test-midi.c', '../profiles/midi/libmidi.c' ],
     c_args: [ '-DMIDI_TEST' ],
-- 
2.52.0

