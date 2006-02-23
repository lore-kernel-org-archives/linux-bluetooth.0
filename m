Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] ISSC USB dongle with PAN
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <004a01c63829$20f79970$1f1410ac@AL31>
References: <004a01c63829$20f79970$1f1410ac@AL31>
Content-Type: text/plain
Message-Id: <1140691437.24721.14.camel@localhost>
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
Date: Thu, 23 Feb 2006 11:43:57 +0100

Hi Al,

>       I am trying NAP using an ISSC USB dongle. On the PANU side I use
> CRS chip with IVT software on Windows XP.
> 
>      The bnep0 connection can be established. Ping with size 900
> works. But
> Ping with size 1000 doesn't work. CSR dongle works fine with same
> bluez software.
> 
> I have searched for the list and found othershave similiar problems.In
> addition to set
> MTU to 1000(ifconfig bnep0 mtu 1000), a ny other solutions to this
> problems? 
> Does MTU solution must be done on both sides (NAP and PANU)?

according to your email address, you work for ISSC. So you might wanna
ask some of your colleges why we can't send big packets with the ISSC
chip. I haven't found any bug in the BlueZ HCI layer, but if the data
packet is too big then your HCI goes spooky. From my understanding it is
a bug in your chip (most likely the HCI part of your firmware).

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
