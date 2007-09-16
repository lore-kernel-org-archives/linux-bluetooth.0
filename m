Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ee63ef30709161045u6e91123fj39996e9797c8f039@mail.gmail.com>
Date: Sun, 16 Sep 2007 12:45:10 -0500
From: "Brandon Casey" <drafnel@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] a2dp not working in stereo and minor patch
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

I have a Sony DRBT21G and I have high quality audio working.
I am using bluez-3.18 libs and utils.

But, I am only getting mono sound. Stereo is not working. Here is an
example running mpg123-alsa...

$ mpg123-alsa -v -a bluetooth test.mp3
Playing MPEG stream 1 of 1: 06 Money.mp3 ...

        Title:   Money
        Artist:  Pink Floyd
        Album:   The Dark Side of the Moon [SACD]
        Year:    2003
        Genre:   Rock
        Comment:

MPEG 1.0, Layer: III, Freq: 44100, mode: Joint-Stereo, modext: 0, BPF : 835
Channels: 2, copyright: No, original: No, CRC: No, emphasis: 0.
Bitrate: 256 kbits/s Extension value: 0
Audio: 1:1 conversion, rate: 44100, encoding: signed 16 bit, channels: 1


This last line seems to indicate that the audio is being converted to
1 channel. The missing stereo separation is particularly noticeable in
this song since the beginning starts out with cash register sounds
alternating from one ear to the other.

Similarly, mplayer prints out these lines for an mpg file:
Forced audio codec: mad
Opening audio decoder: [libmad] libmad mpeg audio decoder
AUDIO: 48000 Hz, 2 ch, s16le, 128.0 kbit/8.33% (ratio: 16000->192000)
Selected audio codec: [mad] afm: libmad (libMAD MPEG layer 1-2-3)
==========================================================================
AO: [alsa] 44100Hz 1ch s16le (2 bytes per sample)


my .asoundrc has:
pcm.bluetooth {
    type bluetooth
    device 00:13:A9:C5:20:32
    profile hifi
    mode stereo
#    subbands "8"
#    blocks "16"
#    bitpool "250"
#    allocation snr
#    rate "44100"
}

There was a bug in pcm_bluetooth.c that prevented mode from being
parsed properly, a patch is attached at the end of this email.

Here is some of the hcidump:
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
        ACP SEID 2 - Audio Sink
< ACL data: handle 1 flags 0x02 dlen 7
    L2CAP(d): cid 0x0052 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 1
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 1
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-53
        Content Protection
          02 00
< ACL data: handle 1 flags 0x02 dlen 7
    L2CAP(d): cid 0x0052 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 2
        ACP SEID 2
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 2
        Media Transport
        Media Codec - MPEG-1,2 Audio
          3F 07 FF FE
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0052 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 3
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz
          JointStereo
          16 Blocks
          8 Subbands
          Loudness
          Bitpool Range 2-53
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 3
< ACL data: handle 1 flags 0x02 dlen 7
    L2CAP(d): cid 0x0052 len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 4
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 4
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0053 flags 0x00 clen 0
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 895
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0053 flags 0x00 result 0 clen 4
      Success
      MTU 895
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 7
    L2CAP(d): cid 0x0052 len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 5
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 5
< ACL data: handle 1 flags 0x02 dlen 7


As you can see, these headphones also support mpeg codec.

I don't know if I am reading that dump correctly, but it looks like
joint-stereo is being selected every time regardless of what mode is
set to in .asoundrc

Any help is appreciated,
-brandon


--- pcm_bluetooth.c_orig        2007-09-15 03:46:30.000000000 -0500
+++ pcm_bluetooth.c     2007-09-15 03:48:06.000000000 -0500
@@ -995,15 +995,15 @@
                                return -EINVAL;
                        }

-                       if (strcmp(pref, "auto") == 0)
+                       if (strcmp(mode, "auto") == 0)
                                cfg->mode = CFG_MODE_AUTO;
-                       else if (strcmp(pref, "mono") == 0)
+                       else if (strcmp(mode, "mono") == 0)
                                cfg->mode = CFG_MODE_MONO;
-                       else if (strcmp(pref, "dual") == 0)
+                       else if (strcmp(mode, "dual") == 0)
                                cfg->mode = CFG_MODE_DUAL_CHANNEL;
-                       else if (strcmp(pref, "stereo") == 0)
+                       else if (strcmp(mode, "stereo") == 0)
                                cfg->mode = CFG_MODE_STEREO;
-                       else if (strcmp(pref, "joint") == 0)
+                       else if (strcmp(mode, "joint") == 0)
                                cfg->mode = CFG_MODE_JOINT_STEREO;
                        continue;
                }
@@ -1014,11 +1014,11 @@
                                return -EINVAL;
                        }

-                       if (strcmp(pref, "auto") == 0)
+                       if (strcmp(allocation, "auto") == 0)
                                sbc->allocation = CFG_ALLOCATION_AUTO;
-                       else if (strcmp(pref, "loudness") == 0)
+                       else if (strcmp(allocation, "loudness") == 0)
                                sbc->allocation = CFG_ALLOCATION_LOUDNESS;
-                       else if (strcmp(pref, "snr") == 0)
+                       else if (strcmp(allocation, "snr") == 0)
                                sbc->allocation = CFG_ALLOCATION_SNR;
                        continue;
                }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
