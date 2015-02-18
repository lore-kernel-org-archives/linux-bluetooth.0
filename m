Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] tools/gatt-client: Define ATT application err code
Date: Wed, 18 Feb 2015 20:33:40 +0530
Message-id: <1424271820-19566-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds application error codes for ATT response PDUs.
Prints error messages for respective application error codes.
1. IO Error
2. Operation Timedout
3. Operation Aborted

e.g.

[GATT client]# read-value 0x0015
[GATT client]#
Read request failed: IO Error (0x80)
---
 src/shared/att-types.h | 5 +++++
 tools/btgatt-client.c  | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index aa7f0da..5f95dab 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -91,6 +91,11 @@ struct bt_att_pdu_error_rsp {
 #define BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE		0x10
 #define BT_ATT_ERROR_INSUFFICIENT_RESOURCES		0x11
 
+/* Application error codes for Error response PDU*/
+#define BT_ATT_ERROR_IO				0x80
+#define BT_ATT_ERROR_TIMEOUT				0x81
+#define BT_ATT_ERROR_ABORTED				0x82
+
 /*
  * ATT attribute permission bitfield values. Permissions are grouped as
  * "Access", "Encryption", "Authentication", and "Authorization". A bitmask of
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index e59d5db..7777211 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -111,6 +111,12 @@ static const char *ecode_to_string(uint8_t ecode)
 		return "Group type Not Supported";
 	case BT_ATT_ERROR_INSUFFICIENT_RESOURCES:
 		return "Insufficient Resources";
+	case BT_ATT_ERROR_IO:
+		return "IO Error";
+	case BT_ATT_ERROR_TIMEOUT:
+		return "Operation Timed out";
+	case BT_ATT_ERROR_ABORTED:
+		return "Operation Aborted";
 	default:
 		return "Unknown error type";
 	}
-- 
1.9.1

