Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE72D6E59
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942341; cv=none; b=FduEE3cVQ/V3P6jeN4tAceSkFkR+SEcTawr3WcBp3oK7RGKdQN7ycSKf/zi8XY3894wSMXPBqSw86VFZ3jXR2knz+yerkxcdsY1mdPl5s4IC/Z8R9GRFb4EzkNJOrbS4+IkRDoxo1WPr+OWdRG9fSxmBEvm63NkkE85/KqbRag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942341; c=relaxed/simple;
	bh=20gBKYmIUB4bk582sB6UDgUB6/iGusnw4819WWxHv8I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIL0hQ8C8hPRY75n5oH/m4CdGMwrCI4ecSSmrA3u84Czn3eGEW6ezu84+dpbtW6l4T/pMMXHRQJFREid3pRBh/LkZqi+nmxr4CWiakpBpApuS/w3EAOmxMm1gTa1Sl/NRzRNoaPvFJglXkx/RiG4oE48UVno+8L4Ce51CYKWMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E43791FD55
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] build: Make more use of 'feature' options
Date: Mon, 11 Aug 2025 21:53:44 +0200
Message-ID: <20250811195850.1775759-4-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeffeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedvjeeigeehhfdtieejfeeuvdeihfefveehieeftdeukeeijedtfedtudeludetieenucffohhmrghinhepshgvrhhvihgtvgdrihhnpdhrshhtrdhinhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

This allows finer control around what is built and what is not,
trying to build as much as possible by default.

This also makes it easier to enable all the "auto" features which would
then fail if dependencies are missing (maximalist builds, for testing),
or disable everything by default, and only enable select options, which
minimises side-effects for distributions.
---
 client/meson.build     |  2 +-
 emulator/meson.build   |  2 +-
 lib/meson.build        |  2 +-
 mesh/meson.build       |  6 ++--
 meson.build            | 28 +++++++++---------
 meson_options.txt      | 66 +++++++++++++++++++++---------------------
 monitor/meson.build    |  2 +-
 obexd/meson.build      |  8 ++---
 peripheral/meson.build |  2 +-
 plugins/meson.build    |  6 ++--
 profiles/meson.build   | 36 +++++++++++------------
 src/meson.build        |  6 ++--
 tools/mesh/meson.build |  2 +-
 tools/meson.build      | 24 +++++++--------
 unit/meson.build       |  4 +--
 15 files changed, 97 insertions(+), 99 deletions(-)

diff --git a/client/meson.build b/client/meson.build
index 52397d1e17de..77bc9c5d9473 100644
--- a/client/meson.build
+++ b/client/meson.build
@@ -40,7 +40,7 @@ client_man_pages = [
   'bluetoothctl-hci.1'
 ]
 
-if get_option('manpages').enabled()
+if rst2man.found()
   foreach man_page: client_man_pages
     man_page_name = man_page.substring(0, -2)
     custom_target(man_page,
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
index ef0c7669c273..78325b12fdeb 100644
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
index 8c6f5631a9db..5b8fd2e6a94f 100644
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
@@ -59,7 +59,7 @@ executable('bluetooth-meshd',
   install_dir: pkglibexecdir
 )
 
-if get_option('manpages').enabled()
+if rst2man.found()
   bluetooth_meshd_rst = configure_file(
     input: 'bluetooth-meshd.rst.in',
     output: 'bluetooth-meshd.rst',
diff --git a/meson.build b/meson.build
index 74af6ac10dc4..bdfe46a98bbd 100644
--- a/meson.build
+++ b/meson.build
@@ -92,10 +92,8 @@ if get_option('buildtype').contains('debug')
 
   add_project_arguments(common_flags, language: 'c')
 
-  if get_option('valgrind')
-    config_h.set('HAVE_VALGRIND_MEMCHECK_H',
-      cc.has_header('valgrind/memcheck.h', required: false))
-  endif
+  config_h.set('HAVE_VALGRIND_MEMCHECK_H',
+    cc.has_header('valgrind/memcheck.h', required: get_option('valgrind').enabled()))
 endif
 
 test_cflags = [
@@ -122,8 +120,8 @@ config_h.set10('HAVE_DECL_SCM_TSTAMP_COMPLETION',
   cc.has_header_symbol('linux/errqueue.h', 'SCM_TSTAMP_COMPLETION', prefix: '#include <time.h>'))
 
 udev_required = get_option('udev').enabled() or
-    get_option('sixaxis') or
-    get_option('hid2hci')
+    get_option('sixaxis').enabled() or
+    get_option('hid2hci').enabled()
 udev_dep = dependency('udev', version:'>= 196', required: udev_required)
 udevlib_dep = dependency('libudev', required: udev_required)
 
@@ -138,7 +136,7 @@ systemd_dep = dependency('systemd', required: get_option('systemd'))
 libsystemd_dep = dependency('libsystemd', required: get_option('systemd'))
 ell_dep = dependency('ell',
   version: '>= 0.39',
-  required: get_option('btpclient') or get_option('mesh').enabled(),
+  required: get_option('btpclient').enabled() or get_option('mesh').enabled(),
   fallback : ['ell', 'libell_dep'],
   default_options: [
     'default_library=static',
@@ -226,12 +224,12 @@ if cups_dep.found()
   endif
 endif
 
-external_plugins_link_args = get_option('external-plugins') ? '-Wl,--export-dynamic' : ''
+external_plugins_link_args = get_option('external-plugins').enabled() ? '-Wl,--export-dynamic' : ''
 
-config_h.set('HAVE_A2DP', get_option('a2dp'))
-config_h.set('HAVE_AVRCP', get_option('avrcp'))
-config_h.set('HAVE_ASHA', get_option('asha'))
-config_h.set10('EXTERNAL_PLUGINS', get_option('external-plugins'))
+config_h.set('HAVE_A2DP', get_option('a2dp').enabled())
+config_h.set('HAVE_AVRCP', get_option('avrcp').enabled())
+config_h.set('HAVE_ASHA', get_option('asha').enabled())
+config_h.set10('EXTERNAL_PLUGINS', get_option('external-plugins').enabled())
 config_h.set_quoted('VERSION', meson.project_version())
 
 configure_file(
@@ -247,7 +245,7 @@ subdir('plugins')
 subdir('profiles')
 subdir('src')
 subdir('client')
-if get_option('monitor')
+if get_option('monitor').enabled()
   subdir('monitor')
 endif
 subdir('emulator')
@@ -263,10 +261,10 @@ endif
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
index 2d9231b120ca..aae4f377f0a2 100644
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
@@ -23,29 +23,29 @@ option('zsh-completion-dir', type:'string', value: '', description: 'Path to ins
 option('udevdir', type: 'string', value: '', description: 'udev directory')
 option('cups_serverbin', type: 'string', value: '', description: 'CUPS directory')
 
-option('nfc', type: 'boolean', value: false, description: 'Enable NFC pairing')
-option('sap', type: 'boolean', value: false, description: 'Enable SAP profile')
-option('a2dp', type: 'boolean', value: true, description: 'Enable A2DP profile')
-option('avrcp', type: 'boolean', value: true, description: 'Enable AVRCP profile')
-option('network', type: 'boolean', value: true, description: 'Enable network profiles')
-option('hid', type: 'boolean', value: true, description: 'Enable HID profile')
-option('hog', type: 'boolean', value: true, description: 'Enable HoG profile')
-option('health', type: 'boolean', value: false, description: 'Enable health profiles')
-option('bap', type: 'boolean', value: true, description: 'Enable BAP profile')
-option('bass', type: 'boolean', value: true, description: 'Enable BASS service')
-option('mcp', type: 'boolean', value: true, description: 'Enable MCP profile')
-option('ccp', type: 'boolean', value: true, description: 'Enable CCP profile')
-option('vcp', type: 'boolean', value: true, description: 'Enable VCP profile')
-option('micp', type: 'boolean', value: true, description: 'Enable MICP profile')
-option('csip', type: 'boolean', value: true, description: 'Enable CSIP profile')
-option('asha', type: 'boolean', value: true, description: 'Enable ASHA support')
+option('nfc', type: 'feature', value: 'disabled', description: 'Enable NFC pairing')
+option('sap', type: 'feature', value: 'disabled', description: 'Enable SAP profile')
+option('a2dp', type: 'feature', value: 'auto', description: 'Enable A2DP profile')
+option('avrcp', type: 'feature', value: 'auto', description: 'Enable AVRCP profile')
+option('network', type: 'feature', value: 'auto', description: 'Enable network profiles')
+option('hid', type: 'feature', value: 'auto', description: 'Enable HID profile')
+option('hog', type: 'feature', value: 'auto', description: 'Enable HoG profile')
+option('health', type: 'feature', value: 'disabled', description: 'Enable health profiles')
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
 option('obex', type: 'feature', value: 'auto', description: 'Enable OBEX profile support')
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
diff --git a/monitor/meson.build b/monitor/meson.build
index ad78e176d978..4f9a764167be 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -36,7 +36,7 @@ executable('btmon',
   install: true
 )
 
-if get_option('manpages').enabled()
+if rst2man.found()
   custom_target(
     input: 'btmon.rst',
     output: 'btmon.1',
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
index 8ac37b9e6cc8..656126b67efa 100644
--- a/profiles/meson.build
+++ b/profiles/meson.build
@@ -15,7 +15,7 @@ builtin_sources += files(
   'battery/battery.c'
 )
 
-if get_option('sap')
+if get_option('sap').enabled()
   builtin_modules += 'sap'
   builtin_sources += files(
     'sap/main.c',
@@ -25,7 +25,7 @@ if get_option('sap')
   )
 endif
 
-if get_option('a2dp')
+if get_option('a2dp').enabled()
   builtin_modules += 'a2dp'
   builtin_sources += files(
     'audio/source.c',
@@ -35,7 +35,7 @@ if get_option('a2dp')
   )
 endif
 
-if get_option('avrcp')
+if get_option('avrcp').enabled()
   builtin_modules += 'avrcp'
   builtin_sources += files(
     'audio/control.c',
@@ -45,7 +45,7 @@ if get_option('avrcp')
   )
 endif
 
-if get_option('network')
+if get_option('network').enabled()
   builtin_modules += 'network'
   builtin_sources += files(
     'network/manager.c',
@@ -58,7 +58,7 @@ if get_option('network')
   )
 endif
 
-if get_option('hid')
+if get_option('hid').enabled()
   builtin_modules += 'input'
   builtin_sources += files(
     'input/manager.c',
@@ -71,7 +71,7 @@ if get_option('hid')
   )
 endif
 
-if get_option('hog')
+if get_option('hog').enabled()
   builtin_modules += 'hog'
   builtin_sources += files(
     'input/hog.c',
@@ -83,7 +83,7 @@ if get_option('hog')
   )
 endif
 
-if get_option('health')
+if get_option('health').enabled()
   builtin_modules += 'health'
   builtin_sources += files(
     'health/mcap.c',
@@ -94,7 +94,7 @@ if get_option('health')
   )
 endif
 
-if get_option('midi').enabled()
+if alsa_dep.found()
   builtin_modules += 'midi'
   builtin_sources += files(
     'midi/midi.c',
@@ -103,54 +103,54 @@ if get_option('midi').enabled()
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
index 3466357bb4e9..51535087f198 100644
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
@@ -86,7 +86,7 @@ executable('bluetoothd',
   install_dir: pkglibexecdir
 )
 
-if get_option('manpages').enabled()
+if rst2man.found()
   bluetoothd_rst = configure_file(
     input: 'bluetoothd.rst.in',
     output: 'bluetoothd.rst',
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
index 59e4f7d52824..5e73b048c118 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -1,6 +1,6 @@
 tools_man_pages = []
 
-if get_option('logger')
+if get_option('logger').enabled()
   executable('btmon-logger',
     [ 'btmon-logger.c' ],
     dependencies: libshared_mainloop_dep,
@@ -8,7 +8,7 @@ if get_option('logger')
     install_dir: pkglibexecdir
   )
 
-  if get_option('systemd')
+  if systemd_dep.found()
     configure_file(
       input: 'bluetooth-logger.service.in',
       output: 'bluetooth-logger.service',
@@ -39,7 +39,7 @@ tester_tools = [
   'hci'
 ]
 
-if get_option('tests')
+if get_option('tests').enabled()
   foreach tool: tester_tools
     executable(tool + '-tester',
       sources: [ tool + '-tester.c', emulator_sources ],
@@ -48,7 +48,7 @@ if get_option('tests')
   endforeach
 endif
 
-if get_option('btpclient')
+if get_option('btpclient').enabled()
   executable('btpclient',
     sources: [ 'btpclient.c', '../src/shared/btp.c' ],
     include_directories: '..',
@@ -65,7 +65,7 @@ if get_option('btpclient')
   )
 endif
 
-if get_option('hid2hci')
+if get_option('hid2hci').enabled()
   executable('hid2hci',
     sources: 'hid2hci.c',
     dependencies: udevlib_dep,
@@ -76,7 +76,7 @@ if get_option('hid2hci')
     install_dir: udevdir / 'rules.d',
     rename: '97-hid2hci.rules'
   )
-  if get_option('manpages').enabled()
+  if rst2man.found()
     tools_man_pages += 'hid2hci.1'
   endif
 endif
@@ -113,7 +113,7 @@ inst_tools_names = [
   'isotest'
 ]
 
-if get_option('tools')
+if get_option('tools').enabled()
   foreach tool: tools_names
     executable(tool,
       sources: tool + '.c',
@@ -129,7 +129,7 @@ if get_option('tools')
     )
   endforeach
 
-  if get_option('manpages').enabled()
+  if rst2man.found()
     tools_man_pages += [
       'rctest.1',
       'l2ping.1',
@@ -196,7 +196,7 @@ if get_option('tools')
         include_directories: '..',
         install: true
       )
-      if get_option('deprecated')
+      if get_option('deprecated').enabled()
         executable('meshctl',
           sources: [
             'meshctl.c',
@@ -227,7 +227,7 @@ if get_option('tools')
     endif
   endif
 
-  if get_option('deprecated')
+  if get_option('deprecated').enabled()
     executable('gatttool',
       sources: gatttool_sources,
       dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep ],
@@ -299,7 +299,7 @@ if get_option('tools')
       )
     endforeach
 
-    if get_option('manpages').enabled()
+    if rst2man.found()
       tools_man_pages += [
         'hciattach.1',
         'hciconfig.1',
@@ -312,7 +312,7 @@ if get_option('tools')
     endif
   endif
 
-  if get_option('systemd')
+  if systemd_dep.found()
     configure_file(
       input: 'mpris-proxy.service.in',
       output: 'mpris-proxy.service',
diff --git a/unit/meson.build b/unit/meson.build
index cf3e80d69439..88a4a4ac1d89 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -47,7 +47,7 @@ tests2 = [
   [ 'test-avctp.c', '../src/log.c', 'avctp.c' ],
 ]
 
-if get_option('obex').enabled()
+if ical_dep.found()
   tests2 += [
     [ 'test-gobex.c', 'util.c', gobex_sources ],
     [ 'test-gobex-packet.c', 'util.c', gobex_sources ],
@@ -82,7 +82,7 @@ exe = executable('test-gattrib',
 )
 test('test-gattrib', exe)
 
-if get_option('midi').enabled()
+if alsa_dep.found()
   exe = executable('test-midi',
     sources: [ 'test-midi.c', '../profiles/midi/libmidi.c' ],
     c_args: [ '-DMIDI_TEST' ],
-- 
2.50.0

