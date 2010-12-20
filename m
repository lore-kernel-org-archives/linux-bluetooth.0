Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 2/2] Remove le_advertising_info struct from adapter.c
Date: Mon, 20 Dec 2010 14:16:45 -0400
Message-Id: <1292869005-12391-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1292869005-12391-1-git-send-email-bruna.moreira@openbossa.org>
References: <1292869005-12391-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   13 ++++---------
 src/adapter.h |    6 +++---
 src/event.c   |    6 +++++-
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index db3649f..5cdf4c2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2763,23 +2763,18 @@ static void remove_same_uuid(gpointer data, gpointer user_data)
 }
 
 void adapter_update_device_from_info(struct btd_adapter *adapter,
-						le_advertising_info *info,
-						char *name, GSList *services,
-						uint8_t flags)
+						bdaddr_t bdaddr, int8_t rssi,
+						uint8_t evt_type, char *name,
+						GSList *services, uint8_t flags)
 {
 	struct remote_dev_info *dev;
-	bdaddr_t bdaddr;
 	gboolean new_dev;
-	int8_t rssi;
-
-	rssi = *(info->data + info->length);
-	bdaddr = info->bdaddr;
 
 	dev = get_found_dev(adapter, &bdaddr, &new_dev);
 
 	if (new_dev) {
 		dev->le = TRUE;
-		dev->evt_type = info->evt_type;
+		dev->evt_type = evt_type;
 	} else if (dev->rssi == rssi)
 		return;
 
diff --git a/src/adapter.h b/src/adapter.h
index a390088..039c30b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -136,9 +136,9 @@ int adapter_get_discover_type(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
 void adapter_update_device_from_info(struct btd_adapter *adapter,
-						le_advertising_info *info,
-						char *name, GSList *services,
-						uint8_t flags);
+						bdaddr_t bdaddr, int8_t rssi,
+						uint8_t evt_type, char *name,
+						GSList *services, uint8_t flags);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
diff --git a/src/event.c b/src/event.c
index 3603643..55a83c2 100644
--- a/src/event.c
+++ b/src/event.c
@@ -435,6 +435,7 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 {
 	struct btd_adapter *adapter;
 	struct eir_data eir_data;
+	int8_t rssi;
 	int err;
 
 	adapter = manager_find_adapter(local);
@@ -450,7 +451,10 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 		error("Error parsing advertising data: %s (%d)",
 							strerror(-err), -err);
 
-	adapter_update_device_from_info(adapter, info, eir_data.name,
+	rssi = *(info->data + info->length);
+
+	adapter_update_device_from_info(adapter, info->bdaddr, rssi,
+					info->evt_type, eir_data.name,
 					eir_data.services, eir_data.flags);
 }
 
-- 
1.7.0.4

