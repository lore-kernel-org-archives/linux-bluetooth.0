Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY108-F37BFB6E454B50F1EB33E4AD68C0@phx.gbl>
From: "djails sliajd" <djails@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Bluez-users] Problem with sdpd
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
Date: Thu, 29 Sep 2005 04:54:18 +0000

Hi,
The following problem happens every time I turn on my BT headset if sdpd is 
running (see the hcidump capture at the end): there is an ACL packet exhange 
that loops forever...

The only two ways out I found so far:

Kill the connection with "hcitool dc 00:03:89:52:CB:6F"

OR

Kill the sdpd daemon before turning on the headset, turn on the headset and 
then run sdpd.

Now here is my configuration:

FC4, 2.6.12kernel on i686
Bluetooth adaptor: belkin F8T001 usb BT dongle (directly connected to the 
usb port, no USB hub)
Headset: Plantronics M2500
hciconfig -a:
        hci0:   Type: USB
        BD Address: 00:0A:3A:59:81:EC ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3663805 acl:611 sco:71453 events:710 errors:0
        TX bytes:3584997 acl:607 sco:70061 commands:58 errors:0
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'sit-146a.it.jcu.edu.au-0'
        Class: 0x120104
        Service Classes: Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 
0x33c
        Manufacturer: Cambridge Silicon Radio (10)
hciconfig hci0 revision says "SCO mapping:  HCI"

hcitool info 00:03:89:52:CB:6F
        Requesting information ...
        BD Address:  00:03:89:52:CB:6F
        Device Name: M2500 by Plantronics
        LMP Version: 1.2 (0x2) LMP Subversion: 0x615
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbc 0xe8 0x01 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <sniff mode> <SCO link> <HV3 packets> <u-law log> <A-law 
log>
                <CVSD> <AFH cap. slave> <AFH cap. master>

Package version: bluez-hcidump-1.18-1 & bluez-utils-2.15-7

Lastly, here is the hcidump produced when I turn on my headset:

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
>HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:03:89:52:CB:6F class 0x20040c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:03:89:52:CB:6F role 0x01
    Role: Slave
>HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
>HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:03:89:52:CB:6F
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:03:89:52:CB:6F
    Link key: 38538b54fad52d65f22091e314d65e5d
>HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:03:89:52:CB:6F
>HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:03:89:52:CB:6F type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
>HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  o . R . . . .
>HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
  ) . . .
>ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
>HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
>HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0x0018
    Packet type: DM1 DH1
>HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
>ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
>HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
>HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
>ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
>ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x111f (Handsfree AG)
          max 40
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
>HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
>ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x2 len 0xa
          pat uuid-32 0x1112 (Headset AG)
          max 40
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x2 len 0x5
          count 0
          cont 00
>HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
>ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x3 len 0xa
          pat uuid-32 0x1112 (Headset AG)
          max 40
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x3 len 0x5
          count 0
          cont 00
>HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
>ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x4 len 0xa
          pat uuid-32 0x1112 (Headset AG)
          max 40
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x4 len 0x5
          count 0
          cont 00
>HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
>ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x5 len 0xa
          pat uuid-32 0x1112 (Headset AG)
          max 40
          cont 00
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x5 len 0x5
          count 0
          cont 00
The >HCI >ACL <ACL loop goes on forever ...

Thanks for helping me fixing this

_________________________________________________________________
Tout savoir sur la sécurité de vos enfants sur Internet ! 
http://go.msn.fr/10-channel/80-security/protection/default.asp



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
