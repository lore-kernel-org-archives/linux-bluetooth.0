Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Message-ID: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Subject: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
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
Date: Thu, 25 Nov 2004 18:11:24 +0900


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello guys,

I just decided to try a2play&co with my old Toshiba AV Headset
(pretty old actually, bought that I think maybe at least 1 year ago,
it was an option of Dynabook serie).

Well, it didn't work well, it seems to fail during the connection/configuration
phase. Since I never heared you speaking about this headset I think you
might be interested in the several log I took (just ask me if you want
some other info).

I divided, sox, sbcenc, a2play into 3 steps so that's why the command
line take a .sbc file.

[alain@rillette btsco]$ ./a2play 08:00:46:A4:C5:C3 Treasure_01.sbc 
subbands = 1
allocation method = 1
channel_mode = 2
blocks = 3
sampling frequency = 2
bitpool = 32
frame len = 72
Using address: 08:00:46:A4:C5:C3
Found A2DP Sink
Connected [imtu 672, omtu 2048, flush_to 65535]
seid = 1
got capabilities response
sent set_config
set config rejected
couldn't get stream psm

I also attach two logs I took with hcidump, the first time with
hcidump and the second time in RAW dump (hcidump --raw).

sorry I don't plan to jump into the code to see what's wrong but
if I can be of any help (testing/sending logs .... ) please let me
know.

Alain

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dump_sr-1.1"

HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024 
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110d (AdvAudio)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 31
    L2CAP(d): cid 0x0040 len 112 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x6b
          cnt 0x68
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10001
            aid 0x0001 (SrvClassIDList)
               < uuid-16 0x110b (AudioSink) >
            aid 0x0002 (SrvRecState)
               uint 0x8
            aid 0x0004 (ProtocolDescList)
               < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
               uuid-16 0x0019 (AVDTP) uint 0x100 > >
            aid 0x0005 (BrwGrpList)
               < uuid-16 0x1002 (PubBrwsGrp) >
            aid 0x0006 (LangBaseAttrIDList)
               < uint 0x656e uint 0x6a uint 0x100 >
            aid 0x0008 (SrvAvail)
               uint 0xff
            aid 0x0009 (BTProfileDescList)
               < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
            aid 0x0100 (SrvName)
               str "Audio Sink"

          cont 00 
< ACL data: handle 0x0028 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          cnt 0x2
          cont 00 
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 2048 
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 25]
      AVDTP(s): Discover rfa: transaction 0
< ACL data: handle 0x0028 flags 0x02 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 20
    L2CAP(d): cid 0x0041 len 16 [psm 25]
      AVDTP(s): Capabilities rfa: transaction 0
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 25]
      AVDTP(s): Set config rfa: transaction 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dump_sr-1.1-raw"

HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< 01 05 04 0D C3 C5 A4 46 00 08 18 CC 02 00 00 00 01 
> 04 0F 04 00 01 05 04 
> 04 03 0B 00 28 00 C3 C5 A4 46 00 08 01 00 
< 02 28 20 0C 00 08 00 01 00 02 01 04 00 01 00 40 00 
> 04 13 05 01 28 00 01 00 
> 04 20 07 C3 C5 A4 46 00 08 01 
> 04 1B 03 28 00 05 
> 02 28 20 10 00 0C 00 01 00 03 01 08 00 40 00 40 00 00 00 00 
  00 
< 02 28 20 0C 00 08 00 01 00 04 02 04 00 40 00 00 00 
> 04 13 05 01 28 00 01 00 
> 02 28 20 0E 00 0A 00 01 00 05 02 06 00 40 00 00 00 00 00 
> 02 28 20 10 00 0C 00 01 00 04 09 08 00 40 00 00 00 01 02 00 
  04 
< 02 28 20 0E 00 0A 00 01 00 05 09 06 00 40 00 00 00 00 00 
< 02 28 20 18 00 14 00 40 00 06 00 00 00 0F 35 03 19 11 0D FF 
  FF 35 05 0A 00 00 FF FF 00 
> 04 13 05 01 28 00 01 00 
> 04 13 05 01 28 00 01 00 
> 02 28 20 11 00 70 00 40 00 07 00 00 00 6B 00 68 35 66 35 64 
  09 00 
> 02 28 10 11 00 00 0A 00 01 00 01 09 00 01 35 03 19 11 0B 09 
  00 02 
> 02 28 10 11 00 0A 00 00 00 08 09 00 04 35 10 35 06 19 01 00 
  09 00 
> 02 28 10 11 00 19 35 06 19 00 19 09 01 00 09 00 05 35 03 19 
  10 02 
> 02 28 10 11 00 09 00 06 35 09 09 65 6E 09 00 6A 09 01 00 09 
  00 08 
> 02 28 10 11 00 08 FF 09 00 09 35 08 35 06 19 11 0D 09 01 00 
  09 01 
> 02 28 10 0E 00 00 25 0A 41 75 64 69 6F 20 53 69 6E 6B 00 
< 02 28 20 18 00 14 00 40 00 06 00 01 00 0F 35 03 19 12 00 FF 
  FF 35 05 0A 00 00 FF FF 00 
> 04 13 05 01 28 00 01 00 
> 02 28 20 0E 00 0A 00 40 00 07 00 01 00 05 00 02 35 00 00 
< 02 28 20 0C 00 08 00 01 00 06 03 04 00 40 00 40 00 
< 02 28 20 0C 00 08 00 01 00 02 04 04 00 19 00 41 00 
> 04 13 05 01 28 00 01 00 
> 04 13 05 01 28 00 01 00 
> 02 28 20 0C 00 08 00 01 00 07 03 04 00 40 00 40 00 
> 02 28 20 10 00 0C 00 01 00 03 04 08 00 40 00 41 00 00 00 00 
  00 
< 02 28 20 0C 00 08 00 01 00 04 05 04 00 40 00 00 00 
> 04 13 05 01 28 00 01 00 
> 02 28 20 0E 00 0A 00 01 00 05 05 06 00 41 00 00 00 00 00 
> 02 28 20 10 00 0C 00 01 00 04 0A 08 00 41 00 00 00 01 02 00 
  08 
< 02 28 20 0E 00 0A 00 01 00 05 0A 06 00 40 00 00 00 00 00 
< 02 28 20 06 00 02 00 40 00 00 01 
> 04 13 05 01 28 00 01 00 
> 04 13 05 01 28 00 01 00 
> 02 28 20 0C 00 08 00 41 00 02 01 04 08 0C 08 10 00 
< 02 28 20 07 00 03 00 40 00 10 02 04 
> 04 13 05 01 28 00 01 00 
> 02 28 20 14 00 10 00 41 00 12 02 01 00 07 06 00 00 3F FF 04 
  40 04 02 02 00 
< 02 28 20 12 00 0E 00 40 00 20 03 04 04 01 00 07 06 00 00 22 
  16 02 FA 
> 04 13 05 01 28 00 01 00 
> 02 28 20 08 00 04 00 41 00 23 03 07 CC 
< 02 28 20 0C 00 08 00 01 00 06 06 04 00 40 00 41 00 
> 04 13 05 01 28 00 01 00 
> 02 28 20 0C 00 08 00 01 00 07 06 04 00 40 00 41 00 
< 01 06 04 03 28 00 13 
> 04 0F 04 00 01 06 04 
> 04 05 04 00 28 00 16 

--DocE+STaALJfprDB--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
