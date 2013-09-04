Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Sep 2013 18:14:23 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth regression in 3.10
Message-ID: <20130904181423.50ff9f20@milhouse>
In-Reply-To: <F0FC77C9-DCEF-48B8-8ABF-12446908AAC4@holtmann.org>
References: <20130904155318.21cb6f37@milhouse>
	<F0FC77C9-DCEF-48B8-8ABF-12446908AAC4@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Gqt_Z/REF+C9FUWRtrdfAHm"; protocol="application/pgp-signature"
List-ID: <linux-bluetooth.vger.kernel.org>

--Sig_/Gqt_Z/REF+C9FUWRtrdfAHm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Sep 2013 08:40:00 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> > This is a Broadcom chip based device.
>=20
> that device is CSR based and not Broadcom based. Check with hciconfig hci=
0 version to see what it really is.

I'm pretty sure there is a Broadcom chip in there, because I opened it once.

> Check with hciconfig hci0 version to see what it really is.

$ hciconfig hci0 version | grep Manu
        Manufacturer: Broadcom Corporation (15)

> Can you toy with hcitool cmd to send the HCI_Delete_Stored_Link_Key comma=
nds and see what parameters it would accept to delete all keys.

Can you give me a few hints and examples?

--=20
Michael

--Sig_/Gqt_Z/REF+C9FUWRtrdfAHm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJ1xiAAoJEPUyvh2QjYsOTWEP/3AEuVgnsIwyN09lheCXdXKu
RP7PTYZrUV5B3JoFVoIkZeGM+sWwMv/EpMqAPU+rsqpBLT913Am1LV4wsfxZ8KZr
KPe3cjtPqQ4WVNYdkjQxtRuZCQi7W7A6ndPRsCq6Nul/ak/9YhSBilagQoTzpR+1
W5LzdDdD1f4cxwndJmZ+mFUOM1HMH089xhFzvlzMnRuaKlKZgl0Jvsj/Ir26dNpA
d9s2/PmkvPTi+Xrs62XdVGVjIzrKhhMQptaidDP09SRbCUwdJsLTYE63u0PY8V4m
wRCrFWiCcS2TBBa/T+GVL1mQK5uAWsV6mWfGZGXhKBLvgjQXU1K8k+cw9DI9sZYV
CSeeYkCRFrcdGZMM39PVrbUsD/2/2aWI1FnTyCHMC7cYQRTi9CI0hm8rzoZR8jdC
q91ogA/4KL23aF4hBbg2FHYn7wtL/5Gfw5Axgeeik9o+i3DHfm+8hmT21m4I+OT4
Kx+OTnIel/xSdG1MoIlmQZ2AkfIfNxwqWROItKBUTyf6raA35sUdl5MVwfkgp3+1
3V6B+pq+oDErrw9mY6u5LJoYYcOvfP/N5KxJdLOMIvaoJrQNmMBs1/m71dRKqJM2
2mHCgyh3G1VYwxHj3k3mPjYbTNpSlTrsyTqbOka2tf36L8u+EYOriuw+XIz3lvse
cYiL7BdCXnZniFSJpfFu
=ZOWq
-----END PGP SIGNATURE-----

--Sig_/Gqt_Z/REF+C9FUWRtrdfAHm--
