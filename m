Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 5/6] Bluetooth: Check the SDU size against the MTU value
Date: Fri, 26 Mar 2010 16:19:18 -0300
Message-Id: <1269631159-20750-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269631159-20750-4-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-20-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-1-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-2-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-3-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-4-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

If the SDU size is greater than the MTU something is wrong, so report
an error.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e6e2351..20c3f53 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3335,6 +3335,9 @@ static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 co
 		pi->sdu_len = get_unaligned_le16(skb->data);
 		skb_pull(skb, 2);
 
+		if (pi->sdu_len > pi->imtu)
+			break;
+
 		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
 		if (!pi->sdu) {
 			err = -ENOMEM;
-- 
1.6.4.4
