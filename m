Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0806110233w2252f8f4od7a49ea09676079b@mail.gmail.com>
Date: Wed, 11 Jun 2008 11:33:25 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1213176225.1593.8.camel@pcmik05.zmk.uni-kl.de>
MIME-Version: 1.0
References: <3e9cdced0806110010v2d5db37di201da69e956e2194@mail.gmail.com>
	<1213176225.1593.8.camel@pcmik05.zmk.uni-kl.de>
Subject: Re: [Bluez-users] hidd and hidp
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Thanks for your help so far.
I will take a look in detail concerning the functionality of hidp and
its real prerequisites.
The thing is, I can only use Kernel 2.4.21.
It might be ok to port the module hidp to kernel 2.4 but if it also
uses a generic HID Impl. of 2.6 which is total different to the one in
2.4 it might be too much work..
However, I've also tried bthid of Peter Klausler, it worked fine so
far, but if the Keyboard goes in idle-mode and tries to reconnect,
bthid crashes with a segmentation fault. So there seems to be a bug in
the listen mode of bthid.

So I will still focus both strategies... we will see which one is better...
1. porting hipd, hidd to Kernel 2.4!
2. debugging bthid!

Any help, hints are welcome...

thanks,
Fritz



On 6/11/08, Thomas Ilnseher <illth@gmx.de> wrote:
>
> Am Mittwoch, den 11.06.2008, 09:10 +0200 schrieb Fritz Code:
>> Hi!
>>
>> is it right that the two components hidd (the daemon) and the kernel
>> module hidp (found in net/bluetooth/) work together in order to
>> provide support for Bluetooth Keyboards and other HID devices?
>> As far as I know hidd has been replaced, if yes with what?
>> And which role plays the Input service which is also an own folder in
>> the bluez-utils?
> I dunno.
>>
>> Anyway, the two components hidd and hidp provide HID support?
>> I took a look at hidd and hidp and found out that hidd listends for
>> incoming connections, if it gets one it forwards this connection to
>> the kernel
>> modules hidp which adds it to its handlers. From there the kernel
>> module serves the connection and uses the well known input function
>> input_event to get the scancodes into the input system of linux.
> I spent some time debugging my bluetooth mouse. (I was using the
> 2.6.25.4 kernel).
>
> The hid traffic is done inside the kernel. I know there is some
> input_event codepath in hidp, but for my mouse, this codepath was NOT
> taken. there is an alternative codepath that forwards such bluetooth
> frames after some mangling to the generic hid driver, which parses the
> events, and uses register_event.
>
> Therefore you need the generic hid implementation of the kernel, too.
> in 2.6.25.4, and possibly earlier 2.6er kernels, there is a generic hid
> driver core, that is used by the usb_hid driver and hidp. The generic
> core does the nasty stuff like parsing the usage tables, etc ...
>>
>> So for a basic support of keyboards I only need hidd and hidp
>> running?
> i suspect that you need hcid as a prerequisite for hidd.
> I found out that if you do a 'hidd --search', nothing is forked. might
> be wrong thou.
>
>
>>
>> Thanks...
>>
>>
>>
>> --
>> Regards,
>> --Codefritz
>>
>>
>>
>> -------------------------------------------------------------------------
>> Check out the new SourceForge.net Marketplace.
>> It's the best place to buy or sell services for
>> just about anything Open Source.
>> http://sourceforge.net/services/buy/index.php
>> _______________________________________________ Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
> --
> Thomas Ilnseher <illth@gmx.de>
>
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-- 
Regards,
--Codefritz

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
