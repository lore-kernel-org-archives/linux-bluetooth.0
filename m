Return-Path: <cyrus@holtmann.org>
From: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Perelet, Oleg" <operelet@quicinc.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Date: Mon, 12 Jul 2010 12:01:02 +0530
Subject: RE: [RFC] Bluetooth: Add firmware load infrastructure for BT devices
Message-ID: <44EE5C37ADC36343B0625A05DD408C4850DB2A7D69@CHEXMB-01.global.atheros.com>
In-Reply-To: <1278596572.10421.25.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Thursday, July 08, 2010 7:13 PM
To: Shanmugamkamatchi Balashanmugam
Cc: Perelet, Oleg; linux-bluetooth@vger.kernel.org
Subject: RE: [RFC] Bluetooth: Add firmware load infrastructure for BT devic=
es

Hi Bala,

> Firmware loading to target RAM needs to be done once when the device is i=
nserted.  Firmware loading will not be required every time=20
> the device goes from DOWN to UP. I think each HCI driver requires
> a separate firmware loading code as firmware loading is=20
> different for different interfaces.  Please advice if my understanding is=
 wrong.
>=20
> I initially thought of registration=20
> mechanism with btusb transport driver to load firmware, but before
> the device is inserted btusb will not be loaded and registering the=20
> firmware load function with btusb was not possible.
>=20
> Please advice alternate solution to load firmware from transport driver.

>my advise would be to just build devices that change their USB VID/PID
>after the firmware got loaded. That way it is easy to have a firmware
>loading driver and just btusb for real operation. Why is it so hard to
>build just simple hardware that would just work.

>Regards

>Marcel

Thanks for the suggestion.
This is what is done for some of the devices.
For performance reasons few other devices comes with=20
small firmware in flash and the device gets detected as=20
generic bluetooth device when plugged in.  So control reaches btusb
once the device is plugged in.  In this case actual firmware
needs to be downloaded to target from btusb transport driver.

Please suggest if there is other way to handle these devices in linux.

Regards,
Bala.
