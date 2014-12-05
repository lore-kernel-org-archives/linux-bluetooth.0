Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH ] monitor/rfcomm: Fix byte ordering issue
Date: Fri, 05 Dec 2014 19:14:29 +0530
Message-id: <1417787069-11163-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The correct byte order for RFCOMM protocol is
little endian.
---
 monitor/rfcomm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index fe3afb7..e8dfdb5 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -218,7 +218,7 @@ static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 		GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
 		rpn.xoff);
 
-	if (!l2cap_frame_get_be16(frame, &rpn.pm))
+	if (!l2cap_frame_get_le16(frame, &rpn.pm))
 		return false;
 
 	print_field("%*cpm 0x%04x", indent, ' ', rpn.pm);
@@ -267,7 +267,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
 		return false;
 
-	if (!l2cap_frame_get_be16(frame, &pn.mtu))
+	if (!l2cap_frame_get_le16(frame, &pn.mtu))
 		return false;
 
 	if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
-- 
1.9.1

