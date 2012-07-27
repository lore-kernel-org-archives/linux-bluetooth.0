Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 04/14] core: Add a list of LE devices to connect
Date: Fri, 27 Jul 2012 19:29:48 -0300
Message-Id: <1343428198-23621-5-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
References: <1343428198-23621-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit creates a per-adapter list of LE devices to connect when a
advertising from them is seen during a scan.
---
 src/adapter.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h |    2 ++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5dd9821..d0f8d6b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -132,6 +132,7 @@ struct btd_adapter {
 	GSList *devices;		/* Devices structure pointers */
 	GSList *mode_sessions;		/* Request Mode sessions */
 	GSList *disc_sessions;		/* Discovery sessions */
+	GSList *connect_list;		/* Devices to connect when found */
 	guint discov_id;		/* Discovery timer */
 	gboolean discovering;		/* Discovery active */
 	gboolean discov_suspended;	/* Discovery suspended */
@@ -2166,6 +2167,32 @@ const char *btd_adapter_get_name(struct btd_adapter *adapter)
 	return adapter->name;
 }
 
+void adapter_connect_list_add(struct btd_adapter *adapter,
+					struct btd_device *device)
+{
+	bdaddr_t bdaddr;
+
+	device_get_address(device, &bdaddr, NULL);
+	if (g_slist_find_custom(adapter->connect_list, &bdaddr,
+					(GCompareFunc) device_bdaddr_cmp)) {
+		DBG("trying to add device %s which is already in the connect "
+				"list, ignoring", device_get_path(device));
+		return;
+	}
+
+	adapter->connect_list = g_slist_append(adapter->connect_list, device);
+	DBG("%s added to %s's connect_list", device_get_path(device),
+								adapter->name);
+}
+
+void adapter_connect_list_remove(struct btd_adapter *adapter,
+					struct btd_device *device)
+{
+	adapter->connect_list = g_slist_remove(adapter->connect_list, device);
+	DBG("%s removed from %s's connect_list", device_get_path(device),
+								adapter->name);
+}
+
 void btd_adapter_start(struct btd_adapter *adapter)
 {
 	char address[18];
@@ -2820,6 +2847,21 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer, const char *file)
 	return textfile_get(filename, peer_addr);
 }
 
+static gboolean connect_pending_cb(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+
+	/* in the future we may want to check here if the controller supports
+	 * scanning and connecting at the same time */
+	if (adapter->discovering)
+		return TRUE;
+
+	/* TODO: call device connect callback */
+
+	return FALSE;
+}
+
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, uint8_t confirm_name,
@@ -2831,6 +2873,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	gboolean legacy, name_known;
 	uint32_t dev_class;
 	int err;
+	GSList *l;
 
 	memset(&eir_data, 0, sizeof(eir_data));
 	err = eir_parse(&eir_data, data, data_len);
@@ -2853,7 +2896,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 								eir_data.name);
 
 	dev = adapter_search_found_devices(adapter, bdaddr);
-	if (dev) {
+	if (dev && dev->bdaddr_type == BDADDR_BREDR) {
 		adapter->oor_devices = g_slist_remove(adapter->oor_devices,
 							dev);
 
@@ -2904,6 +2947,16 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 	adapter->found_devices = g_slist_prepend(adapter->found_devices, dev);
 
+	if (bdaddr_type == BDADDR_LE_PUBLIC ||
+					bdaddr_type == BDADDR_LE_RANDOM) {
+		l = g_slist_find_custom(adapter->connect_list, bdaddr,
+					(GCompareFunc) device_bdaddr_cmp);
+		if (l) {
+			g_idle_add(connect_pending_cb, l->data);
+			stop_discovery(adapter);
+		}
+	}
+
 done:
 	dev->rssi = rssi;
 
diff --git a/src/adapter.h b/src/adapter.h
index 602bb6f..e31f355 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -230,3 +230,5 @@ int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 
 int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
 void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
+void adapter_connect_list_add(struct btd_adapter *adapter, struct btd_device *device);
+void adapter_connect_list_remove(struct btd_adapter *adapter, struct btd_device *device);
-- 
1.7.10.4

