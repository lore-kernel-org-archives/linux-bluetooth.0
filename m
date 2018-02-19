Return-Path: <stefan.wahren@i2se.com>
Date: Mon, 19 Feb 2018 19:53:03 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Eric Anholt <eric@anholt.net>,
	=?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-ID: <1332560657.154293.1519066383196@email.1und1.de>
In-Reply-To: <25DCE32D-EDDA-40AC-B75C-133F1338A5D9@holtmann.org>
References: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
 <1941091231.91372.1518962068876@email.1und1.de>
 <414BD031-1C2F-4E27-BBB4-BEB9F71B099F@holtmann.org>
 <76f76129-dd3e-2d17-635d-18a563d12aa8@gmail.com>
 <f94056a0-ece7-c579-6b7d-d6589079d9e6@i2se.com>
 <E39D4C6D-90AC-426A-BA98-02EE4F78E14C@holtmann.org>
 <1290800239.153918.1519064893302@email.1und1.de>
 <25DCE32D-EDDA-40AC-B75C-133F1338A5D9@holtmann.org>
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Marcel Holtmann <marcel@holtmann.org> hat am 19. Februar 2018 um 19:38 ge=
schrieben:
>=20
>=20
> Hi Stefan,
>=20
> >>>>>>> One option is of course to keep the max-speed in the DT at 115200=
 Mbps. It would work, but seriously slow down the transport. Maybe this sho=
uld be done until we get access to the GPIOs.
> >>>>> So I am convinced when we run on hardware that has no GPIO resource=
s exposed (as it is with RPi right now), we should limit the operational sp=
eed to the initialization speed. And then my problem actually goes away. It=
 also forces people to get the GPIOs exposed or they have to stick with a s=
lower HCI transport.
> >>>>=20
> >>>> We may also reset to initialization speed on module unload.
> >>>> This will allow multiple tests on the hardware, even if it does not =
have GPIOs exposed.
> >>>=20
> >>> I prefer this solution instead of coding workarounds within the devic=
etree.
> >>=20
> >> DT is actually for encoding workarounds for the hardware. If the GPIOs=
 are not exposed, we are actually limited. However I am going to do that in=
 the hci_bcm.c driver itself since it is a more wider problem. If the GPIO =
resources are not available, the device will actually not function. This is=
 actually a valid assumption for all hardwired Bluetooth chips. They all ha=
ve some GPIO or power control option. The only reason to not have GPIOs wou=
ld be external development boards. So the RPi with the not exposed GPIOs is=
 kinda broken hardware right now. That we got this far supporting Bluetooth=
 on it has to be considered pure luck :)
> >=20
> > only to make sure that we talking about the same, please take a look at=
 my attempt for the RPi Zero W [1].
> >=20
> > Using the BT_ON signal as shutdown-gpio is not enough? I'm sorry i didn=
't test the reload case yet.
> >=20
> > So after the implementation of the RPI firmware expander driver, we sti=
ll need this baudrate limitiation?
> >=20
> > Btw Baruch said that he will send a new version of his patch series soo=
n.
> >=20
> > [1] - https://github.com/lategoodbye/rpi-zero/commit/e3085c093e56364a69=
f2e32d35827635b95cf966
>=20
> before you include "shutdown-gpios =3D <&gpio 45 GPIO_ACTIVE_HIGH>;=E2=80=
=9D we might need to figure out on how the BT_ON GPIO is working and what i=
t is suppose to be doing. But otherwise the patch fro the Zero W looks righ=
t to me.
>=20
> Also keep in mind that the current 4.16-rc2 kernel will require the shutd=
own-gpios and device-wakeup-gpios both to be available. We have not yet tes=
ted this when only shutdown-gpios is available. You might need to modify bc=
m_get_resources and bcm_gpio_set_power to test this out.

i think this contradicts to the binding documentation, which defines both a=
s optional.

Stefan

>=20
> Regards
>=20
> Marcel
>
