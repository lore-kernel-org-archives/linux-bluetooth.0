Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Question about role switch
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDE4F@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A45BDE4F@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1103127611.8717.7.camel@pegasus>
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
Date: Wed, 15 Dec 2004 17:20:11 +0100

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
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
>                                
> >>>>>>>> This is my Linux PC. 
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
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

everything before HCI 16.4 has not even limited scatternet support.
Check you my CSR page for more details.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
