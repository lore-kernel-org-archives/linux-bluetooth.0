Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Digianswer USB driver
From: Marcel Holtmann <marcel@holtmann.org>
To: "Jan J. Jessen" <jjjessen@control.auc.dk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<Pine.GSO.4.40.0309231002430.12164-100000@prosit.control.auc.dk>
References: <Pine.GSO.4.40.0309231002430.12164-100000@prosit.control.auc.dk>
Content-Type: text/plain
Message-Id: <1064307381.26572.162.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 23 Sep 2003 10:56:15 +0200

Hi Jan,

> Works perfect:-) At first hciconfig hci0 up gave an error saying that it
> couldn't set scan mode. Working with these cards for more than a year, I
> know that they sometimes don't reply with the event they are supposed to,
> so I just tried again, and everything is OK Bluetooth:-)

these are good news. Your initial problem setting scan mode can only be
solved with a USB sniffer, I think.

Do you have any H:2 USB Bluetooth devices? If yes, please attach them
along with a Digianswer one to the same host and use them both. I want
to make sure that a Digianswer device works in conjunction with a H:2
device.

> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:50:CD:00:42:2B ACL MTU: 384:6  SCO MTU: 32:7
>         UP RUNNING
>         RX bytes:58747 acl:0 sco:0 events:6 errors:0
>         TX bytes:27 acl:0 sco:0 commands:7 errors:0
>         Features: 0xff 0xfa 0x21 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: ''
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x37
>         Manufacturer: Motorola (8)

Have you ever updated the firmware of the Digianswer device? I though
that Digianswer already had a USB device at the time they are not a
subsidiary of Motorola. So the manufacturer should be 12.

> I hope this is all the information that you need. It shure will easy my
> explanations to students here at the university that wants to use these
> devices, that they can just use bluez from now on.

Please do my test above and send me "hciconfig -a" of a machine with two
different dongles. If this works I apply this patch to mainline and your
students can start working with BlueZ very easy ;)

> Since Digianswer is a subsidiary of Motorola one could imagine that if
> Motorola once made a Bluetooth USB dongle, Bluez would work perfectly
> with it - just a thouhgt.

Do you have any contact to Motorola, so I can get one of these devices?

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
