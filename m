Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH] Bluetooth: Stop ack_timer if ERTM enters in Local Busy or SREJ_SENT
Date: Wed, 12 May 2010 18:59:36 -0300
Message-Id: <1273701576-17238-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1273633558-10576-6-git-send-email-padovan@profusion.mobi>
References: <1273633558-10576-6-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

The ack_timer is implemation specific, disabling it in such situation
avoids some potencial errors in the ERTM protocol.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2192b9c..b061108 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3633,6 +3633,8 @@ static int l2cap_push_rx_skb(struct sock *sk, struct sk_buff *skb, u16 control)
 
 	pi->conn_state |= L2CAP_CONN_RNR_SENT;
 
+	del_timer(&pi->ack_timer);
+
 	queue_work(_busy_wq, &pi->busy_work);
 
 	return err;
@@ -3882,6 +3884,8 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 		pi->conn_state |= L2CAP_CONN_SEND_PBIT;
 
 		l2cap_send_srejframe(sk, tx_seq);
+
+		del_timer(&pi->ack_timer);
 	}
 	return 0;
 
-- 
1.6.4.4
