Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC v2 3/9] Bluetooth: Start SMP procedure
Date: Mon,  6 Dec 2010 18:43:46 -0300
Message-Id: <1291671832-13435-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

Start SMP procedure for LE connections. This modification intercepts l2cap
received frames and call proper SMP functions to start the SMP procedure. By
now, no keys are being used.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    7 +++++++
 net/bluetooth/smp.c        |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 69e5f80..674799c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -54,6 +54,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/smp.h>
 
 #define VERSION "2.15"
 
@@ -642,6 +643,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
+			if (smp_conn_security(conn, l2cap_pi(sk)->sec_level))
+				BT_DBG("Insufficient security");
 		}
 
 		if (sk->sk_type != SOCK_SEQPACKET &&
@@ -4626,6 +4629,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		l2cap_conless_channel(conn, psm, skb);
 		break;
 
+	case L2CAP_CID_SMP:
+		smp_sig_channel(conn, skb);
+		break;
+
 	default:
 		l2cap_data_channel(conn, cid, skb);
 		break;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e427d11..e9dde5f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -86,7 +86,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		return 1;
 	}
 
-	if (conn->hcon->link_mode & HCI_LM_MASTER) {
+	if (conn->hcon->out) {
 		struct smp_cmd_pairing cp;
 		cp.io_capability = 0x00;
 		cp.oob_flag = 0x00;
-- 
1.7.3.2

