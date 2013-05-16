Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alex Deymo <deymo@chromium.org>
Date: Wed, 15 May 2013 21:38:17 -0700
Message-ID: <CAGd9gwgFnuqiYMkYgb=2Ssh8ScoR45H=PZWG-BOXb8kwjnMMNg@mail.gmail.com>
Subject: audio: Connect doesn't return when audio device is off.
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I was debugging this issue when I found that may be related with this
new concept of "service", anyway this issue is present in bluez 5.4
and 5.5 (did not try with previous versions).

The problem is easy to reproduce. Again I'm using the Bose SoundLink
model 404600 but it should work with any audio device. The steps are
as follow:
1. power on the adapter, scan and pair to the device.
2. trust the device.
3. turn off the device (short-press once the power button)
4. attempt to connect to the device from the bluetoothctl.
The D-Bus Connect call doesn't return. I think that in general the
Connect call doesn't return on failure, it only returns when it
succeeds.
I can also run into this same issue attempting to connect from the
device (short-press the bluetooth button on this device) and running
the "connect" command from bluetoothctl immediately after. In this
case the device successfully connects to the host, but the attempt to
connect from the host fails and Connect doesn't return. The funny
thing is that the device works and you can play music to it.

I would appreciate if you can help me to debug this issue. I tracked
down the connection failure to connect_lost() being called.... but I'm
sure should the audio profile notify the device or the service about
the profile connection failure.

Thanks!
Alex.
