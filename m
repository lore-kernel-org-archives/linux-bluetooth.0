Return-Path: <stefan.wahren@i2se.com>
Date: Thu, 22 Feb 2018 15:26:23 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Eric Anholt <eric@anholt.net>,
	=?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-ID: <2139019758.47998.1519309583130@email.1und1.de>
In-Reply-To: <68D82C47-F3AE-4E03-A687-A13F4F927310@holtmann.org>
References: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
 <1941091231.91372.1518962068876@email.1und1.de>
 <414BD031-1C2F-4E27-BBB4-BEB9F71B099F@holtmann.org>
 <76f76129-dd3e-2d17-635d-18a563d12aa8@gmail.com>
 <f94056a0-ece7-c579-6b7d-d6589079d9e6@i2se.com>
 <E39D4C6D-90AC-426A-BA98-02EE4F78E14C@holtmann.org>
 <1290800239.153918.1519064893302@email.1und1.de>
 <25DCE32D-EDDA-40AC-B75C-133F1338A5D9@holtmann.org>
 <1332560657.154293.1519066383196@email.1und1.de>
 <68D82C47-F3AE-4E03-A687-A13F4F927310@holtmann.org>
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Marcel Holtmann <marcel@holtmann.org> hat am 19. Februar 2018 um 19:58 ge=
schrieben:
>=20
>=20
> Hi Stefan,
>=20
> >>>>>>>>> One option is of course to keep the max-speed in the DT at 1152=
00 Mbps. It would work, but seriously slow down the transport. Maybe this s=
hould be done until we get access to the GPIOs.
> >>>>>>> So I am convinced when we run on hardware that has no GPIO resour=
ces exposed (as it is with RPi right now), we should limit the operational =
speed to the initialization speed. And then my problem actually goes away. =
It also forces people to get the GPIOs exposed or they have to stick with a=
 slower HCI transport.
> >>>>>>=20
> >>>>>> We may also reset to initialization speed on module unload.
> >>>>>> This will allow multiple tests on the hardware, even if it does no=
t have GPIOs exposed.
> >>>>>=20
> >>>>> I prefer this solution instead of coding workarounds within the dev=
icetree.
> >>>>=20
> >>>> DT is actually for encoding workarounds for the hardware. If the GPI=
Os are not exposed, we are actually limited. However I am going to do that =
in the hci_bcm.c driver itself since it is a more wider problem. If the GPI=
O resources are not available, the device will actually not function. This =
is actually a valid assumption for all hardwired Bluetooth chips. They all =
have some GPIO or power control option. The only reason to not have GPIOs w=
ould be external development boards. So the RPi with the not exposed GPIOs =
is kinda broken hardware right now. That we got this far supporting Bluetoo=
th on it has to be considered pure luck :)
> >>>=20
> >>> only to make sure that we talking about the same, please take a look =
at my attempt for the RPi Zero W [1].
> >>>=20
> >>> Using the BT_ON signal as shutdown-gpio is not enough? I'm sorry i di=
dn't test the reload case yet.
> >>>=20
> >>> So after the implementation of the RPI firmware expander driver, we s=
till need this baudrate limitiation?
> >>>=20
> >>> Btw Baruch said that he will send a new version of his patch series s=
oon.
> >>>=20
> >>> [1] - https://github.com/lategoodbye/rpi-zero/commit/e3085c093e56364a=
69f2e32d35827635b95cf966
> >>=20
> >> before you include "shutdown-gpios =3D <&gpio 45 GPIO_ACTIVE_HIGH>;=E2=
=80=9D we might need to figure out on how the BT_ON GPIO is working and wha=
t it is suppose to be doing. But otherwise the patch fro the Zero W looks r=
ight to me.
> >>=20
> >> Also keep in mind that the current 4.16-rc2 kernel will require the sh=
utdown-gpios and device-wakeup-gpios both to be available. We have not yet =
tested this when only shutdown-gpios is available. You might need to modify=
 bcm_get_resources and bcm_gpio_set_power to test this out.
> >=20
> > i think this contradicts to the binding documentation, which defines bo=
th as optional.
>=20
> the 4.15 kernel might be fine actually while the support for Apple hardwa=
re with Broadcom UART devices might have accidentally required this now. Ma=
ybe you just want to hack your kernel and see how it goes when just having =
the shutdown-gpios available.
>=20
> I am super curious if the firmware resets and falls back to the ROM state=
 or if something is actually kept.

since i don't have any schematics about the BT part, i simply retested my p=
atches against 4.15 on RPi Zero W.

modprobe -r hci_uart
modprobe hci_uart

works without any issues:

[  233.486208] Bluetooth: HCI UART driver ver 2.3
[  233.486258] Bluetooth: HCI UART protocol H4 registered
[  233.487189] hci_uart_bcm serial0-0: BCM irq: -22
[  233.488382] Bluetooth: HCI UART protocol Broadcom registered
[  233.641217] Bluetooth: hci0: BCM: chip id 94
[  233.642081] Bluetooth: hci0: BCM: features 0x2e
[  233.644283] Bluetooth: hci0: BCM43430A1
[  233.644321] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
[  234.360569] Bluetooth: hci0: BCM (001.002.009) build 0325

After enabling bluetooth scanning i will see these error messages periodica=
lly:

[  815.939839] Bluetooth: hci0: last event is not cmd complete (0x0f)
[  831.302476] Bluetooth: hci0: last event is not cmd complete (0x0f)
[  847.303953] Bluetooth: hci0: last event is not cmd complete (0x0f)
[  863.305284] Bluetooth: hci0: last event is not cmd complete (0x0f)
[  879.306838] Bluetooth: hci0: last event is not cmd complete (0x0f)

Btw: Linus Wallej applied the GPIO expander driver

Stefan

>=20
> Regards
>=20
> Marcel
>
