Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040205011102.GA23352@bougret.hpl.hp.com>
References: <20040204015825.GA2217@bougret.hpl.hp.com>
	 <1075879044.13285.151.camel@pegasus>
	 <20040204175832.GB16590@bougret.hpl.hp.com>
	 <1075924727.2783.47.camel@pegasus>
	 <20040204214541.GA20129@bougret.hpl.hp.com>
	 <1075942818.2783.70.camel@pegasus>
	 <20040205011102.GA23352@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1075944624.2783.87.camel@pegasus>
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
Date: Thu, 05 Feb 2004 02:30:24 +0100

Hi Jean,

> > I haven't tested this yet, but I think the problem is the extra check in
> > bt_sock_poll() for the accept_q:
> > 
> >         if (!skb_queue_empty(&sk->sk_receive_queue) || 
> >                         !list_empty(&bt_sk(sk)->accept_q) ||
> >                         (sk->sk_shutdown & RCV_SHUTDOWN))
> >                 mask |= POLLIN | POLLRDNORM;
> 
> 	Wrong. The client may only receive packet and never send
> packets, and anyway those packets would go to the child socket, not
> the parent socket (remember, we are before accept(), so we are polling
> the parent/listening socket). You really need to test the *childs* of
> this socket (i.e. those guys in accept_q).
> 	One way to do this is to have a counter counting the number of
> child sockets in CONNECTED mode but not yet dequeued. One idea is to
> reuse sk_ack_backlog to do this.

now I got it. I was thinking from the wrong direction ;)

Touching sk_ack_backlog or introducing another counter is not a good
idea, I think. What about moving the bt_accept_enqueue() call in the
L2CAP code to the right "time"?

BTW do RFCOMM have the same problem?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
