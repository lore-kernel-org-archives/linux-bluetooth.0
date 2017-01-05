Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 05 Jan 2017 16:46:27 +0000
From: Dario Teixeira <dario.teixeira@nleyten.com>
To: linux-bluetooth@vger.kernel.org
Subject: LEAdvertisement interface on older kernels
Message-ID: <e40dc0a21f7080547028dfb7dad6eb65@nleyten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've manually compiled the latest Bluez (5.43) on both Raspberry Pi 2
and Artik 5 systems, as I need the experimental features for BLE 
enabled.
While on the Pi things work as expected, on the Artik 5 the 
"LEAdvertisement"
interface is not enabled.  Upon closer inspection, the bluetoothd daemon
on the Artik 5 complains on startup with the following error:

   "Failed to read advertising features: Unknown Command (0x01)"

I suspect the problem may be related to the old kernel (3.10.93)
that ships with the Artik 5, because these features may require
a more recent kernel.  Is this suspicion correct?  And if so,
is there any other solution besides attempting to compile a
newer kernel for the Artik 5?

Thanks in advance for your attention!
Best regards,
Dario Teixeira

