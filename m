Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
To: Alexandros Karypidis <karypid@inf.uth.gr>, bluez-devel@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
In-Reply-To: <200302081814.47394.karypid@inf.uth.gr>
References: <200302081740.48000.karypid@inf.uth.gr>
	<200302071951.35073.karypid@inf.uth.gr>
	<1044653775.32672.14.camel@pegasus.local>
	<200302081740.48000.karypid@inf.uth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 10 Feb 2003 13:13:45 -0800

At 06:14 PM 2/8/2003 +0200, Alexandros Karypidis wrote:
>BTW, it dawned on me that:
>
>1) connect() succeeds even if bind() wasn't previously called for the client 
>socket.
>2) accept() also produces a new socket.
>
>I assumed that these operations evidently select a free PSM for the sockets 
>they use/produce. I could not find any such thing in the code however (but I 
>don't really know the BlueZ code).
>
>Then, I did the simple tests of:
>
>A. Calling getsockname() after a connect() with no previous bind()
>B. Calling getsockname() after a accept()
>
>Case A reported PSM zero (0) !!! This is clearly a bug!
No it's _not_. 
L2CAP PSM != TCP/UDP port. Although it may look like it's the same thing. It's not. 

>Case B reported PSM 5000. This is the PSM where the server socket on which 
>accept() was called was bound. So:
>
>        clsock = accept (srvsock, ...);
>
>Produces a clsock whose PSM is equal to that of srvsock. I don't know if this 
>is correct or not.
Yes it is correct.

L2CAP PSM identifies a protocol or a service. CID identifies a logical channel.
Since both client and server sockets use the _same_ protocol they must have the 
same PSM.

TCP/UDP
        [client port]:[client IP]  ---> [server port]:[server IP]

L2CAP
        [service PSM]:[client CID] ---> [service PSM]:[server CID]

See the difference ?
Don't ask me why L2CAP designers didn't stick to common port concept.
Bluetooth spec is full of "innovations" ;-).

So the current code is correct.

Now if people really want dynamic PSMs. We could introduce something like
bind(psm == 0xffff).

Max



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
