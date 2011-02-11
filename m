Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next -v2 11/24] Bluetooth: Start SMP procedure
Date: Thu, 10 Feb 2011 22:38:56 -0300
Message-Id: <1297388349-14878-12-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-11-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-5-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-8-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-9-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-10-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-11-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

Start SMP procedure for LE connections. This modification intercepts
l2cap received frames and call proper SMP functions to start the SMP
procedure. By now, no keys are being used.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ec81e2d..82d20eb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -54,6 +54,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/smp.h>
 
 #define VERSION "2.15"
 
@@ -686,6 +687,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
+			if (smp_conn_security(conn, l2cap_pi(sk)->sec_level))
+				BT_DBG("Insufficient security");
 		}
 
 		if (sk->sk_type != SOCK_SEQPACKET &&
@@ -3578,6 +3581,11 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		l2cap_conless_channel(conn, psm, skb);
 		break;
 
+	case L2CAP_CID_SMP:
+		if (smp_sig_channel(conn, skb))
+			l2cap_conn_del(conn->hcon, EACCES);
+		break;
+
 	default:
 		l2cap_data_channel(conn, cid, skb);
 		break;
-- 
1.7.4

