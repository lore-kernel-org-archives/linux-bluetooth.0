Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v3 1/4] Initial advertising data parsing implementation
Date: Thu, 11 Nov 2010 20:39:26 -0300
Message-Id: <1289518769-3009-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Implement adapter_update_adv() function to parse advertising data
received by btd_event_adv() function. Add some fields for advertising
data in remote_device_info struct.
---
 plugins/hciops.c |    9 +++------
 src/adapter.c    |   26 ++++++++++++++++++++++++++
 src/adapter.h    |    6 ++++++
 src/event.c      |   13 +++++++++++++
 src/event.h      |    1 +
 5 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 418c824..6a88294 100644
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
+		btd_event_advertising_report(&BDADDR(index), info);
+		info = (le_advertising_info *) (info->data + info->length + 1);
 	}
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index 1f39bcc..4ebf953 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3136,6 +3136,31 @@ static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
 	return dev;
 }
 
+void adapter_update_device_from_info(struct btd_adapter *adapter,
+						le_advertising_info *info)
+{
+	struct remote_dev_info *dev;
+	bdaddr_t bdaddr;
+	gboolean new_dev;
+	int8_t rssi;
+
+	rssi = *(info->data + info->length);
+	bdaddr = info->bdaddr;
+
+	dev = get_found_dev(adapter, &bdaddr, &new_dev);
+
+	if (new_dev) {
+		dev->le = TRUE;
+		dev->evt_type = info->evt_type;
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
@@ -3153,6 +3178,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 		if (alias)
 			dev->alias = g_strdup(alias);
 
+		dev->le = FALSE;
 		dev->class = class;
 		dev->legacy = legacy;
 		dev->name_status = name_status;
diff --git a/src/adapter.h b/src/adapter.h
index b0eedb6..e6d2fe6 100644
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
@@ -118,6 +122,8 @@ int adapter_get_discover_type(struct btd_adapter *adapter);
 gboolean adapter_is_ready(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
+void adapter_update_device_from_info(struct btd_adapter *adapter,
+						le_advertising_info *info);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
diff --git a/src/event.c b/src/event.c
index a057306..b6a851e 100644
--- a/src/event.c
+++ b/src/event.c
@@ -322,6 +322,19 @@ static char *extract_eir_name(uint8_t *data, uint8_t *type)
 	return NULL;
 }
 
+void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
+{
+	struct btd_adapter *adapter;
+
+	adapter = manager_find_adapter(local);
+	if (adapter == NULL) {
+		error("No matching adapter found");
+		return;
+	}
+
+	adapter_update_device_from_info(adapter, info);
+}
+
 void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 				int8_t rssi, uint8_t *data)
 {
diff --git a/src/event.h b/src/event.h
index 4a7b9c9..66f3b56 100644
--- a/src/event.h
+++ b/src/event.h
@@ -23,6 +23,7 @@
  */
 
 int btd_event_request_pin(bdaddr_t *sba, struct hci_conn_info *ci);
+void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info);
 void btd_event_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi, uint8_t *data);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
 void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
-- 
1.7.3.2

