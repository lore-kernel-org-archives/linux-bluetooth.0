Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/hog: Fix using invalid range for external report
Date: Wed, 25 Jun 2014 14:49:07 +0300
Message-Id: <1403696947-6777-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index 652c374..4f1a4a8 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -303,7 +303,7 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 	DBG("External report reference read, external report characteristic "
 						"UUID: 0x%04x", uuid16);
 	bt_uuid16_create(&uuid, uuid16);
-	gatt_discover_char(hog->attrib, 0x00, 0xff, &uuid,
+	gatt_discover_char(hog->attrib, 0x0001, 0xffff, &uuid,
 					external_service_char_cb, hog);
 }
 
-- 
1.9.3

