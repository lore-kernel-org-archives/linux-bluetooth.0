Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid and 2.4.25-mh2
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403182116.24096.cijoml@volny.cz>
References: <200403171304.37863.cijoml@volny.cz>
	 <1079525716.3301.12.camel@pegasus>  <200403182116.24096.cijoml@volny.cz>
Content-Type: multipart/mixed; boundary="=-4CU/zb2V8yC6o7EvPy7f"
Message-Id: <1079642075.3301.62.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 18 Mar 2004 21:34:35 +0100


--=-4CU/zb2V8yC6o7EvPy7f
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Michal,

> Works without problem :) Maybe "Patch day" was not so patch :D
> Marcel send me in privat your mh2 patch differenced into parts and I'll find 
> which "patch" in it si bad.

I think it can be only this one. Please apply -mh2 and apply the
attached patch with -R.

Regards

Marcel


--=-4CU/zb2V8yC6o7EvPy7f
Content-Disposition: attachment; filename=patch-non-blocking-race
Content-Type: text/plain; name=patch-non-blocking-race; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/15 19:42:55+01:00 marcel@holtmann.org 
#   [Bluetooth] Fix non-blocking socket race conditions
#   
#   A poll on a non-blocking listen socket signals readable too early. The
#   first time the socket should be readable is if a child is in connected
#   state. And don't signal writeable if the socket is in config state.
#   
#   Noticed by Jean Tourrilhes <jt@hpl.hp.com>
# 
# net/bluetooth/af_bluetooth.c
#   2004/03/15 19:42:15+01:00 marcel@holtmann.org +22 -5
#   Fix non-blocking socket race conditions
# 
diff -Nru a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
--- a/net/bluetooth/af_bluetooth.c	Mon Mar 15 19:43:09 2004
+++ b/net/bluetooth/af_bluetooth.c	Mon Mar 15 19:43:09 2004
@@ -218,15 +218,31 @@
 	return err ? : copied;
 }
 
+static inline unsigned int bluez_accept_poll(struct sock *parent)
+{
+	struct list_head *p, *n;
+	struct sock *sk;
+
+	list_for_each_safe(p, n, &bluez_pi(parent)->accept_q) {
+		sk = (struct sock *) list_entry(p, struct bluez_pinfo, accept_q);
+		if (sk->state == BT_CONNECTED)
+			return POLLIN | POLLRDNORM;
+	}
+
+	return 0;
+}
+
 unsigned int bluez_sock_poll(struct file * file, struct socket *sock, poll_table *wait)
 {
 	struct sock *sk = sock->sk;
-	unsigned int mask;
+	unsigned int mask = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
 	poll_wait(file, sk->sleep, wait);
-	mask = 0;
+
+	if (sk->state == BT_LISTEN)
+		return bluez_accept_poll(sk);
 
 	if (sk->err || !skb_queue_empty(&sk->error_queue))
 		mask |= POLLERR;
@@ -235,16 +251,17 @@
 		mask |= POLLHUP;
 
 	if (!skb_queue_empty(&sk->receive_queue) || 
-			!list_empty(&bluez_pi(sk)->accept_q) ||
 			(sk->shutdown & RCV_SHUTDOWN))
 		mask |= POLLIN | POLLRDNORM;
 
 	if (sk->state == BT_CLOSED)
 		mask |= POLLHUP;
 
-	if (sk->state == BT_CONNECT || sk->state == BT_CONNECT2)
+	if (sk->state == BT_CONNECT ||
+			sk->state == BT_CONNECT2 ||
+			sk->state == BT_CONFIG)
 		return mask;
-	
+
 	if (sock_writeable(sk))
 		mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
 	else

--=-4CU/zb2V8yC6o7EvPy7f--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
