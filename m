Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030306133725.025f46d8@mail1.qualcomm.com>
Date: Thu, 06 Mar 2003 14:06:53 -0800
To: david.libault@inventel.fr, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] BlueZ Qualification
Cc: Daryl Van Vorst <dvpub@telus.net>, bluez-devel@lists.sourceforge.net, Halam.Rose@7layers-UK.com
In-Reply-To: <3E58CB9800003E68@serveur.inventel.fr> (added by
	serveur.inventel.fr)
References: <1046706518.14907.133.camel@linux>
	<5.1.0.14.2.20030227125343.023513a0@mail1.qualcomm.com>
	<5.1.0.14.2.20030228122906.023b3ca8@mail1.qualcomm.com>
	<1046706518.14907.133.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

At 10:06 AM 3/3/2003, David LIBAULT wrote:
>> 2. Have own patches against the stable kernel for qualification
>
>IMHO, it is possible to have L2CAP qualified without messing up that much the 
>code, and without changing the behavior/performance when "the other side" is 
>working properly. 
May be. But we don't seem to know that for sure. What about that L2CAP MTU 
negotiation thing for example ?

>It anyway does not make sense to have one stack for qualification and one stack 
>for "real usage", as, in theory, only qualified bluetooth products should be 
>runing... 
Linux servers, workstations, laptops, etc are not "bluetooth products". 
Also we're not saying two stacks right. We're saying a separate package (or patch or 
whatever). And the only reason to have that package is if qualification
support becomes ugly.

>Bluez is one of the cleanest Bluetooth implementations, and is becoming (or is already) 
>a reference implementation. Lets qualify it ! 
Sure. I'm with you.

>> The same rules apply to the userspace utils and also to the userspace
>> protocol implementations like SDP and OBEX.
>>
>> In general I think a qualified version of the BlueZ stack is a good
>> idea, but this is also hard work and at this points comes the money
>> problem in. The end user don't get any advantages of a qualified Linux
>> Bluetooth (it only sounds great), but companies who plan to use BlueZ in
>> their Bluetooth products will save a lot of time, money and knowledge if
>> they don't have to qualify the complete stack again. If we really got
>> BlueZ qualified and companies can take advantage of it I think that they
>> should payback something to the OpenSource community. And at this point
>> the idea of a non-profit organization which takes care of a qualified
>> version of the BlueZ stack and represent the Linux fraction in the
>> Bluetooth SIG comes to my mind.
>
>My interest as a company is to help having Bluez qualified. If once I have 
>suffered, for the qualification I have to pay someone again later there is 
>absolutely no interest in having Bluez qualified ! I just use Bluez as it is 
>and qualify it myself !
Darn, no Volvo for me :(

>I also think that having Bluez qualified is very small effort compared to the 
>one of developing a complete/robust/functional/performant stack. The biggest 
>effort has already been done by Maxim and other people, and it is open 
>source. Companies take more advantage from Bluez itself than from a 
>"qualified" Bluez. Qualification should be as the stack itself : open source.

I see another benefit of qualification. In order to get qualified we need a tool 
set that implements test cases and stuff. This toolset is pretty much a regression
test suite which is always good to have.

>> People that already have some experiences in qualification (and
>> especially BlueZ) should start now sharing their results with us, so we
>> can start planing the next step.
>
>Next step : L2CAP qualification.
>
>The main issue is to have the tester side...
>
>        1) write a small user-mode program that can open and close an ACL channel, 
>and send any kind of packet over this link
Don't you guys have that already ? If not I'll write this one.
Do you have any specific features in mind ?

>        2) write a script for each test case
Anybody willing to contribute that ? 

It sounds like we need to create a module in CVS and start putting things that
we need together. Any suggestion for a name ? "qube" ?

Max
