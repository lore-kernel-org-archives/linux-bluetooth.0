Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4148A827.6030103@uni-paderborn.de>
References: <41470C59.2050909@uni-paderborn.de>
	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>
	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>
	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>
	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de>
	 <1095234376.5263.10.camel@pegasus>  <4148A827.6030103@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1095282404.19426.6.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 15 Sep 2004 23:06:44 +0200

Hi Stefan,

> I just tested this rather old dongle:
> 
> hci0:   Type: USB
>         BD Address: 00:06:AB:80:6F:5C ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:64709 acl:1565 sco:0 events:1055 errors:0
>         TX bytes:38780 acl:1236 sco:0 commands:297 errors:0
>         Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver: 
> 0x1007
>         Manufacturer: Broadcom Corporation (15)
> 
> Same problem. I tried the same dongle one year ago and it was not 
> supported by BlueZ. Now it is. Thumbs up for that!

this is supported much longer, but it was not easy to get it working.

> >There are more than one timeouts in the BlueZ stack. Even the ACL
> >disconnect timeout is different for the initiator and the acceptor of
> >and ACL connection. Keep an eye on the HCI disconnect events on each of
> >your devices and compare the timestamps.
> >  
> I set my timeouts by setting SO_RCVTIMEO and SO_SNDTIMEO on the L2CAP 
> socket. But I think this is just the socket timeout. Is there a way to 
> influence the internal timeouts of BlueZ (L2CAP, ACL)?

You must recompile your kernel and actually modifying them makes not
really sense, because for example the HCI disconnect timeout is useful
to keep the ACL link open for 2-4 seconds so that it can be reused by
the next L2CAP connection.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
