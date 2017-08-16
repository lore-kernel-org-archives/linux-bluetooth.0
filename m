Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btusb: driver to enable the usb-wakeup feature
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1502920015-6418-1-git-send-email-sukumar.ghorai@intel.com>
Date: Wed, 16 Aug 2017 11:49:21 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Amit K Bag <amit.k.bag@intel.com>
Message-Id: <9231F97C-0FC7-42B1-B23A-28EDAC1725CD@holtmann.org>
References: <1502920015-6418-1-git-send-email-sukumar.ghorai@intel.com>
To: Sukumar Ghorai <sukumar.ghorai@intel.com>
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
> Most of the device operation (such as mass storage) initiated from host
> (except HID) and USB wakeup aligned with host resume procedure. For BT
> device, usb-wakeup capability need to enable form btusc driver as a
> generic solution for multiple profile use case and required for USB remote
> wakeup (in-bus wakeup) while host is suspended. Also usb-wakeup feature
> need to enable/disable with HCI interface up and down.
> 
> Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
> drivers/bluetooth/btusb.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

