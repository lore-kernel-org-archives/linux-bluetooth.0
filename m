Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040205231325.GA10683@bougret.hpl.hp.com>
References: <20040205011102.GA23352@bougret.hpl.hp.com>
	 <1075944624.2783.87.camel@pegasus>
	 <20040205014030.GA23802@bougret.hpl.hp.com>
	 <1075947705.2783.117.camel@pegasus>
	 <20040205022635.GA24757@bougret.hpl.hp.com>
	 <1075948602.2783.129.camel@pegasus>
	 <20040205033019.GA25518@bougret.hpl.hp.com>
	 <1075988978.2783.140.camel@pegasus>
	 <20040205171919.GA5417@bougret.hpl.hp.com>
	 <1076005057.2806.7.camel@pegasus>
	 <20040205231325.GA10683@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1076024244.2806.20.camel@pegasus>
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
Date: Fri, 06 Feb 2004 00:37:24 +0100

Hi Jean,

> 	There is one thing I don't like about your patch : you disable
> error checking for listening socket. I don't think it's right,
> especially for checking socket shutdown.
> 	Let's take the following scenario. Multi-threaded program, one
> listening l2cap socket. One thread poll/select on the socket. At some
> point, the second thread close the socket. I would expect the first
> thread to receive a POLLHUP. Note that you can do the same with a
> single threaded program, closing the listening socket in the signal
> handler.
> 	The attached patch is a minor modification of your patch that
> should fix this issue.

take a look at tcp_poll() in net/ipv4/tcp.c, because they do it the same
and do we really have to care about it? How does TCP handles this case?

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
