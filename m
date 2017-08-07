Return-Path: <eric@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Marcel Holtmann <marcel@holtmann.org>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: devicetree <devicetree@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, sbranden@broadcom.com, rjui@broadcom.com, "open list\:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Loic Poulain <loic.poulain@gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_bcm: Add serdev support
In-Reply-To: <A997C486-989A-4040-9871-773A858D8410@holtmann.org>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com> <1501576704-26423-3-git-send-email-loic.poulain@gmail.com> <696124D4-A5DA-46FA-A0F0-5DC74363BD23@holtmann.org> <444254163.121186.1501874785594@email.1und1.de> <51D602E3-B21A-402B-A1F5-6241D55448E9@holtmann.org> <1498038890.121361.1501875841550@email.1und1.de> <BB04C3A8-2BFC-44B7-AA84-E0B81F560B8C@holtmann.org> <653244764.121525.1501876203800@email.1und1.de> <A997C486-989A-4040-9871-773A858D8410@holtmann.org>
Date: Mon, 07 Aug 2017 15:17:25 -0700
Message-ID: <87o9rr10qy.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Stefan,
>
>>>>>>>> Add basic support for Broadcom serial slave devices.
>>>>>>>> Probe the serial device, retrieve its maximum speed and
>>>>>>>> register a new hci uart device.
>>>>>>>>=20
>>>>>>>> Tested/compatible with bcm43438 (RPi3).
>>>>>>>>=20
>>>>>>>> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
>>>>>>>> ...
>>>>>>>>=20
>>>>>>>> +static int bcm_serdev_probe(struct serdev_device *serdev)
>>>>>>>> +{
>>>>>>>> +	struct bcm_bt_device *bcmdev;
>>>>>>>> +	u32 speed;
>>>>>>>> +	int err;
>>>>>>>> +
>>>>>>>> +	bcmdev =3D devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNE=
L);
>>>>>>>> +	if (!bcmdev)
>>>>>>>> +		return -ENOMEM;
>>>>>>>> +
>>>>>>>> +	bcmdev->hu.serdev =3D serdev;
>>>>>>>> +	serdev_device_set_drvdata(serdev, bcmdev);
>>>>>>>> +
>>>>>>>> +	err =3D of_property_read_u32(serdev->dev.of_node, "max-speed", &=
speed);
>>>>>>>> +	if (!err)
>>>>>>>> +		bcmdev->hu.oper_speed =3D speed;
>>>>>>>> +
>>>>>>>> +	return hci_uart_register_device(&bcmdev->hu, &bcm_proto);
>>>>>>>> +}
>>>>>>>=20
>>>>>>> We do not need any GPIO for reset lines or anything else for the rP=
I3?
>>>>>>>=20
>>>>>>=20
>>>>>> unfortunately we don't have full schematics for RPI3, but according =
to firmware dt-blob.dts [1] there is a GPIO called BT_ON. This GPIO is cont=
rolled by the GPIO expander on the RPI3 board. The necessary driver for thi=
s expander is still out of tree (last mainlining attempt [2]).
>>>>>=20
>>>>> so who handles this GPIO then right now (or any other GPIO for that m=
atter)? I have seen Bluetooth being enabled and operational, but I really w=
ant to get this working in a plain upstream Fedora and without using hciatt=
ach or btattach.
>>>>=20
>>>> The GPU firmware enables the GPIO and keeps this state. The mentioned =
expander driver should provide the ARM core (Linux) the necessary control.
>>>=20
>>> what is the default behavior after reboot. BT_ON enabled or not?
>>=20
>> AFAIK: enabled

Correct: it's enabled by the 2nd stage bootloader and never modified
From=20there.

> that would be a funny default since it means that it consumes power
> even if Bluetooth is never used. We really want to hook this up into
> the Bluetooth power control of the controller. So that on power down
> it also disables it and saves as much power as possible.

We would need a driver to talk to the firmware for the GPIO expander to
turn it off.  I wrote one last year, but my motivation got killed by DT
bikeshedding.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlmI5vYACgkQtdYpNtH8
nuiQpBAAjpOkOzUm5soRf0LWy38aWFIHEkHlIjUreAv4em81pDyO2zYiRXEOz8hF
wm8bGxoOgi21nc1lQJgh1nzLuXUuHohXdEm6haN3EHDJGvOTX7fk49BGL3BGi0ld
f6NHAYEpkrUFwjekmYeUNjgGstkKL96eE30V0MVl+4mWiRY0zV5mR9H/w41mIxgV
/4dobMJiJD15lwY5Kh22EB+EgAiURHoEpCNRJAgorHcwR4kiK223pLwhQ8ZtaA13
hk6x7GdAcfpshGopUNsTd18nCZIm/6IgghMH+WetUg/c3j5/8ttyTn9v0Jr8CmmV
VV8ZZypti2RK9gwHUqct6SFGrc7IvC3FrhgAD2hYsMWrIq2uDaEQ3R11qwUeVJxc
n/YpeNt/ZZsGguQ9h01In3Qh68Zd1DSzOh7VEirNAQrP/Qx6s+ZzVOuWwQCaG/YR
hND01SPt2Cgcf4k8tW5Kz/drc5EWs8uOrmLn+GD42QRjAZdkoHBxR7L/RUqR9OQU
UZcZtpIJ+GOydL/VKAaMiOZ2OrUPml8zk+ilAqOdwyS4PKf2mdup8v9afcaIyBT9
y9ZAfh+nMJpPRH2/W+GyLKrEiB83F2Fz7zt58igivri7MWEwu2FrP46adHjwYGxZ
+AAG3ZYfRc1XKP5cm93uvAVtJ6l0rOUrSf4e9GS9r+YIgpw3nN8=
=TLCr
-----END PGP SIGNATURE-----
--=-=-=--
