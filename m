Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 34/40] android/gatt: Add support for execute write
Date: Tue, 29 Apr 2014 18:47:23 +0200
Message-Id: <1398790049-30303-35-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0931374..cda8697 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3939,6 +3939,13 @@ static uint8_t write_request(const uint8_t *cmd, uint16_t cmd_len,
 			return ATT_ECODE_INVALID_PDU;
 		}
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
 		free(req_data);
@@ -4001,11 +4008,11 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
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

