Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Nov 2008 11:11:42 +0100
From: martin f krafft <madduck@madduck.net>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Subject: Re: btusb+sco: unable to install hw params (set_params:979)
Message-ID: <20081113101142.GA896@piper.oerlikon.madduck.net>
References: <20081107162741.GA8182@piper.oerlikon.madduck.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <20081107162741.GA8182@piper.oerlikon.madduck.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2008.11.07.1727 +0100]:
>   $ strace -f -o /tmp/arecord.strace arecord -f S16_LE -D bt250 >/tmp/tes=
t.wav
>   Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono

On my last try with the voice profile, I found this in the syslog:

  hcid[30479]: Audio API: received BT_GETCAPABILITIES_REQ
  hcid[30479]: Audio API: sending BT_GETCAPABILITIES_RSP
  hcid[30479]: Audio API: received BT_SETCONFIGURATION_REQ
  hcid[30479]: config sco - device =3D 00:1A:45:14:EE:D7 access_mode =3D 1
  hcid[30479]: connect(): Connection timed out (110)
  hcid[30479]: Unable to lock headset
  hcid[30479]: config failed
  hcid[30479]: Audio API: sending BT_SETCONFIGURATION_RSP

If I use the sco profile, I get:

  hcid[30479]: Audio API: received BT_GETCAPABILITIES_REQ
  hcid[30479]: Audio API: sending BT_GETCAPABILITIES_RSP
  hcid[30479]: Audio API: received BT_SETCONFIGURATION_REQ
  hcid[30479]: config sco - device =3D 00:1A:45:14:EE:D7 access_mode =3D 1
  kernel: [600899.137535] hci_scodata_packet: hci0 SCO packet for unknown c=
onnection handle 42

This last message comes in at a rate of 100/s while the bluetooth
LED on the headset flashes 1/s, until I remove hci0 or kill hcid.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
tempt not a desperate man.
                                                -- william shakespeare
=20
spamtraps: madduck.bogus@madduck.net

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkb/V4ACgkQIgvIgzMMSnW5BACg28cfPhJMsQAikTYPy+a6wVHA
5wMAoMgNKJVnNtWcMjM9q184z4xxNj+M
=1xRI
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
