Return-Path: <cyrus@holtmann.org>
From: Pavel Volkov <negaipub@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Bluez 5, A2DP headphones
Date: Sun, 09 Feb 2014 12:37:02 -0800 (PST)
Message-ID: <1481471.Fs3M2bYstJ@melforce>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm having trouble connecting to my headphones after upgrading from Bluez 4 to 
Bluez 5 with a few more people.
Link to Gentoo Bugzilla: https://bugs.gentoo.org/show_bug.cgi?id=499908

Summary: 
I'm not using PulseAudio and this is the error from system journal:

2月 09 15:01:54 melforce bluetoothd[12825]: a2dp-sink profile connect failed for 
00:02:3C:31:96:12: Protocol not available

It appears when I try to connect to it from bluedevil (KDE's Bluetooth stack) 
or when mplayer2 tries to open the ALSA device.

Do you have any clues?
