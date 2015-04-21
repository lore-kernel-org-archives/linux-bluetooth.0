Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/5] monitor: Add support for decoding bnep Compressed pkt
Date: Tue, 21 Apr 2015 14:44:27 +0530
Message-id: <1429607669-30669-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
References: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      BNEP: Compressed Ethernet (0x02|0)
         [proto 0x0300]
        3c 3b 3a 39 38 37 36 35 34 33 32 31 30 2f 2e 2d
        2c 2b 2a 29 28 27 26 25 24 23 22 21 20 1f 1e 1d
---
 monitor/bnep.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/monitor/bnep.c b/monitor/bnep.c
index d417e2f..1735a7a 100644
--- a/monitor/bnep.c
+++ b/monitor/bnep.c
@@ -142,6 +142,20 @@ static bool bnep_control(struct bnep_frame *bnep_frame,
 	return true;
 }
 
+static bool bnep_compressed(struct bnep_frame *bnep_frame,
+					uint8_t indent,	int hdr_len)
+{
+
+	struct l2cap_frame *frame = &bnep_frame->l2cap_frame;
+
+	if (!l2cap_frame_get_be16(frame, &proto))
+		return false;
+
+	print_field("%*c[proto 0x%04x] ", indent, ' ', proto);
+
+	return true;
+}
+
 struct bnep_data {
 	uint8_t type;
 	const char *str;
@@ -151,7 +165,7 @@ struct bnep_data {
 static const struct bnep_data bnep_table[] = {
 	{ 0x00, "General Ethernet",		bnep_general	},
 	{ 0x01, "Control",			bnep_control	},
-	{ 0x02, "Compressed Ethernet",				},
+	{ 0x02, "Compressed Ethernet",		bnep_compressed	},
 	{ 0x03, "Compressed Ethernet SrcOnly",			},
 	{ 0x04, "Compressed Ethernet DestOnly",			},
 	{ }
-- 
1.9.1

