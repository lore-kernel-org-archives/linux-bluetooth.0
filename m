Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [SOLVED] BCM2035 over UART on the E680I
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4340F026.1040604@cyph.ath.cx>
References: <432D6F49.80304@cyph.ath.cx>  <4340F026.1040604@cyph.ath.cx>
Content-Type: text/plain
Message-Id: <1128339367.22437.4.camel@blade>
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
Date: Mon, 03 Oct 2005 13:36:07 +0200

Hi,

> Thanks to all those who attempted to help me. Looking through all the 
> code I've hacked together late last night, I spotted a stupid mistake.
> 
> Long story short, I realised that I was basing my custom hciattach on 
> the wrong set of ioctls. It called a custom ioctle Motorola added to the 
> serial driver that caused the bluetooth chip to reset, therefore falling 
> back to its "default" address.
> 
> Nevertheless, I hope this exercise can let some of you know about the 
> vendor-specific HCI commands that can be used to program the BCM2035, 
> especially programming in a custom BD_ADDR.

what do think about writing all this stuff up and posting a patch for
the hciattach program?

I also read that Harald Welte is hacking on the A780 GSM interface. So
maybe at some point it is possible to fully replace their binary only
stuff.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
