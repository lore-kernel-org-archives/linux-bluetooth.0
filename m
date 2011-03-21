Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/10] Bluetooth: Opencode macros in bnep/core.c
Date: Mon, 21 Mar 2011 14:19:57 +0100
Message-ID: <1300713606-23523-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BNEP_RX_TYPES and INCA macros have only one user each and don't provide
any benefits compared to opencoding them.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/bnep/core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 03d4d12..940b4e1 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -187,6 +187,8 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 	n /= (ETH_ALEN * 2);
 
 	if (n > 0) {
+		int i;
+
 		s->mc_filter = 0;
 
 		/* Always send broadcast */
@@ -202,12 +204,14 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 			BT_DBG("mc filter %s -> %s",
 				batostr((void *) a1), batostr((void *) a2));
 
-			#define INCA(a) { int i = 5; while (i >=0 && ++a[i--] == 0); }
-
 			/* Iterate from a1 to a2 */
 			set_bit(bnep_mc_hash(a1), (ulong *) &s->mc_filter);
 			while (memcmp(a1, a2, 6) < 0 && s->mc_filter != ~0LL) {
-				INCA(a1);
+				/* Increment a1 */
+				i = 5;
+				while (i >= 0 && ++a1[i--] == 0)
+					;
+
 				set_bit(bnep_mc_hash(a1), (ulong *) &s->mc_filter);
 			}
 		}
@@ -302,7 +306,6 @@ static u8 __bnep_rx_hlen[] = {
 	ETH_ALEN + 2, /* BNEP_COMPRESSED_SRC_ONLY */
 	ETH_ALEN + 2  /* BNEP_COMPRESSED_DST_ONLY */
 };
-#define BNEP_RX_TYPES	(sizeof(__bnep_rx_hlen) - 1)
 
 static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 {
@@ -314,7 +317,7 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	type = *(u8 *) skb->data; skb_pull(skb, 1);
 
-	if ((type & BNEP_TYPE_MASK) > BNEP_RX_TYPES)
+	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
-- 
1.7.0.4

