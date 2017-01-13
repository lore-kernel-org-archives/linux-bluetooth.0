Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 13 Jan 2017 17:19:07 +0000
From: Dario Teixeira <dario.teixeira@nleyten.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-bluetooth-owner@vger.kernel.org
Subject: Re: LEAdvertisement interface on older kernels
In-Reply-To: <e40dc0a21f7080547028dfb7dad6eb65@nleyten.com>
References: <e40dc0a21f7080547028dfb7dad6eb65@nleyten.com>
Message-ID: <b2bd7735f166b59b11369eb37d0b4d75@nleyten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I've manually compiled the latest Bluez (5.43) on both Raspberry Pi 2
> and Artik 5 systems, as I need the experimental features for BLE 
> enabled.
> While on the Pi things work as expected, on the Artik 5 the 
> "LEAdvertisement"
> interface is not enabled.  Upon closer inspection, the bluetoothd 
> daemon
> on the Artik 5 complains on startup with the following error:
> 
>   "Failed to read advertising features: Unknown Command (0x01)"
> 
> I suspect the problem may be related to the old kernel (3.10.93)
> that ships with the Artik 5, because these features may require
> a more recent kernel.  Is this suspicion correct?  And if so,
> is there any other solution besides attempting to compile a
> newer kernel for the Artik 5?

In the meantime I've found some information which confirms my
initial suspicion: BLE advertising features require kernel >= 4.1,
and therefore it's hopeless to use the Artik 5 for this purpose,
because its heavily patched vendor kernel is stuck at 3.10.93,
possibly forever...

Best regards,
Dario Teixeira

