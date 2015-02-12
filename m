Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] tools/gatt-client: print read/write error messages
Date: Thu, 12 Feb 2015 20:14:56 +0530
Message-id: <1423752296-6763-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Convert error codes to error messages for read/write value
error responses.
---
 tools/btgatt-client.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 8bda89b..0b937b0 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -74,6 +74,70 @@ static void print_prompt(void)
 	fflush(stdout);
 }
 
+static char *ecode_to_string(uint8_t ecode)
+{
+	char *err = NULL;
+
+	switch (ecode) {
+		case BT_ATT_ERROR_INVALID_HANDLE:
+			err = "ERROR: Invalid Handle";
+			break;
+		case BT_ATT_ERROR_READ_NOT_PERMITTED:
+			err = "Read Not Permitted";
+			break;
+		case BT_ATT_ERROR_WRITE_NOT_PERMITTED:
+			err = "Write Not Permitted";
+			break;
+		case BT_ATT_ERROR_INVALID_PDU:
+			err = "Invalid PDU";
+			break;
+		case BT_ATT_ERROR_AUTHENTICATION:
+			err = "Authentication Required";
+			break;
+		case BT_ATT_ERROR_REQUEST_NOT_SUPPORTED:
+			err = "Request Not Supported";
+			break;
+		case BT_ATT_ERROR_INVALID_OFFSET:
+			err = "Invalid Offset";
+			break;
+		case BT_ATT_ERROR_AUTHORIZATION:
+			err = "Authorization Required";
+			break;
+		case BT_ATT_ERROR_PREPARE_QUEUE_FULL:
+			err = "Prepare Write Queue Full";
+			break;
+		case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
+			err = "Attribute Not Found";
+			break;
+		case BT_ATT_ERROR_ATTRIBUTE_NOT_LONG:
+			err = "Attribute Not Long";
+			break;
+		case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE:
+			err = "Insuficient Encryption Key Size";
+			break;
+		case BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN:
+			err = "Invalid Attribute value len";
+			break;
+		case BT_ATT_ERROR_UNLIKELY:
+			err = "Unlikely Error";
+			break;
+		case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION:
+			err = "Insufficient Encryption";
+			break;
+		case BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE:
+			err = "Group type Not Supported";
+			break;
+		case BT_ATT_ERROR_INSUFFICIENT_RESOURCES:
+			err = "Insufficient Resources";
+			break;
+		default:
+			err = "Unknown error type";
+			break;
+	}
+
+	return err;
+}
+
 static void att_disconnect_cb(int err, void *user_data)
 {
 	printf("Device disconnected: %s\n", strerror(err));
@@ -489,7 +553,8 @@ static void read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 	int i;
 
 	if (!success) {
-		PRLOG("\nRead request failed: 0x%02x\n", att_ecode);
+		PRLOG("\nRead request failed: %s\n",
+				ecode_to_string(att_ecode));
 		return;
 	}
 
@@ -596,7 +661,7 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
 	if (success) {
 		PRLOG("\nWrite successful\n");
 	} else {
-		PRLOG("\nWrite failed: 0x%02x\n", att_ecode);
+		PRLOG("\nWrite failed: %s\n", ecode_to_string(att_ecode));
 	}
 }
 
@@ -726,7 +791,7 @@ static void write_long_cb(bool success, bool reliable_error, uint8_t att_ecode,
 	} else if (reliable_error) {
 		PRLOG("Reliable write not verified\n");
 	} else {
-		PRLOG("Write failed: 0x%02x\n", att_ecode);
+		PRLOG("\nWrite failed: %s\n", ecode_to_string(att_ecode));
 	}
 }
 
-- 
1.9.1

