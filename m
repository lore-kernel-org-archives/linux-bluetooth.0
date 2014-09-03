Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH] shared/gatt-client: Fix invalid access during descriptor discovery.
Date: Wed,  3 Sep 2014 13:26:28 -0700
Message-Id: <1409775988-24535-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an off-by-one error during descriptor discovery, which results
in an invalid access if more than one descriptor declaration exists within a
service handle range.
---
 src/shared/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 101e47e..1a157ec 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -229,7 +229,7 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 	op->cur_chrc->num_descs = desc_count;
 	op->cur_chrc->descs = descs;
 
-	for (i = op->cur_chrc_index;
+	for (i = op->cur_chrc_index + 1;
 				i < op->cur_service->service.num_chrcs; i++) {
 		op->cur_chrc_index = i;
 		op->cur_chrc++;
-- 
2.1.0.rc2.206.gedb03e5

