Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41FF6E2C.7040908@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Hardware error
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
Date: Tue, 01 Feb 2005 19:55:24 +0800

Dear All
    When i try to send file though bluetooth, there is a hardware error 
in hcidump. I am using serial dongle with CSR BC02 external chip set, 
hci firmware ver 18.1.  And then both side will halt at the bluetooth 
read/write system call. I want to find out is it the problem from my 
hardware or anything else. Do anyone have ideas?

 > HCI Event: Number of Completed Packets(0x13) plen 5
 > HCI Event: Number of Completed Packets(0x13) plen 5
< ACL data: handle 0x002a flags 0x02 dlen 20
    L2CAP(d): cid 0x62 len 16 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 12 fcs 0x40
< ACL data: handle 0x002a flags 0x02 dlen 192
 > HCI Event: Number of Completed Packets(0x13) plen 5
 > HCI Event: Number of Completed Packets(0x13) plen 5
< ACL data: handle 0x002a flags 0x01 dlen 139
    L2CAP(d): cid 0x62 len 327 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 322 fcs 0x40
 > HCI Event: Hardware Error(0x10) plen 1
 > ACL data: handle 0x002a flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 3
< ACL data: handle 0x002a flags 0x02 dlen 20
    L2CAP(d): cid 0x62 len 16 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 12 fcs 0x40
< ACL data: handle 0x002a flags 0x02 dlen 192


hci0:   Type: UART
        BD Address: 00:08:E0:01:49:6A ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:149871 acl:2811 sco:0 events:12828 errors:0
        TX bytes:1847648 acl:15873 sco:0 commands:307 errors:0
        Features: 0xff 0xff 0x8b 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'mike (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x490 LMP Ver: 1.2 (0x2) LMP Subver: 
0x490
        Manufacturer: Cambridge Silicon Radio (10)

best regard
Mike,Lee




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
