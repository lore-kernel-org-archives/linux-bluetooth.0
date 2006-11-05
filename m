Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <454DCE75.40205@lmv.me.uk>
Date: Sun, 05 Nov 2006 11:43:49 +0000
From: Leon Verrall <leon@lmv.me.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] ALSA Sound output blocks with btsco and Jabra 250V
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Guys,

Wonder if you can spot what I'm doing wrong. OS is Kubuntu 6.10 (Edgy) on 
amd64. have btsco, bluez etc from that distro:

ii  alsa-base           1.0.11-5ubuntu1 ALSA driver configuration files
ii  alsa-oss            1.0.11-1        ALSA wrapper for OSS applications
ii  alsa-utils          1.0.11-6ubuntu2 ALSA utilities
ii  bluez-btsco         0.42-0ubuntu1   Bluez Bluetooth SCO tool
ii  bluez-btsco         0.42-0ubuntu1   Bluez Bluetooth SCO tool
ii  bluez-cups          3.7-1ubuntu4    Bluetooth printer driver for CUPS
ii  bluez-hcidump       1.32-1          Analyses Bluetooth HCI packets
ii  bluez-utils         3.7-1ubuntu4    Bluetooth tools and daemons

USB dongle is this:

hci0:   Type: USB
         BD Address: 00:02:72:??:??:?? ACL MTU: 192:8 SCO MTU: 64:8
         HCI 16.4
         Chip version: BlueCore02-External
         Max key size: 56 bit
         SCO mapping:  HCI


I've modprobe'd snd_bt_sco, paired my jabra 250v and told rfcomm to provide 
a permanent binding:

rfcomm0: 00:07:A4:??:??:?? channel 1 clean

Run up btsco -v and see this:

leon@robin:~$ btsco 00:07:a4:??:??:?? -v
btsco v0.42
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0
speaker volume: 11 mic volume: 11
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=11
Sending up speaker change 11
speaker volume: 11 mic volume: 11

when running:

aplay -D plughw:Headset /opt/media/sounds/okman.wav
Playing WAVE '/opt/media/sounds/okman.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono

or mplayer:

mplayer -ao alsa:device=hw=1.0 some.mp3

...
alsa-init: 1 soundcard found, using: hw:1,0
alsa: 8000 Hz/1 channels/2 bpf/32768 bytes buffer/Signed 16 bit Little Endian
AO: [alsa] 8000Hz 1ch s16le (2 bytes per sample)
Building audio filter chain for 44100Hz/2ch/s16le -> 8000Hz/1ch/s16le...
Video: no video
Starting playback...
A:   0.0 (unknown) of 257.0 (04:17.0)  1.0%

and blocks here...

If I change the speaker/mic volumes with the headset or alsamixer it works. 
The call button generates an AT exchange as well but whatever opens the alsa 
device simply blocks. fuser of the /dev/snd device shows the app has it 
open. The connection stays open to the headset until I kill whatever's using 
the alsa device and then it drops. So basically working perfectly... except 
no audio data gets passsed by the driver to the headset.

The ubuntu kernel seems to include the sco_mtu patch...

Any help appreciated. Must be something obvious I've missed as others seem 
to report the Jabra works OK and this Bluetooth dongle's pretty flawless.

Leon

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
