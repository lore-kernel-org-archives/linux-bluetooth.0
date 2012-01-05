Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 5 Jan 2012 14:07:25 +0100
Message-ID: <CA+uOhx5kPJd8efy+AOsMURN61buitD5v==n7Xfanr9RuNUywxw@mail.gmail.com>
Subject: Device-initiated HID connections: How to pair? (PS Move)
From: Thomas Perl <th.perl@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm working on getting the PS Move Controller to work with Linux[1].
Right now, I'm disabling bluetoothd's "input" plugin and listen to the
two l2cap sockets directly, which is ugly and prevents using "normal"
Bluetooth HID devices together with a PS Move controller. Ideally, I
want bluetoothd to accept the connection and use Linux' hidraw
interface to communicate with the controller. The GUI pairing in GNOME
3 doesn't work, no matter what PIN mode (automatic, 0000, do not pair)
I select. On Windows, it works after pairing it without PIN, and OS X
apparently allows the connection without any question or pairing.

Is there any way to tell bluetoothd "here's a Bluetooth address, and
if you get a HID connection from it, accept the connection"? I added
an entry "XX:XX:XX:XX:XX:XX [all]" to
/var/lib/bluetooth/YY:YY:YY:YY:YY:YY/trusts, but this entry gets
removed at first connection (the X-address being the controller's
address and the Y-address being my host adapter's address) and I'm
pretty sure that I'm not supposed to hand-edit files in
/var/lib/bluetooth/ ;) When pressing the PS button on the controller
(which tries to establish a Bluetooth connection with the host), I
get:

bluetoothd[5487]: Refusing input device connect: No such file or directory (2)

The pairing works about the same way as with the Sixaxis controller
(use USB HID feature reports to "upload" the Bluetooth host address to
the controller, and then the controller will connect to this address
as HID device).

I'd be also be grateful for any hints on where to start writing a
patch if device-initiated HID connections are not supported - I dug
around a bit in bluetoothd's input module code, but got stuck.

I'm using Bluez in Debian, with the following package versions installed:

ii  bluetooth                 4.96-3
ii  bluez                     4.96-3
ii  bluez-alsa                4.96-3
ii  bluez-cups                4.96-3
ii  bluez-gstreamer           4.96-3
ii  bluez-hcidump             2.1-1
ii  gir1.2-gnomebluetooth-1.0 3.2.1-1
ii  gnome-bluetooth           3.2.1-1
ii  libbluetooth-dev          4.96-3
ii  libbluetooth3             4.96-3
ii  libgnome-bluetooth8       3.2.1-1

Thanks for any help or pointers :)
Thomas

[1] http://thp.io/2010/psmove/
