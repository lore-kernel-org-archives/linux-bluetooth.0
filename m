Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <470B5184.1070507@free.fr>
Date: Tue, 09 Oct 2007 12:01:40 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Brad Midgley <bmidgley@xmission.com>
References: <de4879e80710011431q3fa8c870m95a08dc46ea9a679@mail.gmail.com>	<de4879e80710051236j243ff5c6mc6bd18e5c43640a6@mail.gmail.com>	<2d5a2c100710081056m6391d8aao6fbc2d2b1aa34948@mail.gmail.com>	<1191884194.12212.13.camel@aeonflux.holtmann.net>	<d89ddf300710081832w1ac37dfana49571dc9306dbf2@mail.gmail.com>	<470B356F.1050805@silicom.fr>
	<1191919440.31341.9.camel@aeonflux.holtmann.net>
In-Reply-To: <1191919440.31341.9.camel@aeonflux.holtmann.net>
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

Hi Marcel, Luiz, Johan, Brad,
> 
>> Well, *I do* care.
>> As i told you back in Montpellier, i need a way to plug an external 
>> (proprietary) hardware accelerated audio system onto the audio service.
>> In fact i could start working on such a library right away, provided 
>> that it is LGPL, so that i can link a proprietary stuff on top of it.
>> Even if it is not packaged as an external library at first, provided i 
>> can somehow copy the code out of bluez tree and rebuild a LGPL library 
>> out of it would be acceptable as a first step. :-)
> 
> I am okay with that. That is not the problem. Having that code under
> LGPL license is no big deal for me. I am actually fully okay with that.
> However please remember that my default license will always be GPL and
> you really have to tell me if you want something different.

Ok, I 100% agree with you : GPL per default, LGPL for "some special 
bits" :-)

> 
>> If that can't be done then i'm gonna go grumble in a corner and we will
>> have missed an opportunity to move the bluez audio system forward. :-(
>> And remembering what Marcel told us during the meeting, the IPC API is 
>> not public because "we don't really know what we're doing".
>> My answer to that is:
>>   - having worked on audio stuff for some time now, i think i know what 
>> i would be doing if i was to work on this API : which mean it would be 
>> made stable pretty quickly.
>>   - We'd better start stabilizing the API before too much effort has 
>> been put on the gstreamer plugin or any other plugin, otherwise we will 
>> have to fix them all afterwards.
> 
> This is not gonna work out. You have to deal with API and ABI breakage
> if you are working outside the tree and wanna be closed source. That is
> the price you pay. I don't see any other way around that.
> 
> Remember that a lot of things are highly related to the Bluetooth
> specification and A2DP is changing quickly. Actually the versions 1.4
> are already on their way to be getting approved at some point. Also the
> meta data transfer needs some extra love.

I 100% agree with that too. Maybe we just misundertood ourselves about 
how "public" it should bet :-)

Basically what i meant is that we should define & stabilize this API for 
our own internal use (Gst, ALSA, PulseAudio), and for other people 
involved in the Bluez project working also on some out of tree project 
(that would be me and maybe the Access guys AFAIK)
However i'm fully aware that this API will break from time to time due
to changes or new features, and won't blame anybody for that :-)

> 
> And we need a security audit before ever thinking about making this
> really public and stabilize it.

Well, i didn't mean something *that* public (at least not for now).
I just meant something not-completely-unstable-not-documented-that-
will-keep-changing-and-breaking-my-software-for-no-reason. :-)

So this looks that we agree on everything afterall. :-)

> The LGPL wish is easy to solve. Get Johan and Luiz to agree here on the
> mailing list and then we make ipc.h and an upcoming ipc.c licensed under
> LGPL and then you can copy it out from the bluez-utils source and use
> it. 

I was more thinking of as a complete rewrite of ipc.h (we should find it 
another name btw : lets call it newipc.h for now ;-) ).
I already started thinking to how i would like to see it look.
It should be relatively lightweight, expose directly a message based API 
(as you would find on most RTOS), with just a few functions to create 
and free a session to the audio daemon, and to retrieve the data socket, 
so that each user wouldn't have to know the tricks about ancilliary data 
passing :-)
I fact it should be so lightweight that i think we could static inline 
all the functions, and thus we wouldn't even need a *.c file.

I'm waiting for comments, int the meantime i'm gonna start drafting a 
newipc.h :-)

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
