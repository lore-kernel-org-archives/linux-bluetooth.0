Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 17/26] tools/hcidump: Decode MPEG-2,4 AAC codec capabilities
Date: Mon, 26 May 2014 15:16:43 +0200
Message-ID: <1401110212-11526-18-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/parser/avdtp.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
index 5a2ee55..5806c07 100644
--- a/tools/parser/avdtp.c
+++ b/tools/parser/avdtp.c
@@ -212,7 +212,9 @@ static void capabilities(int level, struct frame *frm)
 		len = get_u8(frm);
 
 		if (cat == 7) {
-			uint8_t type, codec, tmp;
+			uint8_t type, codec;
+			uint16_t tmp, freq;
+			uint32_t bitrate;
 
 			type  = get_u8(frm);
 			codec = get_u8(frm);
@@ -269,6 +271,59 @@ static void capabilities(int level, struct frame *frm)
 				p_indent(level + 1, frm);
 				printf("Bitpool Range %d-%d\n", tmp, get_u8(frm));
 				break;
+			case 2:
+				tmp = get_u8(frm);
+				p_indent(level + 1, frm);
+				if (tmp & 0x80)
+					printf("MPEG-2 AAC LC ");
+				if (tmp & 0x40)
+					printf("MPEG-4 AAC LC ");
+				if (tmp & 0x20)
+					printf("MPEG-4 AAC LTP ");
+				if (tmp & 0x10)
+					printf("MPEG-4 AAC scalable ");
+				printf("\n");
+				tmp = get_u16(frm);
+				freq = tmp >> 4;
+				p_indent(level + 1, frm);
+				if (freq & 0x0800)
+					printf("8kHz ");
+				if (freq & 0x0400)
+					printf("11.025kHz ");
+				if (freq & 0x0200)
+					printf("12kHz ");
+				if (freq & 0x0100)
+					printf("16kHz ");
+				if (freq & 0x0080)
+					printf("22.05kHz ");
+				if (freq & 0x0040)
+					printf("24kHz ");
+				if (freq & 0x0020)
+					printf("32kHz ");
+				if (freq & 0x0010)
+					printf("44.1kHz ");
+				if (freq & 0x0008)
+					printf("48kHz ");
+				if (freq & 0x0004)
+					printf("64kHz ");
+				if (freq & 0x0002)
+					printf("88.2kHz ");
+				if (freq & 0x0001)
+					printf("96kHz ");
+				printf("\n");
+				tmp >>= 2;
+				p_indent(level + 1, frm);
+				if (tmp & 0x02)
+					printf("1 ");
+				if (tmp & 0x01)
+					printf("2 ");
+				printf("Channels\n");
+				tmp = get_u8(frm);
+				bitrate = ((tmp & 0x7f) << 16) | get_u16(frm);
+				p_indent(level + 1, frm);
+				printf("%ubps ", bitrate);
+				printf("%s\n", tmp & 0x80 ? "VBR" : "");
+				break;
 			default:
 				hex_dump(level + 1, frm, len - 2);
 				frm->ptr += (len - 2);
-- 
1.9.3

