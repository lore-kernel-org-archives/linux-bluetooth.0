Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FD2F07.5060209@tootai.net>
From: administrator tootai <admin@tootai.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Connection issue with headset
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org>
In-Reply-To: <ctdn6n$sqs$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Sun, 30 Jan 2005 20:01:27 +0100

Sebastian Roth a =E9crit :

> Hi Daniel,
>
>> nomade:/home/dh# btsco 00:0b:2e:06:01:2e
>> Device is 1:0
>> Voice setting: 0x0060
>> RFCOMM channel 6 connected
>
> You have to press the headset button now!

I check further and still I can't get it work. If I do a hcitool scan no=20
device is found. But the info command is working:

nomade:/etc/bluetooth# hcitool info 00:0b:2e:06:01:2e
Requesting information ...
        BD Address:  00:0b:2e:06:01:2e
        Device Name: BT1000
        LMP Version: 1.1 (0x1) LMP Subversion: 0x405
        Manufacturer: Transilica, Inc. (24)
        Features: 0xff 0xf9 0x31 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offs=
et>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <SCO link> <HV2 packets> <HV3 packets>
                <u-law log> <A-law log> <CVSD>

Here is a hcidump -x when launching btsco with the given channel:

nomade:/home/dh#btsco 00:0b:2e:06:01:2e 1
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected

HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
  01 25 0C 00 60 00
< HCI Command: Create Connection (0x01|0x0005) plen 13
  2E 01 06 2E 0B 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
 > HCI Event: Link Key Request (0x17) plen 6
  2E 01 06 2E 0B 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  2E 01 06 2E 0B 00 98 0F 70 E7 AD EE 4B 1A 93 1C BA 18 77 0C
  19 00
 > HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 2E 01 06 2E 0B 00
 > HCI Event: Connect Complete (0x03) plen 11
  00 29 00 2E 01 06 2E 0B 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
 > HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 1024
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 317
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 312 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 1 ack_timer 0
      frame_size 312 max_retrans 0 credits 7
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  29 00 13
 > HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 16

And here the output from snd-bt-sco

snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 2000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL

Pairing is done, so what could be the problem?

I would really appreciate any help to debug this problem.

Thanks
--=20
Daniel



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
