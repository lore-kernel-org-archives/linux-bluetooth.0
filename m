Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] monitor: Fix use of uninitialized value
Date: Wed, 13 Aug 2014 15:08:45 +0300
Message-Id: <1407931725-6576-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warnings below:
...
 CC       monitor/avctp.o
monitor/avctp.c:600:2: warning: Function call argument is an
uninitialized value
        print_indent(indent, ctrl_pdu_data_color, "AVRCP: ",
pdu2str(pduid),
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/display.h:47:2: note: expanded from macro 'print_indent'
        printf("%*c%s%s%s%s" fmt "%s\n", (indent), ' ', \
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
...
---
 monitor/avctp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 9eeac7f..4f87837 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -590,16 +590,14 @@ static void avrcp_pdu_packet(const struct l2cap_frame *frame, uint8_t ctype,
 	uint16_t len;
 	int i;
 	const struct avrcp_ctrl_pdu_data *ctrl_pdu_data = NULL;
-	const char *ctrl_pdu_data_color;
 	struct l2cap_frame avrcp_frame;
 
 	pduid = *((uint8_t *) frame->data);
 	pt = *((uint8_t *) (frame->data + 1));
 	len = get_be16(frame->data + 2);
 
-	print_indent(indent, ctrl_pdu_data_color, "AVRCP: ", pdu2str(pduid),
-						COLOR_OFF, " pt %s len 0x%04x",
-						pt2str(pt), len);
+	print_indent(indent, COLOR_OFF, "AVRCP: ", pdu2str(pduid), COLOR_OFF,
+					" pt %s len 0x%04x", pt2str(pt), len);
 
 	if ((frame->size < 4) || ((frame->size - 4) != len)) {
 		print_text(COLOR_ERROR, "PDU malformed");
-- 
1.9.1

