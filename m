Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Feb 2014 02:23:21 -0500
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Poulin?= <jeromepoulin@gmail.com>
Subject: [PATCH] Dump advertisement data for LE
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Poulin?= <jeromepoulin@gmail.com>
Message-id: <1393226601-18336-1-git-send-email-jeromepoulin@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows hcidump to dump data inside currently unknown fields, LE
devices like the RFduino will include this kind of data in every broadcast.
---
 tools/parser/hci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 17b776d..bf117ce 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -766,6 +766,7 @@ static inline void ext_inquiry_data_dump(int level, struct frame *frm,
 {
 	uint8_t len = data[0];
 	uint8_t type;
+	char *hexdump;
 	char *str;
 	int i;
 
@@ -821,6 +822,22 @@ static inline void ext_inquiry_data_dump(int level, struct frame *frm,
 		p_indent(level, frm);
 		printf("Unknown type 0x%02x with %d bytes data\n",
 							type, len);
+		str = malloc(len + 1);
+		hexdump = malloc(len*3 + 1);
+		if (str && hexdump) {
+			memcpy(str, data, len);
+			str[len + 1] = 0;
+			for (i = 0; i < len; i++) {
+				sprintf(hexdump+i*3, "%02x ",
+					(unsigned char) str[i]);
+				if (!isprint(str[i]))
+					str[i] = '.';
+			}
+			p_indent(level + 1, frm);
+			printf("data: %s| %s\n", hexdump, str);
+			free(hexdump);
+			free(str);
+		}
 		break;
 	}
 }
-- 
1.8.5.3

