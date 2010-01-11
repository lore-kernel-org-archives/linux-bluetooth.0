Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 11 Jan 2010 16:58:22 +0900
Message-ID: <ca39c8ec1001102358k65cb0385sce42113c71cb5a7d@mail.gmail.com>
Subject: Re movon Bluetooth headset
From: Asutosh Das <das.asutosh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I am using a movon BT headset. I have compiled bluez 3.36 for arm and
am able to play music with a plantronics headset. But I am unable to
play with the movon headset.

Chip - BCM4325
Headset - movon & 590plantronics

I have done the following:
1. I have changed the /etc/asound.conf to movon bdaddr
2. I have created a new audio device for movon using the dbus command
line. The following log shows the two audio devices created:

    # dbus-send --system --print-reply --type=method_call
--dest=org.bluez /org/blue
z/audio org.bluez.audio.Manager.ListDevices
method return sender=:1.15 -> dest=:1.48 reply_serial=2
   array [
      string "/org/bluez/audio/device0"
      string "/org/bluez/audio/device1"
   ]

Now device0 -> movon & device1 -> plantronics


3. The following command works fine and I am able to hear the music in
plantronics.
   dbus-send --system --print-reply --type=method_call
--dest=org.bluez /org/blue
z/audio/device1 org.bluez.audio.Sink.Connect

./mplayer -ao alsa:device=bluetooth /Music/AKJS.mp3


4.  The following command doesn't work and gives me an error .

dbus-send --system --print-reply --type=method_call --dest=org.bluez /org/blue
z/audio/device0 org.bluez.audio.Sink.Connect
hcid[1061]: avdtp_ref(0x70f20): ref=2
called: send_request
called: send_req
This func l2cap_connect
l2cap_connect
L2CAP TRANSPORT

This func l2cap_connect
hcid[1061]: stream creation in progress
hcid[1061]: link_key_request (sba=43:25:D1:00:00:00, dba=00:13:7B:40:1E:8E)
hcid[1061]: kernel auth requirements = 0x00
called: l2cap_connect_cb
hcid[1061]: connect(): Connection refused (111)
This error l2cap_connect_cb
hcid[1061]: avdtp_unref(0x70f20): ref=1
hcid[1061]: connect:connect XCASE detected
hcid[1061]: avdtp_unref(0x70f20): ref=0
hcid[1061]: avdtp_unref(0x70f20): freeing session and removing from list


hcid[1061]: Stream setup failed, after XCASE connect:connect
Error org.bluez.Error.Failed: Stream setup failed


5. My default device is device0 i.e. movon
# dbus-send --system --print-reply --type=method_call --dest=org.bluez /org/blue
z/audio org.bluez.audio.Manager.DefaultDevice
method return sender=:1.15 -> dest=:1.49 reply_serial=2
   string "/org/bluez/audio/device0"


I put the movon headset in discoverable mode and the alternate red &
blue blinking changes to blue alone but stream setup fails !!! ...
Please can you let me know what I am missing here ....
-- 
Thank you,
Warm Regards,
Das
