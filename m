Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: =?ISO-8859-2?Q?Stanis=B3aw_Pitucha?= <viraptor@gmail.com>
Date: Sat, 9 Nov 2013 22:33:38 +0000
Message-ID: <CAFrYPTMT-tvL=HswUuqtOJ-Jr_O5eanVGfHp7Y=v_O6=hV0h+A@mail.gmail.com>
Subject: Debugging broken audio stream
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
I'm having issues with using a remote audio sink device and I can't
find any clear indications of a problem.

My current config is:
- kernel 3.11.6 (x86_64)
- bluez 5.10
- pulseaudio 4.0
- ID 0a5c:21e6 Broadcom Corp. BCM20702 Bluetooth 4.0 [ThinkPad]  (btusb driver)

The receiving device is Logitech's wireless audio adapter.

When sending data from android devices (4.1, 4.3) everything works
without issues, so I think the receiver seems ok.

On the laptop side which is having problems, the initial connection /
pairing works without issues, but the sound stream is very unstable
(unusable really: 1 second of sound, 5 of silence, repeat...) and
sometimes the connection drops / reconnects on its own. Sometimes it
works for a couple of seconds before failing.
Sometimes there's a stacktrace reported from the kernel (see
https://bugs.archlinux.org/task/37697 ), but not always.
The debug output from bluetoothd doesn't report any specific issues
(as far as I can tell from the log) until it disconnects completely
("Abort: Connection timed out (110)")
A full session in debug mode (connect, try to play some music,
connection times out, tries playing again, killing bluez) is available
at http://pastebin.com/n7qfumYR

Syslog contains pages of repeated messages like this (different
time/sizes in each line, chosen smallest/biggest I can see):
Nov 09 20:14:00 gumby pulseaudio[19585]: [bluetooth]
module-bluez5-device.c: Skipping 116 us (= 20 bytes) in audio stream
...
Nov 09 20:14:03 gumby pulseaudio[19585]: [bluetooth]
module-bluez5-device.c: Skipping 564192 us (= 99520 bytes) in audio
stream
I'm not sure how to prove the issue is definitely on either the bluez,
or pulseaudio's side...

What more can I do in this case? What other debugging options do I
have? Would capturing the bluetooth packets be useful at all?
I assume the bluetooth in laptop is not damaged/unsupported, because I
can exchange files between it and the android devices.

Any/all help appreciated.

-- 
KTHXBYE,

Stanisław Pitucha
