Return-Path: <sre@kernel.org>
Date: Wed, 14 Feb 2018 13:37:22 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Hugues <morisset.hugues@gmail.com>
Cc: Linux-Bluetooth <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Bose Quiet Comfort 35 Remaining Battery Reporting
Message-ID: <20180214123722.ybz54w3wsbmdhhgo@earth.universe>
References: <20170213055504.kworoylsusadecl7@earth>
 <1415ce15-3e92-3695-4d83-aac96e442ec1@gmail.com>
 <9c7adf82-d6b2-6f2f-b954-728f4bacee7c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2k3ufpjo2lhufmoq"
In-Reply-To: <9c7adf82-d6b2-6f2f-b954-728f4bacee7c@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--2k3ufpjo2lhufmoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hugues,

I agree, that this should be handled in bluez instead of pulseaudio.
I only implemented the proof of concept in pulseaudio, since it was
not easily possible in bluez and easy to do in pulseaudio. I think
some restructuring of bluez/pulseaudio rfcomm handling is required,
but I don't plan to take care of this.

-- Sebastian

On Sun, Feb 11, 2018 at 02:22:46PM +0100, Hugues wrote:
> Hello,
> Sebastian code works great!
> But how can I proceed so the remaining battery is exposed over upower?
>=20
> 	Greping through pulseaudio sources
> (git://anongit.freedesktop.org/pulseaudio/pulseaudio) for 'battery'
> doesn't return anything, so anything about battery power seems unlikely
> to be merged into pulseaudio.
>=20
> 	upower already expose batteries from bluez through dbus
> (git://anongit.freedesktop.org/upower:src/linux/up-device-bluez.c)
>=20
> So is it possible to do the AT commands at the bluez level and expose
> the infos through dbus, so upower expose it to the rest of the system?
>=20
> Thanks,
> Hugues
>=20
> On 02/24/2017 12:01 PM, Hugues wrote:
> > Hello,
> > Thanks a lot!
> > I tried to connect to the headset through dbus to make the AT commands,
> > but failed.
> > So what's the services/program where this should be implemented so it
> > can be exposed on dbus and picked up by the Desktop Environment?
> >=20
> > Regards,
> > Hugues
> >=20
> > On 02/13/2017 06:55 AM, Sebastian Reichel wrote:
> >> Hi,
> >>
> >> FWIW I was also interested in battery level of my Bose QC35 and
> >> checked this some time ago. That time I only checked the low
> >> energy stuff, since the Android application seems to know the
> >> battery status with only LE being connected.
> >>
> >> Marcel Holtman wrote:
> >>>> This headset do have dual mode, I searched around using gatttool ant=
 the
> >>>> gatt specification but I find nothing about Battery Level
> >>>> (org.bluetooth.characteristic.battery_level.xml) or Battery Service
> >>>> (org.bluetooth.service.battery_service.xml).
> >>
> >> Bose QC35 does not expose battery status through standard battery_level
> >> characteristic. There is a proprietary primary service 0xfebe (which
> >> is assigned to Bose) with a couple of custom services. I assume battery
> >> level can be read through them, but the required commands are unknown.
> >>
> >>>> How could I read what's in the Apple HFP extensions?
> >>>
> >>> Start with this one. It describes the extra HFP AT commands that iOS =
uses:
> >>>
> >>> https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines=
=2Epdf
> >>
> >> Thanks for the documentation link! That is actually implemented for
> >> the Bose QC35. Here is a quick hack providing battery status info
> >> in pulseaudio log:
> >>
> >> https://github.com/sre/pulseaudio/commit/d66b66d20e9bc73e6d0ca89283cf2=
b5675304b00
> >>
> >> -- Sebastian
> >>
> >=20
>=20

--2k3ufpjo2lhufmoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqELX8ACgkQ2O7X88g7
+poGhw/+NjBTTCBhJ+ZReSV8FkEkHRkilnGO3iJ9XzS8aFxwFnvlAvxX6Xf7/ZvW
jWDoxyNiaqeRgAFMDtPjcKWLpORy3FGON85DAO8p3JlrXD8YkYPDsSP71b2w0nC2
0rPWNKTDi/BlJV5gavBzQMZ9YNh2wkTUmSWvIvv8ZTaiZrOBSMzoV+PFQkgXotCU
0cUFk5wfBVCQH3uKajeVnWOjmkKqIHSVjKSjmQL4Kt4tAqDtYGn5sc5n/S51xbso
lwi6qhT6k8SWBeIFdibYS5J7T04S8918JC2twqpyVLhjDv8hsofaxGmWovluj81H
yegvY2Uza7lsFbjMTP+MYV88I6s1ffNgih31wfiRiGrnUcHl1AO2aoBQUUfvdFMd
LD8RvHXpDirV1m9FhWMMW4fJqmWDGsrwyYBwgRIJwvOCqEuQ6Duw9L85yjjRSCrs
3ISrZbcoOlDDEaKg81tEA0hHGATo+WmThMqEKgA0c9zwC/ijwkMePltQ5qCpK3af
2svD38wHpT7SyncTNB0PNSq/m53SIlRI5iH0C4DRToKj0Avj+k6G+y29nOWl6pc+
igPR8wAgFg8MWEKrwbpZZFR6UI3t3M2MzDQot67693omdGeJAIPwv9rJzhrTMHZb
YO08sH/3sf7SBQa7OrynGyxlGJFLeuOjK7vJlhhWRFH26yTdY5w=
=K6AK
-----END PGP SIGNATURE-----

--2k3ufpjo2lhufmoq--
