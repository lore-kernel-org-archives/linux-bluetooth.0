Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-devel] Question about role switch
Message-ID: <A1F0D47583A2D711919F00600819B3A4028BD7@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Wed, 15 Dec 2004 11:49:05 -0500

Hi Marcel,

But, the Windows PC and the Linux PC use the same USB Anycomm dongle. =
The Windows PC
is able to communicate with the X-scale Bluez system. The Linux PC can =
not.
I think this points to something that Windows is doing differently.

BTW, the HCI number you quote "16.4" ....How do I get that number ?
Is that available from hciconfig -a ? Is that one of the values in the =
dump below ?

thanks, and best regards.

Rich
-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: Wednesday, December 15, 2004 11:20 AM
To: BlueZ Mailing List
Subject: RE: [Bluez-devel] Question about role switch


Hi Richard,

> >>>>>>>>This is my X-scale embedded system
> [System 1]$hciconfig -a
> hci0:   Type: UART
>         BD Address: 00:A0:96:08:E7:86 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1842 acl:20 sco:0 events:93 errors:0
>         TX bytes:1415 acl:19 sco:0 commands:41 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP =
Subver: 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
>                               =20
> >>>>>>>> This is my Linux PC.=20
> >>>>>>>> I have the same USB dongle in the Linux and Windows PCs
> [System 2]# /sbin/hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:02:72:40:3F:C2 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:135 acl:0 sco:0 events:19 errors:0
>         TX bytes:569 acl:0 sco:0 commands:18 errors:0
>         Features: 0xff 0xff 0x0f 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'Linux_Rich'
>         Class: 0x700408
>         Service Classes: Object Transfer, Audio, Telephony
>         Device Class: Audio/Video, Hands-free
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP =
Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

everything before HCI 16.4 has not even limited scatternet support.
Check you my CSR page for more details.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.=20
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
