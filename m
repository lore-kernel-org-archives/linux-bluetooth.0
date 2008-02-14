Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Feb 2008 09:22:45 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <235964.6502.qm@web8412.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.00.0802140815230.2549@nge2.ngu.pk>
References: <235964.6502.qm@web8412.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1287612665-1517789732-1202998966=:2549"
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1287612665-1517789732-1202998966=:2549
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 8BIT


On Wed, 13 Feb 2008, pramod gurav wrote:

-> [Pramod@localhost ~]$ strings /sbin/modprobe | grep conf
-> /etc/modules.conf
-> showconfig
-> /etc/modprobe.conf
-> Usage: %s [-v] [-V] [-C config-file] [-n] [-i] [-q] [-b] [-o <modname>] <modname> [parameters...]
-> Failed to open config file %s: %s
-> Failed to open included config file %s: %s

Looks like it's using both /etc/modules.conf and /etc/modprobe.conf, I'd stick 
with /etc/modprobe.conf as I think that's the currently used one in the Linux 
community.


-> This is my /usr/src/linux-2.6.15..i686/.config(Only BT configs are given here)
-> CONFIG_BT=y
-> CONFIG_BT_L2CAP=y
-> CONFIG_BT_SCO=y
-> CONFIG_BT_RFCOMM=y
-> CONFIG_BT_RFCOMM_TTY=y
-> CONFIG_BT_BNEP=y
-> CONFIG_BT_BNEP_MC_FILTER=y
-> CONFIG_BT_BNEP_PROTO_FILTER=y
-> CONFIG_BT_CMTP=m
-> CONFIG_BT_HIDP=y
-> #
-> # Bluetooth device
->  drivers
-> #
-> CONFIG_BT_HCIUSB=y
-> CONFIG_BT_HCIUSB_SCO=y
-> CONFIG_BT_HCIUART=y
-> CONFIG_BT_HCIUART_H4=y
-> CONFIG_BT_HCIUART_BCSP=y
-> CONFIG_BT_HCIBCM203X=y
-> CONFIG_BT_HCIBPA10X=y
-> CONFIG_BT_HCIBFUSB=y
-> CONFIG_BT_HCIDTL1=y
-> CONFIG_BT_HCIBT3C=y
-> CONFIG_BT_HCIBLUECARD=y
-> CONFIG_BT_HCIBTUART=y
-> CONFIG_BT_HCIVHCI=y
-> CONFIG_IEEE80211=m

Looks like it's all compiled in, which is OK. You could do modules (=m) to 
save kernel size, if you like, but it's fine how it is now.

-> SO I have hci_usb compiled in my kernel... 
-> These are things I did now...
-> [root@localhost Pramod]# mv /etc/modules.conf /etc/modules.conf_old
-> copied these lines to /etc/modprobe.conf
-> alias net-pf-31 bluez  ------> changed to ----->  alias net-pf-31 bluetooth
-> alias bt-proto-0 l2cap
-> alias bt-proto-2 sco
-> alias bt-proto-3 rfcomm
-> Added "options 
-> hci_usb 
-> force_scofix=1" to  /etc/modprobe.conf file...

Hopefully on one line?

options	hci_usb force_scofix=1

You can try to see if some of the other options work for you. See them with 
'modinfo hci_usb'.


-> Now I rebooted ..


If they were modules, you won't have to reboot every time you change an 
options. Just

modprobe -r hci_usb
modprobe hci_usb force_scofix=1

or any other option. If it says 'module whatever is in use' kill the things 
using it first, then restart them. Usually anything with 'blue' or 'hci' in 
the name. 'pkill' works good for that, if you have 'pkill'.


-> When I restarted my hcid(with sdpd, audi-service autostart) I found some things that I never seen 
-> before in /var/log/messages these are
-> /***This log appeared for first time*****/
-> Feb 13 09:48:40 localhost audio[2473]: Loading device 00:0F:DE:B1:02:42 (headset )
-> Feb 13 09:48:40 localhost audio[2473]: Setting 00:0F:DE:B1:02:42 as default device
-> 
-> Then I did 
-> [Pramod@localhost ~]$ arecord -D bluetooth -f S16_LE test.raw
-> 
-> both ACL and SCO were established 
-> I was able to record sound from headset...
-> But when I tried
-> [Pramod@localhost ~]$ aplay -D bluetooth -f S16_LE test.raw
-> Playing raw data 'test.raw' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
-> 
-> No sound was listened on headset
-> 
-> [root@localhost Pramod]# hcitool con
-> Connections:
->         < SCO 00:0F:DE:B1:02:42 handle 1 state 1 lm SLAVE
->         < ACL 00:0F:DE:B1:02:42 handle 11 state 1 lm MASTER

Maybe the device isn't in the right state. After yours it says either 'SLAVE' 
or "MASTER", when mine is ready to play it lists:

hcitool con
Connections:
         > ACL 00:1A:45:01:F9:42 handle 11 state 1 lm MASTER AUTH ENCRYPT SECURE

If I try to play without that reading as above, I get nothing, or sometimes 
garbage. Does your headset have a button or switch to make it pair?


I set up all the bluetooth stuff first, start
passkey-agent --default (PIN number) (addr of headset) &
auth-agent &

then turn on the headset, wait a few seconds. Look at 'hcitool con' and if if 
the parameters are there. If so, play sound, if not, press the button on the 
headset, and look again at 'hcitool con' for parameters to be correct. It's 
hard to say what to do exactly for your headset, because I've never seen it, 
and can only guess at how it works. If this stuff here doesn't work, I'd say 
you'll just have to play around with it, or see if you can get your hands on 
some other headsets to see if they work/work differently.

sox -t mp3 file.mp3 -t alsa pcm.bluetooth

>>From this list, it seems you're supposed to use a gnome or KDE utility for the 
jobs of passkey-agent and auth-agent. You might try those. There's probably a 
package or source for them someplace.


-> [root@localhost Pramod]# hcidump -x
-> > SCO data: handle 1 flags 0x00 dlen 48
->     4F 00 CE FF B2 FF B5 FF 41 00 B5 00 B9 00 85 00 8B 00 A3 00
->     54 00 42 00 38 00 1B 00 FB FF D1 FF AB FF 44 00 78 00 87 00
->     73 00 56 00 E8 FF F4 FF
-> ctnr+c

hcidump -i hci0 --ascii

is a little easier to read, than -x, which is hex. You can at least read 
what's going on.


-> the logs were
-> Feb 13 09:49:35 localhost hcid[2469]: link_key_request (sba=00:02:72:CE:5B:80, dba=00:0F:DE:B1:02:42)
-> Feb 13 09:49:36 localhost hcid[2469]: link_key_notify (sba=00:02:72:CE:5B:80, dba=00:0F:DE:B1:02:42)Feb 13 09:49:36 localhost audio[2473]: Badly formated or unrecognized command: AT*ECBP=?
-> Feb 13 09:49:36 localhost audio[2473]: Badly formated or unrecognized command: AT+CSCS="UTF-8"
-> Feb 13 09:49:36 localhost audio[2473]: Badly formated or unrecognized command: AT+CLAN?

I see these too sometimes, I don't think they stop it from working. Maybe try 
both ways in /etc/bluetooth/audio.conf:

# Set to true to only support HSP
# Defaults to false
DisableHFP=false

and

# Set to true to only support HSP
# Defaults to false
DisableHFP=true

and restart. See if that changes anything. If not leave it as 
DisableHFP=false



-> Feb 13 09:51:06 localhost audio[2473]: Audio API: received BT_GETCAPABILITIES_REQ
-> Feb 13 09:51:06 localhost audio[2473]: Audio API: sending BT_GETCAPABILITIES_RSP
-> Feb 13 09:51:06 localhost audio[2473]: Audio API: received BT_SETCONFIGURATION_REQ


-> Feb 13 09:51:06 localhost audio[2473]: config sbc - frequency = 0 channel_mode = 0 allocation = 0 subbands = 0 blocks = 0 bitpool = 0
-> Feb 13 09:51:08 localhost hcid[2469]: pin_code_request (sba=00:02:72:CE:5B:80, dba=00:0F:DE:B1:02:42)
-> Feb 13 09:51:08 localhost hcid[2469]: link_key_notify (sba=00:02:72:CE:5B:80, dba=00:0F:DE:B1:02:42)Feb 13 09:51:09 localhost audio[2473]: Badly formated or unrecognized command: AT*ECBP=?
-> Feb 13 09:51:09 localhost audio[2473]: SCO fd=11
-> Feb 13 09:51:09 localhost audio[2473]: Audio API: sending BT_SETCONFIGURATION_RSP
-> Feb 13 09:51:09 localhost audio[2473]: Audio API: received BT_STREAMSTART_REQ
-> Feb 13 09:51:09 localhost audio[2473]: Audio API: sending BT_STREAMSTART_RSP
-> Feb 13 09:51:09 localhost audio[2473]: Audio API: sending BT_STREAMFD_IND
-> Feb 13 09:51:09 localhost audio[2473]: Badly formated or unrecognized command: AT+CSCS="UTF-8"
-> Feb 13 09:51:09 localhost audio[2473]: Badly formated or unrecognized command: AT+CLAN?
-> Feb 13 09:52:30 localhost audio[2473]: Audio API: received BT_STREAMSTART_REQ
-> Feb 13 09:52:30 localhost audio[2473]: Audio API: sending BT_STREAMSTART_RSP
-> Feb 13 09:52:30 localhost audio[2473]: Audio API: sending BT_STREAMFD_IND
-> Feb 13 09:52:43 localhost kernel: hci_scodata_packet: hci0 SCO packet for unknown connection handle 1
-> 
-> Feb 13 09:52:43 localhost kernel: hci_scodata_packet: hci0 SCO packet for unknown connection handle 1

These two lines above might show a problem. It shouldn't be unknown, correct?


-> Feb 13 09:53:12 localhost audio[2473]: Audio API: received BT_GETCAPABILITIES_REQ
-> Feb 13 09:53:12 localhost audio[2473]: Audio API: sending BT_GETCAPABILITIES_RSP
-> Feb 13 09:53:12 localhost audio[2473]: Audio API: received BT_SETCONFIGURATION_REQ
-> Feb 13 09:53:12 localhost audio[2473]: config sbc - frequency = 0 channel_mode = 0 allocation = 0 subbands = 0 blocks = 0 bitpool = 0
-> 
-> I had made all the changes suggested by you. Are they done properly?

Looks OK so far.

-> This is my hciconfig -a output
-> [root@localhost Pramod]# /usr/local/sbin/hciconfig -a 
-> hci0:   Type: USB
->         BD Address: 00:02:72:CE:5B:80 ACL MTU: 1017:8 SCO MTU: 64:0
->         UP RUNNING PSCAN ISCAN
->         RX bytes:5974443 acl:279 sco:116978 events:188 errors:0
->         TX bytes:4222 acl:168 sco:0 commands:90 errors:0

Rx is received, look at sco, 116978. But look at TX, transmitted, sco:0 makes 
me think nothing is getting sent. Watch hcidump when the sound is supposed to 
play, does it look at it's being sent, just not received, or not sent at all 
because of some reason?

Look at the TX, TX sco on my output after one file,

hci0:   Type: USB
         BD Address: 00:0A:3A:7C:5C:74 ACL MTU: 1017:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:5348812 acl:52 sco:104818 events:93 errors:0
         TX bytes:5403125 acl:48 sco:105913 commands:44 errors:0
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



RX bytes:5348812 acl:52 sco:104818
TX bytes:5403125 acl:48 sco:105913



---1287612665-1517789732-1202998966=:2549
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
---1287612665-1517789732-1202998966=:2549
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

---1287612665-1517789732-1202998966=:2549--
