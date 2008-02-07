Return-Path: <cyrus@holtmann.org>
Message-ID: <47AB5665.8040101@wurmsdobler.org>
Date: Thu, 07 Feb 2008 19:05:09 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Headset, ALSA and other issues
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

Hello,

It was not trivial to sucessfully connect to my BlueTooth development 
module apm6628 (based on CSR BlueCore4-ROM) over RS232. After some 
initial problems the device appears in 90% of trials as hci0 using:

     hciattach /dev/ttyS0 bcsp 57600 flow
     hciconfig hci0 up
     bccmd -t hci psload -r apm6628BT-UART.psr
     killall hciattach
     sleep 1
     hciattach /dev/ttyS0 bcsp 115200 flow
     hciconfig hci0 up

Where the uncertainly und unreliability comes from is still a mistery 
for me. Nevertheless, "hcitool scan" discovers neighbouring bluetooth 
devices, such as the Nokia BH-202 headset with its detailed information:

peter@pc:~$ hcitool info 00:16:8F:EB:6E:53
Requesting information ...
     BD Address:  00:16:8F:EB:6E:53
     Device Name: Nokia BH-202
     LMP Version: 2.0 (0x3) LMP Subversion: 0x978
     Manufacturer: Cambridge Silicon Radio (10)
     Features: 0xfd 0xfe 0x8b 0x80 0x0b 0xa8 0x00 0x80
         <3-slot packets> <encryption> <slot offset> <timing accuracy>
         <role switch> <hold mode> <sniff mode> <RSSI>
         <channel quality> <SCO link> <HV2 packets> <HV3 packets>
         <u-law log> <A-law log> <CVSD> <paging scheme>
         <transparent SCO> <broadcast encrypt> <extended SCO>
         <EV4 packets> <EV5 packets> <AFH cap. slave> <AFH cap. master>
         <EDR eSCO 2 Mbps> <3-slot EDR eSCO> <extended features>

"rfcomm bind all" binds the device to /dev/rfcomm0 using the appropriate 
/etc/bluetooth/rfcomm.conf :

     rfcomm0 {
        bind yes;
        device 00:16:8F:EB:6E:53;
        channel 1;
     }

peter@pc:~$ rfcomm
rfcomm0: 00:16:8F:EB:6E:53 channel 1 clean


As a next step I would like to pair my host PC with the headset and send 
  an audio stream. Even after searching along a lot of documentation on 
various web sites, I do not quite succeed:

peter@pc:~$ mplayer -ao alsa:device=bluetooth test.wav
MPlayer 2:1.0~rc1-0ubuntu13.1 (C) 2000-2006 MPlayer Team
CPU: Intel(R) Core(TM)2 Duo CPU     E6550  @ 2.33GHz (Family: 6, Model: 
15, Stepping: 11)
CPUflags:  MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 SSE2: 1
Compiled with runtime CPU detection.
mplayer: could not connect to socket
mplayer: No such file or directory
Failed to open LIRC support. You will not be able to use your remote 
control.

Playing test.wav.
Audio file file format detected.
==========================================================================
Forced audio codec: mad
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 8000 Hz, 1 ch, u8, 64.0 kbit/100.00% (ratio: 8000->8000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
alsa-lib: pcm_bluetooth.c:1261:(bluetooth_init) Connection fail
alsa-init: playback open error: Connection refused
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video

Exiting... (End of file)


The configuration files are:

     /etc/bluetooth/audio.conf
     [General]
     SCORouting=HCI
     [Headset]
     DisableHFP=false
     pcm.bluetooth {
          type bluetooth
          device "00:16:8F:EB:6E:53"
     }

     ~/.asoundrc
     pcm.bluetooth {
          type bluetooth
          device "00:16:8F:EB:6E:53"
     }


I guess I am missing something essential, and there are a few missing 
links in my understanding how things have to be set up.

Assuming that hcid's role is to discover dynamically bluetooth devices, 
does hcid have to run if there is anyway only one fixed bluetooth device 
connected to the system?

How does an audio player, or consequently the ALSA sound system know 
where to send the PCM synchonous data to such that the bluetooth 
subsystem can transmit them?

Who takes the responsibility to negotiate to the headset over 
/dev/rfcomm0 and to establish the SCO connection?

Who opens a connection to the hci0 socket to pipe the PCM data into it?

What role does the dbus play in this game?

Browsing through the BlueZ-utils code, I get a rough idea, but not the 
big picture how things hang together. Is there somebody on the list who 
happens to life somewhere in Europe (or in a timezon +- a fe hours from 
GMT) and who can spare a few minutes for a phone chat?

Time and number can be arranged over peter at wurmsdobler dot org, and 
as far as the language is concerend, English, German and French are 
fine. If in Cambridge, UK, I am happy to pay a few pints in a local pub.

Regards,
peter



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
