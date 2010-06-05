Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 08/14] Bluetooth: Stop ack_timer if ERTM enters in Local Busy or SREJ_SENT
Date: Sat,  5 Jun 2010 04:50:12 -0300
Message-Id: <1275724218-29453-9-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-8-git-send-email-gustavo@padovan.org>
References: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
 <1275724218-29453-2-git-send-email-gustavo@padovan.org>
 <1275724218-29453-3-git-send-email-gustavo@padovan.org>
 <1275724218-29453-4-git-send-email-gustavo@padovan.org>
 <1275724218-29453-5-git-send-email-gustavo@padovan.org>
 <1275724218-29453-6-git-send-email-gustavo@padovan.org>
 <1275724218-29453-7-git-send-email-gustavo@padovan.org>
 <1275724218-29453-8-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

The ack_timer is implemation specific, disabling it in such situation
avoids some potencial errors in the ERTM protocol.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 7a8454a..35b7791 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3632,6 +3632,8 @@ static int l2cap_push_rx_skb(struct sock *sk, struct sk_buff *skb, u16 control)
 
 	pi->conn_state |= L2CAP_CONN_RNR_SENT;
 
+	del_timer(&pi->ack_timer);
+
 	queue_work(_busy_wq, &pi->busy_work);
 
 	return err;
@@ -3881,6 +3883,8 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 		pi->conn_state |= L2CAP_CONN_SEND_PBIT;
 
 		l2cap_send_srejframe(sk, tx_seq);
+
+		del_timer(&pi->ack_timer);
 	}
 	return 0;
 
-- 
1.7.1
