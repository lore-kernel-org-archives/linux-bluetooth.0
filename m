Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: "Malte J. Wetz" <bluez-users-mlist@malte-wetz.de>
Date: Thu, 3 Jul 2008 02:37:57 +0200
MIME-Version: 1.0
Message-Id: <200807030237.57723.bluez-users-mlist@malte-wetz.de>
Subject: [Bluez-users] Headset not working (was: Belkin USB-Dongle blocks
	USB subsystem)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Am Montag, 30. Juni 2008 schrieb Martin Mueller:
> I have the same dongle and it's incorrctly indentified as "peagsus
> 100Mbit/s Ethernet". Just add the line:
>
> blacklist pegasus

Thanks for that info. It brought me one step closer to getting the stick to =

work. Now, everything appears to work. But the Belkin dongle behaves =

exactly like the MSI dongle: It does not record or playback anything when =

paired with my bluetooth headset (Jabra BT 205).

With my old Logitech MX 900, I used btsco which emulates a soundcard and =

everthing was fine. With the MSI or Belkin dongles, neither btsco nor the =

newer alsa plugin method work.


Ok, first the "deprecated" method with btsco (with correct BT address of =

course):


root@triton:~# btsco -v -r XX:XX:XX:XX:XX:XX
btsco v0.42
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0

Then I start audacity, select =BBALSA: BT Headset: BT SCO PCM (hw:2,0)=AB a=
ls =

input source. I set the project frequency to 8000 Hz and hit the "Record" =

button. I new audio track appears, but the marker indicating the current =

position does not move. It just stays frozen at 0.0 on the timeline.
The btsco-Output is full of connection timeouts:

i/o needed: connecting sco...
Can't connect SCO audio channel
: Connection timed out
speaker volume: 11 mic volume: 14
recieved AT+VGS=3D11
Sending up speaker change 11
speaker volume: 11 mic volume: 14
i/o needed: connecting sco...
Can't connect SCO audio channel
: Connection timed out
speaker volume: 11 mic volume: 14

The syslog says:

Jul  2 15:49:31 triton kernel: hci_scodata_packet: hci0 SCO packet for =

unknown connection handle 1
Jul  2 15:50:01 triton last message repeated 9996 times


Now the "new" method via alsa:

This is my ~/.asoundrc:

pcm.headset { =

        type bluetooth
        device XX:XX:XX:XX:XX:XX
        profile "sco"
} =

 =

ctl.headset { =

        type bluetooth =

} =


I also tried "auto" as profile above, doesn't change anything. Now, I want =

to use mplayer to play back a mp3 file using the headset.

mjw@triton:~$ mplayer -ao 'alsa:device=3Dheadset' test.mp3                 =
       =

MPlayer 1.0rc2-4.2.3 (C) 2000-2007 MPlayer Team
CPU: AMD Athlon(tm) 64 X2 Dual Core Processor 6400+ (Family: 15, Model: 67, =

Stepping: 3)
CPUflags:  MMX: 1 MMX2: 1 3DNow: 1 3DNow2: 1 SSE: 1 SSE2: 1
Compiled with runtime CPU detection.
mplayer: could not connect to socket
mplayer: No such file or directory
Failed to open LIRC support. You will not be able to use your remote =

control.

Playing test.mp3.
Audio file file format detected.
Clip info:
 Title: =

 Artist: =

 Album: =

 Year: 0
 Comment: =

 Track: =

 Genre: Unknown
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Forced audio codec: mad
Opening audio decoder: [libmad] libmad mpeg audio decoder
AUDIO: 44100 Hz, 2 ch, s16le, 128.0 kbit/9.07% (ratio: 16000->176400)
Selected audio codec: [mad] afm: libmad (libMAD MPEG layer 1-2-3)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


And there it remains without anything happening. As you might have guessed, =

the syslog looks similar:

Jul  2 15:53:20 triton kernel: hci_scodata_packet: hci0 SCO packet for =

unknown connection handle 1
Jul  2 15:53:40 triton last message repeated 6565 times
Jul  2 15:53:40 triton kernel: hcid[2999]: segfault at 8 ip b7db5e0e sp =

bfae8090 error 6 in libaudio.so[b7dae000+19000]
Jul  2 15:53:40 triton kernel: hci_scodata_packet: hci0 SCO packet for =

unknown connection handle 1


I checked both dongles under Windows XP. The MSI dongle comes with the =

BlueSoleil stack, the Belkin dongle with the Widcomm stack. Both work =

perfectly. So I think there's nothing wrong with the hardware itself.

I googled for the syslog error above and found this patch: =

http://lkml.org/lkml/2008/2/27/105
It does fix the error message itself, but the headset still does not work. =


Last lines of mplayer-Output:

AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)
Video: no video
Starting playback...
A:   1.0 (01.0) of 293.0 (04:53.0)  0.9%

And there it freezes. This time, syslog says for btsco:

Jul  2 16:10:18 triton kernel: snd-bt-sco revision 1.19 $
Jul  2 16:10:18 triton kernel: snd-bt-sco: snd-bt-scod thread starting
Jul  2 16:10:22 triton hcid[6279]: link_key_request (sba=3DYY:YY:YY:YY:YY:Y=
Y, =

dba=3DXX:XX:XX:XX:XX:XX)
Jul  2 16:10:34 triton hcid[6279]: Audio API: received =

BT_GETCAPABILITIES_REQ
Jul  2 16:10:53 triton hcid[6279]: Audio API: sending BT_GETCAPABILITIES_RSP
Jul  2 16:10:53 triton hcid[6279]: Audio API: received =

BT_SETCONFIGURATION_REQ
Jul  2 16:10:53 triton hcid[6279]: config sco - device =3D XX:XX:XX:XX:XX:X=
X =

access_mode =3D 2
Jul  2 16:11:01 triton ntpd[4908]: synchronized to 192.168.0.1, stratum 2
Jul  2 16:11:01 triton ntpd[4908]: kernel time sync status change 0001
Jul  2 16:11:36 triton kernel: snd-bt-sco: playback_open
Jul  2 16:11:36 triton kernel: snd-bt-sco: prepare ok bps: 16000 size: 3276=
8 =

count: 2048
Jul  2 16:11:36 triton kernel: Bluetooth: SCO (Voice Link) ver 0.5
Jul  2 16:11:36 triton kernel: Bluetooth: SCO socket layer initialized
Jul  2 16:11:36 triton kernel: snd-bt-sco: playback_trigger 1
Jul  2 16:11:36 triton kernel: snd-bt-sco: setting playback to bspcm
Jul  2 16:12:38 triton kernel: snd-bt-sco: playback_trigger 0
Jul  2 16:12:38 triton kernel: snd-bt-sco: setting playback to NULL
Jul  2 16:12:38 triton kernel: snd-bt-sco: Disposing of previous socket =

count 3
Jul  2 16:12:38 triton kernel: snd-bt-sco: file_count is 1 (expected 3)


And for the ALSA plugin:

Jul  2 16:16:02 triton hcid[9056]: Audio API: received =

BT_GETCAPABILITIES_REQ
Jul  2 16:16:02 triton hcid[9056]: Audio API: sending BT_GETCAPABILITIES_RSP
Jul  2 16:16:02 triton hcid[9056]: Audio API: received =

BT_SETCONFIGURATION_REQ
Jul  2 16:16:02 triton hcid[9056]: config sco - device =3D XX:XX:XX:XX:XX:X=
X =

access_mode =3D 2
Jul  2 16:16:05 triton hcid[9056]: link_key_request (sba=3DYY:YY:YY:YY:YY:Y=
Y, =

dba=3DXX:XX:XX:XX:XX:XX)
Jul  2 16:16:08 triton hcid[9056]: SCO fd=3D25
Jul  2 16:16:08 triton hcid[9056]: Audio API: sending =

BT_SETCONFIGURATION_RSP
Jul  2 16:16:08 triton hcid[9056]: Audio API: received BT_STREAMSTART_REQ
Jul  2 16:16:08 triton hcid[9056]: Audio API: sending BT_STREAMSTART_RSP
Jul  2 16:16:08 triton hcid[9056]: Audio API: sending BT_STREAMFD_IND
Jul  2 16:17:28 triton hcid[9056]: Audio API: received BT_STREAMSTART_REQ
Jul  2 16:17:28 triton hcid[9056]: Audio API: sending BT_STREAMSTART_RSP
Jul  2 16:17:28 triton hcid[9056]: Audio API: sending BT_STREAMFD_IND
Jul  2 16:18:08 triton hcid[9056]: Audio API: received BT_STREAMSTART_REQ
Jul  2 16:18:08 triton hcid[9056]: Audio API: sending BT_STREAMSTART_RSP
Jul  2 16:18:08 triton hcid[9056]: Audio API: sending BT_STREAMFD_IND
Jul  2 16:18:48 triton hcid[9056]: Audio API: received BT_STREAMSTART_REQ
Jul  2 16:18:48 triton hcid[9056]: Audio API: sending BT_STREAMSTART_RSP
Jul  2 16:18:48 triton hcid[9056]: Audio API: sending BT_STREAMFD_IND

Note that in the last section, there are always three messages grouped =

together. Everytime one of these triplets is logged, mplayer advances a =

little bit on the playback (steps: 0.1%, 1.2%, 2.4%, and so on) and then =

blocks again until the next triplet shows up.


I would really like to get at least one method working but I don't even hav=
e =

an error message to feed to google. Any ideas on this one?

-- =

Malte J. Wetz  <mail@malte-wetz.de>
Homepage: www.malte-wetz.de (PGP/GPG Keys available on homepage)

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
