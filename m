Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7359D844-F738-4AD1-A1FD-F59BEFD149EC@infitsrl.com>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
	<20060724103824.1ff98fa6@McGee-XPC> <44C4CC37.1060308@infitsrl.com>
	<20060724155621.02cd5e11@localhost.localdomain>
	<1153758912.25058.3.camel@localhost>
	<20060724203433.7184d301@localhost.localdomain>
	<7359D844-F738-4AD1-A1FD-F59BEFD149EC@infitsrl.com>
Content-Type: multipart/mixed; boundary="=-g2jYrdEfjU07SIDgCxF4"
Date: Mon, 24 Jul 2006 23:12:21 +0200
Message-Id: <1153775541.25058.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] It's rfcomm connect problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-g2jYrdEfjU07SIDgCxF4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Fabrizio,

> Last solutions it's to see at l2cap layer and try to understand ho wo  
> write the patch, if
> I will succeed to find  the past Marcel's thread about it I'll try to  
> write this patch.

it must look something like the attached one. However that one might
crash your machine.

Regards

Marcel


--=-g2jYrdEfjU07SIDgCxF4
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 8242a0e..cb19e66 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -183,6 +183,8 @@ struct l2cap_chan_list {
 };
 
 struct l2cap_conn {
+	struct list_head list;
+
 	struct hci_conn	*hcon;
 
 	bdaddr_t	*dst;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index eaaad65..1d1c423 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -63,6 +63,9 @@ static struct bt_sock_list l2cap_sk_list
 	.lock = RW_LOCK_UNLOCKED
 };
 
+static LIST_HEAD(l2cap_conn_list);
+static DEFINE_SPINLOCK(l2cap_conn_lock);
+
 static void __l2cap_sock_close(struct sock *sk, int reason);
 static void l2cap_sock_close(struct sock *sk);
 static void l2cap_sock_kill(struct sock *sk);
@@ -295,6 +298,10 @@ static void l2cap_conn_del(struct hci_co
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	spin_lock_bh(&l2cap_conn_lock);
+	list_del(&conn->list);
+	spin_unlock_bh(&l2cap_conn_lock);
+
 	if (conn->rx_skb)
 		kfree_skb(conn->rx_skb);
 
@@ -642,18 +649,23 @@ static int l2cap_do_connect(struct sock 
 	sk->sk_state = BT_CONNECT;
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
-	if (hcon->state == BT_CONNECTED) {
-		if (sk->sk_type == SOCK_SEQPACKET) {
-			struct l2cap_conn_req req;
-			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
-			req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
-			req.psm  = l2cap_pi(sk)->psm;
-			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-					L2CAP_CONN_REQ, sizeof(req), &req);
-		} else {
-			l2cap_sock_clear_timer(sk);
-			sk->sk_state = BT_CONNECTED;
-		}
+	if (hcon->state != BT_CONNECTED) {
+		spin_lock_bh(&l2cap_conn_lock);
+		list_add_tail(&conn->list, &l2cap_conn_list);
+		spin_unlock_bh(&l2cap_conn_lock);
+		goto done;
+	}
+
+	if (sk->sk_type == SOCK_SEQPACKET) {
+		struct l2cap_conn_req req;
+		l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+		req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
+		req.psm  = l2cap_pi(sk)->psm;
+		l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+				L2CAP_CONN_REQ, sizeof(req), &req);
+	} else {
+		l2cap_sock_clear_timer(sk);
+		sk->sk_state = BT_CONNECTED;
 	}
 
 done:
@@ -1926,12 +1938,35 @@ static int l2cap_connect_cfm(struct hci_
 	if (hcon->type != ACL_LINK)
 		return 0;
 
-	if (!status) {
+	switch (status) {
+	case 0x00:
 		conn = l2cap_conn_add(hcon, status);
-		if (conn)
-			l2cap_conn_ready(conn);
-	} else
+		if (!conn)
+			break;
+
+		spin_lock_bh(&l2cap_conn_lock);
+		list_del(&conn->list);
+		spin_unlock_bh(&l2cap_conn_lock);
+
+		l2cap_conn_ready(conn);
+
+		spin_lock_bh(&l2cap_conn_lock);
+		if (!list_empty(&l2cap_conn_list)) {
+			conn = list_entry(l2cap_conn_list.next, struct l2cap_conn, list);
+			list_move_tail(&conn->list, &l2cap_conn_list);
+			hci_conn_put(conn->hcon);
+			hci_connect(conn->hcon->hdev, ACL_LINK, conn->dst);
+		}
+		spin_unlock_bh(&l2cap_conn_lock);
+		break;
+
+	case 0x0c:
+		break;
+
+	default:
 		l2cap_conn_del(hcon, bt_err(status));
+		break;
+	}
 
 	return 0;
 }

--=-g2jYrdEfjU07SIDgCxF4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-g2jYrdEfjU07SIDgCxF4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-g2jYrdEfjU07SIDgCxF4--
