Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [bluetooth-next v4 02/16] Bluetooth: Start SMP procedure
Date: Thu,  9 Jun 2011 18:50:41 -0300
Message-Id: <1307656255-8659-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

Start SMP procedure for LE connections. This modification intercepts
l2cap received frames and call proper SMP functions to start the SMP
procedure. By now, no keys are being used.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index dff9d76..e9c053c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -54,6 +54,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/smp.h>
 
 int disable_ertm;
 
@@ -898,6 +899,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			l2cap_chan_clear_timer(chan);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
+			if (smp_conn_security(conn, chan->sec_level))
+				BT_DBG("Insufficient security");
 		}
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
@@ -4057,6 +4060,11 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		l2cap_att_channel(conn, cid, skb);
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
1.7.5.4

