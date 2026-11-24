Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535617;
	b=rvaDElLbudEtxuV9L7wGZbwlm6WpeSd2iWsHadOscEyyTqpTAniYEuj+erHFzPWa57l/
	 vC6nfCsXabLJtfvWkTFjmp9tmomxC1J6nXlNyPI79iR7rVVJaUrHlRQpY/lgA+qotKH/4
	 4khKzJ8boCfWX+L4YrTWv8Ot4LcEYg2itvBlVKufAlsJep2RaYF2+dLUOrRFj0gtpkKoH
	 bhkO890yuSHf8X7wIqlxrm8fw3I1wfBIofUoVM2UDeE8gmwg58lJcoYN07D4WhZ5UZ1AP
	 8Je1FRP2rEm3e/mZTRU7/aPvEkATwkJCLjNve+6LRf8Qtnbf2wfneWZl9e5wStuZyOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535617;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=jdPpeDAKDCSjFqOyJUYXyejx/WrHJRmllmKbBBdq6HA=;
	b=JntDLPov+dUnqyJjbRUeg9jOOHUMBbqI68gHXs9c9B6PJRl3f5US1xk3Sh4G1T73MC4x
	 9T7ujm1FD/Ecua97vlZOlIJ9XkCRggCxxcZon6YggCRr6Ygf552a57HfLbISdd+pucYiJ
	 OWswMDngwrxjslMihOHEpnv0FlRMvN1R89purbRWlrZwa1TKN3o5BK/m9AsunvXMxRCUh
	 eEKZ9tBs9PLxEIPk96+H+vvQxJneuQZ/3sFQPbstGwFWLRNz612W02udMQo0b+2Hal0tC
	 OhXL12Vdbvc01jKQsuqPEnq2wey2RBr6f8ZFGwey6sq/GsEe6RDAw5ju4TqUWmuCfgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540CB606A337
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 540CB606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 043933F5A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 06/14] build: Add option to allow disabling bluetoothd
Date: Tue, 24 Nov 2026 16:50:37 +0100
Message-ID: <20261124155319.1752879-7-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124155319.1752879-1-hadess@hadess.net>
References: <20261124155319.1752879-1-hadess@hadess.net>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEBEv/e7Rnmcrb0o8MxhGA/9wRu+2rPwjOvWzrCrMI424z/UmHp9bwrmkd3c/T7fEv2rzYq9k9Vb0YADTTnOVb3Vx4lHLTj8jBXXLcKNrMbVi54VCADrUpvN+jgwJOuy4WSMiycU6wJHeSfGkbp5VaNAegogkCXrk7wC7uakbDgP0qYLc7VzjRSDJWTK9vVKVuqtK0l99Lbf1eVEw5rHA4jkdk4EGWpJlArbjK6M3sRQoSBdLSiI61tC9eo7kT+ZsAYPAi88Y5VzinhYNCvaf+XINYrYzd2qAmBBOXQX3psFVO7bzDOo4KfxbwVUWYPy2jEqqtIiUJvJ5wWymGGa6+nLM8TYjSrDkg7Ysi5abBhl+XJCX5arKAxzUuiF0hnV+k4xo/FfA2t/GpUD/9EWN7pj2ztx0uFRkA8zSACQ/JCpGLsYpJPAjcpcga9dJke3rlLR1OuMOaHPk5Dd3FERo+GiuhqeLPW3R4860Opay/MAuxXJDt+y/fNVd6GPcW0fGUwMIzl1vKg607pSUEDkoHCfO7AhvoxXPdG4IFrslvQzix2PGmYL1P4ZCa4bGw+xe/LQTz3n/lxTbBcicH2stjYn8QUy7o8BlCRRU59qtmEzwHTNBt2cV4gfVZ0sRqeX8yk9ztM4ImWG5pRg97ldbJu9r/U0tXVGRq6/1xDcgxvug
X-GND-State: clean

This makes it possible to build, for example, just the library, or the
command-line client, without also building and installing bluetoothd.
---
 doc/meson.build   |   3 +-
 meson.build       |   8 +++-
 meson_options.txt |   1 +
 src/meson.build   | 115 ++++++++++++++++++++++++----------------------
 unit/meson.build  |  10 +++-
 5 files changed, 78 insertions(+), 59 deletions(-)

diff --git a/doc/meson.build b/doc/meson.build
index 467b07c1572f..6d78545f6541 100644
--- a/doc/meson.build
+++ b/doc/meson.build
@@ -148,7 +148,8 @@ bluetoothd_rst = configure_file(
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
index a842ab37ea96..cbd337f2ab32 100644
--- a/meson.build
+++ b/meson.build
@@ -303,8 +303,12 @@ endif
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
index f5edf4264e0e..7748c1becbc1 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,40 +1,37 @@
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
-  )
+  if systemd_dep.found()
+    configure_file(
+      input: 'bluetooth.service.in',
+      output: 'bluetooth.service',
+      install: true,
+      install_dir: systemdsystemunitdir,
+      configuration: service_conf
+    )
 
-  install_data('org.bluez.service',
-    install_dir: dbussystembusdir
-  )
-endif
+    install_data('org.bluez.service',
+      install_dir: dbussystembusdir
+    )
+  endif
 
-genbuiltin = find_program('genbuiltin')
-builtin_h = custom_target('src-builtin.h',
-  output: 'builtin.h',
-  capture: true,
-  command: [ genbuiltin, builtin_modules ]
-)
+  genbuiltin = find_program('genbuiltin')
+  builtin_h = custom_target('src-builtin.h',
+    output: 'builtin.h',
+    capture: true,
+    command: [ genbuiltin, builtin_modules ]
+  )
 
-executable('bluetoothd',
-  sources: [ builtin_sources,
-    btio_sources,
-    builtin_h,
-    'main.c',
+  bluetoothd_internal_sources = files(
     'log.c',
     'backtrace.c',
     'rfkill.c',
@@ -47,7 +44,6 @@ executable('bluetoothd',
     'sdp-client.c',
     'textfile.c',
     'uuid-helper.c',
-    'plugin.c',
     'storage.c',
     'advertising.c',
     'agent.c',
@@ -65,25 +61,36 @@ executable('bluetoothd',
     'settings.c',
     'set.c',
     'ranging.c',
-  ],
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
+  )
+
+  executable('bluetoothd',
+    sources: [
+      builtin_sources,
+      builtin_h,
+      btio_sources,
+      bluetoothd_internal_sources,
+      'main.c',
+      'plugin.c',
+    ],
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
+  )
+endif
diff --git a/unit/meson.build b/unit/meson.build
index 4b8f18802a30..317f138b97d9 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -81,8 +81,14 @@ else
 endif
 
 exe = executable('test-profile',
-  sources: [ 'test-profile.c', 'btd.c', '../src/profile.c' ],
-  dependencies: [ dbus_dep, libshared_glib_dep, libbluetooth_internal_dep ]
+  sources: [ 'test-profile.c', 'btd.c', bluetoothd_internal_sources, btio_sources ],
+  c_args: [ '-DSTORAGEDIR="@0"'.format(storagedir) ],
+  dependencies: [
+    libgdbus_internal_dep,
+    libshared_glib_dep,
+    libbluetooth_internal_dep,
+    backtrace_dep
+  ]
 )
 test('test-profile', exe)
 
-- 
2.56.0

