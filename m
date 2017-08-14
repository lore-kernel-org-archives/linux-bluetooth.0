Return-Path: <oneukum@suse.com>
Message-ID: <1502695528.12678.3.camel@suse.com>
Subject: Re: [PATCH] bt usb-device initialize as wakeup enable
From: Oliver Neukum <oneukum@suse.com>
To: Marcel Holtmann <marcel@holtmann.org>, Sukumar Ghorai
	 <sukumar.ghorai@intel.com>, Greg Kroah-Hartman <greg@kroah.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Amit K Bag #
 <amit.k.bag@intel.com>,  "Gustavo F. Padovan" <gustavo@padovan.org>,
 linux-bluetooth@vger.kernel.org
Date: Mon, 14 Aug 2017 09:25:28 +0200
In-Reply-To: <CB2B50F2-C0C5-4302-96F7-24B952B97665@holtmann.org>
References: <1502735088-4333-1-git-send-email-sukumar.ghorai@intel.com>
	 <CB2B50F2-C0C5-4302-96F7-24B952B97665@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag, den 14.08.2017, 08:10 +0200 schrieb Marcel Holtmann:
> Hi Sukumar,
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
> > Hence usb-wakeup capability enable form btusc driver as a generic
> > solution for multiple profile usecase and required for USB remote
> > wakeup (in-bus wakeup) while host is suspended.
> > 
> > Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>#
> > ---
> > drivers/bluetooth/btusb.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index e1124ba44154..7eeeeb6ffae6 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -1083,6 +1083,10 @@ static int btusb_open(struct hci_dev *hdev)
> > 	}
> > 
> > 	data->intf->needs_remote_wakeup = 1;
> > +	/* device specific wakeup source enabled and required for USB
> > +	 * remote wakeup while host is suspended
> > +	 */
> > +	device_init_wakeup(&data->udev->dev, true);
> > 
> 
> is this the right location? Are we repeating this on every hciconfig up / btmgmt poweron operation? Or is this something that should be actually happen only once during USB probe callback?

Hi,

it would be more efficient to do that on probe(). But have you tested this for
side effects? Will other BT operations now wake up the host?

On a philosophical note it is kind of ugly to solve a generic problem
in btusb. Arguably wakeup capability should propagate up the device tree
if you request it. Have you discussed this with Rafael?

	Regards
		Oliver
