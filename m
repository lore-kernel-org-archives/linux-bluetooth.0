Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v4 15/18] oob: Refactor oob callback handling and move it to adapter code
Date: Wed, 3 Oct 2012 15:18:28 +0200
Message-ID: <1349270311-31103-16-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
References: <1349270311-31103-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows oob plugin to register for callback after executing
certain action on adapter. Currently reading local OOB data and
pairing is supported. It should be easy to support more callbacks
in future if needed e.g. powering on.

Thanks to this plugin is not required to duplicate code that would
validate adapter/device when callback is received as callback condition
is check in adapter.

It also allows to pass user data which will be provided back when cb
is called further reducing plugin code.

---
 Makefile.am       |    3 +--
 plugins/dbusoob.c |   62 +++++++++++------------------------------------------
 src/adapter.c     |   44 +++++++++++++++++++++++++++++++++++++
 src/adapter.h     |   20 +++++++++++++++++
 src/mgmt.c        |    8 +++----
 src/oob.c         |   41 -----------------------------------
 src/oob.h         |   32 ---------------------------
 7 files changed, 81 insertions(+), 129 deletions(-)
 delete mode 100644 src/oob.c
 delete mode 100644 src/oob.h

diff --git a/Makefile.am b/Makefile.am
index c27eb01..9868710 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -307,8 +307,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/profile.h src/profile.c \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
-			src/event.h src/event.c \
-			src/oob.h src/oob.c src/eir.h src/eir.c \
+			src/event.h src/event.c src/eir.h src/eir.c \
 			src/mgmt.c src/mgmt.h
 src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
 								-ldl -lrt
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index d3bca9e..ea40355 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -44,16 +44,10 @@
 #include "dbus-common.h"
 #include "event.h"
 #include "error.h"
-#include "oob.h"
 #include "storage.h"
 
 #define OOB_INTERFACE	"org.bluez.OutOfBand"
 
-struct oob_request {
-	struct btd_adapter *adapter;
-	DBusMessage *msg;
-};
-
 struct oob_data {
 	char *addr;
 	uint8_t *hash;
@@ -62,47 +56,22 @@ struct oob_data {
 	const char *name;
 };
 
-static GSList *oob_requests = NULL;
-
-static gint oob_request_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct oob_request *data = a;
-	const struct btd_adapter *adapter = b;
-
-	return data->adapter != adapter;
-}
-
-static struct oob_request *find_oob_request(struct btd_adapter *adapter)
-{
-	GSList *match;
-
-	match = g_slist_find_custom(oob_requests, adapter, oob_request_cmp);
-
-	if (match)
-		return match->data;
-
-	return NULL;
-}
-
 static void read_local_data_complete(struct btd_adapter *adapter, uint8_t *hash,
-				uint8_t *randomizer)
+				uint8_t *randomizer, void *user_data)
 {
 	struct DBusMessage *reply;
-	struct oob_request *oob_request;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
+	DBusMessage *msg = user_data;
 
-	oob_request = find_oob_request(adapter);
-	if (!oob_request)
-		return;
+	DBG("");
 
 	if (!hash || !randomizer) {
-		reply = btd_error_failed(oob_request->msg,
-					"Failed to read local OOB data.");
+		reply = btd_error_failed(msg, "Failed to read local OOB data");
 		goto done;
 	}
 
-	reply = dbus_message_new_method_return(oob_request->msg);
+	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		goto done;
 
@@ -119,9 +88,7 @@ static void read_local_data_complete(struct btd_adapter *adapter, uint8_t *hash,
 	dbus_message_iter_close_container(&iter, &dict);
 
 done:
-	oob_requests = g_slist_remove(oob_requests, oob_request);
-	dbus_message_unref(oob_request->msg);
-	g_free(oob_request);
+	dbus_message_unref(msg);
 
 	if (!reply) {
 		error("Couldn't allocate D-Bus message");
@@ -136,21 +103,22 @@ static DBusMessage *read_local_data(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct btd_adapter *adapter = data;
-	struct oob_request *oob_request;
+	struct oob_handler *handler;
 
 	if (!btd_adapter_ssp_enabled(adapter))
 		return btd_error_not_supported(msg);
 
-	if (find_oob_request(adapter))
+	if (btd_adapter_check_oob_handler(adapter))
 		return btd_error_in_progress(msg);
 
 	if (btd_adapter_read_local_oob_data(adapter))
 		return btd_error_failed(msg, "Request failed.");
 
-	oob_request = g_new(struct oob_request, 1);
-	oob_request->adapter = adapter;
-	oob_requests = g_slist_append(oob_requests, oob_request);
-	oob_request->msg = dbus_message_ref(msg);
+	handler = g_new0(struct oob_handler, 1);
+	handler->read_local_cb = read_local_data_complete;
+	handler->user_data = dbus_message_ref(msg);
+
+	btd_adapter_set_oob_handler(adapter, handler);
 
 	return NULL;
 }
@@ -336,8 +304,6 @@ static int oob_probe(struct btd_adapter *adapter)
 
 static void oob_remove(struct btd_adapter *adapter)
 {
-	read_local_data_complete(adapter, NULL, NULL);
-
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 				adapter_get_path(adapter), OOB_INTERFACE);
 }
@@ -352,8 +318,6 @@ static int dbusoob_init(void)
 {
 	DBG("Setup dbusoob plugin");
 
-	oob_register_cb(read_local_data_complete);
-
 	return btd_register_adapter_driver(&oob_driver);
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index 0871a37..073c722 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -157,6 +157,8 @@ struct btd_adapter {
 
 	GSList *drivers;
 	GSList *profiles;
+
+	struct oob_handler *oob_handler;
 };
 
 static gboolean process_auth_queue(gpointer user_data);
@@ -3716,6 +3718,22 @@ int adapter_cancel_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 	return mgmt_cancel_bonding(adapter->dev_id, bdaddr);
 }
 
+static void check_oob_bonding_complete(struct btd_adapter *adapter,
+					bdaddr_t *bdaddr, uint8_t status)
+{
+	if (!adapter->oob_handler || !adapter->oob_handler->bonding_cb)
+		return;
+
+	if (bacmp(bdaddr, &adapter->oob_handler->remote_addr) != 0)
+		return;
+
+	adapter->oob_handler->bonding_cb(adapter, bdaddr, status,
+					adapter->oob_handler->user_data);
+
+	g_free(adapter->oob_handler);
+	adapter->oob_handler = NULL;
+}
+
 void adapter_bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 								uint8_t status)
 {
@@ -3735,6 +3753,8 @@ void adapter_bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		adapter->discov_suspended = FALSE;
 		mgmt_start_discovery(adapter->dev_id);
 	}
+
+	check_oob_bonding_complete(adapter, bdaddr, status);
 }
 
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter)
@@ -3759,3 +3779,27 @@ int btd_adapter_ssp_enabled(struct btd_adapter *adapter)
 {
 	return mgmt_ssp_enabled(adapter->dev_id);
 }
+
+void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
+						struct oob_handler *handler)
+{
+	adapter->oob_handler = handler;
+}
+
+gboolean btd_adapter_check_oob_handler(struct btd_adapter *adapter)
+{
+	return adapter->oob_handler != NULL;
+}
+
+void adapter_read_local_oob_data_complete(struct btd_adapter *adapter,
+					uint8_t *hash, uint8_t *randomizer)
+{
+	if (!adapter->oob_handler || !adapter->oob_handler->read_local_cb)
+		return;
+
+	adapter->oob_handler->read_local_cb(adapter, hash, randomizer,
+					adapter->oob_handler->user_data);
+
+	g_free(adapter->oob_handler);
+	adapter->oob_handler = NULL;
+}
diff --git a/src/adapter.h b/src/adapter.h
index f41ca55..7ca8d95 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -43,6 +43,20 @@
 
 struct btd_adapter;
 
+typedef void (*oob_read_local_cb_t) (struct btd_adapter *adapter,
+					uint8_t *hash, uint8_t *randomizer,
+					void *user_data);
+typedef void (*oob_bonding_cb_t) (struct btd_adapter *adapter,
+					bdaddr_t *bdaddr, uint8_t status,
+					void *user_data);
+
+struct oob_handler {
+	oob_read_local_cb_t read_local_cb;
+	oob_bonding_cb_t bonding_cb;
+	bdaddr_t remote_addr;
+	void *user_data;
+};
+
 struct link_key_info {
 	bdaddr_t bdaddr;
 	unsigned char key[16];
@@ -226,6 +240,8 @@ void adapter_bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							uint8_t status);
 
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter);
+void adapter_read_local_oob_data_complete(struct btd_adapter *adapter,
+					uint8_t *hash, uint8_t *randomizer);
 
 int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 			bdaddr_t *bdaddr, uint8_t *hash, uint8_t *randomizer);
@@ -242,3 +258,7 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 						struct btd_device *device);
 void adapter_connect_list_remove(struct btd_adapter *adapter,
 						struct btd_device *device);
+
+void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
+						struct oob_handler *handler);
+gboolean btd_adapter_check_oob_handler(struct btd_adapter *adapter);
diff --git a/src/mgmt.c b/src/mgmt.c
index d273b2b..b689be8 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -48,7 +48,6 @@
 #include "manager.h"
 #include "device.h"
 #include "event.h"
-#include "oob.h"
 #include "eir.h"
 #include "mgmt.h"
 
@@ -1277,9 +1276,9 @@ static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
 	DBG("hci%u", index);
 
 	adapter = manager_find_adapter_by_id(index);
-
 	if (adapter)
-		oob_read_local_data_complete(adapter, rp->hash, rp->randomizer);
+		adapter_read_local_oob_data_complete(adapter, rp->hash,
+							rp->randomizer);
 }
 
 static void start_discovery_complete(int sk, uint16_t index, uint8_t status,
@@ -1323,9 +1322,8 @@ static void read_local_oob_data_failed(int sk, uint16_t index)
 	DBG("hci%u", index);
 
 	adapter = manager_find_adapter_by_id(index);
-
 	if (adapter)
-		oob_read_local_data_complete(adapter, NULL, NULL);
+		adapter_read_local_oob_data_complete(adapter, NULL, NULL);
 }
 
 static void handle_pending_uuids(uint16_t index)
diff --git a/src/oob.c b/src/oob.c
deleted file mode 100644
index 75798fb..0000000
--- a/src/oob.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011  ST-Ericsson SA
- *
- *  Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
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
-#include "adapter.h"
-#include "oob.h"
-
-static oob_read_cb_t local_oob_read_cb = NULL;
-
-void oob_register_cb(oob_read_cb_t cb)
-{
-	local_oob_read_cb = cb;
-}
-
-void oob_read_local_data_complete(struct btd_adapter *adapter, uint8_t *hash,
-							uint8_t *randomizer)
-{
-	if (local_oob_read_cb)
-		local_oob_read_cb(adapter, hash, randomizer);
-}
diff --git a/src/oob.h b/src/oob.h
deleted file mode 100644
index 5805082..0000000
--- a/src/oob.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011  ST-Ericsson SA
- *
- *  Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
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
-typedef void (*oob_read_cb_t) (struct btd_adapter *adapter, uint8_t *hash,
-							uint8_t *randomizer);
-
-void oob_register_cb(oob_read_cb_t cb);
-
-void oob_read_local_data_complete(struct btd_adapter *adapter, uint8_t *hash,
-							uint8_t *randomizer);
-- 
1.7.9.5

