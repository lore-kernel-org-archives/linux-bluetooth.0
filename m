Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040205171919.GA5417@bougret.hpl.hp.com>
References: <20040204214541.GA20129@bougret.hpl.hp.com>
	 <1075942818.2783.70.camel@pegasus>
	 <20040205011102.GA23352@bougret.hpl.hp.com>
	 <1075944624.2783.87.camel@pegasus>
	 <20040205014030.GA23802@bougret.hpl.hp.com>
	 <1075947705.2783.117.camel@pegasus>
	 <20040205022635.GA24757@bougret.hpl.hp.com>
	 <1075948602.2783.129.camel@pegasus>
	 <20040205033019.GA25518@bougret.hpl.hp.com>
	 <1075988978.2783.140.camel@pegasus>
	 <20040205171919.GA5417@bougret.hpl.hp.com>
Content-Type: multipart/mixed; boundary="=-d1IpQ2mBwGtPlS+ok4Pl"
Message-Id: <1076005057.2806.7.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: L2CAP non-blocking socket nasty race conditions
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
Date: Thu, 05 Feb 2004 19:17:37 +0100


--=-d1IpQ2mBwGtPlS+ok4Pl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jean,

> > I had the attached patch in mind. Please check if this also works for
> > you, because it should produce less code execution. I think we can also
> > remove the list_empty() check from bt_sock_listen_poll(), because the
> > list_for_each_safe() gives us the same result.
> 
> 	This should produce the same result. I'll try.

attached is a slight modified version of my patch.

> > I already checked the IPV4 code and they also work with an accept queue,
> > but at the moment I don't understand when they put the new socket on it
> > and how they keep track of it.
> 
> 	Actually, I will double check, because I belive that it may be
> normal behavior. More later.

The TCP code uses its own open_request structure for the accept queue,
but I think the problem of non-blocking listen() will be the same as in
Bluetooth.

However the fix for the sendmsg() race is correct and must be applied.

Regards

Marcel


--=-d1IpQ2mBwGtPlS+ok4Pl
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.2/net/bluetooth/af_bluetooth.c linux-2.6.2-mh/net/bluetooth/af_bluetooth.c
--- linux-2.6.2/net/bluetooth/af_bluetooth.c	2004-02-04 04:43:16.000000000 +0100
+++ linux-2.6.2-mh/net/bluetooth/af_bluetooth.c	2004-02-05 18:56:16.000000000 +0100
@@ -236,15 +236,31 @@
 	return err ? : copied;
 }
 
+static inline unsigned int bt_accept_poll(struct sock *parent)
+{
+	struct list_head *p, *n;
+	struct sock *sk;
+
+	list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
+		sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);
+		if (sk->sk_state == BT_CONNECTED)
+			return POLLIN | POLLRDNORM;
+	}
+
+	return 0;
+}
+
 unsigned int bt_sock_poll(struct file * file, struct socket *sock, poll_table *wait)
 {
 	struct sock *sk = sock->sk;
-	unsigned int mask;
+	unsigned int mask = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
 	poll_wait(file, sk->sk_sleep, wait);
-	mask = 0;
+
+	if (sk->sk_state == BT_LISTEN)
+		return bt_accept_poll(sk);
 
 	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
 		mask |= POLLERR;
@@ -253,16 +269,17 @@
 		mask |= POLLHUP;
 
 	if (!skb_queue_empty(&sk->sk_receive_queue) || 
-			!list_empty(&bt_sk(sk)->accept_q) ||
 			(sk->sk_shutdown & RCV_SHUTDOWN))
 		mask |= POLLIN | POLLRDNORM;
 
 	if (sk->sk_state == BT_CLOSED)
 		mask |= POLLHUP;
 
-	if (sk->sk_state == BT_CONNECT || sk->sk_state == BT_CONNECT2)
+	if (sk->sk_state == BT_CONNECT ||
+			sk->sk_state == BT_CONNECT2 ||
+			sk->sk_state == BT_CONFIG)
 		return mask;
-	
+
 	if (sock_writeable(sk))
 		mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
 	else

--=-d1IpQ2mBwGtPlS+ok4Pl--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
