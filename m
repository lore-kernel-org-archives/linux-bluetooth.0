Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 3/9] obexd: Remove unused source/header files for
 dbus
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <b4b7e77f-8575-36ec-62ef-b879c20f64f2@jp.fujitsu.com>
Message-ID: <05201035-ed06-7b0d-bc49-e7ae47032cc4@jp.fujitsu.com>
Date: Thu, 1 Mar 2018 13:27:16 +0900
MIME-Version: 1.0
In-Reply-To: <b4b7e77f-8575-36ec-62ef-b879c20f64f2@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Due to using g_dbus_emit_property_changed() and g_dbus_get_properties(),
obex_dbus_signal_property_changed() is unused since commit 96063756
("obex-client: Rename org.bluez.obex.Transfer to Transfer1"), and
OBC_PROPERTIES_ARRAY_SIGNATURE macro is unused since commit 3eadc034
("obex-client: Make use of g_dbus_get_properties to get transfer properties").
---
 Makefile.obexd          |  1 -
 obexd/client/dbus.c     | 94 -------------------------------------------------
 obexd/client/dbus.h     | 48 -------------------------
 obexd/client/ftp.c      |  1 -
 obexd/client/map.c      |  1 -
 obexd/client/session.c  |  1 -
 obexd/client/transfer.c |  1 -
 7 files changed, 147 deletions(-)
 delete mode 100644 obexd/client/dbus.c
 delete mode 100644 obexd/client/dbus.h

diff --git a/Makefile.obexd b/Makefile.obexd
index 2e33cbc72..5959f2292 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -76,7 +76,6 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/client/map-event.h obexd/client/map-event.c \
 			obexd/client/transfer.h obexd/client/transfer.c \
 			obexd/client/transport.h obexd/client/transport.c \
-			obexd/client/dbus.h obexd/client/dbus.c \
 			obexd/client/driver.h obexd/client/driver.c \
 			obexd/src/map_ap.h
 obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
diff --git a/obexd/client/dbus.c b/obexd/client/dbus.c
deleted file mode 100644
index bfe5c4974..000000000
--- a/obexd/client/dbus.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- *
- *  OBEX Client
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
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
-#include <glib.h>
-
-#include "gdbus/gdbus.h"
-
-#include "obexd/src/log.h"
-#include "dbus.h"
-
-static void append_variant(DBusMessageIter *iter,
-				int type, void *value)
-{
-	char sig[2];
-	DBusMessageIter valueiter;
-
-	sig[0] = type;
-	sig[1] = 0;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
-						sig, &valueiter);
-
-	dbus_message_iter_append_basic(&valueiter, type, value);
-
-	dbus_message_iter_close_container(iter, &valueiter);
-}
-
-void obex_dbus_dict_append(DBusMessageIter *dict,
-			const char *key, int type, void *value)
-{
-	DBusMessageIter keyiter;
-
-	if (type == DBUS_TYPE_STRING) {
-		const char *str = *((const char **) value);
-		if (str == NULL)
-			return;
-	}
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-							NULL, &keyiter);
-
-	dbus_message_iter_append_basic(&keyiter, DBUS_TYPE_STRING, &key);
-
-	append_variant(&keyiter, type, value);
-
-	dbus_message_iter_close_container(dict, &keyiter);
-}
-
-int obex_dbus_signal_property_changed(DBusConnection *conn,
-					const char *path,
-					const char *interface,
-					const char *name,
-					int type, void *value)
-{
-	DBusMessage *signal;
-	DBusMessageIter iter;
-
-	signal = dbus_message_new_signal(path, interface, "PropertyChanged");
-	if (signal == NULL) {
-		error("Unable to allocate new %s.PropertyChanged signal",
-				interface);
-		return -1;
-	}
-
-	dbus_message_iter_init_append(signal, &iter);
-
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
-
-	append_variant(&iter, type, value);
-
-	return g_dbus_send_message(conn, signal);
-}
diff --git a/obexd/client/dbus.h b/obexd/client/dbus.h
deleted file mode 100644
index 6136bf58e..000000000
--- a/obexd/client/dbus.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *
- *  OBEX Client
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
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
-#ifndef __OBEX_DBUS_H
-#define __OBEX_DBUS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <dbus/dbus.h>
-
-/* Essentially a{sv} */
-#define OBC_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING \
-					DBUS_TYPE_STRING_AS_STRING \
-					DBUS_TYPE_VARIANT_AS_STRING \
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
-
-void obex_dbus_dict_append(DBusMessageIter *dict, const char *key, int type,
-				void *value);
-
-int obex_dbus_signal_property_changed(DBusConnection *conn, const char *path,
-					const char *interface, const char *name,
-					int type, void *value);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OBEX_DBUS_H */
diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index f4923b304..d799821b1 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -31,7 +31,6 @@
 #include "gdbus/gdbus.h"
 
 #include "obexd/src/log.h"
-#include "dbus.h"
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
diff --git a/obexd/client/map.c b/obexd/client/map.c
index d1c897677..3e581c8ee 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -40,7 +40,6 @@
 
 #include "obexd/src/log.h"
 #include "obexd/src/map_ap.h"
-#include "dbus.h"
 #include "map-event.h"
 
 #include "map.h"
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 5f981bf54..4eda255d1 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -40,7 +40,6 @@
 #include "gobex/gobex.h"
 
 #include "obexd/src/log.h"
-#include "dbus.h"
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 092e72fe2..b53dffa21 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -41,7 +41,6 @@
 #include "gobex/gobex.h"
 
 #include "obexd/src/log.h"
-#include "dbus.h"
 #include "transfer.h"
 
 #define TRANSFER_INTERFACE "org.bluez.obex.Transfer1"
-- 
2.14.1

