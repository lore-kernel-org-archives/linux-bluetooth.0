Return-Path: <cyrus@holtmann.org>
Message-ID: <48092EF6.3090603@powercraft.nl>
Date: Sat, 19 Apr 2008 01:29:58 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------080406000302090101060401"
Subject: [Bluez-users] Samsung WEP210 Bluetooth Headset
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
--------------080406000302090101060401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This message contains the following attachment(s):
Samsung WEP210 Bluetooth Headset.txt
simple-agent

Hello everybody,

I bought a new headset and am trying to get it working under debian sid 
3.30-2 bluez-utils

However i cant connect to the device when it is in pairing mode.

I have attached my working files with a lot of background information.

Can somebody help me to get the device working.

Kind regards,

Jelle

--------------080406000302090101060401
Content-Type: text/plain;
 name="Samsung WEP210 Bluetooth Headset.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Samsung WEP210 Bluetooth Headset.txt"

#!/bin/bash

http://gentoo-wiki.com/HOWTO_use_a_bluetooth_headset
http://www.wahlau.org/failed_getting_bluetooth_headset_to_work_with_ubuntu_edgy_eft
http://www.think-future.de/wiki/index.php?title=Bluetooth

sudo cp /etc/bluetooth/audio.conf /etc/bluetooth/audio.conf.backup
sudo mv /etc/bluetooth/audio.conf.backup /etc/bluetooth/audio.conf


cp $HOME/.asoundrc $HOME/.asoundrc.backup

# step 1: install bluetooth alsa software
sudo apt-get install bluetooth-alsa bluez-utils

# step 2: enable bluetooth alsa service


echo '[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service
Autostart=true' | sudo tee /etc/bluetooth/audio.conf

echo '[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service
Autostart=true' | sudo tee /etc/bluetooth/audio.service

cat /etc/bluetooth/audio.service

cat /etc/bluetooth/audio.conf

hcitool scan
20:07:09:15:A9:5A
sudo sdptool browse 20:07:09:15:A9:5A

sudo sdptool search HS
Inquiring ...
Searching for HS on 20:07:09:15:A9:5A ...
Service Name: Headset
Service RecHandle: 0x10001
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

echo 'pcm.bluetooth {
   type bluetooth
   device 20:07:09:15:A9:5A
   profile "auto"
}' | tee --append $HOME/.asoundrc

sudo hcitool cc 20:07:09:15:A9:5A

cat $HOME/.asoundrc

sudo /etc/init.d/bluetooth restart
sudo /etc/init.d/alsa-utils restart

sudo apt-get install mplayer

mplayer -ao alsa:device=bluetooth test.mp3
arecord -D bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE

sudo modprobe snd-bt-sco
dbus-send --system --dest=org.bluez /org/bluez/hci0 org.bluez.Adapter.SetMode string:discoverable
btsco -v  20:07:09:15:A9:5A
sudo a2dpd

pcm.bluetooth {
    type plug
    slave {
       pcm "bluetooth_hw"
    }
}

pcm.bluetooth_hw {
    type bluetooth
    device 00:0B:2E:5B:30:E6
}

sudo hidd --connect 20:07:09:15:A9:5A
sudo l2ping 20:07:09:15:A9:5A

passkey-agent 0000 20:07:09:15:A9:5A

echo 0000 | sudo tee /etc/bluetooth/pin

sdptool search 20:07:09:15:A9:5A
hcitool cc 20:07:09:15:A9:5A
sudo /etc/init.d/syslog restart

sudo /etc/init.d/sysklogd start
sudo /etc/init.d/klogd start

sudo cat /var/log/syslog

sudo vim /etc/bluetooth/hcid.conf
pin_helper /etc/bluetooth/feed-pin.sh;


echo '#!/bin/sh
echo "PIN:0000"' | sudo tee /etc/bluetooth/feed-pin.sh


Apr 19 00:56:29 debian-eeepc hcid[5705]: Audio API: received BT_GETCAPABILITIES_REQ
Apr 19 00:56:29 debian-eeepc hcid[5705]: Audio API: sending BT_GETCAPABILITIES_RSP
Apr 19 00:56:29 debian-eeepc hcid[5705]: Audio API: received BT_SETCONFIGURATION_REQ
Apr 19 00:56:29 debian-eeepc hcid[5705]: config sco - device = 20:07:09:15:A9:5A access_mode = 2
Apr 19 00:56:32 debian-eeepc hcid[5705]: pin_code_request (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 00:56:32 debian-eeepc hcid[5705]: connect(): Connection refused (111)
Apr 19 00:56:32 debian-eeepc hcid[5705]: config failed
Apr 19 00:56:32 debian-eeepc hcid[5705]: Audio API: sending BT_SETCONFIGURATION_RSP

Package: bluez-utils
Version: 3.30-2



dbus-send --system --type=method_call --print-reply --dest=":1.20" \
/org/bluez/audio org.bluez.audio.Manager.CreateDevice string:20:07:09:15:A9:5A

dbus-send --system --type=method_call --print-reply --dest=":1.20" \
"/org/bluez/audio/device0" org.bluez.audio.Sink.Connect

sudo python simple-agent
Agent registered
RequestPasskey (/hci0/dev_20_07_09_15_A9_5A)


Apr 19 01:24:29 debian-eeepc hcid[2353]: Audio API: received BT_GETCAPABILITIES_REQ
Apr 19 01:24:29 debian-eeepc hcid[2353]: Audio API: sending BT_GETCAPABILITIES_RSP
Apr 19 01:24:29 debian-eeepc hcid[2353]: Audio API: received BT_SETCONFIGURATION_REQ
Apr 19 01:24:29 debian-eeepc hcid[2353]: config sco - device = 20:07:09:15:A9:5A access_mode = 2
Apr 19 01:24:33 debian-eeepc hcid[2353]: link_key_request (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 01:24:36 debian-eeepc kernel: usb 1-2: USB disconnect, address 4
Apr 19 01:24:36 debian-eeepc hcid[2353]: HCI dev 0 down
Apr 19 01:24:36 debian-eeepc hcid[2353]: Stopping security manager 0
Apr 19 01:24:36 debian-eeepc hcid[2353]: Device hci0 has been disabled
Apr 19 01:24:36 debian-eeepc hcid[2353]: connect(): Software caused connection abort (103)
Apr 19 01:24:36 debian-eeepc hcid[2353]: config failed
Apr 19 01:24:36 debian-eeepc hcid[2353]: Audio API: sending BT_SETCONFIGURATION_RSP
Apr 19 01:24:37 debian-eeepc hcid[2353]: HCI dev 0 unregistered
Apr 19 01:24:37 debian-eeepc hcid[2353]: Unregister path: /org/bluez/hci0
Apr 19 01:24:37 debian-eeepc hcid[2353]: Device hci0 has been removed
Apr 19 01:24:37 debian-eeepc kernel: usb 1-2: new full speed USB device using uhci_hcd and address 5
Apr 19 01:24:37 debian-eeepc kernel: usb 1-2: configuration #1 chosen from 1 choice

--------------080406000302090101060401
Content-Type: text/plain;
 name="simple-agent"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simple-agent"

#!/usr/bin/python

import gobject

import dbus
import dbus.service
import dbus.mainloop.glib

class Agent(dbus.service.Object):
	@dbus.service.method("org.bluez.Agent",
					in_signature="", out_signature="")
	def Release(self):
		print "Release"
		mainloop.quit()

	@dbus.service.method("org.bluez.Agent",
					in_signature="os", out_signature="")
	def Authorize(self, device, uuid):
		print "Authorize (" + device + ", " + uuid + ")"
		return

	@dbus.service.method("org.bluez.Agent",
					in_signature="o", out_signature="s")
	def RequestPasskey(self, device):
		print "RequestPasskey (" + device + ")"
		return "0000"

	@dbus.service.method("org.bluez.Agent",
					in_signature="s", out_signature="")
	def ConfirmModeChange(self, mode):
		print "ConfirmModeChange (" + mode + ")"
		return

	@dbus.service.method("org.bluez.Agent",
					in_signature="", out_signature="")
	def Cancel(self):
		print "Cancel"
		return

if __name__ == '__main__':
	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

	bus = dbus.SystemBus()
	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
							"org.bluez.Manager")

	path = manager.DefaultAdapter()
	adapter = dbus.Interface(bus.get_object("org.bluez", path),
							"org.bluez.Adapter")

	path = "/test/agent"
	object = Agent(bus, path)

	adapter.RegisterAgent(path)
	print "Agent registered"

	mainloop = gobject.MainLoop()
	mainloop.run()

	#adapter.UnregisterAgent(path)
	#print "Agent unregistered"

--------------080406000302090101060401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--------------080406000302090101060401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------080406000302090101060401--
