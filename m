Return-Path: <jsantos_pt@hotmail.com>
From: "João Santos" <jsantos_pt@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: hci goes down
Date: Tue, 17 Feb 2004 16:08:18 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F28m0LzEDYZqB20002baa9@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

Hi marcel,
> > Could you tell me where i can find a good howto to install the vanilla
> > kernel.
>
>I have written a HOWTO for Debian
>
>	http://www.holtmann.org/linux/kernel/debian.html

I had upgrade the kernel and installed the more recent patch, but the 
results are the same.
I have done:

[root@olivia test]# rfcomm listen rfcomm0 12
Waiting for connection on channel 12

[root@olivia test]# ./scotest -r 00:60:57:15:8A:A9
scotest[15459]: Waiting for connection ...

Then in the phone i made a search for audio acessories. i found the pc and 
connect to him.

[root@olivia test]# rfcomm listen rfcomm0 12
Waiting for connection on channel 12
Connection from 00:60:57:15:8A:A9 to /dev/rfcomm0
Press CTRL-C for hangup

[root@olivia test]# ./scotest -r 00:60:57:15:8A:A9
scotest[15459]: Waiting for connection ...

[root@olivia jsantos]# hcitool con
Connections:
        > ACL 00:60:57:15:8A:A9 handle 40 state 1 lm MASTER AUTH ENCRYPT

Next i press a button in the phone and i start receving sco data:

[root@olivia test]# ./scotest -r 00:60:57:15:8A:A9
scotest[15459]: Waiting for connection ...
scotest[15468]: Connect from 00:60:57:15:8A:A9
scotest[15468]: Receiving ...
scotest[15468]: 720 bytes in 0.00m speed 12555.80 kb
scotest[15468]: 720 bytes in 0.00m speed 12784.09 kb
scotest[15468]: 720 bytes in 0.00m speed 14062.50 kb
scotest[15468]: 720 bytes in 0.00m speed 16351.74 kb
scotest[15468]: 720 bytes in 0.00m speed 16741.07 kb
scotest[15468]: 720 bytes in 0.00m speed 14648.44 kb
scotest[15468]: 720 bytes in 0.00m speed 13521.63 kb
scotest[15468]: 720 bytes in 0.00m speed 18503.29 kb
scotest[15468]: 720 bytes in 0.00m speed 21306.82 kb
scotest[15468]: 720 bytes in 0.00m speed 30.98 kb
scotest[15468]: 720 bytes in 0.00m speed 19531.25 kb
scotest[15468]: 720 bytes in 0.00m speed 38.06 kb
scotest[15468]: 720 bytes in 0.00m speed 76.79 kb
scotest[15468]: 720 bytes in 0.00m speed 36.59 kb
scotest[15468]: 720 bytes in 0.00m speed 76.33 kb
scotest[15468]: 720 bytes in 0.00m speed 35.93 kb
scotest[15468]: 720 bytes in 0.00m speed 79.68 kb
...
...
scotest[15468]: 720 bytes in 0.00m speed 45.65 kb
scotest[15468]: 720 bytes in 0.00m speed 72.51 kb
scotest[15468]: 720 bytes in 0.00m speed 35.63 kb
scotest[15468]: 720 bytes in 0.00m speed 72.47 kb
scotest[15468]: 720 bytes in 0.00m speed 35.58 kb
scotest[15468]: 720 bytes in 0.00m speed 72.79 kb
scotest[15468]: 720 bytes in 0.00m speed 35.51 kb
scotest[15468]: Read failed. Connection reset by peer(104)
scotest[15468]: Disconnect

[root@olivia jsantos]# hcitool con
Connections:
        > SCO 00:60:57:15:8A:A9 handle 43 state 1 lm SLAVE AUTH ENCRYPT
        > ACL 00:60:57:15:8A:A9 handle 40 state 1 lm MASTER AUTH ENCRYPT


HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
>HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>HCI Event: Command Status(0x0f) plen 4
>HCI Event: Link Key Request(0x17) plen 6
>HCI Event: Role Change(0x12) plen 8
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
>HCI Event: Command Complete(0x0e) plen 10
>HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
>HCI Event: Command Status(0x0f) plen 4
>HCI Event: Connection Packet Type Changed(0x1d) plen 5
>HCI Event: Max Slots Change(0x1b) plen 3
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
>ACL data: handle 0x0028 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0xf len 0x8
          pat uuid-16 0x111e
          max 0xff
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x40 len 10 [psm 1]
        SDP SS Rsp: tid 0xf len 0x5
          cur 0x0 tot 0x0
          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
>ACL data: handle 0x0028 flags 0x02 dlen 17
    L2CAP(d): cid 0x40 len 13 [psm 1]
        SDP SS Req: tid 0x10 len 0x8
          pat uuid-16 0x1108 (Headset)
          max 0xff
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 1]
        SDP SS Rsp: tid 0x10 len 0x9
          cur 0x1 tot 0x1 hndl 0x804f6e8
          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 21
    L2CAP(d): cid 0x40 len 17 [psm 1]
        SDP SA Req: tid 0x11 len 0xc
          hndl 0x804f6e8
          max 0xff
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 31
    L2CAP(d): cid 0x40 len 27 [psm 1]
        SDP SA Rsp: tid 0x11 len 0x16
          cnt 0x13
          aid 0x0004 (ProtocolDescList)
             uuid-16 0x0100 (L2CAP)
             uuid-16 0x0003 (RFCOMM) uint 0xc

          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 32772
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
>ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 24 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size 324 
max_retrans 0 credits 0
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 24 frame_type 0 credit_flow 14 pri 0 ack_timer 0 frame_size 324 
max_retrans 0 credits 7
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 24 pf 1 ilen 0 fcs 0xa2
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 24 pf 1 ilen 0 fcs 0x69
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 1 ilen 0 fcs 0xc8
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 9
    L2CAP(d): cid 0x40 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 24 pf 1 ilen 0 fcs 0x12
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): RPN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
dlci 24  br: 7 db: 3 sb: 0 p: 0 pt: 0 xi: 0 xo: 0
       rtri: 0 rtro: 0 rtci: 0 rtco: 0 xon: 17 xoff: 19 pm: 006f
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): RPN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
dlci 24  br: 7 db: 3 sb: 0 p: 0 pt: 0 xi: 0 xo: 0
       rtri: 0 rtro: 0 rtci: 0 rtco: 0 xon: 17 xoff: 19 pm: 3f7f
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
>ACL data: handle 0x0028 flags 0x02 dlen 17
    L2CAP(d): cid 0x41 len 13 [psm 1]
        SDP SS Req: tid 0x12 len 0x8
          pat uuid-16 0x1108 (Headset)
          max 0xff
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x41 len 14 [psm 1]
        SDP SS Rsp: tid 0x12 len 0x9
          cur 0x1 tot 0x1 hndl 0x804f6e8
          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 21
    L2CAP(d): cid 0x41 len 17 [psm 1]
        SDP SA Req: tid 0x13 len 0xc
          hndl 0x804f6e8
          max 0xff
          aid(s) 0x0302 ((null))
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 1]
        SDP SA Rsp: tid 0x13 len 0x5
          cnt 0x2

          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
>ACL data: handle 0x0028 flags 0x02 dlen 31
    L2CAP(d): cid 0x41 len 27 [psm 1]
        SDP SS Req: tid 0x14 len 0x16
          pat uuid-128 0x5555
          max 0xff
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 1]
        SDP SS Rsp: tid 0x14 len 0x5
          cur 0x0 tot 0x0
          cont 00
>HCI Event: Number of Completed Packets(0x13) plen 5
>ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
>HCI Event: Number of Completed Packets(0x13) plen 5
>HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>HCI Event: Command Status(0x0f) plen 4
>HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
>HCI Event: Max Slots Change(0x1b) plen 3
>HCI Event: Command Status(0x0f) plen 4
>HCI Event: Connection Packet Type Changed(0x1d) plen 5
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
...
...
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>SCO data: handle 0x002b dlen 144
>HCI Event: Disconn Complete(0x05) plen 4
>SCO data: handle 0x002b dlen 144
< HCI Command: Reset(0x03|0x0003) plen 0
Receive failed: Broken pipe


After a while i receve broken pipe.
I don't no what is happen, any idea.
Sorry about the long e-mail.
Thanks

João Santos

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail
