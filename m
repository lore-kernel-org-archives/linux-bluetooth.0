Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  4/6] monitor: Add decoding of Filter MultAddr Set pkt
Date: Thu, 07 May 2015 15:52:17 +0530
Message-id: <1430994139-4829-5-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
References: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: Control (0x01|0)
         Filter MultAddr Set (0x05)
           Length: 0x000c
           01:00:00:00:00:00 - ff:ff:ff:ff:ff:ff
---
 monitor/bnep.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index 9bad2d5..15050cb 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -184,6 +184,32 @@ static bool filter_nettype_req(struct bnep_frame *bnep_frame, uint8_t indent)
 	return true;
 }
 
+static bool filter_multaddr_req(struct bnep_frame *bnep_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+	uint16_t length;
+	char start_addr[20], end_addr[20];
+	int i;
+
+	if (!l2cap_frame_get_be16(frame, &length))
+		return false;
+
+	print_field("%*cLength: 0x%04x", indent, ' ', length);
+
+	for (i = 0; i < length / 12; i++) {
+
+		if (!get_macaddr(bnep_frame, start_addr))
+			return false;
+
+		if (!get_macaddr(bnep_frame, end_addr))
+			return false;
+
+		print_field("%*c%s - %s", indent, ' ', start_addr, end_addr);
+	}
+
+	return true;
+}
+
 struct bnep_control_data {
 	uint8_t type;
 	const char *str;
@@ -196,7 +222,7 @@ static const struct bnep_control_data bnep_control_table[] = {
 	{ 0x02, "Setup Conn Rsp",		},
 	{ 0x03, "Filter NetType Set",		filter_nettype_req	},
 	{ 0x04, "Filter NetType Rsp",		},
-	{ 0x05, "Filter MultAddr Set",		},
+	{ 0x05, "Filter MultAddr Set",		filter_multaddr_req	},
 	{ 0x06, "Filter MultAddr Rsp",		},
 	{ }
 };
-- 
1.9.1

