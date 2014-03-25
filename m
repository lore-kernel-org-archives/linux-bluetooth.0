Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/hal-gatt: Fix sending get characteristic cmd
Date: Tue, 25 Mar 2014 13:53:01 +0100
Message-Id: <1395751981-15843-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395751981-15843-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395751981-15843-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 8a8ce9c..51caf8d 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -646,7 +646,7 @@ static bt_status_t get_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 	cmd->conn_id = conn_id;
 
 	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
-	len += sizeof(cmd->srvc_id);
+	cmd->number = 0;
 
 	if (start_char_id) {
 		gatt_id_to_hal(&cmd->gatt_id[0], start_char_id);
-- 
1.9.0

