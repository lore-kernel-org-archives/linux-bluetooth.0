Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Jun 2011 06:06:50 +0200
From: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth headset works!
Message-Id: <20110619060650.fb140f72.yugiohjcj-mailinglist@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello,

I am happy to tell you I finally do something very important : my bluetooth headset works!

This is my mini HOW-TO in 7 steps :

1. Install bluez.

2. Clear old bounded bluetooth devices :
$ sudo rm -rfv /var/lib/bluetooth/*

3. Put the headset in pairing mode.

4. Find the MAC address :
$ hcitool scan
Scanning ...
	00:1E:7C:01:0A:5E	Philips SHB9000

5. Pair the headset :
$ /usr/share/doc/bluez/examples/simple-agent hci0 00:1E:7C:01:0A:5E
Release
New device (/org/bluez/19766/hci0/dev_00_1E_7C_01_0A_5E)

6. Configure ~/.asoundrc :
pcm.!default {
        type bluetooth
        device 00:1E:7C:01:0A:5E
        profile "auto"
}

7. Play a song :
$ vlc ~/documents/downloads/audio/playlist.m3u

Now, I would like to know something :
-Why simple-agent works but bluetooth-agent doesn't work? (step 5)
-How to tell in ~/.asoundrc to use the normal pcm device if the bluetooth headset isn't bounded or have multiple audio devices? (step 6)

Thank you.

