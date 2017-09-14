Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 14 Sep 2017 17:03:54 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>
Subject: Re: Bose QC35 HFP/HSP MTU size
Message-ID: <20170914150354.3hbpgfjylfycjr6w@earth>
References: <20170914114402.qbfwd3ceosrrgzqp@earth>
 <CABBYNZKT6-8VjGPMyJ87jBPnGWQ=LtfODT3JMyVfZ8Nzp=tiMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="omdpf4sdledlqbq5"
In-Reply-To: <CABBYNZKT6-8VjGPMyJ87jBPnGWQ=LtfODT3JMyVfZ8Nzp=tiMw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--omdpf4sdledlqbq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 14, 2017 at 05:00:16PM +0300, Luiz Augusto von Dentz wrote:
> On Thu, Sep 14, 2017 at 2:44 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > Bose QC35 are affected by the attached upgrade notice
> > from Pulseaudio 11. The workaround fixes the problem.
>=20
> This doesn't make much sense when the problem below refer to the local
> adapter not the remote device, so I suspect just about any device
> would have similar problem when using an MTU not compatible with the
> adapter.

Sorry, I didn't look at this more detailed and thought this would be
dependent on the remote device. I only tested the QC35, so all other
headsets may also be broken with the adapter now. The adapter is this
one:

	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info =3D BTUSB_INTEL },

-- Sebastian

> Or perhaps this does depend on the packet type the controller
> end up negotiating since the spec say:
>=20
>=20
> 6.5.2.1 HV1 Packet
> The HV1 packet has 10 information bytes. The bytes are protected with a r=
ate
> 1/3 FEC. No MIC is present. No CRC is present. The payload length is fixe=
d at
> 240 bits. There is no payload header present.
> 6.5.2.2 HV2 Packet
> The HV2 packet has 20 information bytes. The bytes are protected with a r=
ate
> 2/3 FEC. No MIC is present. No CRC is present. The payload length is fixe=
d at
> 240 bits. There is no payload header present.
>  can 6.5.2.3 HV3 Packet
> The HV3 packet has 30 information bytes. The bytes are not protected by F=
EC.
> No MIC is present. No CRC is present. The payload length is fixed at 240 =
bits.
> There is no payload header present.
>=20
> So HV1, HV2, HV3 packet size is 240bit =3D 48 bytes, but for EV and eSCO
> the payload is not fixed. So far we had assumed the controller would
> do the flow control so we just push data to its buffer but if it does
> expect the exact payload depending on the packet type that would
> explain why this doesn't work all the time. I have never seem a SCO
> buffer over 96 bytes and since packets but packets such as 3-EV5 can
> take up to 540 bytes of payload, well I guess we will need to ask the
> controller folks how they are handling SCO over HCI because the spec
> is not very clear about it.
>=20
> > -- Sebastian
> >
> >> https://www.freedesktop.org/wiki/Software/PulseAudio/Notes/11.0/
> >>
> >> Improved bluetooth MTU configuration
> >>
> >> The packet size (a.k.a. MTU, "maximum transmission unit") that
> >> PulseAudio uses with the bluetooth HSP profile was previously
> >> always configured to be 48 bytes. That worked with most hardware,
> >> but some adapters require a different packet size. Now PulseAudio
> >> asks the kernel what packet size should be used, which fixes the
> >> problem.
> >>
> >> However, a new problem appeared: some adapters that used to work
> >> with 48 byte packet size don't any more work with the size that
> >> the kernel tells PulseAudio to use. If you find that HSP audio
> >> stopped working when upgrading to PulseAudio 11.0, you can revert
> >> to the old behaviour by passing option "autodetect_mtu=3Dno" to
> >> module-bluetooth-discover in /etc/pulse/default.pa. If that fixes
> >> the problem, then please report the problem to the BlueZ and/or
> >> PulseAudio developers, so that the kernel can be fixed.
>=20
>=20
>=20
> --=20
> Luiz Augusto von Dentz

--omdpf4sdledlqbq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlm6mlcACgkQ2O7X88g7
+pqUABAAke4Q6yty8/Gk82jCaAZZsf8qt1KrCUOtWI+eyru2yGnRK/eWNOmGSzmi
DWahe8/t32dIVTFXVO5K6sGtYGvNZkWjpMZh/yEApmJBwE8MCNMN1LnDd1Mjl1s/
73b1eHb5G+6dGTmwQqhglsc3hU9+QCv0IamKCyo+dg1CCMietb8IuuNx3Jea+suk
DdMnXGg6hMIIjENcqeHyakaD+hpLs/yyVk+0Qp8RaDshSVznMmaiGd2N9plCEh41
auaHahrubQhi+HrbenqqlScYz4dUya1mYfnzryyLdUx+eJyqXnUxFUYjStbcEIOj
iGwhmIIC5lAzfs7V6sN4hPytMf4ru5EiDQHmGSmbmvzkOUxNiYphtNVKI1jL/euc
dCKn9ETS5Tsv6P6L1AmA8FzD2EdwWzjdIRn28t9c25WzpnvSNQr/3GWo0h4m5vbN
HLFr4kTLDqau0hHFtFZqcfr6aFpm2jf45sqgK1wp2rl3uvk2MQT+4iqF2Awj63ME
6W3bVnNCLUT4lanxo4AfGy6EsIpOx2I4vSbE0RYo/m63FyTxoiXzLspHioqKF1d1
ezS0buRqZ75kYnC9j65vE2fWml0Gd/fXNRMmmWdoh3QXyopYeDLJbzPUQDhNRV/+
1BxZOMb54y9tY8d0MYZ0FEfQgLgZymWtZkVvJAwpE4DUMtyGD14=
=+oU+
-----END PGP SIGNATURE-----

--omdpf4sdledlqbq5--
