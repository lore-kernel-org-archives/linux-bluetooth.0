Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/bluetooth: Fix possible NULL dereference
Date: Mon, 25 Nov 2013 11:47:03 +0200
Message-Id: <1385372823-17035-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since sdp_record_find() may return NULL check this value.
---
 android/bluetooth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index aa684bd..ad8af0d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1332,6 +1332,7 @@ static void set_device_id(void)
 	struct mgmt_cp_set_device_id cp;
 	uint8_t major, minor;
 	uint16_t version;
+	sdp_record_t *rec;
 
 	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
 		return;
@@ -1351,7 +1352,9 @@ static void set_device_id(void)
 	register_device_id(DEVICE_ID_SOURCE, DEVICE_ID_VENDOR,
 						DEVICE_ID_PRODUCT, version);
 
-	bt_adapter_add_record(sdp_record_find(0x10000), 0x00);
+	rec = sdp_record_find(0x10000);
+	if (rec)
+		bt_adapter_add_record(rec, 0x00);
 }
 
 static void set_adapter_name_complete(uint8_t status, uint16_t length,
-- 
1.8.3.2

