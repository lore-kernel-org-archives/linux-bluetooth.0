Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030723092053.0983b3c0@unixmail.qualcomm.com>
Date: Wed, 23 Jul 2003 09:27:41 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Version 3 libs/utils
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1058909609.2854.68.camel@pegasus>
References: <5.1.0.14.2.20030722125704.097cd218@unixmail.qualcomm.com>
	<5.1.0.14.2.20030721173324.096d96b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
	<5.1.0.14.2.20030721173324.096d96b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030722125704.097cd218@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 02:33 PM 7/22/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> >Should we keep the kernel inquiry interface? The kernel inside inquiry
>> >cache is a nice thing and works in the background like a charm :)
>> You mean HCI_INQUIRY ioctl, right ? I'm not sure about that one.
>> We'll certainly keep inquiry cache. Cache doesn't really depend on ioctl.
>
>yes, I meant the ioctl. The kernel inquiry cache is a nice thing and
>maybe we should provide read only access to it from the userspace.
Sure. We already have it in 2.6
        cat /proc/bluetooth/hci/0/inquiry_cache

(btw I'll move it to sysfs)

>> >What about the idea to integrate the inquiry into the library or into
>> >the Bluetooth master daemon.
>> I don't see a need for forwarding inquiry results from a daemon. It can be 
>> done in a simple way in the kernel, just like I explained in prev emails
>> (ie kernel parsing hci_inquiry command).
>
>My concern is the HCI_INQUIRY ioctl, because it don't really fits the
>possibilities and specification details of the inquiry command. 
It should go then :)

>But I don't know what the best way is here and with Bluetooth 1.2 we can also
>get the RSSI from an inquiry result.
>
>At the moment I think additional ioctl's for accessing the inquiry cache
>will make it possible to use the inquiry command in a more dynamic way:
>
>        - get number of inquiry cache entries
>        - copy first n inquiry cache entries to my buffer
>        - flush inquiry cache
>
>Comments? Ideas?
#1 and 2 are already supported in 2.6 (via /proc/.../inquiry_cache).
We could make 'echo 0 > /proc/.../inquiry_cache' flush the cache.

Max
