Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 30 Dec 2011 13:26:21 +0000
Message-ID: <CAMp=V3rgF2GdEqcTpkpB6QGc03JHmawh7GM0h=rvqyHcQHdg7g@mail.gmail.com>
Subject: Bluetooth audio skipping
From: Michael Maddern <michael.maddern@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm not sure I'm supposed to be posting here, but on bluez.org both
the development and user mailings lists point here.

I'm having problems getting bluetooth audio (a2dp) to work without
stuttering, skipping, speeding up etc. I'm using bluetooth speakers
(Creative D100). It works okay if it is right next to my laptop, but
when I touch the speaker or move it more than about 1 meter, it starts
stuttering.

The bluetooth adapter is a Broadcom BCM2070 (which is a class 1
adapter). I'm using kernel 3.1.5-1.

I've tested it with the Bluez 4.96, and I've also compiled 4.97 but
it's no better. I've tried using Alsa and PulseAudio, the problem is
the same with both.  I've tried adjusting the link mode
(accept,master) and link policies (hold,park) as recommended but it
makes no difference.

I've tried disabling WiFi, turning off my router, and all other
bluetooth devices, it still makes no difference at all.

When I dual boot my laptop into Windows 7 and connect the speaker it
works flawlessly. I'm able to take the speaker through 2 rooms (about
10 minutes), and it's still playing smoothly.

I really want it to work as well under Linux, so any help would be
greatly appreciated.

Thank you,
Michael
