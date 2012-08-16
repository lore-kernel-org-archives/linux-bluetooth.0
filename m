Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v3 06/14] core: mutually exclude concurrent connections
Date: Thu, 16 Aug 2012 18:28:36 -0300
Message-Id: <1345152524-13404-7-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
References: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since controllers don't support more than one ongoing connection
procedure at the same time, new connection attempts needs to yield if
there is an ongoing connection procedure already.
---
 src/adapter.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 src/device.c  |  4 ++--
 src/device.h  |  2 +-
 3 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2d8d6c8..7953621 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -133,8 +133,10 @@ struct btd_adapter {
 	GSList *mode_sessions;		/* Request Mode sessions */
 	GSList *disc_sessions;		/* Discovery sessions */
 	GSList *connect_list;		/* Devices to connect when found */
+	GSList *connecting_list;	/* Pending connects */
 	guint discov_id;		/* Discovery timer */
 	gboolean discovering;		/* Discovery active */
+	gboolean connecting;		/* Connect active */
 	gboolean discov_suspended;	/* Discovery suspended */
 	guint auto_timeout_id;		/* Automatic connections timeout */
 	sdp_list_t *services;		/* Services associated to adapter */
@@ -2231,6 +2233,9 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	call_adapter_powered_callbacks(adapter, TRUE);
 
 	info("Adapter %s has been enabled", adapter->path);
+
+	if (g_slist_length(adapter->connect_list))
+		mgmt_start_discovery(adapter->dev_id);
 }
 
 static void reply_pending_requests(struct btd_adapter *adapter)
@@ -2544,6 +2549,7 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 						gboolean discovering)
 {
 	const char *path = adapter->path;
+	guint connect_list_size;
 
 	adapter->discovering = discovering;
 
@@ -2558,11 +2564,17 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 	g_slist_free_full(adapter->oor_devices, dev_info_free);
 	adapter->oor_devices = g_slist_copy(adapter->found_devices);
 
-	if (!adapter_has_discov_sessions(adapter) || adapter->discov_suspended)
+	if (adapter->discov_suspended)
 		return;
 
-	DBG("hci%u restarting discovery, disc_sessions %u", adapter->dev_id,
-					g_slist_length(adapter->disc_sessions));
+	connect_list_size = g_slist_length(adapter->connect_list);
+
+	if (!adapter_has_discov_sessions(adapter) && !connect_list_size)
+		return;
+
+	DBG("hci%u restarting discovery: disc_sessions %u, connect_list size "
+		"%u", adapter->dev_id, g_slist_length(adapter->disc_sessions),
+							connect_list_size);
 
 	adapter->discov_id = g_idle_add(discovery_cb, adapter);
 }
@@ -2868,17 +2880,44 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer,
 	return textfile_get(filename, key);
 }
 
+static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond, gpointer user_data)
+{
+	struct btd_device *device = user_data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+
+	adapter_connect_list_remove(adapter, device);
+	adapter->connecting_list = g_slist_remove(adapter->connecting_list,
+								device);
+
+	adapter->connecting = FALSE;
+
+	if (!g_slist_length(adapter->connecting_list) &&
+					g_slist_length(adapter->connect_list))
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
+	io = device_att_connect(device);
+	g_io_add_watch(io, G_IO_OUT | G_IO_ERR, clean_connecting_state,
+						btd_device_ref(device));
 
 	return FALSE;
 }
@@ -2971,12 +3010,22 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
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
+		l = g_slist_find(adapter->connecting_list, device);
+		if (l)
+			goto done;
+
+		g_idle_add(connect_pending_cb, device);
+		adapter->connecting_list = g_slist_append(
+					adapter->connecting_list, device);
+		stop_discovery(adapter);
 	}
 
 done:
diff --git a/src/device.c b/src/device.c
index 48b27ca..1f64d20 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1976,7 +1976,7 @@ static void att_success_cb(gpointer user_data)
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
 }
 
-gboolean device_att_connect(gpointer user_data)
+GIOChannel *device_att_connect(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	struct btd_adapter *adapter = device->adapter;
@@ -2024,7 +2024,7 @@ gboolean device_att_connect(gpointer user_data)
 
 	device->att_io = io;
 
-	return FALSE;
+	return io;
 }
 
 static void att_browse_error_cb(const GError *gerr, gpointer user_data)
diff --git a/src/device.h b/src/device.h
index 9b7df1c..5f51745 100644
--- a/src/device.h
+++ b/src/device.h
@@ -127,4 +127,4 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver);
-gboolean device_att_connect(gpointer user_data);
+GIOChannel *device_att_connect(gpointer user_data);
-- 
1.7.11.2

