Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/6] android/gatt: Support prepare write request test command
Date: Thu, 29 May 2014 15:05:02 +0200
Message-Id: <1401368704-4265-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'u2' parameter is used for handle value, 'u3' for offset and
'u4' holds the value.
---
 android/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index dfa1a4f..81f8834 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3484,6 +3484,9 @@ static uint8_t handle_test_command_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid,
 									mtu);
 		break;
 	case ATT_OP_PREP_WRITE_REQ:
+		length = enc_prep_write_req(u2, u3, (uint8_t *) &u4, sizeof(u4),
+								pdu, mtu);
+		break;
 	case ATT_OP_EXEC_WRITE_REQ:
 	default:
 		error("gatt: Unknown operation type");
-- 
1.9.3

