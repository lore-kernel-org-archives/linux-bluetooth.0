Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/2] android/hal-gatt: Fix sending wrong gatt_id struct
Date: Tue, 25 Mar 2014 13:53:00 +0100
Message-Id: <1395751981-15843-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index bd61576..8a8ce9c 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -676,7 +676,7 @@ static bt_status_t get_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 	cmd->number = 1;
 
 	if (start_descr_id) {
-		gatt_id_to_hal(&cmd->gatt_id[1], char_id);
+		gatt_id_to_hal(&cmd->gatt_id[1], start_descr_id);
 		len += sizeof(cmd->gatt_id[1]);
 		cmd->number++;
 	}
-- 
1.9.0

