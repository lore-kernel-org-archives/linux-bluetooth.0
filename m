Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Per Thomas Jahr <perja@extern.uio.no>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 19 Feb 2007 22:18:45 +0100
Message-Id: <1171919925.4936.9.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] How to tell if EDR is used?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I'm doing file transfers from my computer to my phone, but I'm not sure
if it's using EDR or not. Is there some way I can find this out by using
f.ex. hcitool, hciconfig or some other tool during the file transfer? 

I use obexftp for the file transfer and both ends should support
Bluetooth 2 + EDR.

BTW: where do I find the explanation for the "Features" bytes?

My computer:

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:XX:XX:XX:XX ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN 
        RX bytes:246878 acl:12503 sco:0 events:6411 errors:0
        TX bytes:13069645 acl:25366 sco:0 commands:45 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'delphi-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x4000 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
        Manufacturer: Broadcom Corporation (15)


My phone (Sony Ericsson K800i):

# hcitool info 00:19:XX:XX:XX:XX
Requesting information ...
        BD Address:  00:19:XX:XX:XX:XX
        LMP Version: 2.0 (0x3) LMP Subversion: 0x520
        Manufacturer: ST Microelectronics (48)
        Features: 0xff 0xeb 0x8d 0xfe 0x9b 0xe9 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <SCO link> <HV3 packets> <u-law log> 
                <A-law log> <CVSD> <power control> <transparent SCO> 
                <broadcast encrypt> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> 
                <enhanced iscan> <interlaced iscan> <interlaced pscan> 
                <inquiry with RSSI> <extended SCO> <EV4 packets> <EV5 packets> 
                <AFH cap. slave> <AFH class. slave> <3-slot EDR ACL> 
                <5-slot EDR ACL> <AFH cap. master> <EDR eSCO 2 Mbps> 
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> 



Thanks
Per Thomas


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
