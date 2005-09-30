Return-Path: <gl@dsa-ac.de>
Date: Fri, 30 Sep 2005 14:18:49 +0200 (CEST)
From: gl@dsa-ac.de
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net, Maksim Krasnyanskiy <maxk@qualcomm.com>,
   USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [2.4.30] RFCOMM race
In-Reply-To: <1128011935.30743.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0509301330520.11341@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0509291329280.11341@pcgl.dsa-ac.de>
 <1128011935.30743.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, 29 Sep 2005, Marcel Holtmann wrote:

>> How: it forks, the child tries to connect to a non-existing peer, at this
>> time the parent issues ioctl(HCIDEVDOWN); ioctl(HCIDEVUP); the DOWN wakes
>> the child up and it dows ioctl(HCIDEVDOWN) too. That's it. On the
>> USB-analyser I see an incomplete HCI Reset, interrupted by the "Read local
>> supported features" - from the UP. (screenshot attached)
>>
>> The question is, of course, where (apart from the program) is the bug? I
>> have to say, that the bluletooth module is connected to an "unsupported"
>> USB controller, the driver for which I am debugging. I thought, naturally,
>> that the bug is there. But now I am not sure. Is this really the case? If
>> yes, what might it be doing wrong? Or is it rfcomm?
>
> is it reproducible with the latest 2.6.14-rc2 kernel running on a i386
> or x86_64 system?

Well, even worse (for me) - I cannot reproduce it on a PC with 2.4.30. 
Same with 2.6.13. So, perhaps, we should assume, that the bug indeed is in 
the USB driver. So, my question should rather be: "what can one do wrong 
in a USB driver to produce such a picture?" What should protect against 
this race? I have problems understanding the USB-log - how it can be 
produced by my program. Let's see:

Parent				Child			USB - HCI

sleep()				connect()		Create Connection
ioctl(HCIDEVDOWN) ------------>	(interrupted)
 				ioctl(HCIDEVDOWN)
ioctl(HCIDEVDOWN) (cont) <-----	(preempted)		Reset
(preempted) ------------------> (resumed:
 				DOWN sees that device
 				is already down, returns)
 				ioctl(HCIDEVUP)		Read Local Supported Features
 							(interrupts "Reset" -
 							the IN transaction
 							is missing!!!)

So, I don't understand, how it is possible - how can Reset be interrupted 
before the IN transaction is sent. The endpoint is the same. Actually, if 
you look at timestamps - the IN should long be out. It is 10ms between the 
"OUT" in "Reset" and the "Read Local Supported Features". Normally the IN 
in Reset comes less than 100us after OUT...

I am adding USB-devel to CC: Unfortunately, I cannot include a link to my 
original post with the snapshot and a code snipplet - it was too big and 
didn't get it to the list, only to the persons I included explicitely in 
CC (Bluetooth maintainers). Marcel's answer is here:
http://sourceforge.net/mailarchive/forum.php?thread_id=8348704&forum_id=1883
I can re-send the files on request.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
