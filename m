Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: inactivity of my Bt
From: Marcel Holtmann <marcel@holtmann.org>
To: nicolas <n1c0l4s.l3@wanadoo.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200406242245.43321.n1c0l4s.l3@wanadoo.fr>
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr>
	 <200406242235.41539.n1c0l4s.l3@wanadoo.fr>
	 <1088109334.4296.137.camel@pegasus>
	 <200406242245.43321.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1088110463.3712.1.camel@pegasus>
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
Date: Thu, 24 Jun 2004 22:54:24 +0200

Hi Nicolas,

> hciconfig -a gives me:
> 
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:50:F2:7E:3B:3F ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN INQUIRY
>         RX bytes:457793 acl:30836 sco:0 events:1508 errors:0
>         TX bytes:4377 acl:101 sco:0 commands:230 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x1f9 LMP Ver: 1.1 (0x1) LMP Subver: 0x1f9
>         Manufacturer: Cambridge Silicon Radio (10)

your link policy looks fine. Everything should work as expected. Check
the syslog and run "hcidump -x" as root if you wann know what is going
on.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
