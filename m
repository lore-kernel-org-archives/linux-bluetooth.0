Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2009 19:06:42 +0530
Message-ID: <d3e5a0a00903310636rccf9a98v2c9f4233c981e92@mail.gmail.com>
Subject: SCO Support over USB
From: Vivek Agarwal <vivek.mailinglists@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear all,

I want to use my bluetooth headset with my embedded platform using a
bluetooth USB dongle.
The main application is to be able to use it with a SIP application
running on the embedded Platform..

I am facing problems making to work.. I will try to explain the
scenario in the mail below please help me where i am going wrong..

First about the embedded platfrom, it is iMX31 based iMX31ADS
evaluation board running 2.6.24 kernel.

Step 1) I tried to compile the bluez-3.36 and enabled the hci_usb
kernel module and checked using
aplay if i am able to hear sound.
I was not succcessful.

Step 2) I tried putting the 2.6.27 bluetooth related changes into the
2.6.24 kernel and see if there changes make it work..

I made all the bluetooth related files similar to the 2.6.27 kernel
bluetooth files except hci_sysfs.c which i kept intact.

Once i made these changes i was able to record and play individually
but get the following problems
	a) the get the following kernel messages when i try to play a .wav
file using aplay..

		hci_scodata_packet: hci0 SCO packet for unknown connection handle 5633
		hci_scodata_packet: hci0 SCO packet for unknown connection handle 9985
		hci_scodata_packet: hci0 SCO packet for unknown connection handle 49664
		hci_scodata_packet: hci0 SCO packet for unknown connection handle 181
		hci_scodata_packet: hci0 SCO packet for unknown connection handle 11264
		hci_scodata_packet: hci0 SCO packet for unknown connection handle 32769
		hci_scodata_packet: hci0 SCO packet for unknown connection handle 49153

	b) i am not able to do an echo test using the following method. The
dont hear any echo.
		arecord -D bt_audio -f S16_LE | aplay -D bt_audio -f S16_LE
	if the run the hcid in debug mode below are the debug messages..

		hcid[1776]: Accepted new client connection on unix socket (fd=21)
			hcid[1776]: Audio API: received BT_GETCAPABILITIES_REQ
			hcid[1776]: Audio API: sending BT_GETCAPABILITIES_RSP
			hcid[1776]: Audio API: received BT_SETCONFIGURATION_REQ
			hcid[1776]: config sco - device = 00:0C:78:72:7E:13 access_mode = 1
			hcid[1776]: /org/bluez/audio/device2: Connecting to
00:0C:78:72:7E:13 channel 2
			hcid[1776]: State changed /org/bluez/audio/device2:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
			hcid[1776]: Accepted new client connection on unix socket (fd=23)
			hcid[1776]: Audio API: received BT_GETCAPABILITIES_REQ
			hcid[1776]: Audio API: sending BT_GETCAPABILITIES_RSP
			hcid[1776]: link_key_request (sba=00:80:98:98:71:10, dba=00:0C:78:72:7E:13)
			hcid[1776]: kernel auth requirements = 0x00
			hcid[1776]: stored link key type = 0x00
			hcid[1776]: /org/bluez/audio/device2: Connected to 00:0C:78:72:7E:13
			hcid[1776]: State changed /org/bluez/audio/device2:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
			hcid[1776]: State changed /org/bluez/audio/device2:
HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
			hcid[1776]: SCO socket opened for headset /org/bluez/audio/device2
			hcid[1776]: SCO fd=24
			hcid[1776]: Audio API: sending BT_SETCONFIGURATION_RSP
			hcid[1776]: State changed /org/bluez/audio/device2:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
			hcid[1776]: Audio API: received BT_STREAMSTART_REQ
			hcid[1776]: Audio API: sending BT_STREAMSTART_RSP
			hcid[1776]: Audio API: sending BT_STREAMFD_IND
			hcid[1776]: Audio API: received BT_SETCONFIGURATION_REQ
			hcid[1776]: config sco - device = 00:0C:78:72:7E:13 access_mode = 2
			hcid[1776]: Audio API: sending BT_SETCONFIGURATION_RSP
			hcid[1776]: Audio API: received BT_STREAMSTART_REQ
			hcid[1776]: Audio API: sending BT_STREAMSTART_RSP
			hcid[1776]: Audio API: sending BT_STREAMFD_IND
			hcid[1776]: Unix client disconnected (fd=23)
			hcid[1776]: Unix client disconnected (fd=21)
			hcid[1776]: State changed /org/bluez/audio/device2:
HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
			hcid[1776]: State changed /org/bluez/audio/device2:
HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED

Please help me resolve the 2 problems i am facing and do let me know
if any one has tried connecting a bluetooth headset AT-BT220 to the
system.

Thanks
Vivek
L&T EmSyS.
