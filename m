Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Dec 2014 15:24:22 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC v2 0/4] Add support for Intel Bluetooth bootloader device
Message-ID: <20141208152422.577ad818@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Changes in v2:
 Consolidate read version function and open firmware function
 Add enum for device mode indication to open the proper firmware


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

Tedd Ho-Jeong An (4):
  Bluetooth: Refactor Intel_read_version and opens firmware patch file
  Bluetooth: Set the firmware file extension based on firmware type
  Bluetooth: Set file extension to SFI file for bootloader mode
  Bluetooth: Add support Intel Bluetooth bootloader device

 drivers/bluetooth/btusb.c | 560 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 472 insertions(+), 88 deletions(-)

-- 
1.9.1
