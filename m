Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v2 04/14] core: Add a list of LE devices to connect
Date: Wed, 15 Aug 2012 11:50:43 -0300
Message-Id: <1345042253-15053-5-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commit creates a per-adapter list of LE devices to connect when a
advertising from them is seen during a scan.
---
 src/adapter.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h |  3 +++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2ceac5c..080b03f 100644
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
@@ -2181,6 +2182,32 @@ const char *btd_adapter_get_name(struct btd_adapter *adapter)
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
@@ -2845,6 +2872,21 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer,
 	return textfile_get(filename, key);
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
@@ -2856,6 +2898,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	gboolean legacy, name_known;
 	uint32_t dev_class;
 	int err;
+	GSList *l;
 
 	memset(&eir_data, 0, sizeof(eir_data));
 	err = eir_parse(&eir_data, data, data_len);
@@ -2878,7 +2921,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 								eir_data.name);
 
 	dev = adapter_search_found_devices(adapter, bdaddr);
-	if (dev) {
+	if (dev && dev->bdaddr_type == BDADDR_BREDR) {
 		adapter->oor_devices = g_slist_remove(adapter->oor_devices,
 							dev);
 
@@ -2930,6 +2973,16 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
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
index 5a0247e..32f3a6d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -232,3 +232,6 @@ int btd_adapter_gatt_server_start(struct btd_adapter *adapter);
 void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
 
 int btd_adapter_ssp_enabled(struct btd_adapter *adapter);
+
+void adapter_connect_list_add(struct btd_adapter *adapter, struct btd_device *device);
+void adapter_connect_list_remove(struct btd_adapter *adapter, struct btd_device *device);
-- 
1.7.11.2

