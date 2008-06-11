Return-Path: <cyrus@holtmann.org>
From: Thomas Ilnseher <illth@gmx.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0806110233w2252f8f4od7a49ea09676079b@mail.gmail.com>
References: <3e9cdced0806110010v2d5db37di201da69e956e2194@mail.gmail.com>
	<1213176225.1593.8.camel@pcmik05.zmk.uni-kl.de>
	<3e9cdced0806110233w2252f8f4od7a49ea09676079b@mail.gmail.com>
Date: Wed, 11 Jun 2008 14:50:54 +0200
Message-Id: <1213188654.1593.15.camel@pcmik05.zmk.uni-kl.de>
Mime-Version: 1.0
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


Am Mittwoch, den 11.06.2008, 11:33 +0200 schrieb Fritz Code:
> Thanks for your help so far.
> I will take a look in detail concerning the functionality of hidp and
> its real prerequisites.
> The thing is, I can only use Kernel 2.4.21.
> It might be ok to port the module hidp to kernel 2.4 but if it also
> uses a generic HID Impl. of 2.6 which is total different to the one in
> 2.4 it might be too much work..
It is very different to 2.4 'cause 2.4 has an integrated usbhid driver.
i think bt was teh reason for the split in 2.6 ...
> However, I've also tried bthid of Peter Klausler, it worked fine so
> far, but if the Keyboard goes in idle-mode and tries to reconnect,
> bthid crashes with a segmentation fault. So there seems to be a bug in
> the listen mode of bthid.
never heard of that.

Just to be curious: are you using some kind of hacked 2.4 kernel for
some embedded system, or are there other reasons why you want to stay
with 2.4 ?
> 
> So I will still focus both strategies... we will see which one is better...
> 1. porting hipd, hidd to Kernel 2.4!
> 2. debugging bthid!
> 
> Any help, hints are welcome...

> 
> 
-- 
Thomas Ilnseher <illth@gmx.de>


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
