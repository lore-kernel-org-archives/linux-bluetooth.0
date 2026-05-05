Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C43CAE7F
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971481; cv=none; b=dSR4ieWt94dRrOq3w01Perg7v+VX4deOFaNcYtFAMjdF7+IlqkP/sE1DrtYMy9u5bIy9DGbBioOjnANmkvhJ+Mw6tYjKIqXAl673NdJagvNTTtNuY3VObV8LZeeK2L0yb32OyTxY3XsqFf/fuhwrTajZcY8JfnTfKovthUkOcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971481; c=relaxed/simple;
	bh=rpbI6XcfDYUf/Tu2ZSzAkXRlNH+DoOXVHGhqNQZVYJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxkGit//BuQ5arzWODGyLtTjgQdQbSeDng5FJqLoJtWahX2sMI+Tx5pAQ19BLXYDlIyl6ImVhoI4kVOmVkJLOlugzWpHu8m/LwiPl5B4HERQfTVmHSXrgp+VfXOqcH3ya84V7ewzeUg1DQjVJFXnrmc/Wi2LcEffr+7ZIhNEZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA4073E95D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:51 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 08/16] build: Add option to allow disabling bluetoothd
Date: Tue,  5 May 2026 10:45:14 +0200
Message-ID: <20260505085741.2497401-9-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTFhqznfbG7j+9srnM48TPXceNL7GMCOcIcArp3t6H5tIeg06WuQv3VK1VmmGA5Q4asMiNgOWphkA5fqSkQGUpPcIOAcsuE65z6k8pORjVeZA6YhrhxshrwfyopcP6imB8Zoa7AG31giSGSSEkmfgWvbotPLUQinhiIgRgLVqzL+HiuLsoLoVoGMFBRZ8nvOeojfwnRCYq/G+zYD6pCYXVHx1iLGHRvq33URIxuAUnMKnFIN5T+7UloPRHuXADHGu/o4S2+lCXhCQn5CWeJIA3oT+xwfPs4/FeLQK4mUtUvSYUhO0GVOSbIf+h4SOKULICn9pJom0CtOE5SmomXiIIqgiAPStgEExSF05B/Hq5w5Ocxj7Fu/XBS0usifP+fMO4EczbYJ+UKYYIW/VPKWqjkPETPhJmkubDLSupsCd8D/mhzrnhMkzMbgj+Rq9GSCPboR96MMYjZ5y+7UH6G+HVuqWpPWtQJZUPijJYHD+ob+suuojcrJsQVleeIs+k+oMlTGQuar8EKwngk11EsNvhojSf0yn5VRk/WCTItobT6j4avvXZad/xu8LeDHERAy0l6B24OGgMhgXDliB9PwC2YMz5fj0fpKS02qDJOpqZztpQyb43WB5XWf51DXFmmZyW4Wrhz3Ia/xdYBsB+SFBOakZeiznlh3gFv7F/C2c+i7AA

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
index 915dd32a37c6..c26dd5740488 100644
--- a/meson.build
+++ b/meson.build
@@ -299,8 +299,12 @@ endif
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
2.54.0

