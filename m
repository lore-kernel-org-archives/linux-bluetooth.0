Return-Path: <eric@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Marcel Holtmann <marcel@holtmann.org>, Loic Poulain <loic.poulain@gmail.com>
Cc: devicetree@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>, rjui@broadcom.com, linux-bluetooth@vger.kernel.org, robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/4] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 serial slave
In-Reply-To: <972AD2C1-FE7C-412D-AEC6-FFED22EC4B77@holtmann.org>
References: <1502992791-10265-1-git-send-email-loic.poulain@gmail.com> <1502992791-10265-3-git-send-email-loic.poulain@gmail.com> <972AD2C1-FE7C-412D-AEC6-FFED22EC4B77@holtmann.org>
Date: Wed, 23 Aug 2017 09:17:29 -0700
Message-ID: <8760dep8bq.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Loic,
>
>> Add BCM43438 (bluetooth) as a slave device of uart0 (pl011/ttyAMA0).
>> This allows to automatically insert the bcm43438 to the bluetooth
>> subsystem instead of relying on userspace helpers (hciattach).
>>=20
>> Overwrite chosen/stdout-path to use 8250 aux uart as console.
>>=20
>> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
>> ---
>> v2: dt-bindings as separate patch
>>     rebase on upcoming pi3 dts changes
>> v3: changes in bcm serdev drivers:
>>     name refactoring and additional comments
>>     Add generic host_set_baudrate method
>>     Use agnostic device_property_read
>> v4: changes in doc and dts:
>>     Add additional params to broadcom bt dt-bindings
>>     Set the max baudrate to 2000000 instead of 921600
>>     use chosen/stdout-path instead of console=3D
>>     remove useless earlyprintk
>>     same changes in bcm283x.dtsi
>>=20
>> arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>
> do you mind resending the 2 pending patches with Rob=E2=80=99s ack on it.=
 And ensure that this goes with DT tree since I can currently not take it s=
ince net-next has not pulled in the pending DT patches.

Normally we wouldn't need a resend and I'd just apply the acks when
applying the DT patches, but I don't see them in my mail.

(Also, note that since we're already at rc6 I might not be able to apply
DT patches to -next until rc1 rolls around)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlmdqpoACgkQtdYpNtH8
nujwoA/+IBQzHeRxu3CHfjFYih1ASkVpQRPZ5h9yzu1sp7jMiiRSDOfBQ5UjlBso
po15d45IUBQb0WQqVQbIctQYb0MXJjPhzmpC9LaNJfPJ5jKlcVQscYUIeRds3Xln
a/YFw9magiT4hlShEabPX+BN4bl/CGqE0/XBVwpHjwSR4G1DSMiQ4e7Oujw2qFNF
XxJTBEOL0o2IrpuA1WSNSQFD0of7jKnE0FQPrzDDDS4v0jpQJDfwCfgaUslQblh3
9HfptaoTBTKBfYzi2p5QPl2rpYQTQiN0Fg/D7qBM9nhAEjz+W6loylTmt3t9VY9n
xLGda5rNPUBYUg0SW7c0pMZvz5df5B568aSn/cCZOu80mWxzeJ9y6zg1Us+ELeJT
UAphvlqU5NIrhvHH8qA3bpo3H4KPUmObhqg1IaQZD3O8JN38QeuDdCr3e1QxtFpY
uDWXS23Eh0E4kCOFNeUoPB/xe7luY2PdLIXdls+GjD7bomm475oxXfUlhMcu8Xxo
gywFHtd+/CR7ECCRKPi+5FwtIr7uhzWzQbj7QGluKpAG6RPQcJW0NPf8w2D+dg6B
umde1e4MR2Biw+duGv15tONpN7HVJS2eFFMoco5Iqp5ZDyzul+ui10zaaXiTjl8q
hfZc5liLsdTbdonAJEKYnYKllc9wJF63sGYLwArSOYBTbt8icgA=
=rTaz
-----END PGP SIGNATURE-----
--=-=-=--
