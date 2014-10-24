Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/signed; boundary="Apple-Mail=_CBF0F8D8-C6C4-4F7E-AA48-191F8E8DF195"; protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: GATT + DBus API Questions
From: Ryan Du Bois <rdub@kamama.com>
In-Reply-To: <CAHrH25SBUL+JtDN_YF-FHfMRa3jqkhZs1YSr5QL5K5Oe_+xJQQ@mail.gmail.com>
Date: Thu, 23 Oct 2014 17:21:37 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <68B9F3E4-5167-413F-9907-7733B8B404B2@kamama.com>
References: <35EC48BC-A069-4F13-94E8-32A1533BB15C@kamama.com> <CAHrH25SBUL+JtDN_YF-FHfMRa3jqkhZs1YSr5QL5K5Oe_+xJQQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_CBF0F8D8-C6C4-4F7E-AA48-191F8E8DF195
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hey Arman,

On Oct 23, 2014, at 5:00 PM, Arman Uguray <armansito@chromium.org> =
wrote:

> Hi Ryan,
>=20
> On Thu, Oct 23, 2014 at 4:41 PM, Ryan Du Bois <rdub@kamama.com> wrote:
>> Hey There,
>>=20
>> I've been trying to create a GATT service via the DBus BlueZ API =
(org.bluez.GattManager1 + org.bluez.GattService1/GattCharacteristic1).  =
I'm currently using dbus-python to do this.
>>=20
>> What I have been able to accomplish thus far (with much exploring of =
the source code, and additional DBG() messages added to illuminate where =
I had been going wrong) is the following:
>>        - Created proper DBus Proxy objects for GattService1 & =
GattCharacteristic1
>>                - Each object vends the =
org.freedesktop.DBus.Properties interface, to allow BlueZ to retrieve =
the UUID and other properties on each instance.
>>        - Created a proper ObjectManager proxy object to allow BlueZ =
to retrieve the aforementioned GattService1 and GattCharacteristic1 =
objects.
>>        - Called GattManager1's RegisterService() method with =
appropriate arguments.
>>        - Observed that BlueZ's GattManager1 instance calls my =
ObjectManager's GetManagedObjects() method, and receives the appropriate =
object paths/handles/properties.
>>        - Observed that BlueZ accomplishes all the internal machinery =
necessary to register the GATT Service in src/gatt-dbus.c (namely, I get =
the "Added GATT service /com/kamama/blargh..." printout on the console, =
when running in debug mode).
>>=20
>> What I'm not able to see is the GATT service being listed when I =
explore the GATT services on my device via a BTLE exploration tool (I'm =
using LightBlue on Mac OS X to explore this device).
>>=20
>> Looking closer at the code, it looks to me like src/gatt-dbus.c is =
not hooked up to attrib/gatt-service.c, which is probably why my GATT =
Service and Characteristic are not showing up when exploring the device.
>>=20
>> Am I missing something, or is this not yet implemented?
>>=20
>> Thanks!
>> --
>> +Ryan Du Bois
>> rdub@kamama.com
>>=20
>=20
> As far as I know, gatt-dbus isn't actually wired up to attrib-server
> as you said. So it populates an internal linked list of attributes but
> then doesn't actually do anything over the listening socket it
> creates.
>=20
> The thing is, we're currently in the process of rewriting all of
> bluez's internal GATT/ATT tools and we'll probably entirely rewrite
> src/gatt-dbus as well. An experimental implementation should appear
> for both GATT client and server roles in the upcoming months, but
> until then there's no good way to host GATT services over D-Bus.
>=20
> Thanks,
> Arman

Okay, that correlates with what I'm seeing. Most examples I've seen =
online
have been implemented in C, calling gatt_service_add().

In the time between now and a working DBus GATT API, would that=20
approach be the proper method to host a GATT service with BlueZ?
I'm on 5.21 at the moment, but could easily upgrade to something else
if it's better for GATT services.

Thanks!
--
+Ryan Du Bois
rdub@kamama.com


--Apple-Mail=_CBF0F8D8-C6C4-4F7E-AA48-191F8E8DF195
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJUSZuRAAoJEK4Z1vjpzDGSj/cH/0lfNd2odTgIhTvpKlphDM6y
PnFx/j7TVR62A5vMqU8L6gx0Mp7qOGCpLTyqOT+ylfzY4zw8lknuJxR9LigxqvbU
oGsSM/5eBZW6RJvtNOzTW5cwELmeLX6DUBe55YwPJtxXk+blA9pQo/szkWlVP6UJ
/8bZt9IT9QAAgVvEBrcNCHpq5VprJH4qkG1MwlfNcvymruHOVVnZ/mTKPxu/e3k2
8JRlSZDVAwSwORs+j44+VEVsVorTJZXhOvUoaYE4dY9Kj6mGJ0dmItvk/fCRETSO
MIj0AgY2SzK1AWVUMhUR9qPxw0Y1+ISd/rnIWCFLkB2e0Aok0QKC13c2twOBnzY=
=4dEm
-----END PGP SIGNATURE-----

--Apple-Mail=_CBF0F8D8-C6C4-4F7E-AA48-191F8E8DF195--
