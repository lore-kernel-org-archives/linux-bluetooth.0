Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040205022635.GA24757@bougret.hpl.hp.com>
References: <20040204015825.GA2217@bougret.hpl.hp.com>
	 <1075879044.13285.151.camel@pegasus>
	 <20040204175832.GB16590@bougret.hpl.hp.com>
	 <1075924727.2783.47.camel@pegasus>
	 <20040204214541.GA20129@bougret.hpl.hp.com>
	 <1075942818.2783.70.camel@pegasus>
	 <20040205011102.GA23352@bougret.hpl.hp.com>
	 <1075944624.2783.87.camel@pegasus>
	 <20040205014030.GA23802@bougret.hpl.hp.com>
	 <1075947705.2783.117.camel@pegasus>
	 <20040205022635.GA24757@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1075948602.2783.129.camel@pegasus>
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
Date: Thu, 05 Feb 2004 03:36:43 +0100

Hi Jean,

> > What I am thinking is that
> > if our socket is BT_LISTEN, we check for an not empty accept_q and than
> > iterate through all sockets for BT_CONNECTED. If we found one, we return
> > POLLIN else nothing.
> 
> 	This is a bit yucky, especially that poll is performance
> critical (for scalability). That's why I was suggesting the socket
> counter in the parent. Check what's sk_ack_backlog does, it's very
> close to what we want.

yes I know, but worse performance only kicks in if it is a listen socket
and if it has at minimum one child in its queue. A second counter sounds
not really better to me and I think it will be very hackish.

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
