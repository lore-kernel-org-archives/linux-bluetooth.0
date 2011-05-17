Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v4 08/12] Remove btd_event_advertising_report
Date: Tue, 17 May 2011 15:26:12 -0300
Message-Id: <1305656772-9803-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1305579001-3019-8-git-send-email-claudio.takahasi@openbossa.org>
References: <1305579001-3019-8-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Advertises should be notified using btd_event_device_found function
to keep the compatibility with mgmtops plugin.
---
 plugins/hciops.c |   13 ++++++++++---
 src/event.c      |   17 -----------------
 src/event.h      |    1 -
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 07643a1..65ad4f3 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2171,19 +2171,26 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 {
 	struct dev_info *dev = &devs[index];
 	le_advertising_info *info;
-	uint8_t num_reports;
+	uint8_t num_reports, rssi;
 	const uint8_t RSSI_SIZE = 1;
 
 	num_reports = meta->data[0];
 
 	info = (le_advertising_info *) &meta->data[1];
-	btd_event_advertising_report(&dev->bdaddr, info);
+	rssi = *(info->data + info->length);
+
+	btd_event_device_found(&dev->bdaddr, &info->bdaddr, 0, rssi,
+								info->data);
+
 	num_reports--;
 
 	while (num_reports--) {
 		info = (le_advertising_info *) (info->data + info->length +
 								RSSI_SIZE);
-		btd_event_advertising_report(&dev->bdaddr, info);
+		rssi = *(info->data + info->length);
+
+		btd_event_device_found(&dev->bdaddr, &info->bdaddr, 0, rssi,
+								info->data);
 	}
 }
 
diff --git a/src/event.c b/src/event.c
index 115b285..3ee8802 100644
--- a/src/event.c
+++ b/src/event.c
@@ -281,23 +281,6 @@ void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
-{
-	struct btd_adapter *adapter;
-	int8_t rssi;
-
-	adapter = manager_find_adapter(local);
-	if (adapter == NULL) {
-		error("No matching adapter found");
-		return;
-	}
-
-	rssi = *(info->data + info->length);
-
-	adapter_update_found_devices(adapter, &info->bdaddr, 0, rssi,
-						info->data, info->length);
-}
-
 static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
 {
 	time_t t;
diff --git a/src/event.h b/src/event.h
index 005d8a7..22c199e 100644
--- a/src/event.h
+++ b/src/event.h
@@ -23,7 +23,6 @@
  */
 
 int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba);
-void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 						int8_t rssi, uint8_t *data);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
-- 
1.7.5.rc3

