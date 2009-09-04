Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2009 09:58:42 -0400
Message-ID: <e72c2e480909040658k53f543cbx3dc39025d589a070@mail.gmail.com>
Subject: hci configuration and 4.51 build problems
From: Philippe Godin <godp1301@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Good day,

I need some help trying to figure out how to properly configure a usb
bluetooth dongle at startup.
I have successfully cross-compiled bluez 4.50 for an arm processor
using the 2.6.22 kernel on a custom filesystem . It starts using the
udev rules provided (note that the usb device is always plugged in). I
need the hci0 device to be up and to allow piscan mode using no
timeout, no security and no authentification. Is it possible for the
bluetoothd daemon to configure the device when it starts? I could not
find any documentation on this matter. Only the main.conf file which
states that setting DiscoverableTimeout to 0 should make the device
discoverable forever which doesn't work obviously.
I can provide extended commands output if needed.


Also, I have downloaded the latest version of bluez 4.51. The release
note states that the build has now been fixed. I tried and I am not
able to compile it. It seems that the --disable-audio argument to the
configure script is ignored. When running make all, it tries to
compile the audio plugin and can't because it needs alsa librairies.
If someone need further information just let me know. I think this can
be easily reproduced on any setup.

Thank you in advance
