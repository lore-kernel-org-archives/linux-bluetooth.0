Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3837d8b10608020729i5bab5ea6vbc18b0ad502b11de@mail.gmail.com>
Date: Wed, 2 Aug 2006 09:29:21 -0500
From: "keith preston" <keithpre@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44D0350A.8090904@xmission.com>
MIME-Version: 1.0
References: <002a01c6b5e5$5e6b0cd0$9d0cc70a@dlh.st.com>
	<44D0350A.8090904@xmission.com>
Subject: Re: [Bluez-devel] Bluetooth Headset Error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0122632812=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0122632812==
Content-Type: multipart/alternative;
	boundary="----=_Part_60887_6175722.1154528961945"

------=_Part_60887_6175722.1154528961945
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>> Sample Rate:44100
>> Channels:1
>
>try something in stereo just in case we don't set things right for mono.

I tried a stereo file and now it works!   This is great, I am going to try
it on my arm platform as that it the current target.  Just for information
here is the dump of hcidump when it works

preston@ubuntu:~/bluetooth/btsco$ sudo hcidump -x HCI sniffer - Bluetooth
packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff < HCI Command: Create
Connection (0x01|0x0005) plen 13
  50 C4 6F 44 0D 00 18 CC 02 00 00 00 01  > HCI Event: Command Status (0x0f)
plen 4
  00 01 05 04
 > HCI Event: Role Change (0x12) plen 8
  00 50 C4 6F 44 0D 00 01
 > HCI Event: Link Key Request (0x17) plen 6
  50 C4 6F 44 0D 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  50 C4 6F 44 0D 00 56 A7 10 D6 FD 73 21 EF B9 98 7F 4F D5 2E
  3C 6A
 > HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 50 C4 6F 44 0D 00
 > HCI Event: Connect Complete (0x03) plen 11
  00 29 00 50 C4 6F 44 0D 00 01 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040  > HCI Event: Page Scan
Repetition Mode Change (0x20) plen 7
  50 C4 6F 44 0D 00 01
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006e scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006e flags 0x00 clen 0  > ACL data: handle
41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 < ACL data: handle
41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006e flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
< ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x006e len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 131
    L2CAP(d): cid 0x0040 len 127 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x7a
          count 119
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x1
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110b (AudioSink) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
                 uuid-16 0x0019 (AVDTP) uint 0x100 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "stereo headphone"
              aid 0x0102 (ProviderName)
                 str "impulse"
              aid 0x0311 (unknown)
                 uint 0x1
          cont 00
< ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x006e len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x006e scid 0x0040 < ACL data: handle 41
flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041  > HCI Event: Number of
Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x006e scid 0x0040  > HCI Event: Number of
Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006f scid 0x0041 result 1 status 0
      Connection pending - No futher information available  > ACL data:
handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006f scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006f flags 0x00 clen 0  > ACL data: handle
41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0 < ACL data: handle
41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006f flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0070 < ACL data: handle 41 flags
0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0070 result 2 status 0
      Connection refused - PSM not supported  > ACL data: handle 41 flags
0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0 < ACL data: handle 41 flags 0x02
dlen 6
    L2CAP(d): cid 0x006f len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0  > HCI Event: Number of
Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x006f len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 1
        ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(d): cid 0x0041 len 16 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 1
        Media Transport
        Media Codec - SBC
          44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 20-58
        Content Protection
          02 00
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x006f len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 2
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz
          Stereo
          16 Blocks
          8 Subbands
          SNR
          Bitpool Range 20-58
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 2 < ACL data: handle 41 flags
0x02 dlen 7
    L2CAP(d): cid 0x006f len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 3
        ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 3
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040  > HCI Event: Number of
Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0071 scid 0x0040 result 1 status 0
      Connection pending - No futher information available  > ACL data:
handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0071 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0071 flags 0x00 clen 0  > ACL data: handle
41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 674
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0071 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x006f len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 4
        ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0072 < ACL data: handle 41 flags
0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0072 result 2 status 0
      Connection refused - PSM not supported  > ACL data: handle 41 flags
0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 4  > HCI Event: Number of Completed
Packets (0x13) plen 5
  01 29 00 01 00
< ACL data: handle 41 flags 0x02 dlen 192 < ACL data: handle 41 flags 0x01
dlen 192 < ACL data: handle 41 flags 0x01 dlen 192 < ACL data: handle 41
flags 0x01 dlen 49
    L2CAP(d): cid 0x0071 len 621 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 1 time 0 ssrc 1
      08 9C BB 20 2D 00 00 00 00 00 00 00 00 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 9C BB 20
      2D 00 00 00 00 00 00 00 00 55 55 55 55 55 55 55 55 55 55 55

/////Packets continue from here....



>      > ACL data: handle 44 flags 0x02 dlen 12
> >         L2CAP(s): Connect req: psm 23 scid 0x0051 < ACL data: handle 44
> >     flags 0x02 dlen 16
> >         L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0051 result 2 status 0
> >           Connection refused - PSM not supported
> >     There is a connection request from the headset on PSM 23 (0x17)
> >     which is AVCTP.
> >     So probably, the headset is trying to connect on AVRCP, which we
> reject.
>
> good find here.
>
> Keith, could you run
> sdptool add AVRTG
> ./avrecv
> and see if the headset is sending avrcp messages?
>

I tried those commands and it looks like no luck.  The output is below.   A
little about the headset, it comes in a pack with a bluetooth transmitter
that hooks into the ipod nano.  The headset has controls for volume and also
for track forward and track backward.   I don't know if these commands are
part of the headset profile, so that might make this headset a bit off the
standard.

preston@ubuntu:~/bluetooth/btsco$ sdptool add AVRTG
Remote target service registered
preston@ubuntu:~/bluetooth/btsco$ ./avrecv
accepting next connection

/////  This never gets anywhere the hcidump is below.   This output happens
when I hit the connect button on the headset.


preston@ubuntu:~/bluetooth/btsco$ sudo hcidump -x
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  50 C4 6F 44 0D 00 18 04 24 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  50 C4 6F 44 0D 00 01
 > HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
 > HCI Event: Link Key Request (0x17) plen 6
  50 C4 6F 44 0D 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  50 C4 6F 44 0D 00 56 A7 10 D6 FD 73 21 EF B9 98 7F 4F D5 2E
  3C 6A
 > HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 50 C4 6F 44 0D 00
 > HCI Event: Connect Complete (0x03) plen 11
  00 29 00 50 C4 6F 44 0D 00 01 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  29 00 18 CC
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  50 C4 6F 44 0D 00 01
 > HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 29 00 18 CC
 > HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0049 < ACL data: handle 41 flags
0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0049 result 2 status 0
      Connection refused - PSM not supported  > HCI Event: Number of
Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 13




Ok, so now on to my next mission to get the alsa plugin to work.  Here is
the error I am experiencing now with the alsa plugin.


preston@ubuntu:~/bluetooth/btsco/alsa-plugins$ aplay -B 1000000 -D
pcm.headphone ~/music/41_30sec.wav
DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 0
DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50
DEBUG: a2dp_alloc: init
DEBUG: a2dp_connect: a2dp 0x8076478 (sk=0, control_sk=0)
DEBUG: connect_stream: Using address: 50:C4:6F:44:0D:00
DEBUG: detect_a2dp: retrying sdp connect: Interrupted system call
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination
DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: connect_stream: couldn't get avdtp_discover


preston@ubuntu:~/bluetooth/btsco$ sudo hcidump -x
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  50 C4 6F 44 0D 00 18 CC 01 00 89 EE 01
 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
 > HCI Event: Role Change (0x12) plen 8
  00 50 C4 6F 44 0D 00 01
 > HCI Event: Link Key Request (0x17) plen 6
  50 C4 6F 44 0D 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  50 C4 6F 44 0D 00 56 A7 10 D6 FD 73 21 EF B9 98 7F 4F D5 2E
  3C 6A
 > HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 50 C4 6F 44 0D 00
 > HCI Event: Connect Complete (0x03) plen 11
  00 29 00 50 C4 6F 44 0D 00 01 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006b scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006b flags 0x00 clen 0
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006b flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
< ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x006b len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 131
    L2CAP(d): cid 0x0040 len 127 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x7a
          count 119
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x1
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110b (AudioSink) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
                 uuid-16 0x0019 (AVDTP) uint 0x100 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "stereo headphone"
              aid 0x0102 (ProviderName)
                 str "impulse"
              aid 0x0311 (unknown)
                 uint 0x1
          cont 00
< ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x006b len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x006b scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x006b scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006c scid 0x0041 result 1 status 0
      Connection pending - No futher information available
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006c scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006c flags 0x00 clen 0
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x006c flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x006c len 3 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
      00
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x006d
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x006d result 2 status 0
      Connection refused - PSM not supported
 > ACL data: handle 41 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x006c scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x006c scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
  29 00 13
 > HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 16

------=_Part_60887_6175722.1154528961945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div style="direction: ltr;"><span class="q"><br>&gt;&gt; Sample Rate:44100<br>&gt;&gt; Channels:1<br>&gt;<br></span></div>&gt;try something in stereo just in case we don't set things right for mono.<br><br>I tried a stereo file and now it works!&nbsp;&nbsp; This is great, I am going to try it on my arm platform as that it the current target.&nbsp; Just for information here is the dump of hcidump when it works
<br><br>preston@ubuntu:~/bluetooth/btsco$ sudo hcidump -x HCI sniffer - Bluetooth packet analyzer ver 1.28<br>device: hci0 snap_len: 1028 filter: 0xffffffff &lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>&nbsp; 50 C4 6F 44 0D 00 18 CC 02 00 00 00 01&nbsp; &gt; HCI Event: Command Status (0x0f) plen 4
<br>&nbsp; 00 01 05 04<br>&nbsp;&gt; HCI Event: Role Change (0x12) plen 8<br>&nbsp; 00 50 C4 6F 44 0D 00 01<br>&nbsp;&gt; HCI Event: Link Key Request (0x17) plen 6<br>&nbsp; 50 C4 6F 44 0D 00<br>&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
<br>&nbsp; 50 C4 6F 44 0D 00 56 A7 10 D6 FD 73 21 EF B9 98 7F 4F D5 2E<br>&nbsp; 3C 6A<br>&nbsp;&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp; 01 0B 04 00 50 C4 6F 44 0D 00<br>&nbsp;&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp; 00 29 00 50 C4 6F 44 0D 00 01 00
<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040&nbsp; &gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>&nbsp; 50 C4 6F 44 0D 00 01<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&nbsp; 29 00 05<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x006e scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful
<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x006e flags 0x00 clen 0&nbsp; &gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 &lt; ACL data: handle 41 flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x006e flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 24<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006e len 20 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0xf
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x110d (AdvAudio)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 131
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 127 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x7a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 119<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x110b (AudioSink) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) uint 0x19 &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0019 (AVDTP) uint 0x100 &gt; &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x656e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x110d (AdvAudio) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;stereo headphone&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0102 (ProviderName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;impulse&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0311 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 24<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006e len 20 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 len 0xf<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1200 (PNPInfo)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 len 0x5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x006e scid 0x0040 &lt; ACL data: handle 41 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 25 scid 0x0041&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x006e scid 0x0040&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x006f scid 0x0041 result 1 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - No futher information available&nbsp; &gt; ACL data: handle 41 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x006f scid 0x0041 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x006f flags 0x00 clen 0&nbsp; &gt; ACL data: handle 41 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0 &lt; ACL data: handle 41 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x006f flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00
<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 23 scid 0x0070 &lt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0070 result 2 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - PSM not supported&nbsp; &gt; ACL data: handle 41 flags 0x02 dlen 6
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover cmd: transaction 0 &lt; ACL data: handle 41 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006f len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover cmd: transaction 0&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover rsp: transaction 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1 - Audio Sink<br>&lt; ACL data: handle 41 flags 0x02 dlen 7<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006f len 3 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Capabilities cmd: transaction 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 20<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 16 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Capabilities rsp: transaction 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Media Transport<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Media Codec - SBC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 44.1kHz 48kHz<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mono DualChannel Stereo JointStereo<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 8 12 16 Blocks<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 8 Subbands<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNR Loudness<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bitpool Range 20-58<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Content Protection<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 02 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006f len 14 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Set config cmd: transaction 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1 - INT SEID 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Media Transport<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Media Codec - SBC<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 44.1kHz<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Stereo<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 Blocks<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 Subbands<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNR<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bitpool Range 20-58<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Set config rsp: transaction 2 &lt; ACL data: handle 41 flags 0x02 dlen 7<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006f len 3 [psm 25]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Open cmd: transaction 3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 2 [psm 25]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Open rsp: transaction 3<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 25 scid 0x0040&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>
&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0071 scid 0x0040 result 1 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - No futher information available&nbsp; &gt; ACL data: handle 41 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0071 scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0071 flags 0x00 clen 0&nbsp; &gt; ACL data: handle 41 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 674<br>&lt; ACL data: handle 41 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0071 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&lt; ACL data: handle 41 flags 0x02 dlen 7<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006f len 3 [psm 25]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Start cmd: transaction 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00
<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 23 scid 0x0072 &lt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0072 result 2 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - PSM not supported&nbsp; &gt; ACL data: handle 41 flags 0x02 dlen 6
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Start rsp: transaction 4&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 192 &lt; ACL data: handle 41 flags 0x01 dlen 192 &lt; ACL data: handle 41 flags 0x01 dlen 192 &lt; ACL data: handle 41 flags 0x01 dlen 49
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0071 len 621 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(m): ver 2 cc 0 pt 1 seqn 1 time 0 ssrc 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 08 9C BB 20 2D 00 00 00 00 00 00 00 00 55 55 55 55 55 55 55<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 9C BB 20<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2D 00 00 00 00 00 00 00 00 55 55 55 55 55 55 55 55 55 55 55<br><br>/////Packets continue from here....
<br><br><br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 12<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 23 scid 0x0051 &lt; ACL data: handle 44
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; flags 0x02 dlen 16<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0051 result 2 status 0<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - PSM not supported<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; There is a connection request from the headset on PSM 23 (0x17)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; which is AVCTP.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; So probably, the headset is trying to connect on AVRCP, which we reject.<br><br>good find here.<br><br>Keith, could you run<br> sdptool add AVRTG<br> ./avrecv<br>and see if the headset is sending avrcp messages?
<br></blockquote></div><br>I tried those commands and it looks like no luck.&nbsp; The output is below. &nbsp; A little about the headset, it comes in a pack with a bluetooth transmitter that hooks into the ipod nano.&nbsp; The headset has controls for volume and also for track forward and track backward.&nbsp;&nbsp; I don't know if these commands are part of the headset profile, so that might make this headset a bit off the standard.
<br><br>preston@ubuntu:~/bluetooth/btsco$ sdptool add AVRTG <br>Remote target service registered <br>preston@ubuntu:~/bluetooth/btsco$ ./avrecv <br>accepting next connection<br><br>/////&nbsp; This never gets anywhere the hcidump is below.&nbsp;&nbsp; This output happens when I hit the connect button on the headset.
<br><br><br>preston@ubuntu:~/bluetooth/btsco$ sudo hcidump -x <br>HCI sniffer - Bluetooth packet analyzer ver 1.28<br>device: hci0 snap_len: 1028 filter: 0xffffffff&nbsp; <br>&gt; HCI Event: Connect Request (0x04) plen 10<br>&nbsp; 50 C4 6F 44 0D 00 18 04 24 01
<br>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>&nbsp; 50 C4 6F 44 0D 00 01<br>&nbsp;&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 00 01 09 04<br>&nbsp;&gt; HCI Event: Link Key Request (0x17) plen 6<br>&nbsp; 50 C4 6F 44 0D 00
<br>&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>&nbsp; 50 C4 6F 44 0D 00 56 A7 10 D6 FD 73 21 EF B9 98 7F 4F D5 2E<br>&nbsp; 3C 6A<br>&nbsp;&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp; 01 0B 04 00 50 C4 6F 44 0D 00
<br>&nbsp;&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp; 00 29 00 50 C4 6F 44 0D 00 01 00<br>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>&nbsp; 29 00 18 CC<br>&nbsp;&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
<br>&nbsp; 50 C4 6F 44 0D 00 01<br>&nbsp;&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 00 01 0F 04<br>&nbsp;&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>&nbsp; 00 29 00 18 CC<br>&nbsp;&gt; HCI Event: Max Slots Change (0x1b) plen 3
<br>&nbsp; 29 00 05<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 25 scid 0x0049 &lt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0049 result 2 status 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - PSM not supported&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp; 00 29 00 13<br><br><br><br><br>Ok, so now on to my next mission to get the alsa plugin to work.&nbsp; Here is the error I am experiencing now with the alsa plugin.
<br><br><br>preston@ubuntu:~/bluetooth/btsco/alsa-plugins$ aplay -B 1000000 -D pcm.headphone ~/music/41_30sec.wav<br>DEBUG: _snd_pcm_a2dp_open: name pcm.headphone mode 0<br>DEBUG: _snd_pcm_a2dp_open: bdaddr/dest is 00:0D:44:6F:C4:50
<br>DEBUG: a2dp_alloc: init<br>DEBUG: a2dp_connect: a2dp 0x8076478 (sk=0, control_sk=0)<br>DEBUG: connect_stream: Using address: 50:C4:6F:44:0D:00<br>DEBUG: detect_a2dp: retrying sdp connect: Interrupted system call<br>DEBUG: detect_a2dp: Found A2DP Sink
<br>DEBUG: connect_stream: Found A2DP Sink at the destination<br>DEBUG: do_connect: Connected [imtu 672, omtu 672, flush_to 65535]<br>DEBUG: connect_stream: Sent the Stream End Point Discovery Command<br>DEBUG: connect_stream: couldn't get avdtp_discover
<br><br><br>preston@ubuntu:~/bluetooth/btsco$ sudo hcidump -x<br>HCI sniffer - Bluetooth packet analyzer ver 1.28<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13
<br>&nbsp; 50 C4 6F 44 0D 00 18 CC 01 00 89 EE 01<br>&nbsp;&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 00 01 05 04<br>&nbsp;&gt; HCI Event: Role Change (0x12) plen 8<br>&nbsp; 00 50 C4 6F 44 0D 00 01<br>&nbsp;&gt; HCI Event: Link Key Request (0x17) plen 6
<br>&nbsp; 50 C4 6F 44 0D 00<br>&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>&nbsp; 50 C4 6F 44 0D 00 56 A7 10 D6 FD 73 21 EF B9 98 7F 4F D5 2E<br>&nbsp; 3C 6A<br>&nbsp;&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp; 01 0B 04 00 50 C4 6F 44 0D 00<br>&nbsp;&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp; 00 29 00 50 C4 6F 44 0D 00 01 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&nbsp; 29 00 05<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x006b scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful
<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x006b flags 0x00 clen 0<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0<br>&lt; ACL data: handle 41 flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x006b flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 24<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006b len 20 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0xf
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x110d (AdvAudio)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 131
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 127 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x7a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 119<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x110b (AudioSink) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) uint 0x19 &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0019 (AVDTP) uint 0x100 &gt; &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x656e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x110d (AdvAudio) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;stereo headphone&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0102 (ProviderName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;impulse&quot;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0311 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 24<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006b len 20 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 len 0xf<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1200 (PNPInfo)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 14
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 len 0x5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x006b scid 0x0040
<br>&lt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 25 scid 0x0041<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x006b scid 0x0040<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x006c scid 0x0041 result 1 status 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - No futher information available<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x006c scid 0x0041 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&lt; ACL data: handle 41 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x006c flags 0x00 clen 0<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0<br>&lt; ACL data: handle 41 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x006c flags 0x00 result 0 clen 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success
<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&lt; ACL data: handle 41 flags 0x02 dlen 7<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x006c len 3 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover cmd: transaction 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 23 scid 0x006d<br>&lt; ACL data: handle 41 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x006d result 2 status 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - PSM not supported<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover cmd: transaction 0<br>&lt; ACL data: handle 41 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x006c scid 0x0041<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>
&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 29 00 01 00<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover rsp: transaction 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1 - Audio Sink
<br>&nbsp;&gt; ACL data: handle 41 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x006c scid 0x0041<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>&nbsp; 29 00 13<br>&nbsp;&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 00 01 06 04<br>&nbsp;&gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp; 00 29 00 16<br><br><br><br><br>

------=_Part_60887_6175722.1154528961945--


--===============0122632812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0122632812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0122632812==--
