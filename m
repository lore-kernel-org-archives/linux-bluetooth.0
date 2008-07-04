Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2008 00:27:18 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200807030237.57723.bluez-users-mlist@malte-wetz.de>
Message-ID: <alpine.LNX.1.10.0807031905300.5583@nge2.ngu.pk>
References: <200807030237.57723.bluez-users-mlist@malte-wetz.de>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headset not working (was: Belkin USB-Dongle
 blocks USB subsystem)
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



On Thu, 3 Jul 2008, Malte J. Wetz wrote:

-> Thanks for that info. It brought me one step closer to getting the stick to 
-> work. Now, everything appears to work. But the Belkin dongle behaves 
-> exactly like the MSI dongle: It does not record or playback anything when 
-> paired with my bluetooth headset (Jabra BT 205).

I think these are older bluetooth hardware that you will need the kernel patch 
for. Mine needs it. Patch kernel & recompile/reinstall modules as it seems 
like you already did below.

-> With my old Logitech MX 900, I used btsco which emulates a soundcard and 
-> everthing was fine. With the MSI or Belkin dongles, neither btsco nor the 
-> newer alsa plugin method work.
-> 
-> 
-> Ok, first the "deprecated" method with btsco (with correct BT address of 
-> course):

This method is old and my not even work anymore with modern bluez, I don't 
know. Try current bluez-utils/libs and current Alsa w/current kernel for best 
results.


-> Jul  2 15:53:20 triton kernel: hci_scodata_packet: hci0 SCO packet for 
-> unknown connection handle 1
-> Jul  2 15:53:40 triton last message repeated 6565 times

This looks like what happens when you don't use the patch when you need it. 
Look at the device and see:

# hcitool info 00:1A:45:01:F9:42

Requesting information ...
         BD Address:  00:1A:45:01:F9:42
         OUI Company: GN Netcom as (00-1A-45)
         LMP Version: 2.0 (0x3) LMP Subversion: 0xbfa
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
                 <encryption> <slot offset> <timing accuracy> <role switch>
                 <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                 <paging scheme> <transparent SCO> <AFH cap. slave>
                 <AFH cap. master>


When it only says "SCO", you'll need the patch. Never saw an ESCO headset 
because I don't own one, but I'd guess it shows things like <eSCO link>?

-> Jul  2 15:53:40 triton kernel: hcid[2999]: segfault at 8 ip b7db5e0e sp 
-> bfae8090 error 6 in libaudio.so[b7dae000+19000]


That might be the segfault I hit awhile back and posted about. It's the same 
solib, libaudio.so

-> Jul  2 15:53:40 triton kernel: hci_scodata_packet: hci0 SCO packet for 
-> unknown connection handle 1


-> Jul  2 16:16:02 triton hcid[9056]: Audio API: received 
-> BT_GETCAPABILITIES_REQ
-> Jul  2 16:16:02 triton hcid[9056]: Audio API: sending BT_GETCAPABILITIES_RSP
-> Jul  2 16:16:02 triton hcid[9056]: Audio API: received 
-> BT_SETCONFIGURATION_REQ
-> Jul  2 16:16:02 triton hcid[9056]: config sco - device = XX:XX:XX:XX:XX:XX 
-> access_mode = 2
-> Jul  2 16:16:05 triton hcid[9056]: link_key_request (sba=YY:YY:YY:YY:YY:YY, 
-> dba=XX:XX:XX:XX:XX:XX)
-> Jul  2 16:16:08 triton hcid[9056]: SCO fd=25
-> Jul  2 16:16:08 triton hcid[9056]: Audio API: sending 
-> BT_SETCONFIGURATION_RSP
-> Jul  2 16:16:08 triton hcid[9056]: Audio API: received BT_STREAMSTART_REQ
-> Jul  2 16:16:08 triton hcid[9056]: Audio API: sending BT_STREAMSTART_RSP
-> Jul  2 16:16:08 triton hcid[9056]: Audio API: sending BT_STREAMFD_IND
-> Jul  2 16:17:28 triton hcid[9056]: Audio API: received BT_STREAMSTART_REQ
-> Jul  2 16:17:28 triton hcid[9056]: Audio API: sending BT_STREAMSTART_RSP
-> Jul  2 16:17:28 triton hcid[9056]: Audio API: sending BT_STREAMFD_IND
-> Jul  2 16:18:08 triton hcid[9056]: Audio API: received BT_STREAMSTART_REQ
-> Jul  2 16:18:08 triton hcid[9056]: Audio API: sending BT_STREAMSTART_RSP
-> Jul  2 16:18:08 triton hcid[9056]: Audio API: sending BT_STREAMFD_IND
-> Jul  2 16:18:48 triton hcid[9056]: Audio API: received BT_STREAMSTART_REQ
-> Jul  2 16:18:48 triton hcid[9056]: Audio API: sending BT_STREAMSTART_RSP
-> Jul  2 16:18:48 triton hcid[9056]: Audio API: sending BT_STREAMFD_IND


Last things are the SCO MTU...

# hciconfig -a

hci0:   Type: USB
         BD Address: 00:0A:3A:7C:5C:74 ACL MTU: 1017:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:4448653 acl:123 sco:87104 events:179 errors:0
         TX bytes:4496843 acl:98 sco:88120 commands:80 errors:0
         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
 	Name: '[vdrl] / BT Device 0'
         Class: 0x1a0108
         Service Classes: Networking, Capturing, Object Transfer
         Device Class: Computer, Server
         HCI Ver: 2.0 (0x3) HCI Rev: 0x4107 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
         Manufacturer: Broadcom Corporation (15)


If the SCO MTU: 64:8 part has zero's there, it won't work. Mine will do this 
without the hci_usb force sco fix param set:

# modinfo hci_usb

filename:       /lib/modules/2.6.25.9/kernel/drivers/bluetooth/hci_usb.ko.gz
license:        GPL
version:        2.9
description:    Bluetooth HCI USB driver ver 2.9
author:         Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann 
<marcel@holtmann.org>
srcversion:     DACD9DA7C0F1ECE25CC71EB
alias:          usb:v0C10p0000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0BDBp1002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v04BFp030Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v057Cp3800d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dcE0dsc01dp01ic*isc*ip*
depends:        bluetooth
vermagic:       2.6.25.9 mod_unload PENTIUM4
parm:           ignore:Ignore devices from the matching table (bool)
parm:           ignore_dga:Ignore devices with id 08fd:0001 (bool)
parm:           ignore_csr:Ignore devices with id 0a12:0001 (bool)
parm:           ignore_sniffer:Ignore devices with id 0a12:0002 (bool)
parm:           disable_scofix:Disable fixup of wrong SCO buffer size (bool)
parm:           force_scofix:Force fixup of wrong SCO buffers size (bool)
parm:           reset:Send HCI reset command on initialization (bool)
parm:           isoc:Set isochronous transfers for SCO over HCI support (int)


Try one of two things if you have this problem:

1.) have no mention of hci_usb any place in modprobe.conf, then manually 
insert the module (remove first if needed) with the param on:

modprobe -r hci_usb
sleep 1
modprobe hci_usb force_scofix=1

(then start the bluetooth stuff)

2.) put this in modprobe.conf. Mine is at /etc/modprobe.conf

options hci_usb force_scofix=1

...and refresh the modules (depmod -e -F /boot/System.map). It must point to 
the current System.map

Make sure the module is out:

modprobe -r hci_usb

Then start bluetooth stuff as usual and modprobe will handle the param for you 
for now on so you can forget about it after this if you go this route.


Also make sure the right files are installed for alsa-lib to do bluetooth 
(there's a few extra in my setup, like the speex ones):

/usr/lib/alsa-lib:

# ls -1

libasound_module_ctl_bluetooth.so*
libasound_module_ctl_dsp_ctl.so*
libasound_module_ctl_oss.so*
libasound_module_pcm_alsa_dsp.so*
libasound_module_pcm_bluetooth.so*
libasound_module_pcm_oss.so*
libasound_module_pcm_upmix.so*
libasound_module_pcm_vdownmix.so*
libasound_module_rate_speexrate_best.so@
libasound_module_rate_speexrate_medium.so@
libasound_module_rate_speexrate.so*
smixer/

-> I would really like to get at least one method working but I don't even have 
-> an error message to feed to google. Any ideas on this one?
->

>>From the start w/above fixes in mind:

Some headsets like mine won't show themselves unless they are put in visible 
mode. On this one, that is turn it off, then back on, holding the button 
awhile. The light stays lit and you can scan it. If you know its address 
already you don't need to do that.

# hcitool scan

Scanning ...
         00:1A:45:01:F9:42       Jabra BT135


# cat /etc/asound.conf

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
         profile "auto"
}

ctl.bluetooth {
         type bluetooth
         device "00:1A:45:01:F9:42"
}

pcm.bt_slave {
         type plug
         slave {
                 pcm "bluetooth"
         }
}



You don't need the first and last stanzas, they are for other stuff.

/usr/bin/dbus-daemon --system
hcid -s -f /etc/bluetooth/hcid.conf

Some times removing the persistant info in /var/lib/bluetooth/* helps clear up 
odd errors. Your dir may be in another place.

passkey-agent --default 0000 00:1A:45:01:F9:42 & (passkey-agent --default <PIN> <Remote BT address> 
auth-agent &  (or whatever you are using to pair with)


Turn on the headset. Mine looks for the computer and connects to it, not the 
other way around. When nothings being sent it disconnects. You don't have to 
worry about manually connecting it. Pressing the button on the side of it 
makes it do the same. Mine is the same company as yours, similar model so they 
might work similarly.

If you built your kernel with auto kmod load you don't need to worry about 
loading modules outside of the hci_usb thing above because of the special 
parameter.

Send some sound. Not all players I've tried work, but I know sox does. And the 
standard Alsa stuff.

sox -t ogg ./sound_file.ogg -t alsa pcm.bluetooth  <-- Name in asound.conf


That should be it. Recording I've done w/sox the same way, just opposite 
direction. You may see a few errors in syslog but it should work.

linux-2.6.25.9
alsa-*-1.0.16
bluez-utils-3.34
bluez-libs-3.34
sox-14.0.1


I posted a few times on headsets. You might look in the list archive for some 
older posts.



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
