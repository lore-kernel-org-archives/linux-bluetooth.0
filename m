Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mcchou@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, josephsih@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH v4] monitor/rfcomm: Fix a potential memory access issue for compatibility with LLVM
Date: Tue, 20 Dec 2016 11:50:13 -0800
Message-Id: <1482263413-85198-1-git-send-email-mcchou@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Miao-chen Chou <mcchou@chromium.org>

This patch removes "packed" attribute from the definition of struct rfcomm_rpn
to prevent the access to an unaligned struct member in mmc_rpn(). This patch
also introduces a temp variable in mcc_pn() to prevent unaligned access without
touching the definition of struct rfcomm_pn, since struct rfcomm_pn is used as
a PDU.
---
v4 removes the unrelated change on the code format.

 monitor/rfcomm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index b32ad40..4bd549c 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -106,7 +106,7 @@ struct rfcomm_rpn {
 	uint8_t xon;
 	uint8_t xoff;
 	uint16_t pm;
-} __attribute__ ((packed));
+};

 struct rfcomm_rls {
 	uint8_t dlci;
@@ -265,6 +265,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 {
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
 	struct rfcomm_pn pn;
+	uint16_t mtu;

 	/* rfcomm_pn struct is defined in rfcomm.h */

@@ -284,8 +285,10 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
 		return false;

-	if (!l2cap_frame_get_le16(frame, &pn.mtu))
+	/* prevent unaligned memory access */
+	if (!l2cap_frame_get_le16(frame, &mtu))
 		return false;
+	pn.mtu = mtu;

 	if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
 		return false;
--
2.8.0.rc3.226.g39d4020

