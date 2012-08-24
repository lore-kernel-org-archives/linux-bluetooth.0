Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/2] Bluetooth: Change signature of smp_conn_security()
Date: Thu, 23 Aug 2012 21:32:43 -0300
Message-Id: <1345768364-9546-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To make it clear that it may be called from contexts that may not have
any knowledge of L2CAP, we change the connection parameter, to receive
a hci_conn.

This also makes it clear that it is checking the security of the link.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/smp.h |  2 +-
 net/bluetooth/l2cap_core.c  | 11 ++++++-----
 net/bluetooth/l2cap_sock.c  |  2 +-
 net/bluetooth/smp.c         |  4 ++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 50993a5..f8ba07f 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -136,7 +136,7 @@ struct smp_chan {
 };
 
 /* SMP Commands */
-int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
+int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
 int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9732f03..7479825 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1216,14 +1216,15 @@ clean:
 static void l2cap_conn_ready(struct l2cap_conn *conn)
 {
 	struct l2cap_chan *chan;
+	struct hci_conn *hcon = conn->hcon;
 
 	BT_DBG("conn %p", conn);
 
-	if (!conn->hcon->out && conn->hcon->type == LE_LINK)
+	if (!hcon->out && hcon->type == LE_LINK)
 		l2cap_le_conn_ready(conn);
 
-	if (conn->hcon->out && conn->hcon->type == LE_LINK)
-		smp_conn_security(conn, conn->hcon->pending_sec_level);
+	if (hcon->out && hcon->type == LE_LINK)
+		smp_conn_security(hcon, hcon->pending_sec_level);
 
 	mutex_lock(&conn->chan_lock);
 
@@ -1236,8 +1237,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			continue;
 		}
 
-		if (conn->hcon->type == LE_LINK) {
-			if (smp_conn_security(conn, chan->sec_level))
+		if (hcon->type == LE_LINK) {
+			if (smp_conn_security(hcon, chan->sec_level))
 				l2cap_chan_ready(chan);
 
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 13f6a98..a75be577 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -619,7 +619,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 				break;
 			}
 
-			if (smp_conn_security(conn, sec.level))
+			if (smp_conn_security(conn->hcon, sec.level))
 				break;
 			sk->sk_state = BT_CONFIG;
 			chan->state = BT_CONFIG;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 16ef0dc..03e284e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -757,9 +757,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
-int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
+int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 {
-	struct hci_conn *hcon = conn->hcon;
+	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct smp_chan *smp = conn->smp_chan;
 	__u8 authreq;
 
-- 
1.7.12

