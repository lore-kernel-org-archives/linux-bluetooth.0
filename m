Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mcchou@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, josephsih@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH 2/2] monitor/rfcomm: Fix a potential memory access issue
Date: Fri,  2 Dec 2016 18:08:32 -0800
Message-Id: <1480730912-41560-1-git-send-email-mcchou@chromium.org>
In-Reply-To: <CABBYNZ+_=ihEO+sVwUV-w5eNOs2FB=7OpjMPTdik_jLHCR29Jw@mail.gmail.com>
References: <CABBYNZ+_=ihEO+sVwUV-w5eNOs2FB=7OpjMPTdik_jLHCR29Jw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Miao-chen Chou <mcchou@chromium.org>

This patch introduces a temp variable to prevent the access to an unaligned
struct member. Since the struct rfcomm_rpn is used from PDU, enforcing alignment
is not a solution due to padding.
---
 monitor/rfcomm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index b32ad40..7f1f23e 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -199,6 +199,7 @@ static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 {
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
 	struct rfcomm_rpn rpn;
+	uint16_t pm;

 	if (!l2cap_frame_get_u8(frame, &rpn.dlci))
 		return false;
@@ -235,8 +236,11 @@ static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 		GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
 		rpn.xoff);

-	if (!l2cap_frame_get_le16(frame, &rpn.pm))
+	/* prevent unaligned memory access */
+	pm = rpn.pm;
+	if (!l2cap_frame_get_le16(frame, &pm))
 		return false;
+	rpn.pm = pm;

 	print_field("%*cpm 0x%04x", indent, ' ', rpn.pm);

@@ -265,6 +269,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 {
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
 	struct rfcomm_pn pn;
+	uint16_t mtu;

 	/* rfcomm_pn struct is defined in rfcomm.h */

@@ -284,8 +289,11 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
 		return false;

-	if (!l2cap_frame_get_le16(frame, &pn.mtu))
+	/* prevent unaligned memory access */
+	mtu = pn.mtu;
+	if (!l2cap_frame_get_le16(frame, &mtu))
 		return false;
+	pn.mtu = mtu;

 	if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
 		return false;
--
2.8.0.rc3.226.g39d4020

