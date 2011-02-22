Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH] Fix potential bug in le_advertising_report()
Date: Tue, 22 Feb 2011 14:44:29 -0300
Message-Id: <1298396669-5530-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the current implementation of le_advertising_report(), the variable
'info' has an invalid memory address after the 'for' loop. If 'info'
is dereferenced it will access invalid memory.

This patch fixes this potential bug and improves the code's readability.
---
 plugins/hciops.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index c3d6290..fd19ef4 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2184,14 +2184,19 @@ static inline void le_advertising_report(int index, evt_le_meta_event *meta)
 {
 	struct dev_info *dev = &devs[index];
 	le_advertising_info *info;
-	uint8_t num, i;
+	uint8_t num_reports;
+	const uint8_t RSSI_SIZE = 1;
 
-	num = meta->data[0];
-	info = (le_advertising_info *) (meta->data + 1);
+	num_reports = meta->data[0];
 
-	for (i = 0; i < num; i++) {
+	info = (le_advertising_info *) &meta->data[1];
+	btd_event_advertising_report(&dev->bdaddr, info);
+	num_reports--;
+
+	while (num_reports--) {
+		info = (le_advertising_info *) (info->data + info->length +
+								RSSI_SIZE);
 		btd_event_advertising_report(&dev->bdaddr, info);
-		info = (le_advertising_info *) (info->data + info->length + 1);
 	}
 }
 
-- 
1.7.1

