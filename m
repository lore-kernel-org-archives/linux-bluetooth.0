Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB/bluetooth crash at boot-time
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040914203859.028fe83a@bluez.bueche.ch>
References: <20040914203859.028fe83a@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1095188536.5695.197.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 14 Sep 2004 21:02:16 +0200

Hi Charles,

> I have a Dell Inspiron 8600, with the integrated bluetooth module, which
> I see as usb device. I run gentoo, kernel 2.6.7-gentoo-r11
> (sys-kernel/gentoo-dev-sources).
> 
> lspci -v -v -v result is attached, the full boot log as well.
> 
> I can enable/disable the wireless parts (bluetooth and IPW2200 mini-pci
> card) using a hotkey (Fn-F2). A blue led shows the status.
> 
> If I boot with it disabled (eg I hotkey it to off during grub
> countdown), and I enable it afterwards, everything is OK, I can use
> bluez with hci and friends fine.
> 
> If I boot it with the wireless stuff enabled, I get a sort of oops,
> below is the partial log, see attachment for unwrapped log.
> 
> I suspect either bluez or USB subsystems, but you guys will probably be
> able to help me. The whole things appeared a few kernel version ago, but
> I can reproduce this history. Thanks for hints.

please check out 2.6.9-rc2 and also try if disabling preempt helps.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
