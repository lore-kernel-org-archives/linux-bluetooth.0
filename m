Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD8350A03
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813969; cv=none; b=JOt8D+AfojrqlcYcbRTB2qyH5gm2Ov9JfPwlk35EP5rxIW2lWhhz/d98McEtLIB/DGuheM7XkVOe1tAx6bcrJyrr8PnDvtZFpuuv+rfiz/R5e9DKNaLLCVPRdf1uoZpY5ZePGIwalBRz9ULwEOOK6VKRTx1FOudmDi7Qn0L4uAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813969; c=relaxed/simple;
	bh=tcUfofbuPq5P9VKl1TmOtgdVuo6CAQTmp4VF7rwy7bU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbsFgKxpxvqIRqW/A4d/6Su9obWBMv8HYYQGbwDPOzCCLGKkD/jJxZYvG3OiaDbZpkgD+5FhEQkd8NOqspDCs+NaVbUr8w8jn2aV//VnPxEwOv+QiwDVfhFHqR26xxHWNyPM92A4cJx9GHuU9W740qd7suIUiFExbeofJ+7IKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CA2644213
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:46:01 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 08/15] build: Add option to allow disabling bluetoothd
Date: Wed, 11 Feb 2026 13:42:04 +0100
Message-ID: <20260211124550.3830639-9-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevhfffgffgjeekueeihfdtffefuefgkefhieehfeevhedtvdejfeevvdfffeefveenucffohhmrghinhepshgvrhhvihgtvgdrihhnnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgeevtedvieeggedvudefpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

This makes it possible to build, for example, just the library, or the
command-line client, without also building and installing bluetoothd.
---
 doc/meson.build   |   3 +-
 meson.build       |   8 ++-
 meson_options.txt |   1 +
 src/meson.build   | 164 +++++++++++++++++++++++-----------------------
 4 files changed, 92 insertions(+), 84 deletions(-)

diff --git a/doc/meson.build b/doc/meson.build
index a991dfe26195..6b25ff6f8f05 100644
--- a/doc/meson.build
+++ b/doc/meson.build
@@ -146,7 +146,8 @@ bluetoothd_rst = configure_file(
   output: 'bluetoothd.rst',
   configuration: man_conf
 )
-if get_option('manpages').enabled()
+
+if get_option('daemon').enabled() and get_option('manpages').enabled()
   custom_target(
     input: bluetoothd_rst,
     output: 'bluetoothd.8',
diff --git a/meson.build b/meson.build
index 099ad5e0dd49..2d4203a02a0b 100644
--- a/meson.build
+++ b/meson.build
@@ -281,8 +281,12 @@ endif
 # Fix permissions on install
 install = find_program('install')
 sh = find_program('sh')
-meson.add_install_script(sh, '-c', 'install -dm755 ${DESTDIR}/' + configdir)
-meson.add_install_script(sh, '-c', 'install -dm700 ${DESTDIR}/' + storagedir)
+if get_option('daemon').enabled()
+  meson.add_install_script(sh, '-c', 'install -dm755 ${DESTDIR}/' + configdir)
+endif
+if get_option('daemon').enabled() or get_option('mesh').enabled()
+  meson.add_install_script(sh, '-c', 'install -dm700 ${DESTDIR}/' + storagedir)
+endif
 if get_option('mesh').enabled()
   meson.add_install_script(sh, '-c', 'install -dm700 ${DESTDIR}/' + meshstoragedir)
 endif
diff --git a/meson_options.txt b/meson_options.txt
index b72080f87813..aad131212886 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,6 +6,7 @@ option('tests', type: 'feature', value: 'auto', description: 'Enable testing too
 option('tools', type: 'feature', value: 'enabled', description: 'Enable Bluetooth tools')
 option('monitor', type: 'feature', value: 'enabled', description: 'Enable Bluetooth monitor')
 option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
+option('daemon', type: 'feature', value: 'enabled', description: 'Enable bluetoothd daemon')
 option('systemd', type: 'feature', value: 'enabled', description: 'Install systemd service files')
 option('logind', type: 'feature', value: 'enabled', description: 'Enable logind integration in obexd')
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support')
diff --git a/src/meson.build b/src/meson.build
index bf2155e13d89..22d142d1ceb6 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,88 +1,90 @@
 subdir('shared')
 
-if get_option('datafiles').enabled()
-  install_data('bluetooth.conf',
-    install_dir: dbusconfdir / 'dbus-1/system.d'
-  )
-  install_data('main.conf',
-    install_dir: configdir
-  )
-endif
+if get_option('daemon').enabled()
+  if get_option('datafiles').enabled()
+    install_data('bluetooth.conf',
+      install_dir: dbusconfdir / 'dbus-1/system.d'
+    )
+    install_data('main.conf',
+      install_dir: configdir
+    )
+  endif
 
-if systemd_dep.found()
-  configure_file(
-    input: 'bluetooth.service.in',
-    output: 'bluetooth.service',
-    install: true,
-    install_dir: systemdsystemunitdir,
-    configuration: service_conf
+  if systemd_dep.found()
+    configure_file(
+      input: 'bluetooth.service.in',
+      output: 'bluetooth.service',
+      install: true,
+      install_dir: systemdsystemunitdir,
+      configuration: service_conf
+    )
+
+    install_data('org.bluez.service',
+      install_dir: dbussystembusdir
+    )
+  endif
+
+  genbuiltin = find_program('genbuiltin')
+  builtin_h = custom_target('src-builtin.h',
+    output: 'builtin.h',
+    capture: true,
+    command: [ genbuiltin, builtin_modules ]
   )
 
-  install_data('org.bluez.service',
-    install_dir: dbussystembusdir
+  executable('bluetoothd',
+    sources: [ builtin_sources,
+      attrib_sources,
+      btio_sources,
+      builtin_h,
+      'main.c',
+      'log.c',
+      'backtrace.c',
+      'rfkill.c',
+      'sdpd-server.c',
+      'sdpd-request.c',
+      'sdpd-service.c',
+      'sdpd-database.c',
+      'gatt-database.c',
+      'sdp-xml.c',
+      'sdp-client.c',
+      'textfile.c',
+      'uuid-helper.c',
+      'plugin.c',
+      'storage.c',
+      'advertising.c',
+      'agent.c',
+      'bearer.c',
+      'error.c',
+      'adapter.c',
+      'profile.c',
+      'service.c',
+      'gatt-client.c',
+      'device.c',
+      'dbus-common.c',
+      'eir.c',
+      'adv_monitor.c',
+      'battery.c',
+      'settings.c',
+      'set.c' ],
+    dependencies: [
+      libbluetooth_internal_dep,
+      libgdbus_internal_dep,
+      libshared_glib_dep,
+      backtrace_dep,
+      glib_dep,
+      dbus_dep,
+      udevlib_dep,
+      builtin_deps
+    ],
+    override_options: [ 'b_lundef=false' ],
+    c_args: [
+      '-DBLUETOOTH_PLUGIN_BUILTIN',
+      '-DPLUGINDIR="@0@"'.format(plugindir),
+      '-DSTORAGEDIR="@0@"'.format(storagedir),
+      '-DCONFIGDIR="@0@"'.format(configdir)
+    ],
+    link_args: [ '-Wl,--gc-sections', external_plugins_link_args ],
+    install: true,
+    install_dir: pkglibexecdir
   )
 endif
-
-genbuiltin = find_program('genbuiltin')
-builtin_h = custom_target('src-builtin.h',
-  output: 'builtin.h',
-  capture: true,
-  command: [ genbuiltin, builtin_modules ]
-)
-
-executable('bluetoothd',
-  sources: [ builtin_sources,
-    attrib_sources,
-    btio_sources,
-    builtin_h,
-    'main.c',
-    'log.c',
-    'backtrace.c',
-    'rfkill.c',
-    'sdpd-server.c',
-    'sdpd-request.c',
-    'sdpd-service.c',
-    'sdpd-database.c',
-    'gatt-database.c',
-    'sdp-xml.c',
-    'sdp-client.c',
-    'textfile.c',
-    'uuid-helper.c',
-    'plugin.c',
-    'storage.c',
-    'advertising.c',
-    'agent.c',
-    'bearer.c',
-    'error.c',
-    'adapter.c',
-    'profile.c',
-    'service.c',
-    'gatt-client.c',
-    'device.c',
-    'dbus-common.c',
-    'eir.c',
-    'adv_monitor.c',
-    'battery.c',
-    'settings.c',
-    'set.c' ],
-  dependencies: [
-    libbluetooth_internal_dep,
-    libgdbus_internal_dep,
-    libshared_glib_dep,
-    backtrace_dep,
-    glib_dep,
-    dbus_dep,
-    udevlib_dep,
-    builtin_deps
-  ],
-  override_options: [ 'b_lundef=false' ],
-  c_args: [
-    '-DBLUETOOTH_PLUGIN_BUILTIN',
-    '-DPLUGINDIR="@0@"'.format(plugindir),
-    '-DSTORAGEDIR="@0@"'.format(storagedir),
-    '-DCONFIGDIR="@0@"'.format(configdir)
-  ],
-  link_args: [ '-Wl,--gc-sections', external_plugins_link_args ],
-  install: true,
-  install_dir: pkglibexecdir
-)
-- 
2.52.0

