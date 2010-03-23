Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 08/19] Bluetooth: Move set of P-bit to l2cap_send_sframe()
Date: Tue, 23 Mar 2010 16:48:35 -0300
Message-Id: <1269373726-13209-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-8-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-8-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Abstract the send of of P-bit and avoids code duplication like we
did with the setting of F-bit.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 6368cb2..2e1884b 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -357,6 +357,11 @@ static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 	}
 
+	if (pi->conn_state & L2CAP_CONN_SEND_PBIT) {
+		control |= L2CAP_CTRL_POLL;
+		pi->conn_state &= ~L2CAP_CONN_SEND_PBIT;
+	}
+
 	skb = bt_skb_alloc(count, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
@@ -3356,10 +3361,6 @@ static void l2cap_send_srejframe(struct sock *sk, u8 tx_seq)
 	while (tx_seq != pi->expected_tx_seq) {
 		control = L2CAP_SUPER_SELECT_REJECT;
 		control |= pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-		if (pi->conn_state & L2CAP_CONN_SEND_PBIT) {
-			control |= L2CAP_CTRL_POLL;
-			pi->conn_state &= ~L2CAP_CONN_SEND_PBIT;
-		}
 		l2cap_send_sframe(pi, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
-- 
1.6.4.4
