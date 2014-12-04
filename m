Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Dec 2014 17:09:19 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: tedd.an@intel.com, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Subject: [RFC 0/3] Add support for Intel Bluetooth bootloader device
Message-ID: <20141203170919.775283a0@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This set of patches adds support for Intel Bluetooth bootloader device.
Compare to previous Intel Bluetooth device, this device is quite different
in a few ways:

1. Using bootloader (RAM)
This device is RAM based so full size of Bluetooth operational firmware
image has to be downloaded to the device in order to run as Bluetooth device.

2. New firmware image file (.sfi)
This device needs a different firmware image file, which size is about 500KB
and the format is also different from previous generation of file (.bseq).

The contents in the file has to be encaptulated by Intel_Sec_Send command.

3. Use Bulk EP
Since the size of firwmare image is big, using Control EP and Interrupt EP
for downloading is not fast enough(takes about 15 seconds). So it uses
Bulk EP to send and receive the data and downloading can be done under 2
seconds.

To do that, the driver has to re-route Intel_Sec_Send command to Bulk EP
even if it is HCI command during the setup stage. For correspond event,
it also re-route the event from Bulk EP to interrupt handler.


Tedd Ho-Jeong An (3):
  Bluetooth: Refactor Intel read version command
  Bluetooth: Add parameter to specify the firmware file extension
  Bluetooth: Add support Intel Bluetooth bootloader device

 drivers/bluetooth/btusb.c | 462 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 428 insertions(+), 34 deletions(-)

-- 
1.9.1
