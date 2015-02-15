Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Feb 2015 10:19:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Use matching names for Broadcom
 firmware files
Message-ID: <20150215081937.GB4786@t440s.P-661HNU-F1>
References: <1423984127-16749-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423984127-16749-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 14, 2015, Marcel Holtmann wrote:
> The Broadcom firmware files are named with firmware version information
> encoded into lmp_subver field. So BCM20702B0_002.001.014.0527.0607.hex
> would be represented by 0x410e. To allow for an easier decoding of the
> actual firmware names, provide an internal table that does the mapping
> and request the firmware file by name.
> 
> Bluetooth: hci0: BCM20702B0 (002.001.014) build 0607
> 
> Now the complicated encoding of lmp_subver will be decoded and turned
> into the name and firmware version information from the firmware files.
> 
> The previous attempt of using udev->product failed badly since it never
> contains any matching entry to the actual hardware or firmware files
> distributed by Broadcom in their Windows drivers. It is even worse since
> it can change depending on if the internal bootstrapping happened before
> the USB bus enumeration or after. This caused many race conditions.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 75 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 22 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
