Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi,
	ulisses@profusion.mobi
Subject: [PATCH 2/7] Bluetooth: Fix Indentation on L2CAP
Date: Wed, 14 Apr 2010 16:41:47 -0300
Message-Id: <1271274112-7806-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1271274112-7806-2-git-send-email-padovan@profusion.mobi>
References: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-2-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index d38bfc2..657a411 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1369,7 +1369,7 @@ static int l2cap_ertm_send(struct sock *sk)
 		return 0;
 
 	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(sk)) &&
-	       !(pi->conn_state & L2CAP_CONN_REMOTE_BUSY)) {
+			!(pi->conn_state & L2CAP_CONN_REMOTE_BUSY)) {
 
 		if (pi->remote_max_tx &&
 				bt_cb(skb)->retries == pi->remote_max_tx) {
-- 
1.6.4.4

