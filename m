Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040204175832.GB16590@bougret.hpl.hp.com>
References: <20040204015825.GA2217@bougret.hpl.hp.com>
	 <1075879044.13285.151.camel@pegasus>
	 <20040204175832.GB16590@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1075924727.2783.47.camel@pegasus>
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
Date: Wed, 04 Feb 2004 20:58:47 +0100

Hi Jean,

> 	No, the code is not that simple and I don't really want it
> out. However, I think any trivial program using non-blocking sockets
> will show that.
> 	Anyway, I think the bug report was detailed enough.

code is always better ;) I have written some stuff by myself now.

> 	After around 500 iterations, it will succeed. I guess it
> depend on your CPU speed.

It seems that we signal the socket readable after the L2CAP connect
req/resp is handled. But the socket is first usable after we had a
two-way L2CAP config req/resp for MTU negotiation. And this takes some
time depending on if we have to do a role change, authenticate etc.

> 	Yes, listen() will not block. However I also want the accept()
> to be non-blocking, because I don't want it to prevent it servincing
> my other socekts. What's the point of writting all the rest of my code
> non-blocking if accept() take 100ms to complete ? The only way to get
> a non-blocking accept() is to have the listen socket in non-blocking
> mode.

Actually I don't know how to change this and I even don't know if this
is a good idea, because the return code of accept() seems right.

Comments?

> 	The sendmsg() problem is on the other side, the client, so a
> simply connected socket. But I've got a much harder time to reproduce
> it.

Haven't looked at it. We need a reliable way do reproduce it.

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
