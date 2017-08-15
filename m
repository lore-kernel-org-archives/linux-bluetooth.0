Return-Path: <eric@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Rob Herring <robh+dt@kernel.org>, Loic Poulain <loic.poulain@gmail.com>
Cc: "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Marcel Holtmann <marcel@holtmann.org>, "open list\:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: net: bluetooth: Add broadcom-bluetooth
In-Reply-To: <CAL_Jsq+akZpqXMPnSh8KRVchWJpFTrzFi6LpOpJ9FYDCrY1hPQ@mail.gmail.com>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com> <CAL_Jsq+akZpqXMPnSh8KRVchWJpFTrzFi6LpOpJ9FYDCrY1hPQ@mail.gmail.com>
Date: Tue, 15 Aug 2017 10:42:12 -0700
Message-ID: <87wp64sp6z.fsf@eliezer.anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Rob Herring <robh+dt@kernel.org> writes:

> On Mon, Aug 7, 2017 at 5:39 AM, Loic Poulain <loic.poulain@gmail.com> wrote:
>> Add binding document for serial bluetooth chips using
>> Broadcom protocol.
>>
>> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
>> ---
>>  v2: dt-bindings as separate patch
>>      rebase on upcoming pi3 dts changes
>>  v3: changes in bcm serdev drivers:
>>      name refactoring and additional comments
>>      Add generic host_set_baudrate method
>>      Use agnostic device_property_read
>>  .../devicetree/bindings/net/broadcom-bluetooth.txt | 29 ++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> new file mode 100644
>> index 0000000..c51ea1b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> @@ -0,0 +1,29 @@
>> +Broadcom Bluetooth Chips
>> +---------------------
>> +
>> +This documents the binding structure and common properties for serial
>> +attached Broadcom devices.
>> +
>> +Serial attached Broadcom devices shall be a child node of the host UART
>> +device the slave device is attached to.
>> +
>> +Required properties:
>> +
>> + - compatible: should contain one of the following:
>> +   * "brcm,bcm43438-bt"
>> +
>> +Optional properties:
>
> Most Broadcom devices have a couple of GPIOs needing control. Maybe
> they are tied off active on RPi3, but you should document them here
> even if the driver doesn't yet need them. I think they are the same as
> the Nokia BT IIRC. Same goes for any input clocks.

As far as the clock goes, I think it would be a reference to <&cprman
BCM2835_CLOCK_GP2>, and the clock should be at 32Khz.  (This is already
set up at boot by the firmware).

In the schematics I have, there are two GPIO lines going to the chip:
BT_ON (expander gpio 0) and WL_ON (expander gpio 1).  We don't have
support for the expander yet, and they are already enabled at boot time,
so hopefully they can be optional properties.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlmTMnQACgkQtdYpNtH8
nug/2RAApwOhrNan3+2EdwzRlJmsz+yuIJoskuO3ml28yuR9S28cKkkTaz2i3mUD
I9XWlb1haQmgBNm1Wu+n5MRUk/uH8tD8VwHgJzpcMy+OmmO84QGFtJAaErYrRHRt
AYsVW3BGwt2xtKX8tBWALtKPu10tncqdy2xfOr2iqZlod8augs4w9KQ/1Sc+oy1F
gp++XvvWF21IYjN4o2/zVUSm+1eHYPAVa3p9rGV+2pMXARQEGXu3i979NasjYtaP
F0SBA1GyqELin0H5ypYtC/oNKAOFjPP1M2zjsVjYQq/Y1o+X/mIIUa3HCZrIhjjG
01Xf5UxSkeYPZye5dcn3IQJYtEsD93hhBf3DnXNntI2s5eBgdqeV/YVU04YC4RnF
sH/SAr5BTsT0QdM0Z64OnRUbSh4sSAZww1iU2BiY+t1wrTKXrDsf1pUJ16I5OqdB
j3LlaUeUdYA94UXSExvgpgFf0QaFqZaJVOv9iE08W1Wd2RNq8arbxCyFkJG4+YG9
m9R8EVcwen1CUOcajUDetBOapqTyK3sy5PtEQOFFdRkUKJ2uB1V91lIzYltBcHKu
ohRs4ASs4XW4J/oAJ4Pqd+PSSFhfmu91qz/Fh9JklCTOL6CyitI+YD9ZhSoZkV3T
SHMu1EdIJcxkRSFjnqnufIVTGAvEqtx+iYcenMZKNHV63g/2DUQ=
=dGeh
-----END PGP SIGNATURE-----
--=-=-=--
