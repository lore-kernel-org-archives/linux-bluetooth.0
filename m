Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 3/5] android/gatt: Fix not confirming write commands in database
Date: Tue,  9 Dec 2014 09:51:48 +0100
Message-Id: <1418115110-25335-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

App will never confirm write command as commands dont need one but we
still need to confirm in databasse. We confirm immediately.
---
 android/gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 841f08c..536a7fe 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4904,6 +4904,8 @@ static void write_cb(struct gatt_db_attribute *attrib, unsigned int id,
 
 	if (opcode == ATT_OP_WRITE_REQ || opcode == ATT_OP_PREP_WRITE_REQ)
 		ev->need_rsp = 0x01;
+	else
+		gatt_db_attribute_write_result(attrib, id, 0);
 
 	ev->length = len;
 	memcpy(ev->value, value, len);
-- 
1.9.1

