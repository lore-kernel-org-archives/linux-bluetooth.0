Return-Path: <jt@bougret.hpl.hp.com>
Date: Thu, 5 Feb 2004 15:13:26 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040205231325.GA10683@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040205011102.GA23352@bougret.hpl.hp.com> <1075944624.2783.87.camel@pegasus> <20040205014030.GA23802@bougret.hpl.hp.com> <1075947705.2783.117.camel@pegasus> <20040205022635.GA24757@bougret.hpl.hp.com> <1075948602.2783.129.camel@pegasus> <20040205033019.GA25518@bougret.hpl.hp.com> <1075988978.2783.140.camel@pegasus> <20040205171919.GA5417@bougret.hpl.hp.com> <1076005057.2806.7.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
In-Reply-To: <1076005057.2806.7.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2004 at 07:17:37PM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > > I had the attached patch in mind. Please check if this also works for
> > > you, because it should produce less code execution. I think we can also
> > > remove the list_empty() check from bt_sock_listen_poll(), because the
> > > list_for_each_safe() gives us the same result.
> > 
> > 	This should produce the same result. I'll try.
> 
> attached is a slight modified version of my patch.

	There is one thing I don't like about your patch : you disable
error checking for listening socket. I don't think it's right,
especially for checking socket shutdown.
	Let's take the following scenario. Multi-threaded program, one
listening l2cap socket. One thread poll/select on the socket. At some
point, the second thread close the socket. I would expect the first
thread to receive a POLLHUP. Note that you can do the same with a
single threaded program, closing the listening socket in the signal
handler.
	The attached patch is a minor modification of your patch that
should fix this issue.

> > > I already checked the IPV4 code and they also work with an accept queue,
> > > but at the moment I don't understand when they put the new socket on it
> > > and how they keep track of it.
> > 
> > 	Actually, I will double check, because I belive that it may be
> > normal behavior. More later.
> 
> The TCP code uses its own open_request structure for the accept queue,
> but I think the problem of non-blocking listen() will be the same as in
> Bluetooth.

	This is "normal" behaviour. As my prog has many active sockets
and many timers, poll just get called a lot in normal operation even
is the BT socket is inactive. False alarm.

> However the fix for the sendmsg() race is correct and must be applied.

	Glad you like it ;-)

> Regards
> 
> Marcel

	Jean



--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bt262_accept_race-3.diff"

diff -u -p linux/net/bluetooth/af_bluetooth.j2.c linux/net/bluetooth/af_bluetooth.c
--- linux/net/bluetooth/af_bluetooth.j2.c	Wed Feb  4 18:51:55 2004
+++ linux/net/bluetooth/af_bluetooth.c	Thu Feb  5 14:43:21 2004
@@ -236,15 +236,28 @@ int bt_sock_recvmsg(struct kiocb *iocb, 
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
 
 	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
 		mask |= POLLERR;
@@ -253,16 +266,20 @@ unsigned int bt_sock_poll(struct file * 
 		mask |= POLLHUP;
 
 	if (!skb_queue_empty(&sk->sk_receive_queue) || 
-			!list_empty(&bt_sk(sk)->accept_q) ||
 			(sk->sk_shutdown & RCV_SHUTDOWN))
 		mask |= POLLIN | POLLRDNORM;
 
+	if (sk->sk_state == BT_LISTEN)
+		return mask | bt_accept_poll(sk);
+
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

--0F1p//8PRICkK4MW--
