Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030306131747.070a7bc0@mail1.qualcomm.com>
Date: Thu, 06 Mar 2003 13:33:12 -0800
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] BlueZ Qualification
Cc: david.libault@inventel.fr, Daryl Van Vorst <dvpub@telus.net>, bluez-devel@lists.sourceforge.net, Halam.Rose@7layers-UK.com
In-Reply-To: <1046706518.14907.133.camel@linux>
References: <5.1.0.14.2.20030228122906.023b3ca8@mail1.qualcomm.com>
	<5.1.0.14.2.20030227125343.023513a0@mail1.qualcomm.com>
	<5.1.0.14.2.20030227125343.023513a0@mail1.qualcomm.com>
	<5.1.0.14.2.20030228122906.023b3ca8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 07:48 AM 3/3/2003, Marcel Holtmann wrote:
>The BlueZ kernel modules are working perfect in conjunction with other
>devices and other stacks, but we have already seen that we need to add
>some quirks for passing the qualification and I agree completly with Max
>that is a bad idea to have things that don't makes sense, but are needed
>for a qualification. 
That the biggest thing that concerns me about qualification. And that's where
separate package helps.

>We should start colleting these quirks and see how we handle them. At the moment 
>I see two ways out of this problem:
>
>1. Include them into the kernel code and make them a compile option
That can be pretty ugly. 

>2. Have own patches against the stable kernel for qualification
I guess by "separate package" I didn't necessarily mean tar.gz with
make install or whatever. It could be a patch.

>The same rules apply to the userspace utils and also to the userspace
>protocol implementations like SDP and OBEX.
For some reason I'm less concerned about ugliness in the user-space code ;-)
(must be because I'm a kernel guy). I'm just kidding of course.

>In general I think a qualified version of the BlueZ stack is a good
>idea, but this is also hard work and at this points comes the money
>problem in. The end user don't get any advantages of a qualified Linux
>Bluetooth (it only sounds great), 
True. %99.9 percent of the Linux users couldn't care less whether Bluetooth 
stack is qualified or not as long as it works correctly.

>but companies who plan to use BlueZ in their Bluetooth products will save a lot of time, 
>money and knowledge if they don't have to qualify the complete stack again. If we really 
>got BlueZ qualified and companies can take advantage of it I think that they should payback 
>something to the OpenSource community. 
Yeah, like buy a new Volvo SUV for me for example ;-)

>And at this point the idea of a non-profit organization which takes care of a qualified
>version of the BlueZ stack and represent the Linux fraction in the Bluetooth SIG comes to 
>my mind.
I'm not sure about that. Might be a good idea.

Max
