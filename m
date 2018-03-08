Return-Path: <stefan.wahren@i2se.com>
Date: Thu, 8 Mar 2018 01:02:38 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marcel Holtmann <marcel@holtmann.org>, Eric Anholt <eric@anholt.net>
Cc: Lukas Wunner <lukas@wunner.de>, Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Phil Elwell <phil@raspberrypi.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	=?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
	devicetree <devicetree@vger.kernel.org>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	Loic Poulain <loic.poulain@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Message-ID: <698451580.263856.1520467358497@email.1und1.de>
In-Reply-To: <87muzjfr8l.fsf@anholt.net>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
 <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
 <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
 <438185389.274708.1520422108782@email.1und1.de>
 <03B9ACBE-3ACA-40C4-9DA2-6A57D1AD96E0@holtmann.org>
 <2071508922.276811.1520426568577@email.1und1.de>
 <87sh9bvh3r.fsf@anholt.net>
 <D48AB207-F7F4-46D8-AC65-EC5CF76A6084@holtmann.org>
 <87muzjfr8l.fsf@anholt.net>
Subject: Re: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Eric Anholt <eric@anholt.net> hat am 7. M=C3=A4rz 2018 um 23:36 geschrieb=
en:
>=20
>=20
> Marcel Holtmann <marcel@holtmann.org> writes:
>=20
> > Hi Eric,
> >
> >>>>>>>>> Add BCM43438 (bluetooth) as a serdev slave device of uart0 (pl0=
11/ttyAMA0).
> >>>>>>>>> This allows to automatically insert the bcm43438 to the bluetoo=
th
> >>>>>>>>> subsystem instead of relying on patched userspace helpers (hcia=
ttach).
> >>>>>>>>>=20
> >>>>>>>>> In order to keep a debug UART we need to switch to uart1.
> >>>>>>>>>=20
> >>>>>>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>>>>>>>> ---
> >>>>>>>>> arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 14 +++++++++++++-
> >>>>>>>>> 1 file changed, 13 insertions(+), 1 deletion(-)
> >>>>>>>>>=20
> >>>>>>>>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/ar=
m/boot/dts/bcm2835-rpi-zero-w.dts
> >>>>>>>>> index cf53436..b7f79f1 100644
> >>>>>>>>> --- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>>>>>>>> +++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>>>>>>>> @@ -131,6 +131,18 @@
> >>>>>>>>>=20
> >>>>>>>>> &uart0 {
> >>>>>>>>> =09pinctrl-names =3D "default";
> >>>>>>>>> -=09pinctrl-0 =3D <&uart0_gpio14>;
> >>>>>>>>> +=09pinctrl-0 =3D <&uart0_gpio32 &uart0_ctsrts_gpio30>;
> >>>>>>>>> +=09status =3D "okay";
> >>>>>>>>> +
> >>>>>>>>> +=09bluetooth {
> >>>>>>>>> +=09=09compatible =3D "brcm,bcm43438-bt";
> >>>>>>>>> +=09=09max-speed =3D <2000000>;
> >>>>>>>>> +=09=09shutdown-gpios =3D <&gpio 45 GPIO_ACTIVE_HIGH>;
> >>>>>>>>> +=09};
> >>>>>>>>> +};
> >>>>>>>>=20
> >>>>>>>> is the shutdown GPIO working as expected with this hardware. So =
even module unload and reload works fine?
> >>>>>>>=20
> >>>>>>> Yes, unload and reload works fine.=20
> >>>>>>>=20
> >>>>>>>> Meaning we are getting back to the 115200 default baud rate on t=
he UART?
> >>>>>>>=20
> >>>>>>> I assume that, because reload works as expected.=20
> >>>>>>=20
> >>>>>> awesome. That is good news.
> >>>>>>=20
> >>>>>> Since you said that the GPIO expander driver for the RPi 3 has bee=
n accepted, did you test it there as well? If so, then it would be good to =
get a patch that also provides shutdown-gpios for RPi 3.
> >>>>>=20
> >>>>> after applying Loic's patch and the necessary patch for the RPi 3 d=
ts file (see below), i will get this output:
> >>>>>=20
> >>>>> [    4.873246] Bluetooth: HCI UART driver ver 2.3
> >>>>> [    4.873260] Bluetooth: HCI UART protocol H4 registered
> >>>>> [    4.873265] Bluetooth: HCI UART protocol Three-wire (H5) registe=
red
> >>>>> [    4.873751] Bluetooth: HCI UART protocol Broadcom registered
> >>>>> [    4.877279] uart-pl011 3f201000.serial: no DMA platform data
> >>>>> [    6.952382] Bluetooth: hci0: command 0xfc18 tx timeout
> >>>>> [   15.192298] Bluetooth: hci0: BCM: failed to write update baudrat=
e (-110)
> >>>>> [   15.192312] Bluetooth: hci0: Failed to set baudrate
> >>>>> [   15.316415] Bluetooth: hci0: BCM: chip id 94
> >>>>> [   15.318567] Bluetooth: hci0: BCM: features 0x2e
> >>>>> [   15.341538] Bluetooth: hci0: BCM43430A1
> >>>>> [   15.341560] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
> >>>>> [   19.112670] Bluetooth: hci0: BCM (001.002.009) build 0360
> >>>>> [  274.713732] Bluetooth: hci0: command 0x0c14 tx timeout
> >>>>> [  274.714085] Bluetooth: hci0: Frame reassembly failed (-84)
> >>>>> [  317.275941] Bluetooth: hci0: last event is not cmd complete (0x0=
f)
> >>>>>=20
> >>>>> I don't see these errors on RPi Zero W. Maybe the reason for this i=
s the lack of hardware flowcontrol on RPi 3. Or some of the downstream patc=
hes on BlueZ must be adapted for the kernel [1].
> >>>>>=20
> >>>>> Btw the bcm43438 is detected even after unloading and reloading the=
 driver. But the timeout occurs also on driver reload. Reducing the baudrat=
e to 115200 doesn't help here.
> >>>>=20
> >>>> maybe it needs some time after switching the hardware on. Have you t=
ried to sleep for a bit at the end of bcm_gpio_set_power?
> >>>=20
> >>> I will try, but this could also be an "issue" of the gpio expander
> >>> driver. AFAIK the expander is connected via I2C to the GPU. In case
> >>> the mailbox reply come before the I2C command has been handled by the
> >>> GPIO expander, we are running out of sync.
> >>=20
> >> The mailbox command for setting GPIO state is synchronous in terms of
> >> sending the i2c command to the GPIO expander HW.
> >
> > does that mean the driver does this correctly and really waits for the
> > completion. Or does the GPIO expander might return to quickly and
> > returns a false sense of GPIO state. I think it would be good a sleep
> > of 50ms after the GPIO makes a difference. Maybe the GPIO expander
> > driver needs to take this into account.
>=20
> It seems unlikely that you can get to I2C stop before the GPIO expander
> HW has changed the state of the output.
>=20
> > Reality is that once the Bluetooth driver toggled the GPIO, it goes
> > onto initializing the chip. One other reason might be that no device
> > wakeup GPIO is wired here, that the chip actually needs some time
> > before it is all good to go.
>=20
> This seems much more likely to me.  The spec for bcm43438 is easily
> googleable and has a power-on timing diagram.

after applying this patch [1] the RPi 3 specific probing errors disappear.

But this is only a quick hack. The proper solution would be to extend hci_h=
5 in order to support the BCM43438.

[1] - https://github.com/lategoodbye/rpi-zero/commit/ed5900296dfb7aec7f4674=
77440751e7367a1881

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
