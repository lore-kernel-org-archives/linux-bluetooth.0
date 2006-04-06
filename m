Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Alexandre Coser Monteiro" <coser@cos.ufrj.br>
To: bluez-users@lists.sourceforge.net
Message-Id: <20060406200923.M10379@cos.ufrj.br>
In-Reply-To: <Pine.LNX.4.64.0604020439250.738@data.home>
References: <Pine.LNX.4.64.0603181246420.738@data.home> <Pine.LNX.4.64.0604020439250.738@data.home>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: [Bluez-users] sniff & pand
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
Date: Thu, 6 Apr 2006 18:22:45 -0200


  Every time I try to command sniff mode at the Slave one, in a connection made by
command <pand -s -c "address"> it failure and give this message :

< HCI Command: ogf 0x02, ocf 0x0003, plen 9
 06 10 00 00 10 FF F7 00 07
> HCI Event: 0x0f plen 4
12 01 03 08               

hcidump show me this :

< HCI Command: Sniff Mode (0x02|0x0003) plen 9
> HCI Event: Command Status (0x0f) plen 4

hciconfig  -a show this :
hci0:   Type: USB
        BD Address: 00:03:C9:23:DE:B2 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:954701 acl:264 sco:0 events:100672 errors:0
        TX bytes:606650 acl:395 sco:0 commands:100394 errors:0
        Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: SNIFF
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2033'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver: 0x1007
        Manufacturer: Broadcom Corporation (15)

 It is impossible to enter in sniff mode by a pand conection ?






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
