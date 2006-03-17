Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem With the Inquiry and RFCOMM conexions
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <001001c644f0$2c3d9130$0300a8c0@akira>
References: <001001c644f0$2c3d9130$0300a8c0@akira>
Content-Type: text/plain; charset=utf-8
Message-Id: <1142600160.4392.22.camel@localhost>
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
Date: Fri, 17 Mar 2006 13:56:00 +0100

Hi,

> I have a problem with make a Inquiry and RFCOMM conexions at the same
> time and don=C2=B4t understand why.....(with BlueZ).
> =20
> Is It possible in the same module of bluetooth make a inquiry
> (independ thread) and RFCOMM conexions (4 o 5 conexions in independ
> threads) =20
> at the same time?
> =20
> If I use diferent handles for this the call HCI to the module ...
> Is it independient?=20

you can use as many handles as you like, but the underlaying HCI device
is still the same. It doesn't allow inquiries while you are connecting
to another device. However newer chips allow to run an inquiry while you
are connected (still not while connecting).

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
