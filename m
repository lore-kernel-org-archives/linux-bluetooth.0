Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Add a Kconfig option to enable USB
 autosuspend by default
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171113134416.31886-1-hdegoede@redhat.com>
Date: Mon, 13 Nov 2017 16:11:29 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <B2AB4064-D3B3-42A7-8CE6-01179F1DF52E@holtmann.org>
References: <20171113134416.31886-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> On many laptops the btusb device is the only USB device not having USB
> autosuspend enabled, this causes not only the HCI but also the USB
> controller to stay awake, together using aprox. 0.4W of power.
> 
> Modern ultrabooks idle around 6W (at 50% screen brightness), 3.5W for
> Apollo Lake devices. 0.4W is a significant chunk of this (7 / 11%).
> 
> The btusb driver already contains code to allow enabling USB autosuspend,
> but currently leaves it up to the user / userspace to enable it. This
> means that for most people it will not be enabled, leading to an
> unnecessarily high power consumption.
> 
> Since enabling it is not entirely without risk of regressions, this
> commit adds a Kconfig option so that Linux distributions can choose to
> enable it by default. This commit also adds a module option so that when
> distros receive bugs they can easily ask the user to disable it again
> for easy debugging.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -s/BT_USB_AUTOSUSPEND/BT_HCIBTUSB_AUTOSUSPEND/
> -s/enable_usb_autosuspend/enable_autosuspend/
> ---
> drivers/bluetooth/Kconfig | 10 ++++++++++
> drivers/bluetooth/btusb.c |  7 +++++++
> 2 files changed, 17 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

