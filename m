Return-Path: <cyrus@holtmann.org>
Subject: Re: Transient devices
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2d5a2c100910271332p1a036037x7ae1db9276c6ce1e@mail.gmail.com>
References: <1256648475.2367.106.camel@localhost.localdomain>
	 <2d5a2c100910271332p1a036037x7ae1db9276c6ce1e@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 23 Nov 2009 14:29:43 +0000
Message-ID: <1258986583.2773.2539.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-10-27 at 17:32 -0300, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Oct 27, 2009 at 10:01 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > Heya,
> >
> > I've had a few thoughts about some use cases that currently cause
> > problems (or would cause problems) with bluetoothd.
> >
> >
> > 1) Printer pairing and setup
> >
> > The cups backend will create a non-paired device to detect whether
> > devices with a printer class have supported services.
> >
> > The problem is that the CUPS backend will not remove the device once
> > done, and the device will now appear in the list of known devices for
> > bluetoothd. In terms of UIs, that means it shows up in the wizard (as
> > it's not paired or setup), but not in the properties, thus can't be
> > removed from the list.
> >
> > It would be nice to receive this data and have it cached client-side
> > instead, like we do for discovery results.
> 
> Not sure if Im following, but you can always cache the device
> properties even if the device was created by CUPs. Also I think any
> other process willing to do its own wizard for bluetooth is a bad idea

Why? Doesn't it make sense to be able to setup a new Bluetooth printer
by going through both the "New Printer" and the "New Bluetooth device"
way? Other OSes do that.

The only thing I actually want from the printer when setting it up is
the SDP record. Right now, it's not possible to get the SDP record of a
device through the D-Bus interface without doing a "CreateDevice", which
means the device will always be present.

Doing a CreateDevice followed by a RemoveDevice on the client side is a
recipe for disaster.

So I'd basically want to be able to get the SDP record without creating
the device, and have be on-disk in bluetoothd's cache.

> specially if you are caching some data in the application side, btw,
> why do you need to cache this information?

We don't really need a "cache", we just need to be able to get the data
about the device. It's a memory cache, and the application won't be
writing the data to disk. The cache is just for this application, and it
will be gone when the application exits, just like discovery results.

> I believe the most convenient is always using the applet to create
> devices in a way that you virtually plug devices, so other subsystems
> doesn't have to care about doing this, actually this very similar to
> what macos does for 'Connect Network', what about 'Connect Printer'?
> 
> I know this cause an extra step to really enable the device, but
> remember bluetooth is not really connected all the time.

"Connect Printer" doesn't make sense in the way you mention. Connections
to printers will be transient anyway.

Furthermore, "Connect Network" in MacOS X requires the device to already
be paired (which isn't something that applies to the use case above),
and we already support network devices natively in connman and
NetworkManager removing the need for a "Connect Network" menu item.

> > 2) Adapter provided devices
> >
> > Although we don't currently have code for that, it would be nice to
> > handle the possibility.
> >
> > Some adapters provide a way to store link keys, and other data
> > pertaining to input devices.
> >
> > The problem with setting those up is that the pairing will be permanent
> > on the bluetoothd side. We should make sure the associations go away
> > when the adapter goes down.
> 
> The link key is per adapter and afaik there is no way to use it with
> another adapter.

The problem here is that linkkeys on the device can change, but as
bluetoothd would be caching them on disk, they wouldn't get removed
after the device is unplugged. For example:
- plugin HID proxy dongle
- read linkkeys from device and put them on disk, keyboard A will be
paired
- using another computer/OS, change the "default" keyboard on the HID
proxy dongle to keyboard B
- use dongle with bluetoothd again, keyboard B's linkkeys is read from
the adapter, but keyboard A's linkkeys are still on-disk.

If you didn't cache keyboard A's linkkeys, you'd avoid problems like
both A and B still being "connected" to the computer.

Cheers

