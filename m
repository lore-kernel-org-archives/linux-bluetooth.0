Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulissesf@gmail.com>
In-Reply-To: <d23110170608090806j2b39e87eqd84ba9843d216153@mail.gmail.com>
References: <44D88EC1.7010009@pracucci.com> <44D8815D.4000108@infitsrl.com>
	<d23110170608090806j2b39e87eqd84ba9843d216153@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-QyWvEp4tfgBm743WMku4"
Date: Thu, 10 Aug 2006 21:08:43 +0200
Message-Id: <1155236923.4492.49.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "File descriptor in bad state" on sdp_connect()
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


--=-QyWvEp4tfgBm743WMku4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ulisses,

> > I have had a similar problem ....I've discovered (with Marcel help) is a
> > problem in l2cap layer.
> > l2cap kernel module do not handle multiple connect, Marcel send to me a
> > patch I am trying to make to work
> >  but I'm very busy with my job and is not still clear where the patch
> > hangs the system.
> 
> We thought we had a deadlock somewhere but it wasn't the case. We had
> two problems:
> 
>  - trying to list_del() the same list entry twice leading us to a page fault

where do we delete the entry twice?

>  - we've forgotten to INIT_LIST_HEAD() our l2cap_conn->list leading us
> to a NULL pointer dereference

This must be another bug, because it is not needed to init the list item
itself. You only have to init the list head.

The attached patch should not change any behavior, but keep track of
L2CAP connections in creation state. Please test and check the output of
dmesg.

Regards

Marcel


--=-QyWvEp4tfgBm743WMku4
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
index d56f60b..1fd3060 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -55,7 +55,7 @@ #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "2.8"
+#define VERSION "2.9"
 
 static const struct proto_ops l2cap_sock_ops;
 
@@ -63,6 +63,9 @@ static struct bt_sock_list l2cap_sk_list
 	.lock = RW_LOCK_UNLOCKED
 };
 
+static LIST_HEAD(l2cap_conn_list);
+static DEFINE_SPINLOCK(l2cap_conn_lock);
+
 static void __l2cap_sock_close(struct sock *sk, int reason);
 static void l2cap_sock_close(struct sock *sk);
 static void l2cap_sock_kill(struct sock *sk);
@@ -642,18 +645,23 @@ static int l2cap_do_connect(struct sock 
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
@@ -1920,18 +1928,60 @@ static int l2cap_connect_ind(struct hci_
 static int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn;
+	struct list_head *p;
 
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
 
 	if (hcon->type != ACL_LINK)
 		return 0;
 
-	if (!status) {
+	spin_lock_bh(&l2cap_conn_lock);
+	list_for_each(p, &l2cap_conn_list) {
+		struct l2cap_conn *c = list_entry(p, struct l2cap_conn, list);
+		BT_ERR("src %s dst %s", batostr(c->src), batostr(c->dst));
+	}
+	spin_unlock_bh(&l2cap_conn_lock);
+
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
+#if 0
+		spin_lock_bh(&l2cap_conn_lock);
+		if (!list_empty(&l2cap_conn_list)) {
+			struct l2cap_conn *next;
+			next = list_entry(l2cap_conn_list.next, struct l2cap_conn, list);
+			list_move_tail(&next->list, &l2cap_conn_list);
+			hci_conn_put(next->hcon);
+			hci_connect(next->hcon->hdev, ACL_LINK, next->dst);
+		}
+		spin_unlock_bh(&l2cap_conn_lock);
+#endif
+		break;
+
+	case 0x0c:
+		/* fall-through for now */
+
+	default:
+		conn = hcon->l2cap_data;
+		if (!conn)
+			break;
+
+		spin_lock_bh(&l2cap_conn_lock);
+		list_del(&conn->list);
+		spin_unlock_bh(&l2cap_conn_lock);
+
 		l2cap_conn_del(hcon, bt_err(status));
+		break;
+	}
 
 	return 0;
 }

--=-QyWvEp4tfgBm743WMku4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-QyWvEp4tfgBm743WMku4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-QyWvEp4tfgBm743WMku4--
