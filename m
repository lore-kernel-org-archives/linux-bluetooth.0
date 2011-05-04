Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/3] Remove advertise event type from adapter functions
Date: Wed,  4 May 2011 10:13:48 -0400
Message-Id: <1304518429-8527-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1304518429-8527-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1304518429-8527-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 src/adapter.c |    9 ++++-----
 src/adapter.h |    5 ++---
 src/event.c   |    4 ++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 82002e7..aa8f5d4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3059,18 +3059,17 @@ static void dev_prepend_uuid(gpointer data, gpointer user_data)
 
 void adapter_update_device_from_info(struct btd_adapter *adapter,
 					bdaddr_t bdaddr, int8_t rssi,
-					uint8_t evt_type, const char *name,
-					GSList *services, int flags)
+					const char *name, GSList *services,
+					int flags)
 {
 	struct remote_dev_info *dev;
 	gboolean new_dev;
 
 	dev = get_found_dev(adapter, &bdaddr, &new_dev);
 
-	if (new_dev) {
+	if (new_dev)
 		dev->le = TRUE;
-		dev->evt_type = evt_type;
-	} else if (dev->rssi == rssi)
+	else if (dev->rssi == rssi)
 		return;
 
 	dev->rssi = rssi;
diff --git a/src/adapter.h b/src/adapter.h
index 7cc7c02..a305fa7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -84,7 +84,6 @@ struct remote_dev_info {
 	char **uuids;
 	size_t uuid_count;
 	GSList *services;
-	uint8_t evt_type;
 	uint8_t bdaddr_type;
 	uint8_t flags;
 };
@@ -120,8 +119,8 @@ struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter
 						struct remote_dev_info *match);
 void adapter_update_device_from_info(struct btd_adapter *adapter,
 					bdaddr_t bdaddr, int8_t rssi,
-					uint8_t evt_type, const char *name,
-					GSList *services, int flags);
+					const char *name, GSList *services,
+					int flags);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				int8_t rssi, uint32_t class, const char *name,
 				const char *alias, gboolean legacy,
diff --git a/src/event.c b/src/event.c
index 5373e33..c9d8d8c 100644
--- a/src/event.c
+++ b/src/event.c
@@ -399,8 +399,8 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
 	rssi = *(info->data + info->length);
 
 	adapter_update_device_from_info(adapter, info->bdaddr, rssi,
-					info->evt_type, eir_data.name,
-					eir_data.services, eir_data.flags);
+					eir_data.name, eir_data.services,
+					eir_data.flags);
 
 	free_eir_data(&eir_data);
 }
-- 
1.7.0.4

