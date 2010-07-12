Return-Path: <cyrus@holtmann.org>
Subject: RE: [RFC] Bluetooth: Add firmware load infrastructure for BT
 devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>
Cc: "Perelet, Oleg" <operelet@quicinc.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C4850DB2A7D69@CHEXMB-01.global.atheros.com>
References: <44EE5C37ADC36343B0625A05DD408C4850DB2A7D69@CHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Jul 2010 09:50:57 -0300
Message-ID: <1278939057.10421.159.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

> > Firmware loading to target RAM needs to be done once when the device is inserted.  Firmware loading will not be required every time 
> > the device goes from DOWN to UP. I think each HCI driver requires
> > a separate firmware loading code as firmware loading is 
> > different for different interfaces.  Please advice if my understanding is wrong.
> > 
> > I initially thought of registration 
> > mechanism with btusb transport driver to load firmware, but before
> > the device is inserted btusb will not be loaded and registering the 
> > firmware load function with btusb was not possible.
> > 
> > Please advice alternate solution to load firmware from transport driver.
> 
> >my advise would be to just build devices that change their USB VID/PID
> >after the firmware got loaded. That way it is easy to have a firmware
> >loading driver and just btusb for real operation. Why is it so hard to
> >build just simple hardware that would just work.
> 
> Thanks for the suggestion.
> This is what is done for some of the devices.
> For performance reasons few other devices comes with 
> small firmware in flash and the device gets detected as 
> generic bluetooth device when plugged in.  So control reaches btusb
> once the device is plugged in.  In this case actual firmware
> needs to be downloaded to target from btusb transport driver.

is this simple firmware already talking HCI at that point or is it some
USB protocol to load the rest of the firmware.

Regards

Marcel


