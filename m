Return-Path: <jt@bougret.hpl.hp.com>
Date: Wed, 4 Feb 2004 19:30:19 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040205033019.GA25518@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204175832.GB16590@bougret.hpl.hp.com> <1075924727.2783.47.camel@pegasus> <20040204214541.GA20129@bougret.hpl.hp.com> <1075942818.2783.70.camel@pegasus> <20040205011102.GA23352@bougret.hpl.hp.com> <1075944624.2783.87.camel@pegasus> <20040205014030.GA23802@bougret.hpl.hp.com> <1075947705.2783.117.camel@pegasus> <20040205022635.GA24757@bougret.hpl.hp.com> <1075948602.2783.129.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <1075948602.2783.129.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2004 at 03:36:43AM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > > What I am thinking is that
> > > if our socket is BT_LISTEN, we check for an not empty accept_q and than
> > > iterate through all sockets for BT_CONNECTED. If we found one, we return
> > > POLLIN else nothing.
> > 
> > 	This is a bit yucky, especially that poll is performance
> > critical (for scalability). That's why I was suggesting the socket
> > counter in the parent. Check what's sk_ack_backlog does, it's very
> > close to what we want.
> 
> yes I know, but worse performance only kicks in if it is a listen socket
> and if it has at minimum one child in its queue. A second counter sounds
> not really better to me and I think it will be very hackish.
> 
> Regards
> 
> Marcel

	I implemented the option that you prefered. The patch is
attached.
	I also fixed the "potential" sendmsg race as I understand it
(the one I can't reproduce).

	The good news is that accept no longer returns EAGAIN and my
code no longer tight-loop.
	The problem with the patch is that I get this in my log :
------------------------------------------------------------
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 1
...
...
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 0
J2 - bt_accept_checkqueue - parent ccc11600 backlog 1 num 1
------------------------------------------------------------
	So, in other words I've just moved a tight loop from my code
to the kernel code (or glibc). Which means it seems that we only have
half of the solution (or maybe it's normal poll behavior ?).
	I think at that point we will need to get advice from the
network gurus on how socket notification works.

	Have fun...

	Jean

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bt262_accept_race-1.diff"

diff -u -p linux/net/bluetooth/af_bluetooth.j2.c linux/net/bluetooth/af_bluetooth.c
--- linux/net/bluetooth/af_bluetooth.j2.c	Wed Feb  4 18:51:55 2004
+++ linux/net/bluetooth/af_bluetooth.c	Wed Feb  4 19:09:15 2004
@@ -200,6 +200,30 @@ struct sock *bt_accept_dequeue(struct so
 	return NULL;
 }
 
+static int bt_accept_checkqueue(struct sock *parent)
+{
+	struct list_head *p, *n;
+	struct sock *sk;
+	int num = 0;
+	
+	BT_DBG("parent %p", parent);
+
+	/* Check the number of connected sockets. This is used in poll
+	 * to know if the socket can really perform an accept.
+	 * Jean II */
+	list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
+		sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);
+
+		/* No need to lock, reading/writing ints is atomic and we
+		 * don't need to synchronise. Jean II */
+		if (sk->sk_state == BT_CONNECTED)
+			num++;
+	}
+	printk(KERN_DEBUG "J2 - %s - parent %p backlog %d num %d\n",
+	       __FUNCTION__, parent, parent->sk_ack_backlog, num);
+	return num;
+}
+
 int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	struct msghdr *msg, size_t len, int flags)
 {
@@ -252,15 +276,23 @@ unsigned int bt_sock_poll(struct file * 
 	if (sk->sk_shutdown == SHUTDOWN_MASK)
 		mask |= POLLHUP;
 
+	/* Check is we can read() (== received packet) or
+	 * if we can accept() (== incomming connection) or
+	 * if the socket died. Jean II */
 	if (!skb_queue_empty(&sk->sk_receive_queue) || 
-			!list_empty(&bt_sk(sk)->accept_q) ||
+			(!list_empty(&bt_sk(sk)->accept_q) &&
+				bt_accept_checkqueue(sk) > 0) ||
 			(sk->sk_shutdown & RCV_SHUTDOWN))
 		mask |= POLLIN | POLLRDNORM;
 
 	if (sk->sk_state == BT_CLOSED)
 		mask |= POLLHUP;
 
-	if (sk->sk_state == BT_CONNECT || sk->sk_state == BT_CONNECT2)
+	/* Socket can't be writeable if it's not yet connected, check
+	 * l2cap_sock_sendmsg() for details. Jean II */
+	if (sk->sk_state == BT_CONNECT ||
+	    sk->sk_state == BT_CONNECT2 ||
+	    sk->sk_state == BT_CONFIG)
 		return mask;
 	
 	if (sock_writeable(sk))

--BOKacYhQ+x31HxR3--
