Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  5/6] monitor: Add decoding of common rsp msg pkt
Date: Thu, 07 May 2015 15:52:18 +0530
Message-id: <1430994139-4829-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
References: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: Control (0x01|0)
         Setup Conn Rsp (0x02)
           Rsp msg: Operation Successful(0x0000)

      BNEP: Control (0x01|0)
         Filter NetType Rsp (0x04)
           Rsp msg: Operation Successful(0x0000)

      BNEP: Control (0x01|0)
         Filter MultAddr Rsp (0x06)
           Rsp msg: Operation Failed - Invalid Dst Srv UUID(0x0001)
---
 monitor/bnep.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index 15050cb..d73a3bc 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -158,6 +158,38 @@ static bool setup_conn_req(struct bnep_frame *bnep_frame, uint8_t indent)
 	return true;
 }
 
+static const char *value2str(uint16_t value)
+{
+	switch (value) {
+	case 0x00:
+		return "Operation Successful";
+	case 0x01:
+		return "Operation Failed - Invalid Dst Srv UUID";
+	case 0x02:
+		return "Operation Failed - Invalid Src Srv UUID";
+	case 0x03:
+		return "Operation Failed - Invalid Srv UUID size";
+	case 0x04:
+		return "Operation Failed - Conn not allowed";
+	default:
+		return "Unknown";
+	}
+}
+
+static bool print_rsp_msg(struct bnep_frame *bnep_frame, uint8_t indent)
+{
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+	uint16_t rsp_msg;
+
+	if (!l2cap_frame_get_be16(frame, &rsp_msg))
+		return false;
+
+	print_field("%*cRsp msg: %s(0x%04x) ", indent, ' ',
+					value2str(rsp_msg), rsp_msg);
+
+	return true;
+}
+
 static bool filter_nettype_req(struct bnep_frame *bnep_frame, uint8_t indent)
 {
 	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
@@ -219,11 +251,11 @@ struct bnep_control_data {
 static const struct bnep_control_data bnep_control_table[] = {
 	{ 0x00, "Command Not Understood",	cmd_nt_understood	},
 	{ 0x01, "Setup Conn Req",		setup_conn_req		},
-	{ 0x02, "Setup Conn Rsp",		},
+	{ 0x02, "Setup Conn Rsp",		print_rsp_msg		},
 	{ 0x03, "Filter NetType Set",		filter_nettype_req	},
-	{ 0x04, "Filter NetType Rsp",		},
+	{ 0x04, "Filter NetType Rsp",		print_rsp_msg		},
 	{ 0x05, "Filter MultAddr Set",		filter_multaddr_req	},
-	{ 0x06, "Filter MultAddr Rsp",		},
+	{ 0x06, "Filter MultAddr Rsp",		print_rsp_msg		},
 	{ }
 };
 
-- 
1.9.1

