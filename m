Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] Add sixpair
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1224114777.28173.41.camel@californication>
References: <1224083727.5268.3149.camel@cookie.hadess.net>
	 <1224114777.28173.41.camel@californication>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 01:28:38 +0100
Message-Id: <1224116918.5268.3845.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2008-10-16 at 01:52 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > Here are the patches to get sixpair support built into BlueZ. It uses
> > libusb-1.0 as well as a yet to be merged libusb-1.0 patch to allow
> > re-attaching a driver to a device.
> 
> so I applied all patches except the changes for the build system. I am
> not sure that this is the right way to go.
> 
> If we require libusb-1.0, then we should just change our current code
> that depends on libusb-0.1 and require libusb-1.0 for all of it.

That'd mean porting:
- dfutool
- avctrl
- bccmd's csr_usb code
- hid2hci

The code isn't too complicated, but I wouldn't be able to test any of
the code (apart from maybe hid2hci). Is this something I can promise to
do in the future? It's not very complicated, just time consuming.

> > Problems left to solve:
> > - sixaxis enabler code (as seen in enable_sixaxis() in compat/hidd.c)
> > seems to have disappeared from the input plugin. Is that done in the
> > kernel now, or was it just removed?
> 
> The kernel is not doing it. Seems to be an oversight.

OK. I'll re-add the code to the input plugin.

> > - After "cable pairing" the device, I need to unplug/replug the adapter,
> > or restart bluetoothd. Can anyone think of a better way of getting the
> > list of devices updated?
> 
> We could use inotify or SIGUSR2 or something to re-read the database.

There's a problem with the current method in that there might be data
loss if we're adding data from both bluetoothd, and an external program
(both processes writing the same file at the same time).

We could solve the data loss, and update problem by having an internal,
root only, dbus method available for cable pairing of that sort. For
example, on org.bluez.Adapter:
void AddCablePairedDevice (string name,
                           string address,
                           unsigned int vendor_id,
                           unsigned int product_id,
                           string pnp_record);

The function would just need to do all the storage work sixpair
currently does, and create the device internally similarly to
create_stored_device_from_profiles().

It might also be useful to have an internal (non-dbus) API at the
manager level for hid proxy dongles (where the adapter wouldn't yet
exist when we store the to-be-created devices, not sure how to be
certain those devices will be temporary though).

> > - Some minor niggles in the code itself (use D-Bus instead of parsing
> > command-line tools)
> 
> Of course.
> 
> > - udev rule(s) and parsing only the selected device would be necessary
> > if not required
> 
> If we can do this via the HID bus, then we can do it every time and it
> would not affect the controller itself.

Unless I misunderstood the feature, when claiming the interface, that
would actually remove the pad as an input device.

Cheers
