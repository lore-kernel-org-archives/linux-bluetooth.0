Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040205014030.GA23802@bougret.hpl.hp.com>
References: <20040204015825.GA2217@bougret.hpl.hp.com>
	 <1075879044.13285.151.camel@pegasus>
	 <20040204175832.GB16590@bougret.hpl.hp.com>
	 <1075924727.2783.47.camel@pegasus>
	 <20040204214541.GA20129@bougret.hpl.hp.com>
	 <1075942818.2783.70.camel@pegasus>
	 <20040205011102.GA23352@bougret.hpl.hp.com>
	 <1075944624.2783.87.camel@pegasus>
	 <20040205014030.GA23802@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1075947705.2783.117.camel@pegasus>
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
Date: Thu, 05 Feb 2004 03:21:46 +0100

Hi Jean,

> > Touching sk_ack_backlog or introducing another counter is not a good
> > idea, I think. What about moving the bt_accept_enqueue() call in the
> > L2CAP code to the right "time"?
> 
> 	The problem with that is that you are going to loose track of
> those sockets. As accept has not been done, they are not referenced
> from user space. The only place knowing about them is parent->accept_q.
> 	If for some reason the config req/rsp fail, or if the user
> space doesn't accept, those sockets are going to leak. Look at the
> code in "dequeue" that reap CLOSED sockets, and also the code that
> close all childs when a socket is destroyed.
> 	I told you it was not totally trivial.

right now I don't see an easy way out of it. What I am thinking is that
if our socket is BT_LISTEN, we check for an not empty accept_q and than
iterate through all sockets for BT_CONNECTED. If we found one, we return
POLLIN else nothing.

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
