Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 4/7] Initial advertising data parsing implementation
Date: Wed, 10 Nov 2010 13:51:24 -0400
Message-Id: <1289411487-6113-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Implement adapter_update_adv() function to parse advertising data
received by btd_event_adv() function. Add some fields for advertising
data in remote_device_info struct.
---
 plugins/hciops.c |    9 +++------
 src/adapter.c    |   23 +++++++++++++++++++++++
 src/adapter.h    |    5 +++++
 src/event.c      |   13 +++++++++++++
 src/event.h      |    1 +
 5 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index fc99275..dc7a657 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1011,7 +1011,7 @@ static inline void le_metaevent(int index, void *ptr)
 {
 	evt_le_meta_event *meta = ptr;
 	le_advertising_info *info;
-	uint8_t *rssi, num, i;
+	uint8_t num, i;
 
 	DBG("LE Meta Event");
 
@@ -1022,11 +1022,8 @@ static inline void le_metaevent(int index, void *ptr)
 	info = (le_advertising_info *) (meta->data + 1);
 
 	for (i = 0; i < num; i++) {
-		/* RSSI is last byte of the advertising report event */
-		rssi = info->data + info->length;
-		btd_event_inquiry_result(&BDADDR(index), &info->bdaddr, 0,
-								*rssi, NULL);
-		info = (le_advertising_info *) (rssi + 1);
+		btd_event_adv(&BDADDR(index), info);
+		info = (le_advertising_info *) (info->data + info->length + 1);
 	}
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index c54d035..6b94a43 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3137,6 +3137,28 @@ static gboolean update_found_devices(struct btd_adapter *adapter,
 	return found;
 }
 
+void adapter_update_adv(struct btd_adapter *adapter, le_advertising_info *info)
+{
+	struct remote_dev_info *dev;
+	bdaddr_t bdaddr;
+	int8_t rssi = 0;
+
+	rssi = *(info->data + info->length);
+	bdaddr = info->bdaddr;
+
+	if (!update_found_devices(adapter, &bdaddr, rssi, &dev)) {
+		dev->le = TRUE;
+		dev->evt_type = info->evt_type;
+		bacpy(&dev->bdaddr, &info->bdaddr);
+	} else if (dev->rssi == rssi)
+		return;
+
+	dev->rssi = rssi;
+
+	adapter->found_devices = g_slist_sort(adapter->found_devices,
+						(GCompareFunc) dev_rssi_cmp);
+}
+
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
@@ -3145,6 +3167,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	struct remote_dev_info *dev;
 
 	if (!update_found_devices(adapter, bdaddr, rssi, &dev)) {
+		dev->le = FALSE;
 		dev->class = class;
 		if (name)
 			dev->name = g_strdup(name);
diff --git a/src/adapter.h b/src/adapter.h
index 89b07d7..766b079 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -69,6 +69,10 @@ struct remote_dev_info {
 	char *alias;
 	dbus_bool_t legacy;
 	name_status_t name_status;
+	gboolean le;
+	/* LE adv data */
+	uint8_t evt_type;
+	uint8_t bdaddr_type;
 };
 
 struct hci_dev {
@@ -118,6 +122,7 @@ int adapter_get_discover_type(struct btd_adapter *adapter);
 gboolean adapter_is_ready(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
+void adapter_update_adv(struct btd_adapter *adapter, le_advertising_info *info);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
diff --git a/src/event.c b/src/event.c
index a057306..8b03bc3 100644
--- a/src/event.c
+++ b/src/event.c
@@ -322,6 +322,19 @@ static char *extract_eir_name(uint8_t *data, uint8_t *type)
 	return NULL;
 }
 
+void btd_event_adv(bdaddr_t *local, le_advertising_info *info)
+{
+	struct btd_adapter *adapter;
+
+	adapter = manager_find_adapter(local);
+	if (adapter == NULL) {
+		error("No matching adapter found");
+		return;
+	}
+
+	adapter_update_adv(adapter, info);
+}
+
 void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 				int8_t rssi, uint8_t *data)
 {
diff --git a/src/event.h b/src/event.h
index 4a7b9c9..44e1462 100644
--- a/src/event.h
+++ b/src/event.h
@@ -23,6 +23,7 @@
  */
 
 int btd_event_request_pin(bdaddr_t *sba, struct hci_conn_info *ci);
+void btd_event_adv(bdaddr_t *local, le_advertising_info *info);
 void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi, uint8_t *data);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
-- 
1.7.0.4

