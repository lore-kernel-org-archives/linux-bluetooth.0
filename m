Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/5] monitor: Add support for decoding bnep Control pkt
Date: Tue, 21 Apr 2015 14:44:26 +0530
Message-id: <1429607669-30669-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
References: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: Control (0x01|0)
         Filter MultAddr Set (0x05)
        00 30 ff ff ff ff ff ff ff ff ff ff ff ff 33 33
        00 00 00 01 33 33 00 00 00 01 01 00 5e 00 00 01
---
 monitor/bnep.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index 61b5d71..d417e2f 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -95,6 +95,53 @@ static bool bnep_general(struct bnep_frame *bnep_frame,
 
 }
 
+struct bnep_control_data {
+	uint8_t type;
+	const char *str;
+};
+
+static const struct bnep_control_data bnep_control_table[] = {
+	{ 0x00, "Command Not Understood",	},
+	{ 0x01, "Setup Conn Req",		},
+	{ 0x02, "Setup Conn Rsp",		},
+	{ 0x03, "Filter NetType Set",		},
+	{ 0x04, "Filter NetType Rsp",		},
+	{ 0x05, "Filter MultAddr Set",		},
+	{ 0x06, "Filter MultAddr Rsp",		},
+	{ }
+};
+
+static bool bnep_control(struct bnep_frame *bnep_frame,
+					uint8_t indent,	int hdr_len)
+{
+	uint8_t ctype;
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+	const struct bnep_control_data *bnep_control_data = NULL;
+	const char *type_str;
+	int i;
+
+	if (!l2cap_frame_get_u8(frame, &ctype))
+		return false;
+
+	for (i = 0; bnep_control_table[i].str; i++) {
+		if (bnep_control_table[i].type == ctype) {
+			bnep_control_data = &bnep_control_table[i];
+			break;
+		}
+	}
+
+	if (bnep_control_data)
+		type_str = bnep_control_data->str;
+	else
+		type_str = "Unknown control type";
+
+	print_field("%*c%s (0x%02x) ", indent, ' ', type_str, ctype);
+
+	/* TODO: Handle BNEP control types */
+
+	return true;
+}
+
 struct bnep_data {
 	uint8_t type;
 	const char *str;
@@ -103,7 +150,7 @@ struct bnep_data {
 
 static const struct bnep_data bnep_table[] = {
 	{ 0x00, "General Ethernet",		bnep_general	},
-	{ 0x01, "Control",					},
+	{ 0x01, "Control",			bnep_control	},
 	{ 0x02, "Compressed Ethernet",				},
 	{ 0x03, "Compressed Ethernet SrcOnly",			},
 	{ 0x04, "Compressed Ethernet DestOnly",			},
-- 
1.9.1

