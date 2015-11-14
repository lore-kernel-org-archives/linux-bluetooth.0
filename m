Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2] monitor/rfcomm: Fix names formatting
Date: Sat, 14 Nov 2015 14:35:06 +0100
Message-Id: <1447508106-16965-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/rfcomm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index bdf4000..b32ad40 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -367,7 +367,7 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	else
 		type_str = "Unknown";
 
-	print_field("%*cMCC Message type: %s %s(0x%2.2x)", indent, ' ',
+	print_field("%*cMCC Message type: %s %s (0x%2.2x)", indent, ' ',
 				type_str, CR_STR(mcc.type), type);
 
 	print_field("%*cLength: %d", indent+2, ' ', mcc.length);
@@ -421,7 +421,7 @@ struct rfcomm_data {
 };
 
 static const struct rfcomm_data rfcomm_table[] = {
-	{ 0x2f, "Set Async Balance Mode (SABM) " },
+	{ 0x2f, "Set Async Balance Mode (SABM)" },
 	{ 0x63, "Unnumbered Ack (UA)" },
 	{ 0x0f, "Disconnect Mode (DM)" },
 	{ 0x43, "Disconnect (DISC)" },
@@ -493,7 +493,7 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 	}
 
 	print_indent(6, frame_color, "RFCOMM: ", frame_str, COLOR_OFF,
-						"(0x%2.2x)", ctype);
+						" (0x%2.2x)", ctype);
 
 	rfcomm_frame.hdr = hdr;
 	print_rfcomm_hdr(&rfcomm_frame, indent);
-- 
2.6.2

