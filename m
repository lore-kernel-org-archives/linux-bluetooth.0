Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040204214541.GA20129@bougret.hpl.hp.com>
References: <20040204015825.GA2217@bougret.hpl.hp.com>
	 <1075879044.13285.151.camel@pegasus>
	 <20040204175832.GB16590@bougret.hpl.hp.com>
	 <1075924727.2783.47.camel@pegasus>
	 <20040204214541.GA20129@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1075942818.2783.70.camel@pegasus>
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
Date: Thu, 05 Feb 2004 02:00:18 +0100

Hi Jean,

> 	I could find an informal arrangement if you want my code, like
> "for your eyes only", but it's also not totally trivial to setup.

not needed, because it is very clear where the problem is. But thanks
for the offer.

> 	Yes, the accept() code is right, what's wrong is obviously the
> "poll" code that should not indicate socket readyness before the
> socket is really ready.
> 	The more "correct" way would be to change the "poll()" code to
> really test child socket readyness instead of just testing
> sk_ack_backlog. But, the poll code would get very ugly quickly.
> 	One of the simplest way would be to increase sk_ack_backlog
> only when the socket change to the BT_CONNECTED state (as opposed to
> immediately when we add it to the parent queue). I would need to
> understand where and how exactly is sk_ack_backlog used.
> 	Another solution if we can't use sk_ack_backlog is to use our
> own counter to count the number of child ready, or a flag, or whatever
> mechanism.

I don't see what sk_ack_backlog have to do with it. Can you explain this
to me?

I haven't tested this yet, but I think the problem is the extra check in
bt_sock_poll() for the accept_q:

        if (!skb_queue_empty(&sk->sk_receive_queue) || 
                        !list_empty(&bt_sk(sk)->accept_q) ||
                        (sk->sk_shutdown & RCV_SHUTDOWN))
                mask |= POLLIN | POLLRDNORM;

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
