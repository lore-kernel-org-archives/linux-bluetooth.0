Return-Path: <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Dr . H . Nikolaus Schaller" <hns@goldelico.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] UART slave devices using serio
Date: Wed, 24 Aug 2016 18:24:30 -0500
Message-Id: <20160824232437.9446-1-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This is a new approach to supporting UART slave devices using the
existing serio bus. After Arnd's proding, I took another look at serio
and decided extending it does make sense. Using serio primarily requires
adding DT based device matching and supporting buffer based write and
receive.

Currently, I'm using the existing serio serport ldisc for testing. This
requires using inputattach to open the tty and set the ldisc which in
turn registers a serio port with the serio core:

inputattach -bare /dev/ttyAMA1

Once a tty_port based serio port driver is in place, this step will not
be needed. Supporting cases like a USB UART will also work if the USB
UART is described in DT. If not described in DT, I'm not sure if the
existing serio manual binding is sufficient (Need to figure out how that
works). Slave drivers also need other ways to specify additional data
using module params perhaps. Getting DT overlays to work for
non-discoverable devices behind discoverable buses (i.e. detached from
a base DT) is another option, but that's not yet supported in general.

I've done all the serio changes in place, but ultimately I think at
least the core of serio should be moved out of drivers/input/. I don't
think it belongs under drivers/tty/ or drivers/tty/serial/, so
drivers/serio/?

BT is working under QEMU to the point a slave driver can bind to a
serio port device via DT, register as a BT device, start sending out
initial packets and receive data (typed at a terminal). Now I need to
find a real device.

A git branch is available here[1]. Note it will get rebased.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial-bus-serio


Rob Herring (6):
  serio: add DT driver binding
  serio: serport: hacks to get DT probe to work
  serio: add buffer receive and write functions
  serio: serport: add support for buffered write and receive
  serio: add serial configuration functions
  bluetooth: hack up ldisc to use serio

 drivers/bluetooth/hci_ldisc.c | 261 +++++++++++++++++-------------------------
 drivers/bluetooth/hci_uart.h  |   3 +
 drivers/input/serio/serio.c   |  34 +++++-
 drivers/input/serio/serport.c |  49 ++++----
 include/linux/serio.h         |  59 +++++++++-
 5 files changed, 223 insertions(+), 183 deletions(-)

--
2.9.3
