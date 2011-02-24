Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.dieb@signove.com
Subject: [PATCH] Fix HCI LE advertising report dump
Date: Thu, 24 Feb 2011 14:17:19 -0300
Message-Id: <1298567839-8008-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LE advertising report event has only one data block for each report. Thus, we
can't reuse ext_inquiry_response_dump(), which loops over successive data blocks
until reaches a zero-length one.

This commit introduces ext_inquiry_data_dump(), which dumps a frame containing
data formatted according to [Vol 3] Part C, Section 8. This function is reused
by ext_inquiry_response_dump().

Also adds RSSI parsing to each advertising report.
---
 parser/hci.c |  136 ++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 76 insertions(+), 60 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 183fa66..dc27a27 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -757,67 +757,83 @@ static char *filterpolicy2str(uint8_t policy)
 	}
 }
 
-static inline void ext_inquiry_response_dump(int level, struct frame *frm)
+static inline void ext_inquiry_data_dump(int level, struct frame *frm,
+						uint8_t *data)
 {
-	void *ptr = frm->ptr;
-	uint32_t len = frm->len;
-	uint8_t type, length;
+	uint8_t len = data[0];
+	uint8_t type;
 	char *str;
 	int i;
 
-	length = get_u8(frm);
+	if (len == 0)
+		return;
 
-	while (length > 0) {
-		type = get_u8(frm);
-		length--;
+	type = data[1];
+	data += 2;
+	len -= 1;
 
-		switch (type) {
-		case 0x01:
-			p_indent(level, frm);
-			printf("Flags:");
-			for (i = 0; i < length; i++)
-				printf(" 0x%2.2x", *((uint8_t *) (frm->ptr + i)));
-			printf("\n");
-			break;
+	switch (type) {
+	case 0x01:
+		p_indent(level, frm);
+		printf("Flags:");
+		for (i = 0; i < len; i++)
+			printf(" 0x%2.2x", data[i]);
+		printf("\n");
+		break;
 
-		case 0x02:
-		case 0x03:
-			p_indent(level, frm);
-			printf("%s service classes:",
-					type == 0x02 ? "Shortened" : "Complete");
-			for (i = 0; i < length / 2; i++) {
-				uint16_t val = btohs(bt_get_unaligned((uint16_t *) (frm->ptr + (i * 2))));
-				printf(" 0x%4.4x", val);
-			}
-			printf("\n");
-			break;
+	case 0x02:
+	case 0x03:
+		p_indent(level, frm);
+		printf("%s service classes:",
+				type == 0x02 ? "Shortened" : "Complete");
 
-		case 0x08:
-		case 0x09:
-			str = malloc(length + 1);
-			if (str) {
-				snprintf(str, length + 1, "%s", (char *) frm->ptr);
-				for (i = 0; i < length; i++)
-					if (!isprint(str[i]))
-						str[i] = '.';
-				p_indent(level, frm);
-				printf("%s local name: \'%s\'\n",
-					type == 0x08 ? "Shortened" : "Complete", str);
-				free(str);
-			}
-			break;
+		for (i = 0; i < len / 2; i++) {
+			uint16_t val;
 
-		case 0x0a:
-			p_indent(level, frm);
-			printf("TX power level: %d\n", *((uint8_t *) frm->ptr));
-			break;
+			val = btohs(bt_get_unaligned(((uint16_t *) (data + i * 2))));
+			printf(" 0x%4.4x", val);
+		}
+		printf("\n");
+		break;
 
-		default:
+	case 0x08:
+	case 0x09:
+		str = malloc(len + 1);
+		if (str) {
+			snprintf(str, len + 1, "%s", (char *) data);
+			for (i = 0; i < len; i++)
+				if (!isprint(str[i]))
+					str[i] = '.';
 			p_indent(level, frm);
-			printf("Unknown type 0x%02x with %d bytes data\n",
-								type, length);
-			break;
+			printf("%s local name: \'%s\'\n",
+				type == 0x08 ? "Shortened" : "Complete", str);
+			free(str);
 		}
+		break;
+
+	case 0x0a:
+		p_indent(level, frm);
+		printf("TX power level: %d\n", *((uint8_t *) data));
+		break;
+
+	default:
+		p_indent(level, frm);
+		printf("Unknown type 0x%02x with %d bytes data\n",
+							type, len);
+		break;
+	}
+}
+
+static inline void ext_inquiry_response_dump(int level, struct frame *frm)
+{
+	void *ptr = frm->ptr;
+	uint32_t len = frm->len;
+	uint8_t length;
+
+	length = get_u8(frm);
+
+	while (length > 0) {
+		ext_inquiry_data_dump(level, frm, frm->ptr);
 
 		frm->ptr += length;
 		frm->len -= length;
@@ -3504,14 +3520,12 @@ static inline void evt_le_conn_complete_dump(int level, struct frame *frm)
 
 static inline void evt_le_advertising_report_dump(int level, struct frame *frm)
 {
-	uint8_t num = get_u8(frm);
-	char addr[18];
-	int i;
+	uint8_t num_reports = get_u8(frm);
+	const uint8_t RSSI_SIZE = 1;
 
-	for (i = 0; i < num; i++) {
+	while (num_reports--) {
+		char addr[18];
 		le_advertising_info *info = frm->ptr;
-		void *ptr = frm->ptr;
-		uint32_t len = frm->len;
 
 		p_ba2str(&info->bdaddr, addr);
 
@@ -3522,13 +3536,15 @@ static inline void evt_le_advertising_report_dump(int level, struct frame *frm)
 		printf("bdaddr %s (%s)\n", addr,
 					bdaddrtype2str(info->bdaddr_type));
 
-		frm->ptr += LE_ADVERTISING_INFO_SIZE;
-		frm->len -= LE_ADVERTISING_INFO_SIZE;
+		if (info->length > 0) {
+			ext_inquiry_data_dump(level, frm, &info->length + 1);
+		}
 
-		ext_inquiry_response_dump(level, frm);
+		frm->ptr += LE_ADVERTISING_INFO_SIZE + info->length + RSSI_SIZE;
+		frm->len -= LE_ADVERTISING_INFO_SIZE + info->length + RSSI_SIZE;
 
-		frm->ptr = ptr + 1;
-		frm->len = len - 1;
+		p_indent(level, frm);
+		printf("RSSI: %d\n", ((int8_t *) frm->ptr)[frm->len - 1]);
 	}
 }
 
-- 
1.7.1

