Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] L2Ping / Rfcomm connect : Function not implemented
References: <200412122356.09617.wim.delvaux@adaptiveplanet.com> <200412131243.08426.wim.delvaux@adaptiveplanet.com> <1102938476.8750.145.camel@pegasus>
In-Reply-To: <1102938476.8750.145.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412131259.20788.wim.delvaux@adaptiveplanet.com>
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
Date: Mon, 13 Dec 2004 12:59:20 +0100


Hi marcel,

After a reboot (again a kernel freeze that I mailed about before) and a change 
in hcid.conf ... no result.

New hcidump -x and hciconfig -a 

/mnt/ramfs/tmp # l2ping 00:60:57:35:81:B6
< HCI Command: Create Connection(0x01|0x0005) plen 13
  B6 81 35 57 60 00 18 CC 02 00 00 00 01
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete(0x03) plen 11
  1F 00 00 B6 81 35 57 60 00 01 00
Can't connect.: Function not implemented
/mnt/ramfs/tmp # hciconfig -a
hci0:   Type: UART
        BD Address: 00:02:C7:0D:85:96 ACL MTU: 128:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1484028 acl:3535 sco:0 events:1656 errors:0
        TX bytes:161370 acl:1596 sco:0 commands:42 errors:0
        Features: 0xff 0xff 0x05 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
< HCI Command: Read Local Name(0x03|0x0014) plen 0
> HCI Event: Command Complete(0x0e) plen 252
  01 14 0C 00 66 61 6D 69 6C 69 61 72 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00
        Name: 'familiar'
< HCI Command: Read Class of Device(0x03|0x0023) plen 0
> HCI Event: Command Complete(0x0e) plen 7
  01 23 0C 00 12 01 12
        Class: 0x120112
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Handheld
< HCI Command: Read Local Version Information(0x04|0x0001) plen 0
> HCI Event: Command Complete(0x0e) plen 12
  01 01 10 00 01 72 00 01 0A 00 72 00
        HCI Ver: 1.1 (0x1) HCI Rev: 0x72 LMP Ver: 1.1 (0x1) LMP Subver: 0x72
        Manufacturer: Cambridge Silicon Radio (10)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
