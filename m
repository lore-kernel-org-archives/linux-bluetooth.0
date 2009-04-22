Return-Path: <cyrus@holtmann.org>
Message-ID: <49EF90D3.8070402@dell.com>
Date: Wed, 22 Apr 2009 16:49:07 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Nicol=F2_Chieffo?= <nicolo.chieffo@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: hid2hci in udev rule not working
References: <98391a7b0904210923w2ccba6b1p480dc15fb0298e20@mail.gmail.com>
In-Reply-To: <98391a7b0904210923w2ccba6b1p480dc15fb0298e20@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDA56E17085F013BE8304A02B"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA56E17085F013BE8304A02B
Content-Type: multipart/mixed;
 boundary="------------090000090705000501010104"

This is a multi-part message in MIME format.
--------------090000090705000501010104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Nicol=F2:

Nicol=F2 Chieffo wrote:
> Hello, I own a laptop with a bluetooth which is automatically detected
> as a HID device if I switch it on when ubuntu is running.
> in lsusb I see those 2 lines, for HID mouse and keyboard
>
> Bus 003 Device 010: ID 413c:8158 Dell Computer Corp.
> Bus 003 Device 009: ID 413c:8157 Dell Computer Corp.
>
> the package bluez 4.32 which I have installed from Jaunty, includes
> the file /lib/udev/rules.d/62-bluez-hid2hci.rules with the content:
> ACTION=3D=3D"add", ATTRS{idVendor}=3D=3D"413c",
> ATTRS{bInterfaceProtocol}=3D=3D"02", ATTRS{bmAttributes}=3D=3D"e0",
> RUN+=3D"/usr/sbin/hid2hci --tohci"
>
>  =20
This rule actually was denied upstream so it's carried as an Ubuntu
patch.  Upstream prefers that hid2hci be modified to take command line
arguments before accepting this type of patch.
> unfortunately when I enable the bluetooth switch, the udev rule is not
> called. in my dmesg I see:
> [ 1090.952069] usb 3-1: new full speed USB device using uhci_hcd and ad=
dress 15
> [ 1091.129216] usb 3-1: configuration #1 chosen from 1 choice
> [ 1091.131133] hub 3-1:1.0: USB hub found
> [ 1091.134459] hub 3-1:1.0: 3 ports detected
> [ 1091.414110] usb 3-1.1: new full speed USB device using uhci_hcd and
> address 16
> [ 1091.532208] usb 3-1.1: configuration #1 chosen from 1 choice
> [ 1091.539342] input: HID 413c:8157 as
> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1:1.0/input/input21=

> [ 1091.565146] generic-usb 0003:413C:8157.0009: input,hidraw0: USB HID
> v1.11 Keyboard [HID 413c:8157] on usb-0000:00:1a.0-1.1/input0
> [ 1091.641085] usb 3-1.2: new full speed USB device using uhci_hcd and
> address 17
> [ 1091.763220] usb 3-1.2: configuration #1 chosen from 1 choice
> [ 1091.770411] input: HID 413c:8158 as
> /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.2/3-1.2:1.0/input/input22=

> [ 1091.805156] generic-usb 0003:413C:8158.000A: input,hidraw1: USB HID
> v1.11 Mouse [HID 413c:8158] on usb-0000:00:1a.0-1.2/input0
>
> can you help me on making this rule work?
> please CC me to replies since I'm not subscribed to the list.
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetoo=
th" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20
It looks like for some reason or another the rule doesn't work with
newer udev versions.  Can you try the attached rule instead?  If that
works out, we can at least put that together as an Ubuntu SRU until the
device arguments get added to hid2hci.

Regards
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------090000090705000501010104
Content-Type: text/plain;
 name="62-bluez-hid2hci.rules"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="62-bluez-hid2hci.rules"

#UDEV Rules to match on Bluetooth USB dongles that need to be switched to=
 HCI mode upon
#being plugged into the PC's USB bus.

#This rule covers a variety of Dell Bluetooth adapters
# it looks like a bit of an odd rule, because it is matching
# on a mouse device that is self powered, but that is where
# a HID report needs to be sent to switch modes.
ACTION=3D=3D"add", ENV{ID_VENDOR}=3D=3D"413c", ENV{ID_CLASS}=3D=3D"mouse"=
, ATTRS{bmAttributes}=3D=3D"e0", KERNEL=3D=3D"mouse*", RUN+=3D"/usr/sbin/=
hid2hci --tohci"

--------------090000090705000501010104--

--------------enigDA56E17085F013BE8304A02B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknvkNMACgkQ2CrZjkA73YvC1ACePyScL3VryPL9lLY9Ruv1ztcf
ZJ0AnjhdNHQxkOsc173RAmxuw6Ady0Or
=QHNV
-----END PGP SIGNATURE-----

--------------enigDA56E17085F013BE8304A02B--
