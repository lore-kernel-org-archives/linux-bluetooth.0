Return-Path: <cyrus@holtmann.org>
Date: Sun, 12 Jun 2011 17:31:39 +0200
From: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
To: takeshi.ken.hamasaki@gmail.com
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Re: bluetooth headset on linux
Message-Id: <20110612173139.63533a90.yugiohjcj-mailinglist@laposte.net>
In-Reply-To: <BANLkTim6_pgow2+an11ktfHz49RAoJHK=w@mail.gmail.com>
References: <1307874927.6198.2.camel@localhost>
	<BANLkTim6_pgow2+an11ktfHz49RAoJHK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Ok, so you think this is probably because I use the last version of bluez that I get this compile error.
But as you can see I have the two versions installed, so it should works correctly.

The old bluez version installed on my distro was 3.36
$ apt-cache show libbluetooth-dev | grep Version
Version: 3.36-1

The new bluez version installed on my distro is 4.94.

The 2 libraries version are 2.11.2 and 3.11.2 :
$ ls -l /usr/lib/libbluetooth.*
-rwxr-xr-x 1 root root    938 2011-06-12 01:39 /usr/lib/libbluetooth.la
lrwxrwxrwx 1 root root     22 2011-06-12 17:02 /usr/lib/libbluetooth.so -> libbluetooth.so.3.11.2
lrwxrwxrwx 1 root root     22 2010-12-18 15:25 /usr/lib/libbluetooth.so.2 -> libbluetooth.so.2.11.2
-rw-r--r-- 1 root root  78900 2008-07-12 11:20 /usr/lib/libbluetooth.so.2.11.2
lrwxrwxrwx 1 root root     22 2011-06-12 17:02 /usr/lib/libbluetooth.so.3 -> libbluetooth.so.3.11.2
-rwxr-xr-x 1 root root 104024 2011-06-12 01:39 /usr/lib/libbluetooth.so.3.11.2

If I compile like this plugz, I get the error.
If I change the /usr/lib/libbluetooth.so to target the old libbluetooth.so.2.11.2, I get the same error.

Some people use this headset on Linux[8][9]. So, I think the headset should be supported using bluez...

I read documentation[1][2][3][4][5][6][7][8][9] but I can't bind my headset and my computer using bluetooth... Can you help me?

[1]http://bluetooth-alsa.sourceforge.net/build.html
[2]http://www.linux.ie/articles/bluetoothheadset.php
[3]http://forums.overclockers.com.au/showthread.php?t=694010
[4]https://help.ubuntu.com/community/BluetoothAudio
[5]http://gablog.eu/online/node/80
[6]http://forums.debian.net/viewtopic.php?t=12497
[7]http://penguincopter.blogspot.com/2009/07/linux-bluetooth-komorka-internet.html
[8]http://forums.opensuse.org/english/get-technical-help-here/multimedia/446585-bluetooth-audio-alsa-phonon-kde.html
[9]http://blog.bulix.org/index.php/blog/1008

