Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] monitor: Decode ATT Signed Write Command
Date: Fri, 29 May 2015 00:13:44 +0200
Message-Id: <1432851224-19550-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1432851224-19550-1-git-send-email-szymon.janc@tieto.com>
References: <1432851224-19550-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed Write Command data is as follow:
Attribute Handle (2 octets)
Data (0 or more octets)
Signature (12 octets).

> ACL Data RX: Handle 64 flags 0x02 dlen 20
      ATT: Signed Write Command (0xd2) len 15
        Handle: 0x001f
          Data: 00
          Signature: 00000000df559de6549e1757
---
 monitor/l2cap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 409f5f4..725a156 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2319,6 +2319,13 @@ static void att_write_command(const struct l2cap_frame *frame)
 	print_hex_field("  Data", frame->data + 2, frame->size - 2);
 }
 
+static void att_signed_write_command(const struct l2cap_frame *frame)
+{
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_hex_field("  Data", frame->data + 2, frame->size - 2 - 12);
+	print_hex_field("  Signature", frame->data + frame->size - 12, 12);
+}
+
 struct att_opcode_data {
 	uint8_t opcode;
 	const char *str;
@@ -2380,7 +2387,7 @@ static const struct att_opcode_data att_opcode_table[] = {
 			att_handle_value_conf, 0, true },
 	{ 0x52, "Write Command",
 			att_write_command, 2, false },
-	{ 0xd2, "Signed Write Command"		},
+	{ 0xd2, "Signed Write Command", att_signed_write_command, 14, false },
 	{ }
 };
 
-- 
1.9.3

