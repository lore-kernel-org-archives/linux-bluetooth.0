Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USING PAN: PANU(desktop1)
	->NAP(desktop2)->internet
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050203171303.65603.qmail@web26405.mail.ukl.yahoo.com>
References: <20050203171303.65603.qmail@web26405.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1107451291.11944.96.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 03 Feb 2005 18:21:30 +0100

Hi,

> I read Howto about PAN and I did :
> for the NAP:
> # pand --listen --role NAP
> 
> for the PANU:
> # pand --nodetach --role PANU --search --service NAP
> 
> pand[31712]: Bluetooth PAN daemon version 2.15
> pand[31712]: Inquiring
> pand[31712]: Searching for NAP on 00:02:C7:15:11:04 
> "it's my NAP"
> 
> config of the NAP
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:02:C7:15:11:04 ACL MTU: 192:8
> SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:28224 acl:459 sco:0 events:652
> errors:0
>         TX bytes:20479 acl:357 sco:0 commands:141
> errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
> 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
> HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: ACCEPT MASTER
>         Name: 'imad'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering,
> Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1
> (0x1) LMP Subver: 0x33c
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> config of the PANU
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0B:0D:33:43:A5 ACL MTU: 120:20
> SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:14593 acl:192 sco:0 events:330
> errors:0
>         TX bytes:17841 acl:262 sco:0 commands:44
> errors:0
>         Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00
> 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
> HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'thomas'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering,
> Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2
> (0x2) LMP Subver:
> 0x757
>         Manufacturer: Silicon Wave (11)
> 
> 
> but MY PANU doesn't find the NAP service over my
> NAP???
> wath's the probleme can you help me?

then check with sdptool what is running on your NAP machine.

> and ohter thing wath that mean "nat" and
> "masquerading"
> I find that in http://quozl.netrek.org/bluetooth/

Basic network technologies. This is nothing Bluetooth specific. Teach
yourself about, because there are a lot of information resources
available.

> after making bnep interface between my tow dongle i
> have to write :
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 
> echo 1 > /proc/sys/net/ipv4/ip_forward
> 
> what does it mean?

Check the manual page of iptables and then Netfilter project.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
