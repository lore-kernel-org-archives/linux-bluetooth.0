Return-Path: <jt@bougret.hpl.hp.com>
Date: Tue, 10 Aug 2004 09:32:03 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Michal Semler <cijoml@volny.cz>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2.6] link trigger for AODV and +
Message-ID: <20040810163203.GA1963@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040805013335.GA13608@bougret.hpl.hp.com> <1091976547.2773.29.camel@pegasus> <20040809185159.GA21899@bougret.hpl.hp.com> <1092078516.4564.40.camel@pegasus> <20040809195448.GA24140@bougret.hpl.hp.com> <1092125599.4564.76.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092125599.4564.76.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Aug 10, 2004 at 10:13:19AM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> > > this is a good point and I do think that this patch is a nice additional
> > > feature for BlueZ, but I am not fully comfortable with it in its current
> > > shape. Actually some time ago I thought about removing the support for
> > > stack internal events.
> > 
> > 	In my stuff, I use internal events to know when hci interfaces
> > go up and down and when they appear and disappear. As far as I know,
> > those events are not available by any other means. They are not
> > available through RtNetlink because hci interfaces are not real netdev
> > interfaces.
> 
> these events should be available via hotplug and the bluetooth.agent and
> because of this I was thinking about removing the stack internal stuff.
> 
> If the HCI connections themself are fully integrated into the driver and
> device model an event through hotplug would be the best. Comments?

	I personally don't like hotplug for this application. Hotplug
force the event to go through a bunch of scripts, which is good for
simple config and daemon-less stuff, but bad for daemons.
	Let say you have a big daemon monitoring a bunch of stuff and
keeping track of state. Examples are pand, waproamd, MobileIP... With
hotplug you have to write a script that somehow forward the event to
the daemon. As events are usually passed via Unix sockets, shared
memory or something similar, the scripts need to call a little program
generating the event.
	Therefore you have :
		hotplug event ->
			-> my shell script
				-> my tiny program
					-> Unix socket or shared memory
						-> My daemon
	For each event, you need to create two processes (shell script
and tiny program) than need to be paged from disk. Yuck...
	If you look at waproamd, it uses exclusively the RtNetlink
events, even though the equivalent events exist in Hotplug.

> > > I sent the full patch for inclusion, but it came out that one part
> > > causes troubles and so I removed this part. I didn't found the time for
> > > a further investigation.
> > 
> > 	That's what I said : I'm going to test it properly. If you
> > could remember the issue, that would help.
> 
> I searched the email exchange between Michal and me from the mailing
> list archives for you. Check out this thread:
> 
> 	http://thread.gmane.org/gmane.linux.bluez.user/2672

	The bug is obvious, you forgot that in 2.4.X the list doesn't
point to struct sock but to struct bluez_pinfo. Compare your patch to
the version below.
	Patch has been tested to my satisfaction. If Michal Semler
want to test it, that woud be even better.

> Regards
> 
> Marcel

	Have fun...

	Jean

--------------------------------------------------

diff -u -p linux/net/bluetooth/af_bluetooth.j2.c linux/net/bluetooth/af_bluetooth.c
--- linux/net/bluetooth/af_bluetooth.j2.c	Fri Aug  6 18:38:53 2004
+++ linux/net/bluetooth/af_bluetooth.c	Fri Aug  6 18:48:28 2004
@@ -218,6 +218,22 @@ int bluez_sock_recvmsg(struct socket *so
 	return err ? : copied;
 }
 
+static inline unsigned int bluez_accept_poll(struct sock *parent)
+{
+	struct list_head *p, *n;
+	struct bluez_pinfo *pi;
+	struct sock *sk;
+
+	list_for_each_safe(p, n, &bluez_pi(parent)->accept_q) {
+		pi = list_entry(p, struct bluez_pinfo, accept_q);
+		sk = bluez_sk(pi);
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
@@ -226,6 +242,9 @@ unsigned int bluez_sock_poll(struct file
 	BT_DBG("sock %p, sk %p", sock, sk);
 
 	poll_wait(file, sk->sleep, wait);
+
+	if (sk->state == BT_LISTEN)
+		return bluez_accept_poll(sk);
 
 	if (sk->err || !skb_queue_empty(&sk->error_queue))
 		mask |= POLLERR;
