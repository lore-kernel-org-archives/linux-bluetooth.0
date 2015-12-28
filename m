Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 28 Dec 2015 12:48:57 +0100
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <mkj@gotu.dk>
To: linux-bluetooth@vger.kernel.org
Subject: Bose AE2 SoundLink issues
Message-ID: <20151228114857.GA16950@mkjlap.gotu.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm having trouble "completing" the pairing with my Bose SoundLink
around-ear wireless headphones II (AE2) and Thinkpad X1, running
Debian stretch (testing/sid)

Let me start by stating that the headphones works flawlessly with my
Android 5 smartphone, both sound and the buttons on the headphones.

When pairing with the smartphone the pairing procedure makes the
bluetooth led on the headphones blink first blue, then white, shortly,
then flashing contant white, and the voice in the headphones says
"Connected to <name-of-the-smartphone>". According to Android, the
headphones are used for: "Phone audio", "Media audio", and
"Contact sharing (pbap server)".



Now on to the laptop. Status from bluetooth.service:

bluetoothd[811]: Not enough free handles to register service
bluetoothd[811]: Not enough free handles to register service
bluetoothd[811]: Current Time Service could not be registered
bluetoothd[811]: gatt-time-server: Input/output error (5)
bluetoothd[811]: Not enough free handles to register service
bluetoothd[811]: Not enough free handles to register service
bluetoothd[811]: Sap driver initialization failed.
bluetoothd[811]: sap-server: Operation not permitted (1)

Using only bluetoothctl (no desktop environment), I can discover the
device, see it's UUID's:

[NEW] Device 08:DF:1F:52:58:A0 Bose AE2 SoundLink
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 0000110d-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 0000110f-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 00001130-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 0000112e-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 00001108-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 00001131-0000-1000-8000-00805f9b34fb
[CHG] Device 08:DF:1F:52:58:A0 UUIDs: 0000febe-0000-1000-8000-00805f9b34fb

Pairing with the headphones, after setting the headphones in pairing
 mode and a voice in the headphones says "Ready to pair", using:

pair 08:DF:1F:52:58:A0

... makes the kernel produce:

[19186.946754] Bluetooth: SMP security requested but not available

... and the bluetooth.service produce:

bluetoothd[811]: Unable to register GATT service with handle 0x0001 for device 08:DF:1F:52:58:A0
bluetoothd[811]: Unable to register GATT service with handle 0x0001 for device 08:DF:1F:52:58:A0

bluetoothctl lists the headphones as paired, and the prompt on changes
to the name of the device from "[bluetooth]#". The headphones
bluetooth led changes from blinking blue to blinking white, but never
stops blinking white, and no sound devices gets added to ALSA or pulseaudio.


Maybe the headphones requires some features of my OS? Maybe it
discovers for the "pbap server" on my laptop, or something? Maybe
Bluetooth LE SMP issues?

I'm willing to test, analyse more, or otherwise aid in the development if
anything if it's required.

/Martin

