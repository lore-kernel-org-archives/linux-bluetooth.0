Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040205033019.GA25518@bougret.hpl.hp.com>
References: <20040204175832.GB16590@bougret.hpl.hp.com>
	 <1075924727.2783.47.camel@pegasus>
	 <20040204214541.GA20129@bougret.hpl.hp.com>
	 <1075942818.2783.70.camel@pegasus>
	 <20040205011102.GA23352@bougret.hpl.hp.com>
	 <1075944624.2783.87.camel@pegasus>
	 <20040205014030.GA23802@bougret.hpl.hp.com>
	 <1075947705.2783.117.camel@pegasus>
	 <20040205022635.GA24757@bougret.hpl.hp.com>
	 <1075948602.2783.129.camel@pegasus>
	 <20040205033019.GA25518@bougret.hpl.hp.com>
Content-Type: multipart/mixed; boundary="=-VHPsL3IcLbXmJotekYGK"
Message-Id: <1075988978.2783.140.camel@pegasus>
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
Date: Thu, 05 Feb 2004 14:49:38 +0100


--=-VHPsL3IcLbXmJotekYGK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jean,

> 	So, in other words I've just moved a tight loop from my code
> to the kernel code (or glibc). Which means it seems that we only have
> half of the solution (or maybe it's normal poll behavior ?).

I had the attached patch in mind. Please check if this also works for
you, because it should produce less code execution. I think we can also
remove the list_empty() check from bt_sock_listen_poll(), because the
list_for_each_safe() gives us the same result.

> 	I think at that point we will need to get advice from the
> network gurus on how socket notification works.

I already checked the IPV4 code and they also work with an accept queue,
but at the moment I don't understand when they put the new socket on it
and how they keep track of it.

Regards

Marcel


--=-VHPsL3IcLbXmJotekYGK
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

===== net/bluetooth/af_bluetooth.c 1.27 vs edited =====
--- 1.27/net/bluetooth/af_bluetooth.c	Wed Jan 14 21:56:53 2004
+++ edited/net/bluetooth/af_bluetooth.c	Thu Feb  5 13:44:56 2004
@@ -236,15 +236,34 @@
 	return err ? : copied;
 }
 
+static __inline__ unsigned int bt_sock_listen_poll(struct sock *parent, poll_table *wait)
+{
+	struct list_head *p, *n;
+	struct sock *sk;
+
+	if (list_empty(&bt_sk(parent)->accept_q))
+		return 0;
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
+		return bt_sock_listen_poll(sk, wait);
 
 	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
 		mask |= POLLERR;
@@ -253,16 +272,17 @@
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

--=-VHPsL3IcLbXmJotekYGK--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
