Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001101c4a017$a45ae9d0$1a01010a@baked>
References: <001101c4a017$a45ae9d0$1a01010a@baked>
Content-Type: multipart/mixed; boundary="=-91UBxZ9GfjZrqAy/wT7Q"
Message-Id: <1095798744.5762.4.camel@pegasus>
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
Date: Tue, 21 Sep 2004 22:32:24 +0200


--=-91UBxZ9GfjZrqAy/wT7Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Daryl,

> > for the L2CAP part the attached patch may fixes the problem 
> > and let the
> > module reference count decrease after the disconnect. The 
> > patch is only
> > compile tested. May you wanna give it a chance and run your 
> > L2CAP tests
> > again.
> 
> I gave it a try and it works fine as far as I can tell. I had to apply the
> patch manually though (I'm assuming this is because you're working with a
> 2.6 kernel and I'm not).

I will fix 2.6 first, before I will backport it to 2.4.

> I don't see the use count incrementing badly any more, and the listening
> socket will continue to accept connections after the number of
> connects/disconnects have exceeded the the accept queue.

This sounds great and hopefully this patch has no negative side effects
on normal listen/accept calls and outgoing connections.

> Does this give you any ideas for rfcomm?

Attached is the full patch that should also fix the RFCOMM part. This is
again only compile tested, because I had no time to setup a test system.
The L2CAP solution looks very sane to me, but I am not sure about the
RFCOMM part and we may will have a locking problem. This really needs
intensive testing.

Regards

Marcel


--=-91UBxZ9GfjZrqAy/wT7Q
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
+++ edited/net/bluetooth/rfcomm/sock.c	2004-09-21 02:09:47 +02:00
@@ -104,8 +104,11 @@
 		if (d->state == BT_CONNECTED)
 			rfcomm_session_getaddr(d->session, &bt_sk(sk)->src, NULL);
 		sk->sk_state_change(sk);
-	} else
+	} else {
+		if (d->state == BT_CLOSED)
+			bt_accept_unlink(sk);
 		parent->sk_data_ready(parent, 0);
+	}
 
 	bh_unlock_sock(sk);
 }

--=-91UBxZ9GfjZrqAy/wT7Q--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
