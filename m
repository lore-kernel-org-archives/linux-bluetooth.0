Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: =?iso-8859-1?Q?Jos=E9_S=E1nchez_S=E1nchez?= <jose.sanchez@libera.net>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Fri, 15 Jun 2007 13:00:29 +0200
Message-ID: <003e01c7af3c$65f14e00$a100010a@Libera.local>
MIME-Version: 1.0
In-Reply-To: <1181903862.6846.23.camel@aeonflux.inter-touch.com>
Subject: Re: [Bluez-devel] RV: sdp_connect don't work with some handsets
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel

Here you can see "hciconfig -a" result:

******************************************
[root@localhost sbin]# ./hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:0D:0B:21:6F ACL MTU: 120:20 SCO MTU: 0:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:33459 acl:496 sco:0 events:750 errors:0
        TX bytes:46184 acl:740 sco:0 commands:228 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'libera networks'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)
*******************************************

With "hcitool info MAC" I have the same problem:


*******************************************

[root@localhost sbin]# hcitool info 00:19:A1:36:C5:71     (LG Handset)
Requesting information ...
Can't create connection: Input/output error

[root@localhost sbin]# hcitool info 9A:BC:56:78:12:34   (GRUNGIG Handset) 
Requesting information ...
Can't create connection: Input/output error

[root@localhost sbin]# hcitool info 00:1A:75:12:E5:d8 (SONY-ERIC. Handset) 
Requesting information ...
        BD Address:  00:1A:75:12:E5:d8
        Device Name: Z610i
        LMP Version: 2.0 (0x3) LMP Subversion: 0x520
        Manufacturer: ST Microelectronics (48)
        Features: 0xff 0xeb 0x8d 0xfe 0x9b 0xe9 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>

                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <SCO link> <HV3 packets> <u-law log> 
                <A-law log> <CVSD> <power control> <transparent SCO> 
                <broadcast encrypt> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> 
                <enhanced iscan> <interlaced iscan> <interlaced pscan> 
                <inquiry with RSSI> <extended SCO> <EV4 packets> <EV5
packets> 
                <AFH cap. slave> <AFH class. slave> <3-slot EDR ACL> 
                <5-slot EDR ACL> <AFH cap. master> <EDR eSCO 2 Mbps> 
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> 

**************************************

Also  I can see using hcidump that the problem with hcitool is "Role change
not allowed" again.

****************************************

[root@localhost sbin]# ./hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 9A:BC:56:78:12:34 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 9A:BC:56:78:12:34 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x21 handle 8 bdaddr 9A:BC:56:78:12:34 type ACL encrypt 0x00
    Error: Role Change Not Allowed

********************************************

Regards

Jose


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
