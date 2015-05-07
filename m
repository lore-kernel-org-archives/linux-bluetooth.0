Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/6] monitor: Add decoding of Setup Conn Req pkt
Date: Thu, 07 May 2015 15:52:15 +0530
Message-id: <1430994139-4829-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
References: <1430994139-4829-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: Control (0x01|0)
         Setup Conn Req (0x01)
           Size: 0x02
           Dst: 0x1116(NAP)
           Src: 0x1115(PANU)
---
 monitor/bnep.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index 2e41d5b..a5f2432 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -108,6 +108,56 @@ static bool cmd_nt_understood(struct bnep_frame *bnep_frame, uint8_t indent)
 	return true;
 }
 
+static bool setup_conn_req(struct bnep_frame *bnep_frame, uint8_t indent)
+{
+
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+	uint8_t uuid_size;
+	uint32_t src_uuid = 0, dst_uuid = 0;
+
+	if (!l2cap_frame_get_u8(frame, &uuid_size))
+		return false;
+
+	print_field("%*cSize: 0x%02x ", indent, ' ', uuid_size);
+
+	switch (uuid_size) {
+	case 2:
+		if (!l2cap_frame_get_be16(frame, (uint16_t *) &dst_uuid))
+			return false;
+
+		if (!l2cap_frame_get_be16(frame, (uint16_t *) &src_uuid))
+			return false;
+		break;
+	case 4:
+		if (!l2cap_frame_get_be32(frame, &dst_uuid))
+			return false;
+
+		if (!l2cap_frame_get_be32(frame, &src_uuid))
+			return false;
+		break;
+	case 16:
+		if (!l2cap_frame_get_be32(frame, &dst_uuid))
+			return false;
+
+		l2cap_frame_pull(frame, frame, 12);
+
+		if (!l2cap_frame_get_be32(frame, &src_uuid))
+			return false;
+
+		l2cap_frame_pull(frame, frame, 12);
+		break;
+	default:
+		l2cap_frame_pull(frame, frame, (uuid_size * 2));
+		return true;
+	}
+
+	print_field("%*cDst: 0x%x(%s)", indent, ' ', dst_uuid,
+						uuid32_to_str(dst_uuid));
+	print_field("%*cSrc: 0x%x(%s)", indent, ' ', src_uuid,
+						uuid32_to_str(src_uuid));
+	return true;
+}
+
 struct bnep_control_data {
 	uint8_t type;
 	const char *str;
@@ -116,7 +166,7 @@ struct bnep_control_data {
 
 static const struct bnep_control_data bnep_control_table[] = {
 	{ 0x00, "Command Not Understood",	cmd_nt_understood	},
-	{ 0x01, "Setup Conn Req",		},
+	{ 0x01, "Setup Conn Req",		setup_conn_req		},
 	{ 0x02, "Setup Conn Rsp",		},
 	{ 0x03, "Filter NetType Set",		},
 	{ 0x04, "Filter NetType Rsp",		},
-- 
1.9.1

