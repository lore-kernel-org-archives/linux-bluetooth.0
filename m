Return-Path: <cyrus@holtmann.org>
Subject: WRT non-UTF-8 device names
From: Fabian Greffrath <fabian@greffrath.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-zFTd4qfL1RamJNsLrEnb"
Date: Fri, 21 May 2010 11:01:56 +0200
Message-ID: <1274432516.4068.29.camel@vfrodo>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-zFTd4qfL1RamJNsLrEnb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Dear Bluez list,

I am experiencing the following issues with the bluez 4.63-2 and
gnome-bluetooth 2.30.0-1 packages from Debian unstable:

Please find two text files attached. UTF-8.txt contains the string
"föøbär" in UTF-8 Unicode encoding, whereas non-UTF-8.txt contains the
same string in ISO-8859 encoding. Now please try the following steps,
assuming your bluetooth device identifies as hci0 and you have
bluetooth-applet running (please note that "no bluetooth icon in the
system" tray also means "it is impossible to establish a connection to
or from this device at all"):

$ sudo hciconfig hci0 name `cat UTF-8.txt`
$ sudo hciconfig -a
[...]
	Name: 'föøbär'

$ sudo /etc/init.d/bluetooth restart
Stopping bluetooth: bluetoothd.
Starting bluetooth: bluetoothd.

[Not necessary here, everything is fine.]

$ sudo hciconfig hci0 name `cat non-UTF-8.txt`

[The bluetooth system tray icon disappears immediately.]

$ sudo hciconfig -a
[...]
	Name: 'f��b�r'

[The device name contains non-UTF-8 characters against the spec.]

$ sudo /etc/init.d/bluetooth restart
Stopping bluetooth: bluetoothd.
Starting bluetooth: bluetoothd.

[Doesn't bring the icon back.]

$ sudo hciconfig hci0 name `cat UTF-8.txt`
$ sudo hciconfig -a
[...]
Name: 'föøbär'

[Now the name is back to the valid variant, but still no icon.]

$ sudo /etc/init.d/bluetooth restart
Stopping bluetooth: bluetoothd.
Starting bluetooth: bluetoothd.

[Finally the icon is back.]

Long story short: If the bluetooth adapter's device name contains
non-UTF-8 characters (which my dongle does by default), it requires a
manual device name change and a restart of the daemon (!) to bring the
device back to life. I have previously posted a patch to this list which
fixes this issue by instantly converting faulty device names to UTF-8
and writing them back to the device during the device configuration
phase:

<http://marc.info/?l=linux-bluetooth&m=127315737929319&w=2>

However, I have been told that my "patch might be just working around
the real issue instead of fixing it" and that "It sounds like there's
something else wrong in the initialization process which makes the
initialzation fail if the adapter contains some invalid default name".

So, please, try the steps I presented above yourself and tell me what is
wrong so I can attempt to fix the root of the problem. I am really
itching to get this issue fixed in the short term.

Thank you very much!

Cheers,
Fabian



--=-zFTd4qfL1RamJNsLrEnb
Content-Disposition: attachment; filename="non-UTF-8.txt"
Content-Type: text/plain; name="non-UTF-8.txt"; charset="UTF-8"
Content-Transfer-Encoding: 8bit

f��b�r

--=-zFTd4qfL1RamJNsLrEnb
Content-Disposition: attachment; filename="UTF-8.txt"
Content-Type: text/plain; name="UTF-8.txt"; charset="UTF-8"
Content-Transfer-Encoding: 8bit

föøbär

--=-zFTd4qfL1RamJNsLrEnb--

