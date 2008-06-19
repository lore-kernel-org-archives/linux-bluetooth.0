Return-Path: <cyrus@holtmann.org>
Message-ID: <011601c8d1e5$cef11080$6e01a8c0@Raymondpc>
From: "colorant" <colorant@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Date: Thu, 19 Jun 2008 16:23:52 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-users] When Connect A2DP : Error 22 while configuring
	device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

And following  is the output from HCIDUMP :

> Hi
>
>    I am try to connect A2DP with Bluez
>
>    When useing Aplay to try it , I have following problems :
>
> ~ # aplay -D bluetooth demo.wav
> ALSA lib pcm_bluetooth.c:1158:(bluetooth_cfg) Error 22 while configuring 
> device
> aplay: main:510: audio open error: Invalid argument
>
> Can Someone point out what might be the reason ?
>



~ # aplay -D bluetooth demo.wav
< HCI Command: Create Connection (0x01|0x0005) plen 13
  26 00 B0 72 02 00 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete (0x03) plen 11
  00 2A 00 26 00 B0 72 02 00 01 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  2A 00
> HCI Event: Command Status (0x0f) plen 4
  00 00 1B 04
> HCI Event: Max Slots Change (0x1b) plen 3
  2A 00 05
> HCI Event: Command Status (0x0f) plen 4
  00 01 00 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  2A 00 0F 00
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 2A 00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  26 00 B0 72 02 00 02 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 19 04
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  00 2A 00 FF FF 05 38 18 18 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 0
> HCI Event: Remote Name Req Complete (0x07) plen 255
  00 26 00 B0 72 02 00 52 61 79 6D 6F 6E 64 2D 70 63 00 00 00
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
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 4
      Success
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0043 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1203 (Audio)
          max 64
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x5
          count 0
          cont 00
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0043 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x110d (AdvAudio)
          max 64
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0043 len 13 [psm 1]
        SDP SS Req: tid 0x2 len 0x8
          pat uuid-16 0x110e (AVRemote)
          max 64
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x2 len 0x9
          count 1
          handle 0x1000d
          cont 00
< ACL data: handle 42 flags 0x02 dlen 23
    L2CAP(d): cid 0x0043 len 19 [psm 1]
        SDP SA Req: tid 0x3 len 0xe
          handle 0x1000d
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 94
    L2CAP(d): cid 0x0040 len 90 [psm 1]
        SDP SA Rsp: tid 0x3 len 0x55
          count 82
          aid 0x0000 (SrvRecHndl)
             uint 0x1000d
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x110c (AVRemTarget) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
             uuid-16 0x0017 (AVCTP) uint 0x100 > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0006 (LangBaseAttrIDList)
             < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0008 (SrvAvail)
             uint 0xff
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x110e (AVRemote) uint 0x100 uint 0xf00 > >
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0040
ALSA lib pcm_bluetooth.c:1158:(bluetooth_cfg) Error 22 while configuring 
device
aplay: main:510: audio open error: Invalid argument
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
~ #
~ # > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  2A 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 2A 00 16


Raymond






-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
