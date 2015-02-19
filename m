Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/2] core: gatt: Fix incorrect response on CCC read
Date: Wed, 18 Feb 2015 16:12:34 -0800
Message-Id: <1424304754-11874-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1424304754-11874-1-git-send-email-armansito@chromium.org>
References: <1424304754-11874-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug where a CCC read on the local GATT server always
returned a 0-length value.
---
 src/gatt-database.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 5e83ce1..e876141 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -495,7 +495,7 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
 		goto done;
 	}
 
-	len -= offset;
+	len = 2 - offset;
 	value = len ? &ccc->value[offset] : NULL;
 
 done:
@@ -517,7 +517,7 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
 
 	handle = gatt_db_attribute_get_handle(attrib);
 
-	DBG("CCC read called for handle: 0x%04x", handle);
+	DBG("CCC write called for handle: 0x%04x", handle);
 
 	if (!value || len != 2) {
 		ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
-- 
2.2.0.rc0.207.ga3a616c

