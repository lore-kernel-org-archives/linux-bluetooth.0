Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/6] monitor: Add decoding of Cmd Not Understood pkt
Date: Thu, 07 May 2015 15:52:14 +0530
Message-id: <1430994139-4829-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
References: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: Control (0x01|0)
         Command Not Understood (0x00)
           Type: 0xff
---
 monitor/bnep.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index 537eeba..2e41d5b 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -95,13 +95,27 @@ static bool bnep_general(struct bnep_frame *bnep_frame,
 
 }
 
+static bool cmd_nt_understood(struct bnep_frame *bnep_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+	uint8_t ptype;
+
+	if (!l2cap_frame_get_u8(frame, &ptype))
+		return false;
+
+	print_field("%*cType: 0x%02x ", indent, ' ', ptype);
+
+	return true;
+}
+
 struct bnep_control_data {
 	uint8_t type;
 	const char *str;
+	bool (*func) (struct bnep_frame *frame, uint8_t indent);
 };
 
 static const struct bnep_control_data bnep_control_table[] = {
-	{ 0x00, "Command Not Understood",	},
+	{ 0x00, "Command Not Understood",	cmd_nt_understood	},
 	{ 0x01, "Setup Conn Req",		},
 	{ 0x02, "Setup Conn Rsp",		},
 	{ 0x03, "Filter NetType Set",		},
@@ -137,8 +151,16 @@ static bool bnep_control(struct bnep_frame *bnep_frame,
 
 	print_field("%*c%s (0x%02x) ", indent, ' ', type_str, ctype);
 
-	/* TODO: Handle BNEP control types */
+	if (!bnep_control_data || !bnep_control_data->func) {
+		packet_hexdump(frame->data, hdr_len - 1);
+		l2cap_frame_pull(frame, frame, hdr_len - 1);
+		goto done;
+	}
+
+	if (!bnep_control_data->func(bnep_frame, indent+2))
+		return false;
 
+done:
 	return true;
 }
 
-- 
1.9.1

