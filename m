Return-Path: <charles@bueche.ch>
Date: Thu, 16 Sep 2004 10:31:27 +0200
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB/bluetooth crash at boot-time
Message-ID: <20040916103127.4f97fac5@bluez.bueche.ch>
In-Reply-To: <1095188536.5695.197.camel@pegasus>
References: <20040914203859.028fe83a@bluez.bueche.ch>
	<1095188536.5695.197.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel and list,

thanks for your hint. After 3 cold boots with wireless "on", no Oops to
report. However, I'm now running the vanilla 2.6.9rc2, and my bug was
previously happening under gentoo-dev-sources, which is heavily
patched.

I will have to wait for gentoo-dev-sources-2.6.9 to see if the bug is
really gone.

Meanwhile, I like the boot without stack dumps. Thanks for your support
!

Regards,
Charles

On Tue, 14 Sep 2004 21:02:16 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Charles,
> 
> > I have a Dell Inspiron 8600, with the integrated bluetooth module,
> > which I see as usb device. I run gentoo, kernel 2.6.7-gentoo-r11
> > (sys-kernel/gentoo-dev-sources).
> > 
> > lspci -v -v -v result is attached, the full boot log as well.
> > 
> > I can enable/disable the wireless parts (bluetooth and IPW2200
> > mini-pci card) using a hotkey (Fn-F2). A blue led shows the status.
> > 
> > If I boot with it disabled (eg I hotkey it to off during grub
> > countdown), and I enable it afterwards, everything is OK, I can use
> > bluez with hci and friends fine.
> > 
> > If I boot it with the wireless stuff enabled, I get a sort of oops,
> > below is the partial log, see attachment for unwrapped log.
> > 
> > I suspect either bluez or USB subsystems, but you guys will probably
> > be able to help me. The whole things appeared a few kernel version
> > ago, but I can reproduce this history. Thanks for hints.
> 
> please check out 2.6.9-rc2 and also try if disabling preempt helps.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
> Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
> Camcorder. More prizes in the weekly Lunch Hour Challenge.
> Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
