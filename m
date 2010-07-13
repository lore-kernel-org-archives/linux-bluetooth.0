Return-Path: <cyrus@holtmann.org>
Subject: RE: [RFC] Bluetooth: Add firmware load infrastructure for BT
 devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>
Cc: "Perelet, Oleg" <operelet@quicinc.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C4850DB2A8234@CHEXMB-01.global.atheros.com>
References: <44EE5C37ADC36343B0625A05DD408C4850DB2A8234@CHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 09:43:02 -0300
Message-ID: <1279024982.6282.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

> > > Firmware loading to target RAM needs to be done once when the device is inserted.  Firmware loading will not be required every time 
> > > the device goes from DOWN to UP. I think each HCI driver requires
> > > a separate firmware loading code as firmware loading is 
> > > different for different interfaces.  Please advice if my understanding is wrong.
> > > 
> > > I initially thought of registration 
> > > mechanism with btusb transport driver to load firmware, but before
> > > the device is inserted btusb will not be loaded and registering the 
> > > firmware load function with btusb was not possible.
> > > 
> > > Please advice alternate solution to load firmware from transport driver.
> > 
> > >my advise would be to just build devices that change their USB VID/PID
> > >after the firmware got loaded. That way it is easy to have a firmware
> > >loading driver and just btusb for real operation. Why is it so hard to
> > >build just simple hardware that would just work.
> > 
> > Thanks for the suggestion.
> > This is what is done for some of the devices.
> > For performance reasons few other devices comes with 
> > small firmware in flash and the device gets detected as 
> > generic bluetooth device when plugged in.  So control reaches btusb
> > once the device is plugged in.  In this case actual firmware
> > needs to be downloaded to target from btusb transport driver.
> 
> is this simple firmware already talking HCI at that point or is it some
> USB protocol to load the rest of the firmware.
>
> Firmware in the flash does not talk to HCI. Yes it supports some USB commands which are required to load the rest of the firmware.

so you are basically saying you created a device with generic USB
Bluetooth class that is not following the Bluetooth H:2 specification.
And now you expect the btusb driver to make this work. I think the
screw-up here is clearly on your side by violating the USB Bluetooth
specification in the first place.

If your USB descriptors tell you something like this:

I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

Then you better support HCI commands (H:2 protocol) at that point.

I could understand if the firmware gets loaded via HCI vendor commands,
but just a random other USB protocol is pretty much wrong.

Regards

Marcel


