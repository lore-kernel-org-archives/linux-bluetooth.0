Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  5/5] monitor: Add support for decoding bnep DestOnly pkt
Date: Tue, 21 Apr 2015 14:44:29 +0530
Message-id: <1429607669-30669-6-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
References: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: Compressed Ethernet DestOnly (0x04|0)
         dst 00:00:00:00:00:00 [proto 0x0000]
        00 00 00 00 00 00 61 62 63 64 65 66 30 31 32 33
        34 35 36 37 38 39 5f 62 6e 65 70 5f 74 65 73 74
---
 monitor/bnep.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index 5904367..537eeba 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -177,6 +177,27 @@ static bool bnep_src_only(struct bnep_frame *bnep_frame,
 	return true;
 }
 
+static bool bnep_dst_only(struct bnep_frame *bnep_frame,
+					uint8_t indent,	int hdr_len)
+{
+
+	struct l2cap_frame *frame;
+	char dest_addr[20];
+
+	if (!get_macaddr(bnep_frame, dest_addr))
+		return false;
+
+	frame = &bnep_frame->l2cap_frame;
+
+	if (!l2cap_frame_get_be16(frame, &proto))
+		return false;
+
+	print_field("%*cdst %s [proto 0x%04x] ", indent,
+					' ', dest_addr, proto);
+
+	return true;
+}
+
 struct bnep_data {
 	uint8_t type;
 	const char *str;
@@ -188,7 +209,7 @@ static const struct bnep_data bnep_table[] = {
 	{ 0x01, "Control",			bnep_control	},
 	{ 0x02, "Compressed Ethernet",		bnep_compressed	},
 	{ 0x03, "Compressed Ethernet SrcOnly",	bnep_src_only	},
-	{ 0x04, "Compressed Ethernet DestOnly",			},
+	{ 0x04, "Compressed Ethernet DestOnly",	bnep_dst_only	},
 	{ }
 };
 
-- 
1.9.1

