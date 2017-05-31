Return-Path: <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
Subject: Re: BT led trigger
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
References: <0d6dd864-4c1b-5b78-ad67-98343ee42950@monstr.eu>
 <224A641D-142D-4C11-BA6A-8AE1D338752D@holtmann.org>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <3891fa14-043d-abf8-786c-1a2a82925283@monstr.eu>
Date: Wed, 31 May 2017 19:57:45 +0200
MIME-Version: 1.0
In-Reply-To: <224A641D-142D-4C11-BA6A-8AE1D338752D@holtmann.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6HW3ETKD9ogidWL49mspiMhbD1pJ6OqSA"
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6HW3ETKD9ogidWL49mspiMhbD1pJ6OqSA
Content-Type: multipart/mixed; boundary="14ETBD4WsjM8XR6n15UccdwNRNOKHbMe6";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Message-ID: <3891fa14-043d-abf8-786c-1a2a82925283@monstr.eu>
Subject: Re: BT led trigger
References: <0d6dd864-4c1b-5b78-ad67-98343ee42950@monstr.eu>
 <224A641D-142D-4C11-BA6A-8AE1D338752D@holtmann.org>
In-Reply-To: <224A641D-142D-4C11-BA6A-8AE1D338752D@holtmann.org>

--14ETBD4WsjM8XR6n15UccdwNRNOKHbMe6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Marcel, +linux-bluetooth,

On 31.5.2017 19:34, Marcel Holtmann wrote:
> Hi Michal,
>=20
>> I have found your name in connection to net/bluetooth/leds.c trigger.
>> I understand that this trigger will show status of hci controller
>> and this is just working fine. I have tested it without any issue.
>> I am curious if we could use this trigger to handle also gpio signal
>> which is enabling BT. I am using ti chip where we have bt_en connected=

>> to gpio.
>> I have seen that people are handling this from userspace by exporting
>> gpio and writing values there but it looks pretty bad to me.
>>
>> Have you ever tried to use bt led trigger also for handling gpio enabl=
e
>> signals? Or is there any other nice way how to handle it?
>=20
> that is the wrong approach. See how hci_intel.c, hci_bcm.c, hci_nokia.c=
 and others are dealing with the GPIO pins in the background. There is no=
 need for any user space hacks anymore.

I use TI wl1831 over uart with flow control which is using hci_ll.c.
I understand handling when you have specific driver that you need to
handle it. But if this is just over uart where from simply running
"hciattach -n /dev/ttyS1 texas"
I can detect this chip.

> Also please use linux-bluetooth@vger.kernel.org for these kinds of ques=
tions.

Sorry about it now. Fixed now.

Also I have seen that in bluez that hciattach is deprecated tool.
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Db1eb2c4c
And there are new tools which should replace them
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D301904d6

Should I use btattach instead?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--14ETBD4WsjM8XR6n15UccdwNRNOKHbMe6--

--6HW3ETKD9ogidWL49mspiMhbD1pJ6OqSA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlkvBBkACgkQykllyylKDCH0PQCglkQ+TpE8UzTomnM/VbTatHv+
CasAn172qZd8SsXTPKYLOn5oVHzsvJcd
=3Qh/
-----END PGP SIGNATURE-----

--6HW3ETKD9ogidWL49mspiMhbD1pJ6OqSA--
