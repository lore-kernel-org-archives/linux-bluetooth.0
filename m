Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040204015825.GA2217@bougret.hpl.hp.com>
References: <20040204015825.GA2217@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1075879044.13285.151.camel@pegasus>
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
Date: Wed, 04 Feb 2004 08:17:24 +0100

Hi Jean,

> 	I've just managed to reproduce and track a few bug that so far
> were escaping me. There is a race condition in the accept() code for
> non-blocking L2CAP sockets, and a similar one in sendmsg. Or maybe
> it's just that my code is too fast ;-)

do you have a simple test code to reproduce it?

> 	This is the accept race :
> 	1) L2CAP socket in non blocking mode, because program waiting
> on multiple outputs.
> 	2) Wait on socket to be readable with poll/select.
> 	3) When socket is ready, accept() it and do what we have to do.
> 	4) When the race occur, accept() return an error (EAGAIN).
> 	5) We don't touch the socket and go back to poll/select.
> 	6) Poll/select returns immediately (socket is still readable).
> 	7) We attempt the accept(), EAGAIN, goto (5)

Is this an endless loop? Or do accept() succeeds after some time?

BTW why must a listen socket non-blocking? The listen() command itself
doesn't block and I don't see any need for a non-blocking listen socket.

> 	I didn't managed to fully identify the sendmsg race, but I
> goes like this :
> 	1) Open L2CAP socket in non blocking mode, because program
> waiting on multiple outputs.
> 	2) Connect to BT peer.
> 	3) Wait on socket to be writeable with poll/select.
> 	4) When socket is ready, sendmsg() and do what we have to do.
> 	5) When the race occur, sendmsg() return an error (ENOTCONN).
> 	...
> 
> 	I looked at way to fix the code, but it's not a quick fix and
> there is multiple way to attack the problem. So, if one of you could
> have a look at it...

Is this on a listen/accepted socket or is this a simple connection?

> 	Below you will find a self explanatory log of the kernel
> showing the problem with accept. The first accept was successful (no
> problem), the second one was racy.

>>From the logfile function names I assume this is a 2.6 kernel. Do you
see the same behaviour on 2.4?

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
