Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] bt usb-device initialize as wakeup enable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1502735088-4333-1-git-send-email-sukumar.ghorai@intel.com>
Date: Mon, 14 Aug 2017 08:10:36 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Amit K Bag # <amit.k.bag@intel.com>
Message-Id: <CB2B50F2-C0C5-4302-96F7-24B952B97665@holtmann.org>
References: <1502735088-4333-1-git-send-email-sukumar.ghorai@intel.com>
To: Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Oliver Neukum <oneukum@suse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sukumar,

> BT-Controller connected as platform non-root-hub device and
> usb-driver initialize such device with wakeup disabled,
> Ref. usb_new_device().
> 
> At present wakeup-capability get enabled by hid-input device from usb
> function driver(e.g. BT HID device) at runtime. Again some functional
> driver does not set usb-wakeup capability(e.g LE HID device implement
> as HID-over-GATT), and can't wakeup the host on USB.
> 
> Hence usb-wakeup capability enable form btusc driver as a generic
> solution for multiple profile usecase and required for USB remote
> wakeup (in-bus wakeup) while host is suspended.
> 
> Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>#
> ---
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e1124ba44154..7eeeeb6ffae6 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1083,6 +1083,10 @@ static int btusb_open(struct hci_dev *hdev)
> 	}
> 
> 	data->intf->needs_remote_wakeup = 1;
> +	/* device specific wakeup source enabled and required for USB
> +	 * remote wakeup while host is suspended
> +	 */
> +	device_init_wakeup(&data->udev->dev, true);
> 

is this the right location? Are we repeating this on every hciconfig up / btmgmt poweron operation? Or is this something that should be actually happen only once during USB probe callback?

Regards

Marcel

