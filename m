Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/6] android/gatt: Support write command test command
Date: Thu, 29 May 2014 15:05:01 +0200
Message-Id: <1401368704-4265-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401368704-4265-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'u2' parameter is used to pass handle value.
---
 android/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 85c7b84..dfa1a4f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3480,6 +3480,9 @@ static uint8_t handle_test_command_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid,
 									mtu);
 		break;
 	case ATT_OP_WRITE_CMD:
+		length = enc_write_cmd(u2, (uint8_t *) &u3, sizeof(u3), pdu,
+									mtu);
+		break;
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_EXEC_WRITE_REQ:
 	default:
-- 
1.9.3

