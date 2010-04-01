Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 24/34] Bluetooth: Check the SDU size against the MTU value
Date: Thu,  1 Apr 2010 17:23:42 -0300
Message-Id: <1270153432-6477-25-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-24-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-24-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

If the SDU size is greater than the MTU something is wrong, so report
an error.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
[jprvita@profusion.mobi: set err to appropriate errno value]
Signed-off-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e6e2351..6196f2c 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3335,6 +3335,11 @@ static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 co
 		pi->sdu_len = get_unaligned_le16(skb->data);
 		skb_pull(skb, 2);
 
+		if (pi->sdu_len > pi->imtu) {
+			err = -EMSGSIZE;
+			break;
+		}
+
 		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
 		if (!pi->sdu) {
 			err = -ENOMEM;
-- 
1.6.4.4
