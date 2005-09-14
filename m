Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth power management
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1126687254.2330.26.camel@localhost.localdomain>
References: <1126687254.2330.26.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1126702842.16166.19.camel@station6.example.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 14 Sep 2005 15:00:42 +0200

Hi David,

> Does anybody use BRF6100 chip on the phone? I have read "BRF6100
> singel-chip bluetooth RF device" date sheet to get the method of doing
> power management. It tells me that I can use the HCI command to take the
> BRF6100 from wake up to deep sleep.  It seems that the date sheet
> doesn't tell me how to turn off/on the BRF6100(Is this called
> power-down/on mode?). I wonder to know what do ioctl(ctl, HCIDEVUP,
> hdev)) and ioctl(ctl, HCIDEVDOWN, hdev) do in bluez hcitool.c? Can it
> turn BRF6100 on or off? If yes, is the menu "bluetooth on/off" in
> mobilephone means that the power of BRF6100 is turned on/off?

the BRF6100 is a ROM chip, right? We need a special init routine for it
and the last code I've seen was a mess, because it was Windows code.
This needs a rewrite and I am only doing this if someone sends me a
development kit with that I can test it. The other possibility is that
someone cleans the code and sends me a patch for it.

If you need special support, then tell TI to open their documents and
sponsor the BlueZ project with hardware. Or choose a chip manufacturer
that is more open source friendly. For example CSR.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
