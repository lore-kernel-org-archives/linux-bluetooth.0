Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Bluetooth update for 2.4.23-pre2
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20031009103605.05a94590@unixmail.qualcomm.com>
References: <5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
	<5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
	<5.1.0.14.2.20031009103605.05a94590@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1065723861.14514.91.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 09 Oct 2003 20:24:15 +0200

Hi Max,

> >I see the notify() interface and the seperate counting of ACL and SCO as
> >two different problems and I don't wanna mix them.
> >However I think it is nice to send the "conn" down to the driver, if you
> >thing it is two much, I drop it.
> Well, both are needed only for SCO over USB.
> So in some sense they are related :).
> 
> btw How about fixing it in 2.6 and leaving 2.4 alone ?
> I don't think we will ever have decent Voice support in 2.4 anyway.
> For example ALSA driver will definitely go into 2.6 not 2.4.

the ALSA support is not the point, because you can use the SCO socket
for 2.4 for now and it is working fine for me. I think we should drop
this for 2.4.23 and wait until 2.4.24-pre.

> >> What I'm saying is that we should fix the write way not just some hack that 
> >> fixes first negotiation. It will pass certification with Ceticomm (or whatever 
> >> the name of that company) but will fail if tester code does proper checking ie second 
> >> connection, etc.
> >> It should be a trivial fix. I take a look at it tonight.
> >
> >I looked at your fix and it looks fine to me. Can you please rebuild my
> >marcel-2.4 tree on the base of your current work? I will re-push my
> >other patches so we can sync up with Marcelo until the end of this week.
> >I want to finish this as soon as possible, because I am away for the
> >complete next week.
> Ok. I'll do that. Not sure about today though. Don't worry about sync up 
> with Marcelo. I'll merge both trees and send a patch.

I can push my other changes within 10 minutes if I have a clean tree. So
drop me a note if you have rebuild it it and then I push them.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
