Return-Path: <oneukum@suse.com>
Message-ID: <1502876563.6606.16.camel@suse.com>
Subject: Re: [PATCH] Bluetooth: btusb: driver to enable the usb-wakeup
 feature
From: Oliver Neukum <oneukum@suse.com>
To: Marcel Holtmann <marcel@holtmann.org>, Sukumar Ghorai
	 <sukumar.ghorai@intel.com>, Greg Kroah-Hartman <greg@kroah.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Amit K Bag
 <amit.k.bag@intel.com>,  "Gustavo F. Padovan" <gustavo@padovan.org>,
 linux-bluetooth@vger.kernel.org
Date: Wed, 16 Aug 2017 11:42:43 +0200
In-Reply-To: <D92CCD61-177E-41F1-A644-FBDF42095F0E@holtmann.org>
References: <1502920015-6418-1-git-send-email-sukumar.ghorai@intel.com>
	 <D92CCD61-177E-41F1-A644-FBDF42095F0E@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, den 16.08.2017, 11:37 +0200 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > 
> > BT-Controller connected as platform non-root-hub device and
> > usb-driver initialize such device with wakeup disabled,
> > Ref. usb_new_device().
> > 
> > At present wakeup-capability get enabled by hid-input device from usb
> > function driver(e.g. BT HID device) at runtime. Again some functional
> > driver does not set usb-wakeup capability(e.g LE HID device implement
> > as HID-over-GATT), and can't wakeup the host on USB.
> > 
> > Most of the device operation (such as mass storage) initiated from host
> > (except HID) and USB wakeup aligned with host resume procedure. For BT
> > device, usb-wakeup capability need to enable form btusc driver as a
> > generic solution for multiple profile use case and required for USB remote
> > wakeup (in-bus wakeup) while host is suspended. Also usb-wakeup feature
> > need to enable/disable with HCI interface up and down.
> > 
> > Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
