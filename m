Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095851321.6223.15.camel@pegasus>
References: <001d01c4a02c$9aaeab00$1a01010a@baked>
	 <1095851321.6223.15.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-tTwxFjQ4djUhKtuIP+dt"
Message-Id: <1095861229.6223.32.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Sep 2004 15:53:49 +0200


--=-tTwxFjQ4djUhKtuIP+dt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Daryl,

> the correct approach seems to be:
> 
> 	sk->sk_zapped = 1;
> 	rfcomm_sock_kill(sk);
> 
> The problem is that rfcomm_sock_kill() must be called on an unlocked
> socket and I think that we will deadlock on a SMP machine or get some
> NULL pointer dereferences.

after more and more thinking about that problem I am almost sure that it
is right to call rfcomm_sock_kill() in the state change function. Anyway
we must do this on an unlocked socket. Here is my proposal for the final
patch, but we need real testing on this so that I can be sure that there
are no side effects. Can anyone test it on SMP or HT systems?

Regards

Marcel


--=-tTwxFjQ4djUhKtuIP+dt
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== include/net/bluetooth/bluetooth.h 1.18 vs edited =====
--- 1.18/include/net/bluetooth/bluetooth.h	2004-07-04 17:27:14 +02:00
+++ edited/include/net/bluetooth/bluetooth.h	2004-09-21 01:26:06 +02:00
@@ -133,6 +133,7 @@
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk);
+void bt_accept_unlink(struct sock *sk);
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
 
 /* Skb helpers */
===== net/bluetooth/af_bluetooth.c 1.36 vs edited =====
--- 1.36/net/bluetooth/af_bluetooth.c	2004-07-13 15:39:15 +02:00
+++ edited/net/bluetooth/af_bluetooth.c	2004-09-21 01:26:17 +02:00
@@ -165,7 +165,7 @@
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
 
-static void bt_accept_unlink(struct sock *sk)
+void bt_accept_unlink(struct sock *sk)
 {
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
@@ -174,6 +174,7 @@
 	bt_sk(sk)->parent = NULL;
 	sock_put(sk);
 }
+EXPORT_SYMBOL(bt_accept_unlink);
 
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 {
===== net/bluetooth/l2cap.c 1.44 vs edited =====
--- 1.44/net/bluetooth/l2cap.c	2004-09-04 12:51:17 +02:00
+++ edited/net/bluetooth/l2cap.c	2004-09-21 01:23:41 +02:00
@@ -1005,9 +1005,10 @@
 	if (err)
 		sk->sk_err = err;
 
-	if (parent)
+	if (parent) {
+		bt_accept_unlink(sk);
 		parent->sk_data_ready(parent, 0);
-	else
+	} else
 		sk->sk_state_change(sk);
 }
 
===== net/bluetooth/rfcomm/sock.c 1.29 vs edited =====
--- 1.29/net/bluetooth/rfcomm/sock.c	2004-06-04 02:41:47 +02:00
+++ edited/net/bluetooth/rfcomm/sock.c	2004-09-22 13:26:26 +02:00
@@ -97,17 +97,26 @@
 
 	if (err)
 		sk->sk_err = err;
+
 	sk->sk_state = d->state;
 
 	parent = bt_sk(sk)->parent;
-	if (!parent) {
+	if (parent) {
+		if (d->state == BT_CLOSED) {
+			sk->sk_zapped = 1;
+			bt_accept_unlink(sk);
+		}
+		parent->sk_data_ready(parent, 0);
+	} else {
 		if (d->state == BT_CONNECTED)
 			rfcomm_session_getaddr(d->session, &bt_sk(sk)->src, NULL);
 		sk->sk_state_change(sk);
-	} else
-		parent->sk_data_ready(parent, 0);
+	}
 
 	bh_unlock_sock(sk);
+
+	if (parent && sk->sk_zapped)
+		rfcomm_sock_kill(sk);
 }
 
 /* ---- Socket functions ---- */

--=-tTwxFjQ4djUhKtuIP+dt--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
