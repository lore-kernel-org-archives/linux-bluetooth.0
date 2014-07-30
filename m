Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com
Subject: [PATCH 5/5] 6lowpan: iphc: Fix parenthesis alignments which off-by-one
Date: Wed, 30 Jul 2014 03:48:44 +0200
Message-Id: <1406684924-40906-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CHECK: Alignment should match open parenthesis
+	if (((hdr->flow_lbl[0] & 0x0F) == 0) &&
+	     (hdr->flow_lbl[1] == 0) && (hdr->flow_lbl[2] == 0)) {

CHECK: Alignment should match open parenthesis
+		if ((hdr->priority == 0) &&
+		   ((hdr->flow_lbl[0] & 0xF0) == 0)) {

CHECK: Alignment should match open parenthesis
+		if ((hdr->priority == 0) &&
+		   ((hdr->flow_lbl[0] & 0xF0) == 0)) {

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/6lowpan/iphc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 9e47702d24dd..350ecfafa8e7 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -643,11 +643,11 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	tmp = ((tmp & 0x03) << 6) | (tmp >> 2);
 
 	if (((hdr->flow_lbl[0] & 0x0F) == 0) &&
-	     (hdr->flow_lbl[1] == 0) && (hdr->flow_lbl[2] == 0)) {
+	    (hdr->flow_lbl[1] == 0) && (hdr->flow_lbl[2] == 0)) {
 		/* flow label can be compressed */
 		iphc0 |= LOWPAN_IPHC_FL_C;
 		if ((hdr->priority == 0) &&
-		   ((hdr->flow_lbl[0] & 0xF0) == 0)) {
+		    ((hdr->flow_lbl[0] & 0xF0) == 0)) {
 			/* compress (elide) all */
 			iphc0 |= LOWPAN_IPHC_TC_C;
 		} else {
@@ -658,7 +658,7 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		/* Flow label cannot be compressed */
 		if ((hdr->priority == 0) &&
-		   ((hdr->flow_lbl[0] & 0xF0) == 0)) {
+		    ((hdr->flow_lbl[0] & 0xF0) == 0)) {
 			/* compress only traffic class */
 			iphc0 |= LOWPAN_IPHC_TC_C;
 			*hc_ptr = (tmp & 0xc0) | (hdr->flow_lbl[0] & 0x0F);
-- 
1.9.3

