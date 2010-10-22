Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/6] Bluetooth: Start SMP procedure
Date: Fri, 22 Oct 2010 19:56:58 -0400
Message-Id: <1287791820-22693-5-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <linux-bluetooth@vger.kernel.org>
References: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Start SMP procedure for LE connections. This modification intercepts l2cap
received frames and call proper SMP functions to start the SMP procedure. By
now, no keys are being used.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/l2cap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ba87c84..2a88f23 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -714,6 +714,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
+			if (smp_conn_security(conn, l2cap_pi(sk)->sec_level))
+				BT_DBG("Insufficient security");
 		}
 
 		if (sk->sk_type != SOCK_SEQPACKET &&
@@ -4707,6 +4709,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		l2cap_conless_channel(conn, psm, skb);
 		break;
 
+	case L2CAP_CID_SMP:
+		smp_sig_channel(conn, skb);
+		break;
+
 	default:
 		l2cap_data_channel(conn, cid, skb);
 		break;
-- 
1.7.0.4

