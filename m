Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 33/38] android/gatt: Add support for execute write
Date: Wed, 30 Apr 2014 11:14:04 +0200
Message-Id: <1398849249-5868-34-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 785e6d2..b0795d1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3921,6 +3921,13 @@ static uint8_t write_request(const uint8_t *cmd, uint16_t cmd_len,
 			return ATT_ECODE_INVALID_PDU;
 
 		break;
+	case ATT_OP_EXEC_WRITE_REQ:
+		len = dec_exec_write_req(cmd, cmd_len, value);
+		if (!len)
+			return ATT_ECODE_INVALID_PDU;
+
+		vlen = 1;
+		break;
 	default:
 		error("gatt: Unexpected write type 0x02%x", cmd[0]);
 		return ATT_ECODE_REQ_NOT_SUPP;
@@ -3976,11 +3983,11 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 	case ATT_OP_WRITE_REQ:
 	case ATT_OP_WRITE_CMD:
 	case ATT_OP_PREP_WRITE_REQ:
+	case ATT_OP_EXEC_WRITE_REQ:
 		status = write_request(ipdu, len, dev);
 		if (!status)
 			return;
 		break;
-	case ATT_OP_EXEC_WRITE_REQ:
 	case ATT_OP_FIND_BY_TYPE_REQ:
 	case ATT_OP_HANDLE_CNF:
 	case ATT_OP_HANDLE_IND:
-- 
1.8.4

