Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 06/14] core: gatt: Reset value in db when caching
Date: Wed,  7 Jan 2015 21:48:20 -0800
Message-Id: <1420696108-29699-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After an attribute value is read, changes in the attribute value length
may cause incorrect bytes to remain in the database if the value is not
properly truncated. This patch addresses this by resetting the attribute
value before storing an updated value.
---
 src/gatt-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index a118870..46af263 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -344,6 +344,7 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 		return;
 	}
 
+	gatt_db_attribute_reset(desc->attr);
 	gatt_db_attribute_write(desc->attr, 0, value, length, 0, NULL,
 						write_descriptor_cb, desc);
 
@@ -773,6 +774,7 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 		return ;
 	}
 
+	gatt_db_attribute_reset(chrc->attr);
 	gatt_db_attribute_write(chrc->attr, 0, value, length, op->offset, NULL,
 						write_characteristic_cb, chrc);
 
-- 
2.2.0.rc0.207.ga3a616c

