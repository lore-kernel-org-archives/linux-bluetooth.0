Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 11/11] android/gatt: Verify offset on srvc change ccc write
Date: Thu,  8 Jan 2015 10:17:49 +0100
Message-Id: <1420708669-32600-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Protect CCC from remote sending invalid prepare write offset.

We are not using offset value in the code right now, but there is a test
case in PTS that expects this error to be send. PTS can use this embeded
service's ccc descriptor if no such descriptors are added by the user.
---
 android/gatt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index c00eb9e..70b8a00 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -7029,6 +7029,12 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
+	if (offset > 1) {
+			gatt_db_attribute_write_result(attrib, id,
+						ATT_ECODE_INVALID_OFFSET);
+			return;
+	}
+
 	/* 2 octets are expected as CCC value */
 	if (len != 2) {
 		gatt_db_attribute_write_result(attrib, id,
-- 
1.9.1

