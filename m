Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/tester: Fix ccc descriptor handle
Date: Tue,  3 Feb 2015 14:33:15 +0100
Message-Id: <1422970395-22110-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some service handle count was recently changed.
---
 android/tester-gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 23c6609..15a54fa 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -1084,7 +1084,7 @@ static struct iovec send_notification_1[] = {
 static struct iovec att_read_req_op_v = raw_pdu(L2CAP_ATT_READ_REQ);
 static struct iovec att_write_req_op_v = raw_pdu(L2CAP_ATT_WRITE_REQ);
 
-static struct iovec svc_change_ccc_handle_v = raw_pdu(0x1a, 0x00);
+static struct iovec svc_change_ccc_handle_v = raw_pdu(0x1c, 0x00);
 static struct iovec svc_change_ccc_value_v = raw_pdu(0x00, 0x01);
 
 static void gatt_client_register_action(void)
-- 
1.9.1

