Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/6] android/gatt: Support exec write request test command
Date: Thu, 29 May 2014 15:05:03 +0200
Message-Id: <1401368704-4265-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'u2' parameter is used to pass exec write flag.
---
 android/gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 81f8834..6708718 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3488,6 +3488,8 @@ static uint8_t handle_test_command_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid,
 								pdu, mtu);
 		break;
 	case ATT_OP_EXEC_WRITE_REQ:
+		length = enc_exec_write_req(u2, pdu, mtu);
+		break;
 	default:
 		error("gatt: Unknown operation type");
 
-- 
1.9.3

