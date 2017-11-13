Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluetooth: btusb: Add a Kconfig option to enable USB
 autosuspend by default
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171113094847.16192-1-hdegoede@redhat.com>
Date: Mon, 13 Nov 2017 11:15:13 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <AB3FF512-BD8D-4CFC-A1FC-A050BDD7A139@holtmann.org>
References: <20171113094847.16192-1-hdegoede@redhat.com>
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
> drivers/bluetooth/Kconfig | 10 ++++++++++
> drivers/bluetooth/btusb.c |  7 +++++++
> 2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 6475f8c0d3b2..cde963a15745 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -30,6 +30,16 @@ config BT_HCIBTUSB
> 	  Say Y here to compile support for Bluetooth USB devices into the
> 	  kernel or say M to compile it as module (btusb).
> 
> +config BT_USB_AUTOSUSPEND
> +	bool "Enable USB autosuspend for Bluetooth USB devices by default.
> +	depends on BT_HCIBTUSB
> +	help
> +	  Say Y here to enable USB autosuspend for Bluetooth USB devices by
> +	  default.
> +
> +	  This can be overridden by passing btusb.enable_usb_autosuspend=[y|n]
> +	  on the kernel commandline.
> +

since this is btusb specific, lets call it BT_HCIBTUSB_AUTOSUSPEND.

> config BT_HCIBTUSB_BCM
> 	bool "Broadcom protocol support"
> 	depends on BT_HCIBTUSB
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c054d7bce490..fb0667fda796 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -40,6 +40,7 @@
> 
> static bool disable_scofix;
> static bool force_scofix;
> +static bool enable_usb_autosuspend = IS_ENABLED(CONFIG_BT_USB_AUTOSUSPEND);
> 
> static bool reset = true;
> 
> @@ -3175,6 +3176,9 @@ static int btusb_probe(struct usb_interface *intf,
> 	}
> #endif
> 
> +	if (enable_usb_autosuspend)
> +		usb_enable_autosuspend(data->udev);
> +
> 	err = hci_register_dev(hdev);
> 	if (err < 0)
> 		goto out_free_dev;
> @@ -3387,6 +3391,9 @@ MODULE_PARM_DESC(disable_scofix, "Disable fixup of wrong SCO buffer size");
> module_param(force_scofix, bool, 0644);
> MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
> 
> +module_param(enable_usb_autosuspend, bool, 0644);
> +MODULE_PARM_DESC(enable_usb_autosuspend, "Enable USB autosuspend by default”);

And I prefer that you just call it enable_autosuspend. It is btusb specific and the USB part is already in the name anyway. It is a USB driver.

Regards

Marcel

