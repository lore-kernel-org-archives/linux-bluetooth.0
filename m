Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] zeevo module on uart
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42D2505A.6070206@soft.uni-linz.ac.at>
References: <42D2505A.6070206@soft.uni-linz.ac.at>
Content-Type: text/plain
Message-Id: <1121102289.5934.1.camel@notepaq>
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
Date: Mon, 11 Jul 2005 19:18:09 +0200

Hi Simon,

> I am trying to talk to a Zeevo BT module (tc2001p chip on it) which is
> attached to an xscale processor via serial.
> When I start hciattach, I get an error message (and I cannot talk to the
> device later on):
> 
> root@tinypxa263:~# hciattach ttyS1 any
> h4_recv: Unknown HCI packet type f1
> 
> The current kernel is 2.4.19-rmk7-pxa2 +local patches, bluez* 2.18
> Is this a kernel issue or is something else in my setup wrong?

the support for the 2.4 kernel series is limited as you now. So I can't
provide you any details. However if the Zeevo module capable of working
with H:4 and doesn't need any special initialization, then this can only
mean the the serial port or baud rate settings are wrong.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
