Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 22/27] android/hog: Enable Input Report notifications only if uhid is created
Date: Fri,  3 Apr 2015 15:43:51 +0200
Message-Id: <1428068636-13073-23-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This prevents against the situation when notification is received
before uhid is created. Otherwise bt_uhid error message appears.
---
 android/hog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index d7a00ba..790f362 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -205,8 +205,6 @@ static void report_reference_cb(bool success, uint8_t status,
 	report->id = value[0];
 	report->type = value[1];
 	DBG("Report ID: 0x%02x Report type: 0x%02x", value[0], value[1]);
-
-	report_enable_notif(report, NULL);
 }
 
 static void external_report_reference_cb(bool success, uint8_t status,
@@ -715,6 +713,7 @@ static bool uhid_create(struct bt_hog *hog, const uint8_t *value, uint16_t vlen)
 		return false;
 	}
 
+	queue_foreach(hog->reports, report_enable_notif, NULL);
 	bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
 	bt_uhid_register(hog->uhid, UHID_FEATURE, get_feature, hog);
 	bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
-- 
1.9.1

