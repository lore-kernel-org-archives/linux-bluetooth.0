Return-Path: <sre@kernel.org>
Date: Tue, 16 Aug 2016 09:51:04 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/7] Bluetooth: hci_uart: Add support for word alignment
Message-ID: <20160816075104.blnfshsv7cgcm7gb@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-5-git-send-email-sre@kernel.org>
 <F96C9280-2B85-42A0-A1DB-2C0C231F5C1D@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eo5f46o7vgkagkpi"
In-Reply-To: <F96C9280-2B85-42A0-A1DB-2C0C231F5C1D@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--eo5f46o7vgkagkpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Aug 16, 2016 at 09:05:19AM +0200, Marcel Holtmann wrote:
> Hi Sebatian,
>=20
> > This will be used by Nokia's H4+ protocol, which
> > adds padding to packets to reach word alignment.
> > ---
> > drivers/bluetooth/hci_h4.c   | 10 ++++++++++
> > drivers/bluetooth/hci_uart.h |  1 +
> > 2 files changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> > index 635597b6e168..a934e4eb692b 100644
> > --- a/drivers/bluetooth/hci_h4.c
> > +++ b/drivers/bluetooth/hci_h4.c
> > @@ -253,11 +253,21 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev,=
 struct sk_buff *skb,
> > 			}
> >=20
> > 			if (!dlen) {
> > +				if ((&pkts[i])->wordaligned && !(skb->len % 2)) {
> > +					buffer++;
> > +					count--;
> > +				}
> > +
> > 				/* No more data, complete frame */
> > 				(&pkts[i])->recv(hdev, skb);
> > 				skb =3D NULL;
> > 			}
> > 		} else {
> > +			if ((&pkts[i])->wordaligned && !(skb->len % 2)) {
> > +				buffer++;
> > +				count--;
> > +			}
> > +
> > 			/* Complete frame */
> > 			(&pkts[i])->recv(hdev, skb);
> > 			skb =3D NULL;
> > diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> > index 839bad1d8152..a7d67aec3632 100644
> > --- a/drivers/bluetooth/hci_uart.h
> > +++ b/drivers/bluetooth/hci_uart.h
> > @@ -121,6 +121,7 @@ struct h4_recv_pkt {
> > 	u8  loff;	/* Data length offset in header */
> > 	u8  lsize;	/* Data length field size */
> > 	u16 maxlen;	/* Max overall packet length */
> > +	bool wordaligned;	/* packets are word aligned */
>=20
> I wonder if not a u8 align would be a way better choice here. We
> set it to 1 for all existing packet types. And the Nokia driver
> can use 2 here.

Sounds less hacky than my approach. Also it made me notice, that my
code is not safe, since the buffer size is not checked. I will use
u8 align and fix the buffer size check.

-- Sebastian

--eo5f46o7vgkagkpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXssXlAAoJENju1/PIO/qa66YP/itYjvxMOTrBHtDb6Ob/5xFg
emzNE0SxNA4jmC3reWmcgNtebAfnRNXZdGN7zP9DGlX98rX4iqI+08rOOtC05Z90
T6/QguGy/UP9F4Y6itWPq6eCNkXEphSwgwZUb/nLZcqvpGPi/EahmBDB65/DuHHe
XUUON9zG9b02J+P020kzBtsTBI6UPYFpCpukmrAUb7n3e4rX+5cglG54+TYY01yY
gyEiLNoUkkgRtulsQO9Y6J4nAwthP40hc6yw+xdYlDi/MdhVwenc5ZiRfKHxILKQ
OGxTnkHlUbpwJnn4qMkdTv5aOfM4lc6C3tNrhU/Co5hHpl09GOiSaUfnkg6ByM1U
DLBSmvE6fz52z4xbmDTsgcY9owQ/JySKVEPkuEcYy8NGXAPCQpyT2EAh4LURTY2j
1Mh6bPedAEJK3J3zjDz4jGqaIrMRcN9wiD8MF/hgnA4hnL86eNJVvZzGPmgMa/Sm
5vBC7/a7LFEo2W+yq8nWwU/FVPC2p6Y4hQbRQOTEksPq3D6Ybsx273lCLlLvdX6p
KMB9xEtAZTpKs6lwdGyo95f/xhCLoCHXiNG+cFic2Iw5srVaUhR8PGSXtS6i6KgA
o0OnHNGvinvUVL/dBxnl2BZZJgp1DpBFOK1h2XI6D89HA6q5dd1iRJirNy2eiTga
bbDiWT+t6ceUsT/6V12b
=K8NM
-----END PGP SIGNATURE-----

--eo5f46o7vgkagkpi--
