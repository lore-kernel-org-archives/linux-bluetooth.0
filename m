Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003101c49f62$7e2f7fb0$1a01010a@baked>
References: <003101c49f62$7e2f7fb0$1a01010a@baked>
Content-Type: multipart/mixed; boundary="=-3OGFW19oibem7MecuPoe"
Message-Id: <1095723182.5731.76.camel@pegasus>
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
Date: Tue, 21 Sep 2004 01:33:03 +0200


--=-3OGFW19oibem7MecuPoe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Daryl,

> > so this means when we disconnect we must ensure that we also 
> > remove this
> > connection from the accept queue if it is pending there.
> > 
> > What I know think is that calling the bt_accept_unlink() function only
> > from bt_accept_dequeue() is wrong. If bt_sk(sk)->parent is set and we
> > ran into a disconnect then we must unlink it by ourself. Does 
> > this make
> > sense?
> 
> This makes sense to me, but I'm not convinced that it's enough of a problem
> to warrant major changes. And I'm probably not the best person to ask. ;)

for the L2CAP part the attached patch may fixes the problem and let the
module reference count decrease after the disconnect. The patch is only
compile tested. May you wanna give it a chance and run your L2CAP tests
again.

> Do we know how the tcp stack handles this kind of thing? (I had a quick look
> at a text on sockets and it didn't specifically cover the case of
> connections getting closed which are in the queue. But it was clear that the
> precise behaviour of the queue varies for tcp-ip from unix to unix.)
> 
> Most servers (I think) would sit with accept() blocking and then spend a
> very brief time handing off the new connection before blocking on accept()
> again. So this wouldn't cause much trouble.
> 
> I suppose this could affect a very simple server which is single-threaded
> (and so could spend significant time between accept() calls). Or a very busy
> server. I'm not sure that this is really a major issue for bluetooth (the
> bandwith and number of real connections is quite limited compared to
> tcp-ip).

The queueing for the accept case is different and so you can't really
compare Bluetooth with TCP/IP. Maybe we made a design mistake in the
early days of BlueZ that will now hit us very badly.

Regards

Marcel


--=-3OGFW19oibem7MecuPoe
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
 

--=-3OGFW19oibem7MecuPoe--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
