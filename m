Return-Path: <cyrus@holtmann.org>
Message-ID: <480A5877.4080201@powercraft.nl>
Date: Sat, 19 Apr 2008 22:39:19 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48092EF6.3090603@powercraft.nl> <48093316.3070906@powercraft.nl>
	<alpine.LNX.1.00.0804190011000.27696@nge2.ngu.pk>
In-Reply-To: <alpine.LNX.1.00.0804190011000.27696@nge2.ngu.pk>
Content-Type: multipart/mixed; boundary="------------010408050305070205040600"
Subject: Re: [Bluez-users] Samsung WEP210 Bluetooth Headset
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

This is a multi-part message in MIME format.
--------------010408050305070205040600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

jayjwa wrote:
> On Sat, 19 Apr 2008, Jelle de Jong wrote:
> 
> -> > This message contains the following attachment(s):
> -> > Samsung WEP210 Bluetooth Headset.txt
> -> > simple-agent
> 
> Looks like you have alot of obsolete and unneeded steps in there.
> 
> 
> -> > I bought a new headset and am trying to get it working under debian sid
> -> > 3.30-2 bluez-utils
> -> > 
> -> > However i cant connect to the device when it is in pairing mode.
> 
> I can't connect to mine either without it disconnecting, but it connects to 
> the computer when a sound is to be played. I'm guessing this is just how they 
> work.
> 
> -> > I have attached my working files with a lot of background information.
> -> > 
> -> > Can somebody help me to get the device working.
> 
> Getting headsets going is a frequent topic on this list, so you might try 
> looking at a past solution first, to see if it helps, before starting from the 
> beginning trying to solve this problem. Here's one I posted when I was first 
> using mine:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_name=alpine.LNX.1.00.0802052112140.20192%40nge2.ngu.pk&forum_name=bluez-users
> 
> There's alot of headset-talk, particularly in the Feb. 2008 part of the 
> archive.
> 
>

Thank you,

So, I tried to get it working for a other 4 hours, but I can't get it to
work. Please help me, how can I get the device fully working, what am I
doing wrong here?

Please take a look at the logs i attached in the mail, i hope this gives
enough information for a advanced bluez users to tell me what is wrong.

Kind regards,

Jelle

snapshot of my syslog >>
Apr 19 21:55:55 debian-eeepc hcid[2330]: Bluetooth HCI daemon
Apr 19 21:55:55 debian-eeepc hcid[2330]: HCI dev 0 registered
Apr 19 21:55:55 debian-eeepc hcid[2330]: Starting SDP server
Apr 19 21:55:55 debian-eeepc hcid[2330]: Unix socket created: 12
Apr 19 21:55:55 debian-eeepc hidd[2333]: Bluetooth HID daemon
Apr 19 21:55:55 debian-eeepc hcid[2330]: Registered manager
path:/org/bluez/audio
Apr 19 21:55:55 debian-eeepc hcid[2330]: Registering service
Apr 19 21:55:55 debian-eeepc hcid[2330]: Unable to execute
/usr/lib/bluetooth/bluetoothd-service-audio
Apr 19 21:55:55 debian-eeepc hcid[2330]: HCI dev 0 up
Apr 19 21:55:55 debian-eeepc hcid[2330]: Device hci0 has been added
Apr 19 21:55:55 debian-eeepc hcid[2330]: Starting security manager 0
Apr 19 21:55:55 debian-eeepc hcid[2330]: Device hci0 has been activated
Apr 19 21:56:53 debian-eeepc hcid[2330]: link_key_request
(sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 21:56:55 debian-eeepc hcid[2330]: pin_code_request
(sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 21:56:55 debian-eeepc hcid[2330]: link_key_notify
(sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 21:56:57 debian-eeepc hcid[2330]: link_key_request
(sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 21:56:58 debian-eeepc hcid[2330]: Access denied: Not authorized
Apr 19 21:56:59 debian-eeepc hcid[2330]: link_key_notify
(sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: received
BT_GETCAPABILITIES_REQ
Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: sending
BT_GETCAPABILITIES_RSP
Apr 19 21:57:18 debian-eeepc hcid[2330]: Audio API: received
BT_SETCONFIGURATION_REQ
Apr 19 21:57:18 debian-eeepc hcid[2330]: config sco - device =
20:07:09:15:A9:5A access_mode = 2
Apr 19 21:57:20 debian-eeepc hcid[2330]: link_key_request
(sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 21:57:22 debian-eeepc kernel: Bluetooth: SCO (Voice Link) ver 0.5
Apr 19 21:57:22 debian-eeepc kernel: Bluetooth: SCO socket layer initialized
Apr 19 21:57:24 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
for unknown connection handle 43
Apr 19 21:57:55 debian-eeepc last message repeated 10158 times
Apr 19 21:58:02 debian-eeepc last message repeated 2576 times
Apr 19 21:58:02 debian-eeepc hcid[2330]: connect(): Connection timed out
(110)
Apr 19 21:58:02 debian-eeepc hcid[2330]: config failed
Apr 19 21:58:02 debian-eeepc hcid[2330]: Audio API: sending
BT_SETCONFIGURATION_RSP
Apr 19 21:58:02 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
for unknown connection handle 43
Apr 19 21:58:33 debian-eeepc last message repeated 10090 times
Apr 19 21:59:23 debian-eeepc last message repeated 16726 times
Apr 19 21:59:23 debian-eeepc hcid[2330]: Audio API: received
BT_GETCAPABILITIES_REQ
Apr 19 21:59:23 debian-eeepc hcid[2330]: Audio API: sending
BT_GETCAPABILITIES_RSP
Apr 19 21:59:23 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
for unknown connection handle 43
Apr 19 21:59:23 debian-eeepc last message repeated 2 times
Apr 19 21:59:23 debian-eeepc hcid[2330]: Audio API: received
BT_SETCONFIGURATION_REQ
Apr 19 21:59:23 debian-eeepc hcid[2330]: config sco - device =
20:07:09:15:A9:5A access_mode = 2
Apr 19 21:59:23 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
for unknown connection handle 43
Apr 19 21:59:54 debian-eeepc last message repeated 10270 times
Apr 19 22:00:03 debian-eeepc last message repeated 3062 times
Apr 19 22:00:03 debian-eeepc hcid[2330]: connect(): Connection timed out
(110)
Apr 19 22:00:03 debian-eeepc hcid[2330]: config failed
Apr 19 22:00:03 debian-eeepc hcid[2330]: Audio API: sending
BT_SETCONFIGURATION_RSP
Apr 19 22:00:03 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet
for unknown connection handle 43



--------------010408050305070205040600
Content-Type: text/plain;
 name="Samsung WEP210 Bluetooth Headset.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Samsung WEP210 Bluetooth Headset.txt"

#!/bin/bash

# background information:
http://gentoo-wiki.com/HOWTO_use_a_bluetooth_headset
http://www.wahlau.org/failed_getting_bluetooth_headset_to_work_with_ubuntu_edgy_eft
http://www.think-future.de/wiki/index.php?title=Bluetooth
http://sourceforge.net/mailarchive/forum.php?thread_name=alpine.LNX.1.00.0802052112140.20192%40nge2.ngu.pk&forum_name=bluez-users

# step 1: install bluetooth alsa software
sudo apt-get install bluetooth-alsa bluez-utils

sudo /etc/init.d/bluetooth stop
sudo /etc/init.d/alsa-utils stop
echo | sudo tee /var/log/syslog
sudo rm --recursive /var/lib/bluetooth/*

sudo modprobe --remove hci_usb
sudo modprobe hci_usb force_scofix=1

# system information:
cd $HOME
apt-cache show bluez-utils > bluez-utils-version-log.txt
lsmod > $HOME/lsmod-log.txt

# step 2: enable bluetooth audio service
sudo cp /etc/bluetooth/audio.service /etc/bluetooth/audio.service.backup
#~ sudo mv /etc/bluetooth/audio.service.backup /etc/bluetooth/audio.service

echo '[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service
Autostart=true' | sudo tee /etc/bluetooth/audio.service

sudo cat /etc/bluetooth/audio.service
sudo cp /etc/bluetooth/audio.service $HOME/audio.service

# step 3:
sudo cp /etc/bluetooth/audio.conf /etc/bluetooth/audio.conf.backup
#~ sudo mv /etc/bluetooth/audio.conf.backup /etc/bluetooth/audio.conf

echo '[General]
SCORouting=HCI
[Headset]
DisableHFP=false' | sudo tee /etc/bluetooth/audio.conf

sudo cat /etc/bluetooth/audio.conf
sudo cp /etc/bluetooth/audio.conf $HOME/audio.conf

# step 4:
cp $HOME/.asoundrc $HOME/.asoundrc.backup

echo 'pcm.bluetooth {
    type plug
    slave {
       pcm "bluetooth_hardware"
    }
}
pcm.bluetooth_hardware {
    type bluetooth
    device 20:07:09:15:A9:5A
    # profile "auto"
}' | tee $HOME/.asoundrc

sudo cp $HOME/.asoundrc $HOME/asoundrc

# step 5:
sudo cp /etc/bluetooth/hcid.conf /etc/bluetooth/hcid.conf.backup

echo 'options {
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
}' | sudo tee /etc/bluetooth/hcid.conf

cat /etc/bluetooth/hcid.conf
sudo cp /etc/bluetooth/hcid.conf $HOME/hcid.conf

echo 0000 | sudo tee /etc/bluetooth/pin
sudo cp /etc/bluetooth/pin $HOME/pin

sudo hcidump -X > $HOME/hcidump.txt

sudo /etc/init.d/sysklogd start
sudo /etc/init.d/klogd start
sudo /etc/init.d/bluetooth restart
sudo /etc/init.d/alsa-utils restart
sudo python simple-agent 2> $HOME/simple-agent-log.txt

sudo tail --lines=100 --follow /var/log/syslog

sudo cp /var/log/syslog $HOME/syslog

sudo apt-get install mplayer
mplayer -ao alsa:device=bluetooth test.mp3
arecord -D bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE

hcitool scan
20:07:09:15:A9:5A
sudo sdptool browse 20:07:09:15:A9:5A
sudo sdptool search HS > sptool-search-hs-log.txt
hcitool con > hcitool-con-log.txt
sudo hcitool cc 20:07:09:15:A9:5A
sdptool search 20:07:09:15:A9:5A
hcitool cc 20:07:09:15:A9:5A
ls -hal /var/lib/bluetooth/

# note: why is this not avalible in debian sid
passkey-agent 0000 20:07:09:15:A9:5A


--------------010408050305070205040600
Content-Type: application/x-bzip;
 name="debug-bluez.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="debug-bluez.tar.bz2"

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
fvNqZIyLFBAXyHrTzUMCT8gu5IpwoSGeIcrq
--------------010408050305070205040600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--------------010408050305070205040600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------010408050305070205040600--
