Return-Path: <stefan.wahren@i2se.com>
Date: Mon, 14 Aug 2017 19:39:06 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Loic Poulain <loic.poulain@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-rpi-kernel@lists.infradead.org,
	Johan Hedberg <johan.hedberg@gmail.com>, devicetree@vger.kernel.org
Message-ID: <1880215175.270786.1502732346219@email.1und1.de>
In-Reply-To: <e001e055-10a5-facd-a8e1-57c1bdb78172@gmail.com>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
 <1502102366-2760-2-git-send-email-loic.poulain@gmail.com>
 <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com>
 <8186E2A3-D0AC-498F-8229-78862D363F78@holtmann.org>
 <392e6d51-33d6-1585-6582-1397a0c64852@gmail.com>
 <161632C7-EBBF-47F5-86DC-453E10395B54@holtmann.org>
 <e001e055-10a5-facd-a8e1-57c1bdb78172@gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as
 serial slave
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Loic Poulain <loic.poulain@gmail.com> hat am 14. August 2017 um 19:32 ges=
chrieben:
>=20
>=20
>=20
>=20
> On 14/08/2017 18:02, Marcel Holtmann wrote:
> > Hi Loic,
> >
> >>>>> Add BCM43438 as a slave device of uart0 (pl011/ttyAMA0).
> >>>>> This allows to automatically insert the bcm43438 to the bluetooth
> >>>>> subsystem instead of relying on userspace helpers (hciattach).
> >>>>>
> >>>>> Overwrite bootargs to use 8250 aux uart (ttyS0) as console instead
> >>>>> of pl011/ttyAMA0.
> >>>>>
> >>>>> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> >>>>> ---
> >>>>> v2: dt-bindings as separate patch
> >>>>>      rebase on upcoming pi3 dts changes
> >>>>> v3: changes in bcm serdev drivers:
> >>>>>      name refactoring and additional comments
> >>>>>      Add generic host_set_baudrate method
> >>>>>      Use agnostic device_property_read
> >>>>>
> >>>>> arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
> >>>>> 1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/=
dts/bcm2837-rpi-3-b.dts
> >>>>> index 20725ca..5abc1df 100644
> >>>>> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> >>>>> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> >>>>> @@ -8,6 +8,11 @@
> >>>>>         compatible =3D "raspberrypi,3-model-b", "brcm,bcm2837";
> >>>>>         model =3D "Raspberry Pi 3 Model B";
> >>>>>
> >>>>> +       chosen {
> >>>>> +               /* 8250 auxiliar UART instead of pl011 */
> >>>>> +               bootargs =3D "earlyprintk console=3DttyS0,115200";
> >>>> This is an unrelated change. "earlyprintk" is arm32 specific and onl=
y
> >>>> works with a kernel built with a specific uart type and address. Als=
o,
> >>>> stdout-path property is preferred to set the default over "console=
=E2=80=9D.
> >> I'm going to use stdout-path according to your comment.
> >> However one of the goals was to overwrite the bcm283x.dtsi bootargs,
> >> I assume the same comment apply on the dtsi (stdpath usage /earlyprint=
k)
> >> which should require update too.
> >>
> >>> the whole fun with the serial console on the rPI3 and the bt-miniuart=
 overlay is something we should solve now. What is the upstream story on th=
is since the config.txt and everything around it is confusing and also misl=
eading since it relies on a Raspbian userspace.
> >>>
> >>> Do we need to the kernel and init to stay away from the ttyAMA0 to av=
oid confusing the BT chip? As I mentioned earlier, I can not even get a Fed=
ora 26 with hciattach or btattach to work.
> >>>
> >> It is also possible to mux the auxiliary mini UART to drive the Blueto=
oth
> >> controller in order to keep ttyAMA0 as the "legacy" RPi ext-uart/conso=
le,
> >> however SoC spec says that this mini UART is intented to be used mainl=
y as
> >> a console due to shallow FIFOs and no DMA.
> > what upstream kernel tree did you test this with? On a Fedora 26 kernel=
 (now 4.12 based), I still do not have the Bluetooth hardware working.
> >
> > Regards
> >
> > Marcel
> >
>=20
> I built kernel, modules and dtb from a bluetooth-next tree (4.12 and=20
> 4.13-rc3).
> Using 32-bit multi_v7_defconfig + some additional confs to enable=20
> miniuart (BCM2835AUX...) for console.
> I push this on a raspbian image.
>=20
> my boot/config.txt is very simple (no overlay):
>=20
> kernel=3DzImage
> device_tree=3Dbcm2837-rpi-3-b.dtb
> # hack for miniuart serial clock
> core_freq=3D250
> dtparam=3Daudio=3Don
>=20

since the BCM2837 is a 64 bit platform, could you please test also this cas=
e?

Thanks
Stefan

> Regards,
> Loic
>=20
>=20
>
