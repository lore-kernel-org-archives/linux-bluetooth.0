Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD4386C3E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022024; cv=none; b=m5pNt7P51B/IcOl5errJzVNZFmq7VZ4pSi/TKYXmcdl+cdt2U7vEBMRwnLzqPY6sW+bh6ntVBxnMguufiYzl+q03dh1lI/ey9hcbnxsls8QGPz46zEclQTHmKxbFqx2vNt5J5eqZ5j5hFCunG9UNGamlAawUnP0pAV80H3c4s4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022024; c=relaxed/simple;
	bh=K1zVWK6DHUFlVPYL4rVSrPp8Lg4q+WAiH6M8k1MkvdA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+/495KwI5fM4hXcqlhMPfdahL4iF6WcjBl30fClApRT/upxbFbvowLbcGn4ukifbnpfhCfZJ+Mn4k2LtCDn1wnTVIqISZbvfysN67VKkTxTbFUD5TuXyeqJEPNDlDQtQyHjB7IH0QtGGxzZzBq4c5ulU2OXO0SQw7bRA+yoXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDCF03EBFE
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:34 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 07/15] build: Add option to allow disabling bluetoothd
Date: Fri, 24 Apr 2026 11:11:10 +0200
Message-ID: <20260424091324.3097084-8-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091324.3097084-1-hadess@hadess.net>
References: <20260424091324.3097084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEmmAL5YyLoSvYFSCH5iK9G0oZyEBdPUe3yuP7ylLGBpD2JaBzZq82ydFC6IHifKQkcnwqrmGgD9gFlWAM1Hy9LK3tIuaGDOmu/cOX02EPBpVUKs9lbwGG3tgI9ZX2KOXKYtAxVNpq39xgK1rlvNHZPj/Wz9dVIVTFY63ROznNkkS39j8i6eeqLjRyDfmcuPWkmY215FQYf8F/PmzXkwfcROagsCgt4F+1vryJTuDoCQYBUD7TeNK7+lppb5Cs378XeM70RbWCNYCS679sbGcE3UwL618oJmIRxDP0E7CvGRV15Oyk3j78dzBkb5AmtYdyWe1HU1Ir1vkESzAhObKjwEc/xAtvin3ELOgCbhBBoDKRRL4JQaCKqfggZ+fCnT+00BcN4xELa2N0gmi3kw7Me3sYEN4ewxq95rgA3S7V3WJJhCVldOZySjXNBTNT7iC7PmnranJewB0jpIQvp1OJI/Wl/Vrlf59hAiVsiWZm3RDT1DBHcKdv5B7NkH7qc89RNySRLUueacqkfgdRsqb/kA3Mm7oUPbiC+kIDnHBbicnddKbTQJLq5j+Ad0PWjxxcQAH2W3ypYQ/31AkMqJXmIQ5SBc3nWYpmHP0kluaBxpzZvAbc7er4NkWBBSp11eEBRm+IRQ6PI4wufGt7hwk/LqdmuzCYGKDZr2zNOosNgOw
X-GND-State: clean
X-GND-Score: 0

This makes it possible to build, for example, just the library, or the
command-line client, without also building and installing bluetoothd.
---
 doc/meson.build   |   3 +-
 meson.build       |   8 ++-
 meson_options.txt |   1 +
 src/meson.build   | 164 +++++++++++++++++++++++-----------------------
 4 files changed, 92 insertions(+), 84 deletions(-)

diff --git a/doc/meson.build b/doc/meson.build
index 3d5ccd7d3034..498b6a479067 100644
--- a/doc/meson.build
+++ b/doc/meson.build
@@ -146,7 +146,8 @@ bluetoothd_rst = configure_file(
   output: 'bluetoothd.rst',
   configuration: man_conf
 )
-if rst2man.found()
+
+if get_option('daemon').enabled() and rst2man.found()
   custom_target(
     input: bluetoothd_rst,
     output: 'bluetoothd.8',
diff --git a/meson.build b/meson.build
index 0b5cc0b7ce69..f716eae1f063 100644
--- a/meson.build
+++ b/meson.build
@@ -293,8 +293,12 @@ endif
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
index 54cfdbb0d7c1..79e75e33ddaf 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,6 +6,7 @@ option('tests', type: 'feature', value: 'auto', description: 'Enable testing too
 option('tools', type: 'feature', value: 'enabled', description: 'Enable Bluetooth tools')
 option('monitor', type: 'feature', value: 'enabled', description: 'Enable Bluetooth monitor')
 option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
+option('daemon', type: 'feature', value: 'enabled', description: 'Enable bluetoothd daemon')
 option('systemd', type: 'feature', value: 'enabled', description: 'Install systemd service files')
 option('logind', type: 'feature', value: 'enabled', description: 'Enable logind integration in obexd')
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support in tools')
diff --git a/src/meson.build b/src/meson.build
index 65b7131c86b4..4962b782a7b6 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,88 +1,90 @@
 subdir('shared')
 
-if get_option('datafiles').allowed()
-  install_data('bluetooth.conf',
-    install_dir: dbusconfdir / 'dbus-1/system.d'
-  )
-  install_data('main.conf',
-    install_dir: configdir
-  )
-endif
+if get_option('daemon').allowed()
+  if get_option('datafiles').allowed()
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
2.53.0

