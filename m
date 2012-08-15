Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v2 05/14] core: use adapter connect list for LE connections
Date: Wed, 15 Aug 2012 11:50:44 -0300
Message-Id: <1345042253-15053-6-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a connection is needed for a LE device it is added to the adapter
connect list instead of directly connecting the ATT io channel.
---
 src/adapter.c |  2 +-
 src/device.c  | 43 +++++++++++--------------------------------
 src/device.h  |  1 +
 3 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 080b03f..ea707d3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2882,7 +2882,7 @@ static gboolean connect_pending_cb(gpointer user_data)
 	if (adapter->discovering)
 		return TRUE;
 
-	/* TODO: call device connect callback */
+	device_att_connect(device);
 
 	return FALSE;
 }
diff --git a/src/device.c b/src/device.c
index 24b9065..e677976 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1798,15 +1798,6 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 		attio->dcfunc(attio->user_data);
 }
 
-static void att_connect_dispatched(gpointer user_data)
-{
-	struct btd_device *device = user_data;
-
-	device->auto_id = 0;
-}
-
-static gboolean att_connect(gpointer user_data);
-
 static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1826,10 +1817,7 @@ static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 	if (device->auto_connect == FALSE || err != ETIMEDOUT)
 		goto done;
 
-	device->auto_id = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT_IDLE,
-						AUTO_CONNECTION_INTERVAL,
-						att_connect, device,
-						att_connect_dispatched);
+	adapter_connect_list_add(device_get_adapter(device), device);
 
 done:
 	attio_cleanup(device);
@@ -1973,11 +1961,7 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
 	if (device->auto_connect == FALSE)
 		return;
 
-	device->auto_id = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT_IDLE,
-						AUTO_CONNECTION_INTERVAL,
-						att_connect, device,
-						att_connect_dispatched);
-
+	adapter_connect_list_add(device_get_adapter(device), device);
 	DBG("Enabling automatic connections");
 }
 
@@ -1992,7 +1976,7 @@ static void att_success_cb(gpointer user_data)
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
 }
 
-static gboolean att_connect(gpointer user_data)
+gboolean device_att_connect(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device->adapter;
@@ -2262,6 +2246,9 @@ void device_set_temporary(struct btd_device *device, gboolean temporary)
 
 	DBG("temporary %d", temporary);
 
+	if (temporary)
+		adapter_connect_list_remove(device_get_adapter(device), device);
+
 	device->temporary = temporary;
 }
 
@@ -2277,6 +2264,7 @@ void device_set_bonded(struct btd_device *device, gboolean bonded)
 
 void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
+	struct btd_adapter *adapter = device_get_adapter(device);
 	char addr[18];
 
 	if (!device)
@@ -2290,15 +2278,10 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 
 	/* Disabling auto connect */
 	if (enable == FALSE) {
-		if (device->auto_id)
-			g_source_remove(device->auto_id);
+		adapter_connect_list_remove(adapter, device);
 		return;
 	}
 
-	/* Enabling auto connect */
-	if (device->auto_id != 0)
-		return;
-
 	if (device->attrib) {
 		DBG("Already connected");
 		return;
@@ -2307,9 +2290,8 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 	if (device->attios == NULL && device->attios_offline == NULL)
 		return;
 
-	device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
-						att_connect, device,
-						att_connect_dispatched);
+	/* Enabling auto connect */
+	adapter_connect_list_add(adapter, device);
 }
 
 static gboolean start_discovery(gpointer user_data)
@@ -3091,10 +3073,7 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 
 	device->attios = g_slist_append(device->attios, attio);
 
-	if (device->auto_id == 0)
-		device->auto_id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE,
-						att_connect, device,
-						att_connect_dispatched);
+	adapter_connect_list_add(device_get_adapter(device), device);
 
 	return attio->id;
 }
diff --git a/src/device.h b/src/device.h
index 2b2e6d8..9b7df1c 100644
--- a/src/device.h
+++ b/src/device.h
@@ -127,3 +127,4 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver);
+gboolean device_att_connect(gpointer user_data);
-- 
1.7.11.2

