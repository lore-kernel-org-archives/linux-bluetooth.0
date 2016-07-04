Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Replace constant hw_variant from Intel Bluetooth firmware filename
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160628085639.7caaf7f7@fedora-linux-22.shared>
Date: Mon, 4 Jul 2016 20:10:13 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <B6FCA562-0B4A-423D-9B4C-FA85AB2C62E9@holtmann.org>
References: <20160628085639.7caaf7f7@fedora-linux-22.shared>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> The format of Intel Bluetooth firmware filename for bootloader product
> is ibt-<hw_variant>-<device_revision_id>.sfi
> 
> Currently the driver uses a constant value 11 (0x0b) for hw_variant
> to support LnP/SfP product. But new product like WsP product has
> a different value such as 12 (0x0c).
> 
> To support the multiple products, this patch replaces the constant
> value of hw_variant to the actual hw_variant value read from
> the device.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 13 +++++++++----
> 1 file changed, 9 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

