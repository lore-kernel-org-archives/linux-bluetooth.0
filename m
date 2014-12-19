Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2] android/gatt: Report error on invalid value length for CCC descriptor
Date: Fri, 19 Dec 2014 07:50:14 +0100
Message-Id: <1418971814-24965-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For application services, characteristics and descriptors it's user
app's responsibility to verify value length but for embeded ones we
need to do this in daemon. This is checked in TC_GAW_SR_BI_34_C and
PTS tries to write to embeded CCC descritor if no other descriptors
are added by the apps. It is expected by PTS for us to be more strict
about value length controll.
---
 android/gatt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0258d91..76df029 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6961,8 +6961,15 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
+	/* 2 octets are expected as CCC value */
+	if (len != 2) {
+		gatt_db_attribute_write_result(attrib, id,
+						ATT_ECODE_INVAL_ATTR_VALUE_LEN);
+		return;
+	}
+
 	/* Set services changed indication value */
-	bt_store_gatt_ccc(bdaddr, *value);
+	bt_store_gatt_ccc(bdaddr, get_le16(value));
 
 	gatt_db_attribute_write_result(attrib, id, 0);
 }
-- 
1.9.1

