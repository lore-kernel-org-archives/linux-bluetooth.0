Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v7 1/9] core: Mutually exclude concurrent connections
Date: Tue, 25 Sep 2012 14:37:58 -0300
Message-Id: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since controllers don't support more than one ongoing connection
procedure at the same time, new connection attempts needs to yield if
there is an ongoing connection procedure already.
---
 src/adapter.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 src/device.c  |  6 +++---
 src/device.h  |  2 +-
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e154c69..47f82c0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -135,6 +135,8 @@ struct btd_adapter {
 	GSList *connect_list;		/* Devices to connect when found */
 	guint discov_id;		/* Discovery timer */
 	gboolean discovering;		/* Discovery active */
+	gboolean connecting;		/* Connect active */
+	guint waiting_to_connect;	/* # of devices waiting to connect */
 	gboolean discov_suspended;	/* Discovery suspended */
 	guint auto_timeout_id;		/* Automatic connections timeout */
 	sdp_list_t *services;		/* Services associated to adapter */
@@ -2242,6 +2244,9 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	call_adapter_powered_callbacks(adapter, TRUE);
 
 	info("Adapter %s has been enabled", adapter->path);
+
+	if (g_slist_length(adapter->connect_list) > 0)
+		mgmt_start_discovery(adapter->dev_id);
 }
 
 static void reply_pending_requests(struct btd_adapter *adapter)
@@ -2565,6 +2570,7 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 						gboolean discovering)
 {
 	const char *path = adapter->path;
+	guint connect_list_len;
 
 	adapter->discovering = discovering;
 
@@ -2579,11 +2585,17 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 	g_slist_free_full(adapter->oor_devices, dev_info_free);
 	adapter->oor_devices = g_slist_copy(adapter->found_devices);
 
-	if (!adapter_has_discov_sessions(adapter) || adapter->discov_suspended)
+	if (adapter->discov_suspended)
+		return;
+
+	connect_list_len = g_slist_length(adapter->connect_list);
+
+	if (!adapter_has_discov_sessions(adapter) && connect_list_len == 0)
 		return;
 
-	DBG("hci%u restarting discovery, disc_sessions %u", adapter->dev_id,
-					g_slist_length(adapter->disc_sessions));
+	DBG("hci%u restarting discovery: disc_sessions %u connect_list_len %u",
+		adapter->dev_id, g_slist_length(adapter->disc_sessions),
+							connect_list_len);
 
 	adapter->discov_id = g_idle_add(discovery_cb, adapter);
 }
@@ -2890,17 +2902,46 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer,
 	return textfile_get(filename, key);
 }
 
+static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct btd_device *device = user_data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+
+	adapter->connecting = FALSE;
+
+	if (adapter->waiting_to_connect == 0 &&
+				g_slist_length(adapter->connect_list) > 0)
+		mgmt_start_discovery(adapter->dev_id);
+
+	btd_device_unref(device);
+
+	return FALSE;
+}
+
 static gboolean connect_pending_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device_get_adapter(device);
+	GIOChannel *io;
 
 	/* in the future we may want to check here if the controller supports
 	 * scanning and connecting at the same time */
 	if (adapter->discovering)
 		return TRUE;
 
-	device_att_connect(device);
+	if (adapter->connecting)
+		return TRUE;
+
+	adapter->connecting = TRUE;
+	adapter->waiting_to_connect--;
+
+	io = device_att_connect(device);
+	g_io_add_watch(io, G_IO_OUT | G_IO_ERR, clean_connecting_state,
+						btd_device_ref(device));
+	g_io_channel_unref(io);
+
+	btd_device_unref(device);
 
 	return FALSE;
 }
@@ -2993,12 +3034,19 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 	if (bdaddr_type == BDADDR_LE_PUBLIC ||
 					bdaddr_type == BDADDR_LE_RANDOM) {
+		struct btd_device *device;
+
 		l = g_slist_find_custom(adapter->connect_list, bdaddr,
 					(GCompareFunc) device_bdaddr_cmp);
-		if (l) {
-			g_idle_add(connect_pending_cb, l->data);
-			stop_discovery(adapter);
-		}
+		if (!l)
+			goto done;
+
+		device = l->data;
+		adapter_connect_list_remove(adapter, device);
+
+		g_idle_add(connect_pending_cb,  btd_device_ref(device));
+		stop_discovery(adapter);
+		adapter->waiting_to_connect++;
 	}
 
 done:
diff --git a/src/device.c b/src/device.c
index 57fdf00..5d92ff5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2007,7 +2007,7 @@ static void att_success_cb(gpointer user_data)
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
 }
 
-gboolean device_att_connect(gpointer user_data)
+GIOChannel *device_att_connect(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device->adapter;
@@ -2050,12 +2050,12 @@ gboolean device_att_connect(gpointer user_data)
 		error("ATT bt_io_connect(%s): %s", addr, gerr->message);
 		g_error_free(gerr);
 		g_free(attcb);
-		return FALSE;
+		return NULL;
 	}
 
 	device->att_io = io;
 
-	return FALSE;
+	return g_io_channel_ref(io);
 }
 
 static void att_browse_error_cb(const GError *gerr, gpointer user_data)
diff --git a/src/device.h b/src/device.h
index aee6d13..d9aa6f5 100644
--- a/src/device.h
+++ b/src/device.h
@@ -124,4 +124,4 @@ int device_unblock(struct btd_device *device, gboolean silent,
 void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver);
-gboolean device_att_connect(gpointer user_data);
+GIOChannel *device_att_connect(gpointer user_data);
-- 
1.7.11.4

