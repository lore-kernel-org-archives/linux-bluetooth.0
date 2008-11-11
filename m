Return-Path: <cyrus@holtmann.org>
Message-ID: <5a14e9b50811111406m5e9e56c4u598b93506cbb8372@mail.gmail.com>
Date: Tue, 11 Nov 2008 23:06:55 +0100
From: "XazZ XazZ" <xazz.xazz@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Problem with bluez and a bluetooth headset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

good evening everyone

Few days ago I got a new, beautiful bluetooth headset.
It's a Nokia BH-503
My PC got an "ID 1131:1001 Integrated System Solution Corp. KY-BT100
Bluetooth Adapter"
For the usb dongle part from lsusb -vv check the link at the bottom (lsusb)

Sadly I'm having some trouble getting my headset to work with my PC.
Neither I can play music over my headset nor can I record something over it.

When I'm trying to record sound via `arecord -D plug:bluetooth -f
S16_LE test.wav` I get the following output:
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 8000 Hz,
Mono
ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params)
BT_SETCONFIGURATION failed : Input/output error(5)
arecord: set_params:1022: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: 0

skype tells me:
ALSA lib pcm_bluetooth.c:1619:(bluetooth_init) BT_GETCAPABILITIES
failed : Input/output error(5)

I've added a link to bluetoothd's logfile when trying to record via arecord
(link name is bluetoothd.log)
I also added bluetoothd's logfile when trying to do the sound
test in skype (link name is bluetoothd.log.0)

The bluez version I'm running: 4.17

I also tried to get my headset working with bluez 3.32
with 3.32 I could play music over my headset - but I could NOT record sound.
I googled and some people came up with the fact that pulseaudio might
break bluetooth sound: I do not have pulseaudio installed or running

I also tried changing the bluetooth section in my ~/.asoundrc
I changed profile to: "voice" then to "hifi" and then to "auto" -> it
never worked

In my dmesg I get "hci_scodata_packet: hci0 SCO packet for unknown
connection handle 2" and "hci_scodata_packet: hci0 SCO packet for
unknown connection handle 65398"
according to jhe from IRC: <jhe> that error sounds like its sending
SCO packets without having informed the host (bluez) that there's a
SCO connection
NOTE: its == my bluetooth dongle

Earlier I also got some stack traces - but I couldn't reproduce those
on a non-tainted system yet:
http://nopaste.ch/3992403666920ab.html

As soon as I'm able to reproduce on a non-tainted kernel I'll post an update

If you need more information please feel free to ask - I'll post it as
soon as I can.

Thanks in advance
XazZ

dmesg.log: http://nopaste.ch/25dd0e4b29d440a.html
bluetoothd.log: http://nopaste.ch/e395401980f8100.html
bluetoothd.log.1: http://nopaste.ch/fe11fe7cbe6a598.html
lsusb: http://nopaste.ch/408c541369cfd9f.html
