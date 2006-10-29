Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4544689B.3020503@gmail.com>
Date: Sun, 29 Oct 2006 03:38:51 -0500
From: "JP Freeley (GMAIL-NYC)" <jpf321@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] intermittent ISCAN functionality
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I seem to be having a problem with ISCAN. Sometimes it is initiated, 
sometimes it is not. I have to run several hciconfig down/up commands 
until I can see ISCAN in hciconfig -a output. Obviously my hcid.conf is 
set up properly (unedited debian sid version) or else I would never see 
ISCAN.

Does nyone have any thoughts, I'm happy to provide anything else that 
may help.

NOW YOU SEE IT.. NOW YOU DON'T see below...

# hciconfig hci down
# hciconfig hci up 
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:87:37:14 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:10494 acl:307 sco:0 events:501 errors:0
        TX bytes:12999 acl:329 sco:0 commands:316 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hostname-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

# hciconfig hci down
# hciconfig hci down
# hciconfig hci down
# hciconfig hci up
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:87:37:14 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:10907 acl:307 sco:0 events:520 errors:0
        TX bytes:13316 acl:329 sco:0 commands:335 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hostname-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

# hciconfig hci down
# hciconfig hci down
# hciconfig hci down
# hciconfig hci up
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:87:37:14 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:11320 acl:307 sco:0 events:539 errors:0
        TX bytes:13633 acl:329 sco:0 commands:354 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hostname-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

# hciconfig hci up
# hciconfig -a   
hci0:   Type: USB
        BD Address: 00:03:C9:87:37:14 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:11597 acl:307 sco:0 events:542 errors:0
        TX bytes:13642 acl:329 sco:0 commands:357 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hostname-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

# hciconfig hci down
# hciconfig hci up
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:87:37:14 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:12010 acl:307 sco:0 events:561 errors:0
        TX bytes:13959 acl:329 sco:0 commands:376 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hostname-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

# hciconfig hci down
# hciconfig hci down
# hciconfig hci up
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:87:37:14 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:12423 acl:307 sco:0 events:580 errors:0
        TX bytes:14276 acl:329 sco:0 commands:395 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hostname-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

# hciconfig hci down
# hciconfig hci up
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:87:37:14 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:12836 acl:307 sco:0 events:599 errors:0
        TX bytes:14593 acl:329 sco:0 commands:414 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hostname-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object 
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)



Thanks,

jpf

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
