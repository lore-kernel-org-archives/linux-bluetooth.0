Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] monitor/l2cap: Add log msg for read_blob_rsp
Date: Fri, 13 Feb 2015 16:48:03 +0530
Message-id: <1423826283-19270-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ACL Data RX: Handle 71 flags 0x02 dlen 27                                                                                                                                                 [hci0] 79.680052
      ATT: Read Blob Response (0x0d) len 22
        Part of Attribute Value:
        11 22 33 44 55 66 77 88 99 00 12 34 56 78 90 12  ."3DUfw....4Vx..
        34 56 78 90 12 34                                4Vx..4
---
 monitor/l2cap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 0030a4c..d58c14f 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2198,6 +2198,7 @@ static void att_read_blob_req(const struct l2cap_frame *frame)
 
 static void att_read_blob_rsp(const struct l2cap_frame *frame)
 {
+	print_field("Part of Attribute Value:");
 	packet_hexdump(frame->data, frame->size);
 }
 
-- 
1.9.1

