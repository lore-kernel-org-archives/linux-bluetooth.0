Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/6] android/gatt: Support read blob request in test command
Date: Thu, 29 May 2014 12:34:06 +0200
Message-Id: <1401359648-576-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401359648-576-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401359648-576-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'u2' command paremeter is used as handle and 'u3' as offset value.
---
 android/gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index ec75594..40325bc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3467,6 +3467,8 @@ static uint8_t handle_test_command_read(bdaddr_t *bdaddr, bt_uuid_t *uuid,
 		length = enc_read_by_type_req(u2, u3, uuid, pdu, mtu);
 		break;
 	case ATT_OP_READ_BLOB_REQ:
+		length = enc_read_blob_req(u2, u3, pdu, mtu);
+		break;
 	case ATT_OP_READ_BY_GROUP_REQ:
 	case ATT_OP_READ_MULTI_REQ:
 	default:
-- 
1.9.3

