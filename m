Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Reply-To: pghatwork@gmail.com
Date: Fri, 10 Sep 2010 14:53:59 +0200
Message-ID: <AANLkTikTBdr4U1bPtfXWhgLgdvWDMPJrFjBCktPL40dg@mail.gmail.com>
Subject: Request for input regarding new driver in MFD for GPS_Bluetooth_FM
 controller CG2900
From: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
To: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: linus.walleij@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Me and my colleagues here at ST-Ericsson SA are working on a Linux
driver for our connectivity combo chip CG2900
(http://www.stericsson.com/product/223489.jsp).
CG2900 is a controller containing GPS, Bluetooth, and FM radio (also
called GBF-controller), which can be connected to the platform using
UART or SPI as transport. The communication towards the different
functionalities is done via so-called HCI H:4 channels, where the
first byte in the message determines the channel being used for the
particular message. Channels 1, 2, 3, and 4 are used for Bluetooth
(Command, ACL, SCO, and Event) according to Bluetooth specification
while 8 is used for FM radio and 9 is used for GPS. There are also a
few other channels used for various debug purposes.

Since there are multiple functionalities we thought that a good place
to put this driver is as a MFD driver. I hope you agree?
As can be seen below there is also a driver for the BlueZ stack, cg2900_hci.

The architecture of the driver is as follows:
 - cg2900_core: Implements driver API. Keeps track of opened channels,
registered chip handlers, and transport used. When first user
registers it requests startup of chip. When last user deregisters it
requests shutdown of chip. Uses Bluetooth HCI Local Version
Information to determine chip connected.
 - cg2900_chip: Implements chip specific features for the CG2900.
Downloads patches and settings during chip startup.
 - stlc2690_chip: As cg2900_chip but for STLC2690 controller (BT/FM combo).
 - cg2900_uart: Registers as a driver for the TTY Line Discipline
N_HCI. When transport is opened from User Space, e.g. from hciattach,
it registers as transport to cg2900_core.
 - cg2900_spi: Registers to the SPI driver. When being probed it
registers as transport to cg2900_core.
 - cg2900_char_device: Exposes all channels as character devices so
they can be used by user space stacks.
 - cg2900_hci: Registers to BlueZ (i.e. not a MFD driver) and to the
CG2900 MFD driver. Acts as a connector for Bluetooth functionality
between BlueZ and CG2900 MFD driver.

The API as it is now contains functions for:
 - register
 - deregister
 - alloc_skb
 - write
 - reset
 - get_chip_revision

For a user the normal way to work would be:
 - Register to the driver. The user supplies a name to the channel for
look-up and a set of callbacks for receiving data and detecting reset.
The register function returns, if successful, a pointer to a device
structure used when calling the other functions.
 - Send data to the chip using the write function, supplying device
structure and sk_buffer.
 - Receive data from the chip through the read callback, which
supplies device structure and sk_buffer.
 - Perform reset of the chip of a lock-up is detected by the stack.
 - Deregister from the driver.

Compared to other MFD drivers there are some major differences:
 - The CG2900 driver does not use the MFD core functions, such as
mfd_add_devices, but that could be changed quite easily by replacing
register and deregister with users using the MFD device probe instead.
This could however collide with the next difference.
 - The CG2900 driver is made with freedom of choice and usage in mind.
It is possible to dynamically open and close channels and even
transports. This means that you could open a channel first from Kernel
space (using API), then it could be closed and another user could open
it from User space (using char dev). From what I've heard this is not
very popular among the Linux community, but I really like the way it
works. Note that any channel can only have one user at a time.

I know that there are also other HCI combo chips with Linux drivers,
e.g by TI. If there is a wish we could modify this driver from cg2900
to e.g. hci_combo and make it neutral inside cg2900_core from which
chip is actually being used. This way any manufacturer could use it as
a generic framework for their multifunction HCI combo devices.


So if you've been able to read through this long message I would like
you to think through and voice your opinion about what I've presented
above. Especially:
 - Shall I use the MFD functions instead of our own API?
 - Is it OK to dynamically use the channels either from Kernel or User space?
 - Would you prefer this to be a ST-Ericsson CG2900 chip driver only
or would you like an HCI-Combo framework where you could add your own
chips?

Best regards,

Pär-Gunnar Hjälmdahl
Senior Staff Engineer
ST-Ericsson SA
Lund, Sweden
