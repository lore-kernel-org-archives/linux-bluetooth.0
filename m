Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/6] monitor: Add decoding of Filter NetType Set pkt
Date: Thu, 07 May 2015 15:52:16 +0530
Message-id: <1430994139-4829-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
References: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: Control (0x01|0)
         Filter NetType Set (0x03)
           Length: 0x0004
           0x86dd - 0x86dd
---
 monitor/bnep.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index a5f2432..9bad2d5 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -158,6 +158,32 @@ static bool setup_conn_req(struct bnep_frame *bnep_frame, uint8_t indent)
 	return true;
 }
 
+static bool filter_nettype_req(struct bnep_frame *bnep_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+	uint16_t length, start_range, end_range;
+	int i;
+
+	if (!l2cap_frame_get_be16(frame, &length))
+		return false;
+
+	print_field("%*cLength: 0x%04x", indent, ' ', length);
+
+	for (i = 0; i < length / 4; i++) {
+
+		if (!l2cap_frame_get_be16(frame, &start_range))
+			return false;
+
+		if (!l2cap_frame_get_be16(frame, &end_range))
+			return false;
+
+		print_field("%*c0x%04x - 0x%04x", indent, ' ',
+						start_range, end_range);
+	}
+
+	return true;
+}
+
 struct bnep_control_data {
 	uint8_t type;
 	const char *str;
@@ -168,7 +194,7 @@ static const struct bnep_control_data bnep_control_table[] = {
 	{ 0x00, "Command Not Understood",	cmd_nt_understood	},
 	{ 0x01, "Setup Conn Req",		setup_conn_req		},
 	{ 0x02, "Setup Conn Rsp",		},
-	{ 0x03, "Filter NetType Set",		},
+	{ 0x03, "Filter NetType Set",		filter_nettype_req	},
 	{ 0x04, "Filter NetType Rsp",		},
 	{ 0x05, "Filter MultAddr Set",		},
 	{ 0x06, "Filter MultAddr Rsp",		},
-- 
1.9.1

