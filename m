Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: set sk_sndbuf and sk_rcvbuf properly in ERTM
Date: Mon, 27 Sep 2010 17:16:48 -0300
Message-Id: <1285618609-11499-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Setting both this value to MPS * TxWin * 1.2 guarantees that we are
reserving space to fit the whole txwindow in the memory, and that
sendmsg() will block when the transmission window is full avoid
overloading the system memory.
I don't have a strong reason about the 1.2 constant in the account, we
can do another tests in the future and change that value.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 44aa034..1e2ab05 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3129,9 +3129,17 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		l2cap_pi(sk)->next_tx_seq = 0;
 		l2cap_pi(sk)->expected_tx_seq = 0;
 		__skb_queue_head_init(TX_QUEUE(sk));
-		if (l2cap_pi(sk)->mode ==  L2CAP_MODE_ERTM)
+		if (l2cap_pi(sk)->mode ==  L2CAP_MODE_ERTM) {
 			l2cap_ertm_init(sk);
 
+			sk->sk_sndbuf = (l2cap_pi(sk)->remote_tx_win * 1.2 *
+						(sizeof(struct l2cap_pinfo) +
+						l2cap_pi(sk)->mps));
+			sk->sk_rcvbuf = (l2cap_pi(sk)->tx_win * 1.2 *
+						(sizeof(struct l2cap_pinfo) +
+						l2cap_pi(sk)->remote_mps));
+		}
+
 		l2cap_chan_ready(sk);
 	}
 
-- 
1.7.3

