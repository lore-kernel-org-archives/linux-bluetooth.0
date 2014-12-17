Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 2/2] parser/rfcomm: Add support for decoding Test command
Date: Wed, 17 Dec 2014 17:29:45 +0530
Message-id: <1418817585-26816-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418817585-26816-1-git-send-email-gowtham.ab@samsung.com>
References: <1418817585-26816-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL data: handle 75 flags 0x00 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(s): TEST RSP: cr 0 dlci 0 pf 0 ilen 6 fcs 0xaa mcc_len 4
        Test data: 0x 5f 54 65 73
---
 tools/parser/rfcomm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/parser/rfcomm.c b/tools/parser/rfcomm.c
index acf8d66..ea8dfad 100644
--- a/tools/parser/rfcomm.c
+++ b/tools/parser/rfcomm.c
@@ -69,6 +69,17 @@ static inline void mcc_test(int level, uint8_t *ptr, int len,
 	printf("TEST %s: ", CR_STR(mcc_head));
 	print_rfcomm_hdr(head, ptr, len);
 	print_mcc(mcc_head);
+
+	p_indent(level, 0);
+	printf("%*cTest data: 0x ", level, ' ');
+
+	while (len > 1) {
+		printf("%2.2x ", (uint8_t)*ptr);
+		len--;
+		ptr++;
+	}
+
+	printf("\n");
 }
 static inline void mcc_fcon(int level, uint8_t *ptr, int len,
 				long_frame_head *head, mcc_long_frame_head *mcc_head)
@@ -208,7 +219,6 @@ static inline void mcc_frame(int level, struct frame *frm, long_frame_head *head
 	switch (mcc_head.type.type) {
 	case TEST:
 		mcc_test(level, frm->ptr, frm->len, head, &mcc_head);
-		raw_dump(level, frm); 
 		break;
 	case FCON:
 		mcc_fcon(level, frm->ptr, frm->len, head, &mcc_head);
-- 
1.9.1

