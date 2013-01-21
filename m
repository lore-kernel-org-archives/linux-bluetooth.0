Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] monitor: Fix possible crash on unknown command
Date: Mon, 21 Jan 2013 16:17:47 +0100
Message-ID: <1358781467-32172-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If uknown command is received monitor would crash due to dereference
of NULL opcode_data pointer.
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 19139f8..58a5a97 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4266,7 +4266,7 @@ static void cmd_complete_evt(const void *data, uint8_t size)
 	print_indent(6, opcode_color, "", opcode_str, COLOR_OFF,
 			" (0x%2.2x|0x%4.4x) ncmd %d", ogf, ocf, evt->ncmd);
 
-	if (!opcode_data->rsp_func) {
+	if (!opcode_data || !opcode_data->rsp_func) {
 		packet_hexdump(data + 3, size - 3);
 		return;
 	}
-- 
1.8.0.3

