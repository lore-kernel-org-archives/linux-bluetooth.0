Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <470B356F.1050805@silicom.fr>
References: <de4879e80710011431q3fa8c870m95a08dc46ea9a679@mail.gmail.com>
	<de4879e80710051236j243ff5c6mc6bd18e5c43640a6@mail.gmail.com>
	<2d5a2c100710081056m6391d8aao6fbc2d2b1aa34948@mail.gmail.com>
	<1191884194.12212.13.camel@aeonflux.holtmann.net>
	<d89ddf300710081832w1ac37dfana49571dc9306dbf2@mail.gmail.com>
	<470B356F.1050805@silicom.fr>
Date: Tue, 09 Oct 2007 10:44:00 +0200
Message-Id: <1191919440.31341.9.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Patch: inheritance problem in gsta2dpsink
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien,

> Well, *I do* care.
> As i told you back in Montpellier, i need a way to plug an external 
> (proprietary) hardware accelerated audio system onto the audio service.
> In fact i could start working on such a library right away, provided 
> that it is LGPL, so that i can link a proprietary stuff on top of it.
> Even if it is not packaged as an external library at first, provided i 
> can somehow copy the code out of bluez tree and rebuild a LGPL library 
> out of it would be acceptable as a first step. :-)

I am okay with that. That is not the problem. Having that code under
LGPL license is no big deal for me. I am actually fully okay with that.
However please remember that my default license will always be GPL and
you really have to tell me if you want something different.

> If that can't be done then i'm gonna go grumble in a corner and we will
> have missed an opportunity to move the bluez audio system forward. :-(
> And remembering what Marcel told us during the meeting, the IPC API is 
> not public because "we don't really know what we're doing".
> My answer to that is:
>   - having worked on audio stuff for some time now, i think i know what 
> i would be doing if i was to work on this API : which mean it would be 
> made stable pretty quickly.
>   - We'd better start stabilizing the API before too much effort has 
> been put on the gstreamer plugin or any other plugin, otherwise we will 
> have to fix them all afterwards.

This is not gonna work out. You have to deal with API and ABI breakage
if you are working outside the tree and wanna be closed source. That is
the price you pay. I don't see any other way around that.

Remember that a lot of things are highly related to the Bluetooth
specification and A2DP is changing quickly. Actually the versions 1.4
are already on their way to be getting approved at some point. Also the
meta data transfer needs some extra love.

And we need a security audit before ever thinking about making this
really public and stabilize it.

> A last thing : this is likely to be a one time offer, because i need to 
> start working on this stuff as soon as today. If we miss the window i 
> won't be able to spent company time on this library, which mean i will 
> only be able to get involved on my spare time, which i kind of lack
> these days...

The LGPL wish is easy to solve. Get Johan and Luiz to agree here on the
mailing list and then we make ipc.h and an upcoming ipc.c licensed under
LGPL and then you can copy it out from the bluez-utils source and use
it. Just a warning up front. You have to wrap it into a library by
yourself, because otherwise you might be violating the LGPL.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
