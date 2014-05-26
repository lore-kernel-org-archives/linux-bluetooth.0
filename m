Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 18/26] tools/hcidump: Decode aptX codec capabilities
Date: Mon, 26 May 2014 15:16:44 +0200
Message-ID: <1401110212-11526-19-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/parser/avdtp.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
index 5806c07..14dc417 100644
--- a/tools/parser/avdtp.c
+++ b/tools/parser/avdtp.c
@@ -150,6 +150,13 @@ static char *codec2str(uint8_t type, uint8_t codec)
 	return "Unknown";
 }
 
+static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
+{
+	if (vendor == 0x0000004f && vndcodec == 0x0001)
+		return "aptX";
+	return "Unknown";
+}
+
 static char *cat2str(uint8_t cat)
 {
 	switch (cat) {
@@ -213,13 +220,23 @@ static void capabilities(int level, struct frame *frm)
 
 		if (cat == 7) {
 			uint8_t type, codec;
-			uint16_t tmp, freq;
-			uint32_t bitrate;
+			uint16_t tmp, freq, vndcodec = 0;
+			uint32_t bitrate, vendor = 0;
 
 			type  = get_u8(frm);
 			codec = get_u8(frm);
 
-			printf("%s - %s\n", cat2str(cat), codec2str(type, codec));
+			if (codec == 255) {
+				vendor = btohl(htonl(get_u32(frm)));
+				vndcodec = btohs(htons(get_u16(frm)));
+
+				printf("%s - %s (%s)\n", cat2str(cat),
+						codec2str(type, codec),
+						vndcodec2str(vendor, vndcodec));
+			} else {
+				printf("%s - %s\n", cat2str(cat),
+							codec2str(type, codec));
+			}
 
 			switch (codec) {
 			case 0:
@@ -324,6 +341,33 @@ static void capabilities(int level, struct frame *frm)
 				printf("%ubps ", bitrate);
 				printf("%s\n", tmp & 0x80 ? "VBR" : "");
 				break;
+			case 255:
+				if (vendor == 0x0000004f &&
+							vndcodec == 0x0001) {
+					tmp = get_u8(frm);
+					p_indent(level + 1, frm);
+					if (tmp & 0x80)
+						printf("16kHz ");
+					if (tmp & 0x40)
+						printf("32kHz ");
+					if (tmp & 0x20)
+						printf("44.1kHz ");
+					if (tmp & 0x10)
+						printf("48kHz ");
+					printf("\n");
+					p_indent(level + 1, frm);
+					if (tmp & 0x02)
+						printf("Stereo ");
+					if (tmp & 0x01)
+						printf("Mono ");
+					printf("\n");
+					break;
+				} else {
+					hex_dump(level + 1, frm, len - 8);
+					frm->ptr += (len - 8);
+					frm->len -= (len - 8);
+				}
+				break;
 			default:
 				hex_dump(level + 1, frm, len - 2);
 				frm->ptr += (len - 2);
-- 
1.9.3

