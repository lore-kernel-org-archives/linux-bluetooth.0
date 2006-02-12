Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43EEAFA9.5050704@blueyonder.co.uk>
From: Sid Boyce <sboyce@blueyonder.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <43E41B2A.90605@blueyonder.co.uk>
In-Reply-To: <43E41B2A.90605@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Re: Still silent Nokia HDW-3 headset
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
Date: Sun, 12 Feb 2006 03:46:49 +0000

Broadcom chipset based dongle was the problem, replaced with a CSR 
chipset based dongle by Fresh Accessories, audio works fine, even with 
Skype.
Regards
Sid.

Sid Boyce wrote:
> Kmix does not see the mixer controls, qamix sees the card but controls 
> are empty, gnome-volume-control sees both alsa and oss mixers, but 
> setting them full on doesn't make a difference ... they are not muted.
> No sound either on record or playback.
> I'm quite mystified. All the data I can think of set out below.
> I need to hunt down the "pskey command", haven't found it in CVS or 
> anywhere else.
> Regards
> Sid.
> 
> snd_bt_sco             15756  1
> snd_pcm                86408  6 
> snd_emu10k1,snd_bt_sco,snd_pcm_oss,snd_intel8x0,snd_ac97_codec,snd_usb_audio 
> 
> snd_page_alloc         10376  4 snd_emu10k1,snd_bt_sco,snd_intel8x0,snd_pcm
> snd_hwdep               9604  3 snd_emu10k1,snd_bt_sco,snd_usb_audio
> snd                    52612  15 
> snd_emu10k1,snd_bt_sco,snd_pcm_oss,snd_mixer_oss,snd_seq,snd_mpu401,snd_intel8x0,snd_mpu401_uart,snd_ac97_codec,snd_usb_audio,snd_pcm,snd_timer,snd_rawmidi,snd_seq_device,snd_hwdep 
> 
> 
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0A:3A:63:CF:47 ACL MTU: 377:10 SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:3240 acl:91 sco:0 events:176 errors:0
>         TX bytes:2873 acl:115 sco:0 commands:49 errors:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x7e010c
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Laptop
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 
> 0x309
>         Manufacturer: Broadcom Corporation (15)
> 
> # hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0A:3A:63:CF:47 ACL MTU: 377:10 SCO MTU: 16:0
>         Firmware 0.3 / 9
> 
> /var/log/messages
> Feb  2 10:00:36 barrabas hcid[8432]: link_key_request 
> (sba=00:0A:3A:63:CF:47, dba=00:03:89:60:F9:CF)
> Feb  2 10:00:37 barrabas hcid[8432]: pin_code_request 
> (sba=00:0A:3A:63:CF:47, dba=00:03:89:60:F9:CF)
> Feb  2 10:00:37 barrabas hcid[8432]: link_key_notify 
> (sba=00:0A:3A:63:CF:47, dba=00:03:89:60:F9:CF)
> 
> Headset plugged in, the above is reported. The PIN (0000) done when 
> first connected some time ago, so it doesn't prompt for it.
> 
> barrabas:/ftp/Feb06/burn # btsco -v 00:03:89:60:F9:CF
> btsco v0.41
> Device is 2:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> 
> # aplay -D plughw:Headset /XXX.wav
> Playing WAVE '/XXX.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> Aborted by signal Interrupt...  (CTRL-C done)
> 
> # hcidump -x
> HCIDump - HCI packet analyzer ver 1.9
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < ACL data: handle 0x0006 flags 0x02 dlen 18
>     L2CAP(d): cid 0x44 len 14 [psm 0]
>       0B EF 15 41 54 2B 56 47 53 3D 31 35 0D 9A
> < ACL data: handle 0x0006 flags 0x02 dlen 18
>     L2CAP(d): cid 0x44 len 14 [psm 0]
>       0B EF 15 41 54 2B 56 47 4D 3D 31 35 0D 9A
> < HCI Command: Add SCO Connection (0x01|0x0007) plen 4
>   06 00 E0 00
>  > HCI Event: Command Status (0x0f) plen 4
>   00 01 07 04
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 06 00 02 00
>  > HCI Event: Connect Complete (0x03) plen 11
>   00 01 00 CF F9 60 89 03 00 00 01
>  > ACL data: handle 0x0006 flags 0x02 dlen 17
>  > ACL data: handle 0x0006 flags 0x01 dlen 2
>     L2CAP(d): cid 0x41 len 15 [psm 0]
>       09 FF 15 02 41 54 2B 56 47 53 3D 30 37 0D 5C
> < ACL data: handle 0x0006 flags 0x02 dlen 14
>     L2CAP(d): cid 0x44 len 10 [psm 0]
>       0B EF 0D 0D 0A 4F 4B 0D 0A 9A
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 06 00 01 00
> < ACL data: handle 0x0006 flags 0x02 dlen 17
>     L2CAP(d): cid 0x44 len 13 [psm 0]
>       0B EF 13 41 54 2B 56 47 53 3D 37 0D 9A
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>   01 00 13
>  > HCI Event: Command Status (0x0f) plen 4
>   00 01 06 04
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 06 00 01 00
>  > HCI Event: Disconn Complete (0x05) plen 4
>   00 01 00 16
> 
> 
> 
> barrabas:/home/lancelot # cat /proc/asound/cards
>  0 [nForce2        ]: NFORCE - NVidia nForce2
>                       NVidia nForce2 with ALC650F at 0xe7080000, irq 9
>  1 [UART           ]: MPU-401 UART - MPU-401 UART
>                       MPU-401 UART at 0x330, irq 10
>  2 [Headset        ]: Bluetooth SCO - BT Headset
>                       BT Headset 1
> 
> barrabas:/home/lancelot # cat /proc/asound/card2/oss_mixer
> VOLUME "Master" 0
> BASS "" 0
> TREBLE "" 0
> SYNTH "" 0
> PCM "" 0
> SPEAKER "" 0
> LINE "" 0
> MIC "Mic" 0
> CD "" 0
> IMIX "" 0
> ALTPCM "" 0
> RECLEV "" 0
> IGAIN "" 0
> OGAIN "" 0
> LINE1 "" 0
> LINE2 "" 0
> LINE3 "" 0
> DIGITAL1 "" 0
> DIGITAL2 "" 0
> DIGITAL3 "" 0
> PHONEIN "" 0
> PHONEOUT "" 0
> VIDEO "" 0
> RADIO "" 0
> MONITOR "" 0
> 
> barrabas:/home/lancelot # cat /proc/asound/card2/id
> Headset
> 
> 
> barrabas:/home/lancelot # cat /proc/asound/card2/pcm0c/info
> card: 2
> device: 0
> subdevice: 0
> stream: CAPTURE
> id: Bluetooth SCO PCM
> name: BT SCO PCM
> subname: subdevice #0
> class: 0
> subclass: 0
> subdevices_count: 1
> subdevices_avail: 1
> barrabas:/home/lancelot # cat /proc/asound/card2/pcm0c/oss
> barrabas:/home/lancelot # cat /proc/asound/card2/pcm0p/
> info  oss   sub0/
> 
> barrabas:/home/lancelot # cat /proc/asound/oss/devices
>   0: [0- 0]: mixer
>   3: [0- 0]: digital audio
>   4: [0- 0]: digital audio
>  12: [0- 1]: digital audio
>  16: [1- 0]: mixer
>  19: [1- 0]: digital audio
>  20: [1- 0]: digital audio
> barrabas:/home/lancelot # cat /proc/asound/oss/sndstat
> Sound Driver:3.8.1a-980706 (ALSA v1.0.11rc2 emulation code)
> Kernel: Linux barrabas 2.6.16-rc1-git4a #2 PREEMPT Wed Feb 1 06:31:29 
> GMT 2006 i686
> Config options: 0
> 
> Installed drivers:
> Type 10: ALSA emulation
> 
> Card config:
> NVidia nForce2 with ALC650F at 0xe7080000, irq 9
> BT Headset 1
> 
> Audio devices:
> 0: NVidia nForce2 (DUPLEX)
> 1: BT SCO PCM (DUPLEX)   <============= "pskey mapsco 0" needed here????
> 
> Synth devices: NOT ENABLED IN CONFIG
> 
> Midi devices: NOT ENABLED IN CONFIG
> 
> Timers:
> 31: system timer
> 
> Mixers:
> 0: Realtek ALC650F
> 1: BT Headset Mixer
> 
> barrabas:/home/lancelot # cat /proc/asound/card2/pcm0p/info
> card: 2
> device: 0
> subdevice: 0
> stream: PLAYBACK
> id: Bluetooth SCO PCM
> name: BT SCO PCM
> subname: subdevice #0
> class: 0
> subclass: 0
> subdevices_count: 1
> subdevices_avail: 1
> 


-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
