Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Feb 2008 22:12:15 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: bluez-users@lists.sourceforge.net
Message-ID: <alpine.LNX.1.00.0802052112140.20192@nge2.ngu.pk>
MIME-Version: 1.0
Subject: [Bluez-users] Headset Audio: Success
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




Finally ;)

Since there's alot of posts about this, I thought I'd post the configs and 
stuff I used. I'm using now linux-2.6.23.14, with bluez-utils and libs 3.25. 
No extra patches. The following modules auto-load, except for hci_usb which 
I'll show why below. All of my work is done on the console.


sco                    12164  0
bridge                 48280  0
bnep                   14720  2
rfcomm                 34588  10
l2cap                  20740  16 bnep,rfcomm
hci_usb                13724  2
bluetooth              47456  9 sco,bnep,rfcomm,l2cap,hci_usb

"bridge" is for networking and doesn't really apply right now, only with PAN.


1. Start dbus. There should be no errors in the system logs. If there is, you 
might have dbus permission problem. I had to fix this on mine.

/etc/dbus-1/system.d/bluetooth.conf

<!-- This configuration file specifies the required security policies
      for Bluetooth core service to work. -->

<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
  "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

   <!-- ../system.conf have denied everything, so we just punch some holes -->

   <policy user="root">
     <allow own="org.bluez"/>
   </policy>

   <policy at_console="true">
     <allow send_destination="org.bluez.Manager"/>
     <allow receive_sender="org.bluez.Manager"/>

     <allow send_path="/org/bluez"/>

     <allow send_destination="org.bluez.Adapter"/>
     <allow receive_sender="org.bluez.Adapter"/>

     <allow send_destination="org.bluez.Service"/>
     <allow receive_sender="org.bluez.Service"/>

     <allow send_destination="org.bluez.Database"/>
     <allow receive_sender="org.bluez.Database"/>

     <allow send_destination="org.bluez.Security"/>
     <allow receive_sender="org.bluez.Security"/>
   </policy>

</busconfig>


2. My setup seems to need the force_scofix kernel module option. If you're 
using a similar setup and what to try to this, remove the hci_usb module. Make 
sure the module actually removes. Use modprobe -r hci_usb. Now re-add it:

modprobe hci_usb force_scofix=1


If that is needed for yours, you can set it permanent in modprobe.conf with 
the 'options' keyword.


3. Fix/check config files. The first two come with bluez-utils. Make sure they 
got installed.


/etc/bluetooth/audio.service:

[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service
Autostart=true



/etc/bluetooth/audio.conf:

# Configuration file for the audio service

# This section contains options which are not specific to any
# particular interface
[General]

# If we want to disable support for specific services
# Defaults to supporting all implemented services
#Disable=Control,Source

# SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
# Defaults to HCI
SCORouting=HCI

# Headset interface specific options (i.e. options which affect how the audio
# service interacts with remote headset devices)
[Headset]

# Set to true to only support HSP
# Defaults to false
DisableHFP=false

# Just an example of potential config options for the other interfaces
#[A2DP]
#SourceCount=2





This one you have to create/edit. The alsa config file, /etc/asound.conf:

## Alsa Sound Config
##
## Extra configurations for Alsa
## (/usr/share/alsa/alsa.conf)
##

pcm.oss {
         type oss
         device /dev/dsp
}

pcm.bluetooth {
         type bluetooth
         device "00:1A:45:01:F9:42"
#       profile "auto"
}

pcm.bt_slave {
         type plug
         slave {
                 pcm "bluetooth"
         }
}



I use OSS stuff, you may not have that first one. The middle one, 
pcm.bluetooth, is the one I finally got this working with. It's also included 
with bluez-utils.


/etc/bluetooth/hcid.conf (minus comments and whitespace):

options {
         autoinit yes;
         security user;
         pairing multi;
         passkey "0000";
}
device {
         name "[%h] / BT Device %d";
         class 0x020108;
         pkt_type DH1,DM1,HV1;
         iscan enable; pscan enable;
         lm accept;
         lp rswitch,hold,sniff,park;

}



4. Start the bluetooth system. Persistant info gets stored in
/var/lib/bluetooth/(address) if you make changes to the config files, it might
be good to remove the address directories and start fresh, then start the
bluetooth daemons again. hcid, sdpd should now be running.

  5417 ?        Ss     0:00 /usr/bin/dbus-daemon --system
  5449 ?        S<     0:00 [krfcommd]
  5508 ?        Ss     0:00 sdpd
  5511 ?        Ss     0:00 hcid -f /etc/bluetooth/hcid.conf
  5514 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-echo
  5515 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-network
  5517 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-serial
  5518 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-input
  5519 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-audio
  5520 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-transfer
  5521 tty1     SN     0:00 passkey-agent --default 0000 00:1A:45:01:F9:42
  5522 tty1     SN     0:00 auth-agent




5. Start the auth agents, make sure the PIN is correct. 0000 seems to be a 
default on many.


# passkey-agent --default <pin> <address of headset> &

Ex:

# passkey-agent --default 0000 00:1A:45:01:F9:42 &

# auth-agent &

When they get a request, it says:

Authorization request for device 00:1A:45:01:F9:42

on the console. This *may* be because I compiled bluez-utils with debug? I'm 
not sure.


6. Plug in the system adapter if it's not in. I'm using a Belkin/Broadcom USB 
Adapter. It was about $50 at Circuit City. Works out-of-box with the kernel's 
hci_usb module. It should be ready to go. I've never done any "hcitool hci0 
up" commands.


hci0:   Type: USB
         BD Address: 00:0A:3A:7C:5C:74 ACL MTU: 1017:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:70328 acl:51 sco:1307 events:104 errors:0
         TX bytes:74085 acl:48 sco:1416 commands:57 errors:0
         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: '[vdrl] / BT Device 0'
         Class: 0x020108
         Service Classes: Networking
         Device Class: Computer, Server
         HCI Ver: 2.0 (0x3) HCI Rev: 0x4107 LMP Ver: 2.0 (0x3) LMP Subver: 
0x430e
         Manufacturer: Broadcom Corporation (15)





7. Turn on the headset. I'm using a Jabra BT135 that says "Verizon" on it. 
Actually, it was for my cell phone. This headset wants to pair on startup, and 
will try. Since the agents are started, it should work. Mine doesn't show on a 
scan, only if I turn it off, back on, then hold the button down for awhile. It 
stays lit, then I can see it with a scan. It's not needed to scan if you know 
its address already.

Passkey request for device 00:1A:45:01:F9:42 
Authorization request for device 00:1A:45:01:F9:42

# hcitool con

Connections:
         > ACL 00:1A:45:01:F9:42 handle 11 state 1 lm MASTER AUTH ENCRYPT SECURE


It seems to disconnect again after a while. It reconnects again. I haven't 
seen my headset listed in /proc/asound/cards.

8. Try to play something. Make sure it plays on the speakers first (actually 
works), the sound volume is up, etc, etc.



# aplay -D bluetooth /usr/share/kismet/wav/alert.wav

Playing WAVE '/usr/share/kismet/wav/alert.wav' : Signed 16 bit Little Endian, 
Rate 8000 Hz, Mono

#

If you see something like below, try again. My headset seems to go out to 
lunch if it's not sent sound for awhile. Trying re-connects it, then the 
second attempt actually plays.

ALSA lib pcm_bluetooth.c:459:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION 
failed : Input/output error(5)


9. Play some Ogg's. Enjoy sound from across the room. Sox can be built with 
ogg, mp3 support, so you can play those too. I tested sox, aplay, and mpg123.


sox -t ogg /home/jayjwa/media/ogg/NY-Dolls-Pills.ogg -t alsa pcm.bluetooth


Input File     : '/home/jayjwa/media/ogg/NY-Dolls-Pills.ogg'
Sample Size    : 16-bit (2 bytes)
Sample Encoding: Vorbis
Channels       : 2
Sample Rate    : 44100
Comments       :
title=Pills
artist=New York Dolls
genre=Rock
album=New York Dolls
tracknumber=14

Time: 00:44.03 [02:07.72] of 02:51.75 ( 25.6%) Output Buffer: 352.18K



Hope this helps someone. BTW, thanks to bluez developers/people for the 
software.





-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
