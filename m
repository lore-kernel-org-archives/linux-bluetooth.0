Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] How can I talk with others through bluetooth
 modules?
In-Reply-To: <20050718085659.20030.qmail@web15704.mail.cnb.yahoo.com>
Message-ID: <Pine.LNX.4.33.0507181108221.11143-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
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
Date: Mon, 18 Jul 2005 11:11:45 +0200 (CEST)


Hi,

when you want to use te PCM interface with external coes you have to
reconfigure the chip to use the codec interface instead of routing the SC=
O
traffic over HCI. The easiest way to do that is using PSTOOL from CSR. As
far as I know there is also some code within Bluez which allows you to
reconfigure PS settings, but I never tried that.

Ciao,

Peter

On Mon, 18 Jul 2005, [gb2312] =C4=FE =C4=FE wrote:

> Hi,
> My case is as follows:
> I use two CSR(Bluecore2) modlues on two arm platforms
> respectively . And now,I can create ACL and SCO
> connection,both l2test and scotest run well.Even,I can
> transmit files using the program obex_test.
> I just want to transmit voice data through bluetooth
> modules so that I can talk with others using
> microphone.And I connected a C145483 Codec throught
> PCM interface yesterady.But I have no idea about how
> to do now.which profile should I use? sdptool add
> Headset?I think it"s not the right one! The hardware
> is just bluetooth module,not headset! And if I add the
> right profile,what should I do next?? Maybe some tools
> just like btsco?
>
>  [\u@\h \W]\$ hciconfig hci0 version revision
>  hci0:   Type: UART
>          BD Address: 4A:49:4E:00:15:2D ACL MTU: 384:4
> SCO MTU: 64:8
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x2c1 LMP Ver:
> 1.1 (0x1) LMP Subver: 0x2c1
>          Manufacturer: Cambridge Silicon Radio (10)
>          Build 705
>          Chip version: BlueCore02-External
>          Max key size: 56 bit
>          SCO mapping:  PCM
>
> Any help will always be appreciated !
>
> Regards
> gadfly
>
>
>
>
>
>
> ___________________________________________________________
> =D1=C5=BB=A2=C3=E2=B7=D1G=D3=CA=CF=E4=A3=AD=D6=D0=B9=FA=B5=DA=D2=BB=BE=F8=
=CE=DE=C0=AC=BB=F8=D3=CA=BC=FE=C9=A7=C8=C5=B3=AC=B4=F3=D3=CA=CF=E4
> http://cn.mail.yahoo.com/?id=3D77071
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
