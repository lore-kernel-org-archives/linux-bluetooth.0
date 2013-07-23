Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] audio: Remove audio plugin
Date: Tue, 23 Jul 2013 18:01:25 +0300
Message-Id: <1374591686-22646-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1374591686-22646-1-git-send-email-luiz.dentz@gmail.com>
References: <1374591686-22646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Audio plugin is now splitted in multiple plugins so it is no longer
necessary to have a manager to deal with many different drivers.
---
 Makefile.plugins         |   4 --
 profiles/audio/a2dp.c    |   1 -
 profiles/audio/avctp.c   |   1 -
 profiles/audio/avdtp.c   |   1 -
 profiles/audio/control.c |   1 -
 profiles/audio/main.c    |  86 ----------------------------------------
 profiles/audio/manager.c | 101 -----------------------------------------------
 profiles/audio/manager.h |  30 --------------
 profiles/audio/sink.c    |   1 -
 profiles/audio/source.c  |   1 -
 10 files changed, 227 deletions(-)
 delete mode 100644 profiles/audio/main.c
 delete mode 100644 profiles/audio/manager.c
 delete mode 100644 profiles/audio/manager.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 41d5be9..e11a013 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -30,10 +30,6 @@ noinst_LIBRARIES += profiles/sap/libsap.a
 profiles_sap_libsap_a_SOURCES = profiles/sap/sap.h profiles/sap/sap-u8500.c
 endif
 
-builtin_modules += audio
-builtin_sources += profiles/audio/main.c \
-			profiles/audio/manager.h profiles/audio/manager.c
-
 builtin_modules += a2dp
 builtin_sources += profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/sink.h profiles/audio/sink.c \
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 148fb98..807bdd8 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -45,7 +45,6 @@
 #include "src/service.h"
 
 #include "log.h"
-#include "manager.h"
 #include "avdtp.h"
 #include "sink.h"
 #include "source.h"
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 627252a..11e9365 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -53,7 +53,6 @@
 #include "log.h"
 #include "error.h"
 #include "uinput.h"
-#include "manager.h"
 #include "avctp.h"
 #include "avrcp.h"
 
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f6c9408..818dbdd 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -50,7 +50,6 @@
 #include "src/adapter.h"
 #include "src/device.h"
 
-#include "manager.h"
 #include "control.h"
 #include "avdtp.h"
 #include "sink.h"
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 912ca73..5f88a94 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -53,7 +53,6 @@
 
 #include "log.h"
 #include "error.h"
-#include "manager.h"
 #include "avctp.h"
 #include "control.h"
 #include "sdpd.h"
diff --git a/profiles/audio/main.c b/profiles/audio/main.c
deleted file mode 100644
index 996d2af..0000000
--- a/profiles/audio/main.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2006-2010  Nokia Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <sys/socket.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include <glib.h>
-#include <dbus/dbus.h>
-#include <btio/btio.h>
-
-#include "glib-helper.h"
-#include "plugin.h"
-#include "log.h"
-#include "manager.h"
-
-static GKeyFile *load_config_file(const char *file)
-{
-	GError *err = NULL;
-	GKeyFile *keyfile;
-
-	keyfile = g_key_file_new();
-
-	g_key_file_set_list_separator(keyfile, ',');
-
-	if (!g_key_file_load_from_file(keyfile, file, 0, &err)) {
-		if (!g_error_matches(err, G_FILE_ERROR, G_FILE_ERROR_NOENT))
-			error("Parsing %s failed: %s", file, err->message);
-		g_error_free(err);
-		g_key_file_free(keyfile);
-		return NULL;
-	}
-
-	return keyfile;
-}
-
-static int audio_init(void)
-{
-	GKeyFile *config;
-
-	config = load_config_file(CONFIGDIR "/audio.conf");
-
-	if (audio_manager_init(config) < 0) {
-		audio_manager_exit();
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static void audio_exit(void)
-{
-	audio_manager_exit();
-}
-
-BLUETOOTH_PLUGIN_DEFINE(audio, VERSION,
-			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, audio_init, audio_exit)
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
deleted file mode 100644
index 8065b70..0000000
--- a/profiles/audio/manager.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2006-2010  Nokia Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdarg.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <stdint.h>
-#include <stdbool.h>
-#include <sys/stat.h>
-#include <dirent.h>
-#include <ctype.h>
-#include <signal.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include <glib.h>
-#include <dbus/dbus.h>
-#include <btio/btio.h>
-#include <gdbus/gdbus.h>
-
-#include "lib/uuid.h"
-#include "glib-helper.h"
-#include "src/adapter.h"
-#include "src/device.h"
-#include "src/profile.h"
-#include "src/service.h"
-
-#include "log.h"
-#include "error.h"
-#include "avdtp.h"
-#include "media.h"
-#include "a2dp.h"
-#include "sink.h"
-#include "source.h"
-#include "avrcp.h"
-#include "control.h"
-#include "manager.h"
-#include "sdpd.h"
-
-static GKeyFile *config = NULL;
-
-int audio_manager_init(GKeyFile *conf)
-{
-	if (conf)
-		config = conf;
-
-	return 0;
-}
-
-void audio_manager_exit(void)
-{
-	if (config) {
-		g_key_file_free(config);
-		config = NULL;
-	}
-}
-
-static void set_fast_connectable(struct btd_adapter *adapter,
-							gpointer user_data)
-{
-	gboolean enable = GPOINTER_TO_UINT(user_data);
-
-	if (btd_adapter_set_fast_connectable(adapter, enable))
-		error("Changing fast connectable for hci%d failed",
-					btd_adapter_get_index(adapter));
-}
-
-void manager_set_fast_connectable(gboolean enable)
-{
-	adapter_foreach(set_fast_connectable, GUINT_TO_POINTER(enable));
-}
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
deleted file mode 100644
index de8d791..0000000
--- a/profiles/audio/manager.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2006-2010  Nokia Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-int audio_manager_init(GKeyFile *config);
-void audio_manager_exit(void);
-
-/* TRUE to enable fast connectable and FALSE to disable fast connectable for all
- * audio adapters. */
-void manager_set_fast_connectable(gboolean enable);
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 7211e68..400af06 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -47,7 +47,6 @@
 #include "media.h"
 #include "a2dp.h"
 #include "error.h"
-#include "manager.h"
 #include "sink.h"
 #include "dbus-common.h"
 
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 0793af3..24a4353 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -48,7 +48,6 @@
 #include "media.h"
 #include "a2dp.h"
 #include "error.h"
-#include "manager.h"
 #include "source.h"
 #include "dbus-common.h"
 
-- 
1.8.3.1

