Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300802181253g77fe8b85g2ab059b421a6647d@mail.gmail.com>
References: <20080218154244.c5nqdwrvb4wcsgos@www.zarb.org>
	<d89ddf300802181253g77fe8b85g2ab059b421a6647d@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-UynC5HK8gC8d9FepfReJ"
Date: Tue, 19 Feb 2008 13:24:36 +0100
Message-Id: <1203423876.7156.46.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BT headset doesn't work: SCO packet for
	unknown	connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--=-UynC5HK8gC8d9FepfReJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Le lundi 18 février 2008 à 13:53 -0700, Brad Midgley a écrit :
> Guillaume
> 
> > Better try this new version...
> 
> What problem condition does this patch fix? Should Marcel be
> considering it for merging?

I have issues using "voice"/HSP/HFP profiles with the headset below
(bluetooth 1.2 without optional eSCO support) using a bluetooth 2.0
(eSCO + EDR) usb dongle.

Capture and playback don't work at all, although the "hifi"/A2DP profile
works great.

The other headset, which supports eSCO works with "voice" profile.

I'm using kernel 2.6.25rc2 and bluez 3.26.

Here is info about the headset (Motorola HT820) :

hcitool info xx:xx:xx:xx:xx:xx
Requesting information ...
        BD Address:  xx:xx:xx:xx:xx:xx
        Device Name: Motorola HT820
        LMP Version: 2.0 (0x3) LMP Subversion: 0xa41
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x8b 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot
offset> 
                <timing accuracy> <role switch> <hold mode> <sniff
mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
scheme> 
                <transparent SCO> <broadcast encrypt> <enhanced iscan> 
                <interlaced iscan> <interlaced pscan> <inquiry with
RSSI> 
                <AFH cap. slave> <AFH class. slave> <AFH cap. master> 
                <AFH class. master> <extended features> 


About the dongle :

hciconfig -a
hci0:   Type: USB
        BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN 
        RX bytes:706 acl:0 sco:0 events:25 errors:0
        TX bytes:355 acl:0 sco:0 commands:25 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: 
        Link mode: SLAVE ACCEPT 
        Name: 'mybt2dongle'
        Class: 0x180104
        Service Classes: Capturing, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x40eb LMP Ver: 2.0 (0x3) LMP
Subver: 0x430e
        Manufacturer: Broadcom Corporation (15)

Joined is the hcidump traces that show the headset accept the
connection, and gives us a handle (0001) but as a sco link (00).

> HCI Event: Synchronous Connect Complete (0x2c) plen 17
  0000: 00 01 00 3f bc f2 a4 07  00 00 00 00 00 00 00
00  ...?............
  0010: 02

Syslog shows a lot of these lines :
kernel: hci_scodata_packet: hci0 SCO packet for unknown connection
handle 1

And "hcitool con" shows this :
Connections:
        > ACL xx:xx:xx:xx:xx:xx handle 11 state 1 lm SLAVE AUTH ENCRYPT
SECURE 
        < eSCO xx:xx:xx:xx:xx:xx handle 0 state 8 lm SLAVE 

Source reading revealed that :
1) eSCO support for the headset is not checked before trying to
establish an eSCO link,
2) if the headset can't do eSCO, when receiving a "Synchronous
Connection Complete event" with SCO link attribute, the hash table
containing eSCO links is not parsed to add the connection handle.

To fix one of these is enough for my headset to work (with the joined
patchs).

I think it affects more people than me alone, anybody that uses a bt2.0+
dongle and old headset(s). And that's why I try to find other cases
helping other people on bluez-users.

My own tests show my patch attempts aren't ready for inclusion, though.
I can try improving my own patches, but I'd need help from someone
knowing bluez and/or kernel development if we want this to be fixed
quickly...

Maybe some spin_lock should be added, or some other field should be
fixed in patch for 2).
I'm not really sure of the problem with patch for 1).

The problem with 2) is : it works the first time (whatever which
headset, sco or esco), but then switching to using the other headset
fails once, and then works :-(

Best regards,

Guillaume B.






--=-UynC5HK8gC8d9FepfReJ
Content-Disposition: attachment; filename=hcidump_ht820.txt
Content-Type: text/plain; name=hcidump_ht820.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: 3f bc f2 a4 07 00 04 04  24 01                    ?.......$.
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 3f bc f2 a4 07 00 01                              ?......
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 3f bc f2 a4 07 00                                 ?.....
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 3f bc f2 a4 07 00 03 6e  42 9f 49 1e c2 64 e6 04  ?......nB.I..d..
  0010: c5 a9 cf 41 73 ac                                 ...As.
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 3f bc f2 a4  07 00                    ....?.....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 0b 00 3f bc f2 a4 07  00 01 01                 ...?.......
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 0b 00                                             ..
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 0b 00 05                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1b 04                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 0b 00 0f 00                                       ....
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 0b 00 ff ff 8b 78 18  18 00 80                 ......x....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 0b 00                                 ......
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 0b 00 18 cc                                       ....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 0f 04                                       ....
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 3f bc f2 a4 07 00 02 00  00 00                    ?.........
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 0b 00 18 cc                                    .....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0047
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0047 result 0 status 0
      Connection successful
> HCI Event: Command Complete (0x0e) plen 252
  0000: 01 14 0c 00 6c 6f 63 61  6c 68 6f 73 74 2d 30 00  ....localhost-0.
  0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00              ............
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 4
      Success
      MTU 48 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 0
> HCI Event: Command Complete (0x0e) plen 252
  0000: 01 14 0c 00 6c 6f 63 61  6c 68 6f 73 74 2d 30 00  ....localhost-0.
  0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00              ............
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 11 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-32 0x111f (Handsfree AG)
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 3f bc f2 a4 07 00 4d  6f 74 6f 72 6f 6c 61 20  .?.....Motorola 
  0010: 48 54 38 32 30 00 00 00  00 00 00 00 00 00 00 00  HT820...........
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 04 00                                    .....
> HCI Event: Command Complete (0x0e) plen 252
  0000: 01 14 0c 00 6c 6f 63 61  6c 68 6f 73 74 2d 30 00  ....localhost-0.
  0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00              ............
< ACL data: handle 11 flags 0x02 dlen 33
    L2CAP(d): cid 0x0047 len 29 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x18
          count 21
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xd > >
          cont 00
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0047
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0047
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0048
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0
      Connection successful
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 132 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 4
      Success
      MTU 132 
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 4
      MTU 1013 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 04 00                                    .....
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1013 
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0048 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0048 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 7
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7 
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
  0000: 0b 00                                             ..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 11 04                                       ....
> HCI Event: Auth Complete (0x06) plen 3
  0000: 00 0b 00                                          ...
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
  0000: 0b 00 01                                          ...
> HCI Event: Encrypt Change (0x08) plen 4
  0000: 00 0b 00 01                                       ....
< ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0048 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 26 pf 1 ilen 0 fcs 0x2c 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0048 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 13 04                                       ....
< HCI Command: Change Connection Link Key (0x01|0x0015) plen 2
  0000: 0b 00                                             ..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 15 04                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 04 00                                    .....
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Link Key Notification (0x18) plen 23
  0000: 3f bc f2 a4 07 00 a7 55  7a e3 df 57 4b 90 7e 67  ?......Uz..WK.~g
  0010: 20 45 9e 40 43 e0 00                               E.@C..
> HCI Event: Change Connection Link Key Complete (0x09) plen 3
  0000: 00 0b 00                                          ...
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 1 len 9
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0048 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 1 len 9
< ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0048 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 33
> ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 0 fcs 0xf8 credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 03 00                                    .....
> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 11 fcs 0xe4 
      0000: 41 54 2b 42 52 53 46 3d  32 36 0d                 AT+BRSF=26.
< ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0048 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 11 fcs 0x3e 
      0000: 0d 0a 2b 42 52 53 46 3d  30 0d 0a                 ..+BRSF=0..
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 2
      0000: 41 54 2b 43 49 4e 44 3d  3f 0d                    AT+CIND=?.
< ACL data: handle 11 flags 0x02 dlen 70
    L2CAP(d): cid 0x0048 len 66 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 62 fcs 0x3e 
      0000: 0d 0a 2b 43 49 4e 44 3a  28 22 73 65 72 76 69 63  ..+CIND:("servic
      0010: 65 22 2c 28 30 2c 31 29  29 2c 28 22 63 61 6c 6c  e",(0,1)),("call
      0020: 22 2c 28 30 2c 31 29 29  2c 28 22 63 61 6c 6c 73  ",(0,1)),("calls
      0030: 65 74 75 70 22 2c 28 30  2d 33 29 29 0d 0a        etup",(0-3))..
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 04 00                                    .....
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 9 fcs 0xf8 credits 2
      0000: 41 54 2b 43 49 4e 44 3f  0d                       AT+CIND?.
< ACL data: handle 11 flags 0x02 dlen 25
    L2CAP(d): cid 0x0048 len 21 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 17 fcs 0x3e 
      0000: 0d 0a 2b 43 49 4e 44 3a  31 2c 20 30 2c 20 30 0d  ..+CIND:1, 0, 0.
      0010: 0a                                                .
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> ACL data: handle 11 flags 0x02 dlen 27
> ACL data: handle 11 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 24 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 19 fcs 0xf8 credits 2
      0000: 41 54 2b 43 4d 45 52 3d  33 2c 20 30 2c 20 30 2c  AT+CMER=3, 0, 0,
      0010: 20 31 0d                                           1.
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0048 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 01 00                                    .....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 0b 00 01                                          ...
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 0b 00 02 20 03                                 .... .
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
  0000: 0b 00 40 1f 00 00 40 1f  00 00 ff ff 60 00 ff 3f  ..@...@.....`..?
  0010: 00                                                .
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 28 04                                       ..(.
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
  0000: 00 01 00 3f bc f2 a4 07  00 00 00 00 00 00 00 00  ...?............
  0010: 02                                                .
> SCO data: handle 1 flags 0x00 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
[...more 00s...]
[...then, the headset seems to really send data...]
> SCO data: handle 1 flags 0x00 dlen 48
    0000: a0 fa b8 f7 21 f9 d2 f8  55 f9 a9 fa 6d fa 68 fc  ....!...U...m.h.
    0010: 3a fd da fd 13 ff 99 ff  b1 00 4c 01 e8 01 7b 02  :.........L...{.
    0020: d8 02 36 03 51 03 59 03  74 03 32 03 0d 03 fc 02  ..6.Q.Y.t.2.....
[...]


--=-UynC5HK8gC8d9FepfReJ
Content-Disposition: attachment;
	filename=force-sco-link-until-headset-features-are-known.patch
Content-Type: text/x-patch;
	name=force-sco-link-until-headset-features-are-known.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

--- net/bluetooth/hci_conn.c.orig	2008-01-28 09:15:50.000000000 +0100
+++ net/bluetooth/hci_conn.c	2008-02-14 10:34:09.000000000 +0100
@@ -332,6 +332,9 @@
 	if (type == ACL_LINK)
 		return acl;
 
+	if (lmp_esco_capable(hdev) && lmp_esco_capable(acl))
+		type=ESCO_LINK;
+
 	if (!(sco = hci_conn_hash_lookup_ba(hdev, type, dst))) {
 		if (!(sco = hci_conn_add(hdev, type, dst))) {
 			hci_conn_put(acl);
@@ -346,7 +349,7 @@
 
 	if (acl->state == BT_CONNECTED &&
 			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
-		if (lmp_esco_capable(hdev))
+		if (type==ESCO_LINK)
 			hci_setup_sync(sco, acl->handle);
 		else
 			hci_add_sco(sco, acl->handle);
--- net/bluetooth/hci_event.c.orig	2008-01-28 09:15:31.000000000 +0100
+++ net/bluetooth/hci_event.c	2008-02-14 10:26:35.000000000 +0100
@@ -720,7 +720,7 @@
 		struct hci_conn *sco = conn->link;
 		if (sco) {
 			if (!ev->status) {
-				if (lmp_esco_capable(hdev))
+				if (lmp_esco_capable(hdev) && lmp_esco_capable(conn))
 					hci_setup_sync(sco, conn->handle);
 				else
 					hci_add_sco(sco, conn->handle);
@@ -771,7 +771,8 @@
 
 		hci_dev_unlock(hdev);
 
-		if (ev->link_type == ACL_LINK || !lmp_esco_capable(hdev)) {
+		if (ev->link_type == ACL_LINK || !lmp_esco_capable(hdev) 
+				|| !lmp_esco_capable(conn)) {
 			struct hci_cp_accept_conn_req cp;
 
 			bacpy(&cp.bdaddr, &ev->bdaddr);
--- net/bluetooth/sco.c.orig	2008-01-28 09:15:14.000000000 +0100
+++ net/bluetooth/sco.c	2008-02-14 10:36:54.000000000 +0100
@@ -189,7 +189,7 @@
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
-	int err, type;
+	int err;
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
@@ -200,9 +200,7 @@
 
 	err = -ENOMEM;
 
-	type = lmp_esco_capable(hdev) ? ESCO_LINK : SCO_LINK;
-
-	hcon = hci_connect(hdev, type, dst);
+	hcon = hci_connect(hdev, SCO_LINK, dst);
 	if (!hcon)
 		goto done;
 


--=-UynC5HK8gC8d9FepfReJ
Content-Disposition: attachment; filename=also-accept-sco-links-v2.patch
Content-Type: text/x-patch; name=also-accept-sco-links-v2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- net/bluetooth/hci_event.c.orig	2008-02-18 14:02:20.000000000 +0100
+++ net/bluetooth/hci_event.c	2008-02-18 15:19:04.000000000 +0100
@@ -1313,8 +1313,15 @@
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn)
-		goto unlock;
+	if (!conn) {
+		if (ev->link_type==SCO_LINK) {
+			conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
+			if (!conn)
+				goto unlock;
+			else
+				conn->type=SCO_LINK;
+			}
+	}
 
 	if (!ev->status) {
 		conn->handle = __le16_to_cpu(ev->handle);

--=-UynC5HK8gC8d9FepfReJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-UynC5HK8gC8d9FepfReJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-UynC5HK8gC8d9FepfReJ--
