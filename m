Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  6/6] monitor: Add decoding of BNEP Extension Header pkt
Date: Thu, 07 May 2015 15:52:19 +0530
Message-id: <1430994139-4829-7-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
References: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: General Ethernet (0x00|1)
         dst 00:00:00:00:00:00 src 00:00:00:00:00:00 [proto 0x0300]
           Ext Control(0x00|1) len 0x0f
             Filter MultAddr Set (0x05)
               Length: 0x000c
               03:00:00:20:00:00 - 03:00:00:20:00:00
           Ext Unknown(0x7f|0) len 0x0a
        ac ac ac ac ac ac ac ac ac 3c
        3b 3a 39 38 37 36 35 34 33 32 31 30 2f 2e 2d 2c
---
 monitor/bnep.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index d73a3bc..01392e8 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -47,6 +47,11 @@
 #define GET_PKT_TYPE(type) (type & 0x7f)
 #define GET_EXTENSION(type) (type & 0x80)
 
+/* BNEP Extension Type */
+#define BNEP_EXTENSION_CONTROL		0x00
+
+#define BNEP_CONTROL			0x01
+
 uint16_t proto = 0x0000;
 
 struct bnep_frame {
@@ -354,6 +359,43 @@ static bool bnep_dst_only(struct bnep_frame *bnep_frame,
 	return true;
 }
 
+static bool bnep_eval_extension(struct bnep_frame *bnep_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+	uint8_t type, length;
+	int extension;
+
+	if (!l2cap_frame_get_u8(frame, &type))
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &length))
+		return false;
+
+	extension = GET_EXTENSION(type);
+	type = GET_PKT_TYPE(type);
+
+	switch (type) {
+	case BNEP_EXTENSION_CONTROL:
+		print_field("%*cExt Control(0x%02x|%s) len 0x%02x", indent,
+				' ', type, extension ? "1" : "0", length);
+		if (!bnep_control(bnep_frame, indent+2, length))
+			return false;
+		break;
+
+	default:
+		print_field("%*cExt Unknown(0x%02x|%s) len 0x%02x", indent,
+				' ', type, extension ? "1" : "0", length);
+		packet_hexdump(frame->data, length);
+		l2cap_frame_pull(frame, frame, length);
+	}
+
+	if (extension)
+		if (!bnep_eval_extension(bnep_frame, indent))
+			return false;
+
+	return true;
+}
+
 struct bnep_data {
 	uint8_t type;
 	const char *str;
@@ -420,7 +462,16 @@ void bnep_packet(const struct l2cap_frame *frame)
 	if (!bnep_data->func(&bnep_frame, indent, -1))
 		goto fail;
 
-	/* TODO: Handle BNEP packet with Extension Header */
+	/* Extension info */
+	if (bnep_frame.extension)
+		if (!bnep_eval_extension(&bnep_frame, indent+2))
+			goto fail;
+
+	/* Control packet => No payload info */
+	if (bnep_frame.type == BNEP_CONTROL)
+		return;
+
+	/* TODO: Handle BNEP IP packet */
 	packet_hexdump(l2cap_frame->data, l2cap_frame->size);
 
 	return;
-- 
1.9.1

