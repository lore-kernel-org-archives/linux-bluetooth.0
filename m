Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1] monitor/l2cap: Add log msg for read_blob_rsp
Date: Mon, 16 Feb 2015 19:07:21 +0530
Message-id: <1424093841-28541-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

      ATT: Read Blob Response (0x0d) len 22
        Value: 11223344556677889900123456789012345678901234
---
 monitor/l2cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 0030a4c..8e93437 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2198,7 +2198,7 @@ static void att_read_blob_req(const struct l2cap_frame *frame)
 
 static void att_read_blob_rsp(const struct l2cap_frame *frame)
 {
-	packet_hexdump(frame->data, frame->size);
+	print_hex_field("Value", frame->data, frame->size);
 }
 
 static void att_read_multiple_req(const struct l2cap_frame *frame)
-- 
1.9.1

