Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexandros Karypidis <karypid@inf.uth.gr>
To: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Bluez-users] How do I obtain a free PSM
	automatically?
References: <200302081740.48000.karypid@inf.uth.gr>
	<5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20030210125138.04183f58@mail1.qualcomm.com>
MIME-Version: 1.0
Message-Id: <200302111830.51716.karypid@inf.uth.gr>
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
Date: Tue, 11 Feb 2003 18:30:51 +0200
Content-Type: text/plain; CHARSET=iso-8859-1

On Monday 10 February 2003 23:13, Max Krasnyansky wrote:
> At 06:14 PM 2/8/2003 +0200, Alexandros Karypidis wrote:
> >BTW, it dawned on me that:
> >
> >1) connect() succeeds even if bind() wasn't previously called for the
> > client socket.
> >2) accept() also produces a new socket.
> >
> >I assumed that these operations evidently select a free PSM for the
> > sockets they use/produce. I could not find any such thing in the code
> > however (but I don't really know the BlueZ code).
> >
> >Then, I did the simple tests of:
> >
> >A. Calling getsockname() after a connect() with no previous bind()
> >B. Calling getsockname() after a accept()
> >
> >Case A reported PSM zero (0) !!! This is clearly a bug!
>
> No it's _not_.
> L2CAP PSM != TCP/UDP port. Although it may look like it's the same thing.
> It's not.

Ok, I get this now.

> [...]
> L2CAP PSM identifies a protocol or a service. CID identifies a logical
> channel. Since both client and server sockets use the _same_ protocol they
> must have the same PSM.
>
> TCP/UDP
>         [client port]:[client IP]  ---> [server port]:[server IP]
>
> L2CAP
>         [service PSM]:[client CID] ---> [service PSM]:[server CID]
>
> See the difference ?
> Don't ask me why L2CAP designers didn't stick to common port concept.
> Bluetooth spec is full of "innovations" ;-).

Ok. The problem with this design from my viewpoint is that this design assumes 
that a service always uses the same PSM. It assumes that there is no reason 
why I would not want to run the service on PSM A at one point and some time 
later on PSM B. More specifically, it assumes that I may not even care which 
PSM I will be providing the service from, as I might use some "other means" 
to coordinate this with clients (see my previous e-mail).

> So the current code is correct.
>
> Now if people really want dynamic PSMs. We could introduce something like
> bind(psm == 0xffff).

As Marcel already pointed out, this would not adhere to the specs... :(

I think dynamic PSMs are a good idea. The add capability. If only there is a 
way to add them without "breaking" anything it may be worth doing so! Anyway, 
I'm not trying to insist too much or anything -- I'm just throwing around 
some ideas which make sense to me.

-- 
To err is human, but to forgive is beyond the scope of the Operating System...

Alexandros Karypidis
University of Thessaly
Computer & Communications Engineering dept.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
