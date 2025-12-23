Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5E20C463
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494019; cv=none; b=YhU95MAzpx9j4/sdy2bd8aBPlIsZZ9ZD2HBrBYKRieGQ7pNraRyvuq5OSDWyoa1Mws0vndF4JD3PlqoEquDHaH6IyZodjq+ydJYjfMogSgO4xPSbMtSKX9gP6+qUNa03MGR2Fg6lewFx254qSI0rLd3SR1p1GUJOzxiuxOnM/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494019; c=relaxed/simple;
	bh=AIrPVRY3xLhwpK9dMOMAFFOKuI5ZyC5qjcG0OS3QEgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMF9pxtDU3I7oApBn2lpLPtAspcgaP4Dlk3Fi5a2QkjfIykVb3Uqtgsv7E91BuB45hrHmN3PsvzSbfgI+WoWijKeOBKDKgMsCVif6zxVQHaOEwMV0xsxqFv+rgjqdUvZ4z4LvnKosqPPpuiXZXlLez3MtYuFiwlhrvS6kiJdc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
	by mailout04.t-online.de (Postfix) with SMTP id EF65AADE;
	Tue, 23 Dec 2025 13:38:27 +0100 (CET)
Received: from [192.168.101.2] ([220.97.177.23]) by fwd78.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1vY1ej-0JDDrl0; Tue, 23 Dec 2025 13:38:26 +0100
Message-ID: <31553bc66935b6287f0723984388a98b5f720e39.camel@t-online.de>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel NCM865
From: Frank Tornack <f-tornack@t-online.de>
Reply-To: f-tornack@t-online.de
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Dec 2025 13:38:13 +0100
In-Reply-To: <a0ee7d9d9451215a38cdf51c60691f3d4ab433ab.camel@iki.fi>
References: <694a366a.e90a0220.1a6835.f67f@mx.google.com>
		 <20251223094535.91725-1-f-tornack@t-online.de>
	 <a0ee7d9d9451215a38cdf51c60691f3d4ab433ab.camel@iki.fi>
Autocrypt: addr=f-tornack@t-online.de; prefer-encrypt=mutual;
 keydata=mQINBGD6bpgBEAC2K1YdfGWeSkNKDFUatWHUenfQISnvzW6Za/EwXpsuFKZ8eg8tReM+L
 w7YlcWZNPbxtu37zRp9oxSr6dwPw1M+Qyuy8zHaKRcKUT4BFVFzI2i7qMMAPXYwqTm9nAQ0fSWHkZ
 d8lI2YC4TV7NV9+Dz6KV82FvdRA+rx3AHEzNixJnEQKcGbHCvq2/ipjAgFp53ExrAUxCLdU7tfaQY
 BIYtt68QevZJJCqN7NEaZSxWyPjiyJrabgVrnIPATZCwLqRJE6W82eUmFVm1RMJVAfR9LB5zLscR2
 taxP9TXL+utReukPcRrMqG2sYQPPBWo5Ixp7Q0RiuXQ9xmegXgdxz2RJ2cxevjfFWR23sOwjI+grD
 3CF7HF0nirHG/dMrmLvDJxMtwm6WHSmgaCsicrkIU4u/GXTPXVx1qBQbcqfQB2ULQHuZbmfVKMTsw
 KXe8SeBgeKdBF+eZ/2Ol4b8cCDRZnyeERFvFtyLOyjpREtQLIP/40X+LExPkmlVnOYZQwNYIN4Hjh
 Jm6+WVU3ejS1UbhsPq/nfD/TdW12Z9RzDn6JE8Dq0PR+9WOcItfZcIpTG0fGo4MlxqpiJ2tym/GO1
 wiroqvc1fc/DDlUEd4NHiBejaP5T20/j+dYH1BAAjLwZKMVDdEOMiFkAQ7/VaVNyR306dWeNOR8hY
 2rCXcasxT4njwARAQABiQJOBCABCAA4FiEEUq2xkWJh1uZ9Xmrq92m9vmmDMMoFAmD6ckcaHQFFcn
 JvciB3aGlsZSBhZGRpbmcgcGhvdG8ACgkQ92m9vmmDMMqC0g/8Di2Rf9Q+7xA3cHznsmGukanyxVb
 iwcZpO62UM/iKCS4pIHe3OUqukOpXgDKC3HUCfzkZ99SxUioMyGPmfa7u6/Pf7yuEMFWyhgYVJmZR
 N7kgQRW1IKIaFaCYJ7bS4De6BSSGFLv1qphdrSHrLG1Yg36r4tz/qtS7Yl0REEVB2xelY6mE3U+e5
 kIAabG67vLVT5NqqKowSzRuiLLJd2GO6oSczSH688YSa/CQIF5zPh4pMn1bao8h5USpjrH5U6iWDE
 mQu1iEWgG/x6LQDdRG3+O0iSi3+xJBzxTV2w0qdMoMYU2fX86VhuZnu57E513PI6tNe+ny6BZCTet
 IlHpDNbIgCjUYTCqbAqj73nSjcoMKCNCRvd+kKPrKPbryLIc0PFxs1kgZNCZ77ZzO4FdhQhJt+l8C
 vbvsOg8Jy0d/TW2jNXOEnSZJ89QBxwm5tsOUNT4vcZnbueHTBbD7Lnr8uf7MdKKYR0jB4RPKXt86Q
 EJWSbcX9ohyQJVeiuArNP3D4jXO/5mRTapP4GgcJGkuk7ol7caPEi5eTA3vn5Q7nZpPv8YxLi/2gy
 Y42jxwf2LedCujmJMOikPqc7VRQTtQTMmQXqmh5vtjJEoberYut6QSPDemKrPZ56dl60Osc9Kn3Qs
 WJz7UZSfDZSqfTuxwJsdJdBoZ1UO2XzQraXoAAIa0b0ZyYW5rIFRvcm5hY2sgKFNjaGzDvHNzZWwg
 ZXJzdGVsbHQgYW0gMjMuMDcuMjAyMSB1bSBhbGxlIGFsdGVuIFNjaGzDvHNzZWwgenUgZXJzZXR6Z
 W4uKSA8Zi10b3JuYWNrQHQtb25saW5lLmRlPokCVAQTAQgAPhYhBFKtsZFiYdbmfV5q6vdpvb5pgz
 DKBQJg+m6YAhsDBQkB4VgIBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEPdpvb5pgzDKJxkP/i5
 eoYg4Vy5dJ06HCME+yVxAwY86tKvaMkRU6oHGwY4PhgCQJsdbymRzxzZL5Mn92BgK7hSDAPOel3eN
 S9ATUAn0RiIwqAwoxpaWLeXuAPLj5unAHsaqYIxuSQAho5W6ERUSi3k+nsZvhAC+9W2GHICYycUdh
 s7FZLzEHhT8WXZXKNmMH1FwMnsaUdWaHUA085bCIY2NwPRqWKr1wis1k8mG36boBq1MBLjFQ77Jno
 PfT5oACRYXrE5+1X/KmeSshWY9DtnJa27OxhLdD5pmPbdI5uonDh2aWREneOFH/6kx/ihlgW5TF73
 S2Mck2fLsCrBYKryF4Ghu1Qq7z26gOnib1o+3vLDLl1Ur4wkIz6KqEhTVwpLCEHPITepfECGFrrlg
 vUu9q+53mo2Qc84RBcIsYWxAw2xVx52vtHZXl3BBowabJJoziWQahwU1GtNBGYLBaULA5yTS10GqW
 K+NsEBZV7i0vR27b5dUlTxFcLTjqkE/KEXbPU5WAzCarz2uuvwzgoIlgIcKxJXEJ6Ggm6VaO/pP7E
 d8Hi3c1AZ1xrEI+pw/34tVidQDruOeu0VQG5jFd82OxNlRR1w4i0IhbItr1RNE3AzXYBPmLJkZ7A/
 N3MKC5cpa0wmp7LE7maCViqYCczdSqf0CEeEefhLtNhkmVwUTVxavgISv4DM3LKj3mDMEYPp0PBYJ
 KwYBBAHaRw8BAQdA9MoQWxT+PljXoionhEHpIAuLlhUME07Jht42EmJS9/K0f0ZyYW5rIEVja2hhc
 mQgVG9ybmFjayAodGhpcyBrZXkgaXMgdXNlZCBhZnRlciAyMy4wNy4yMDIxLiBBbiBhdHRlbXB0IH
 dhcyBtYWRlIHRvIGludmFsaWRhdGUgb3RoZXIga2V5cykgPGYtdG9ybmFja0B0LW9ubGluZS5kZT6
 JAoYEExYIAi4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQFEFIAAAAAAEAArcHJvb2ZAYXJp
 YWRuZS5pZGh0dHBzOi8vdHViZS50Y2huY3MuZGUvYS9ib2xsZXJ3YWdlbnBpY2FyZC9iFIAAAAAAE
 gBHcHJvb2ZAbWV0YWNvZGUuYml6aHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vZnJhbmtlbnN0ZWluOT
 EvOGE2ZmEwNmMxM2ZiY2VlZjhhMjRmZDFiNmRlNzIyYmFFFIAAAAAAEgAqcHJvb2ZAbWV0YWNvZGU
 uYml6aHR0cHM6Ly9tYXN0b2RvbnRlY2guZGUvQEJvbGxlcndhZ2VuUGljYXJkqhSAAAAAABIAj3By
 b29mQG1ldGFjb2RlLmJpem1hdHJpeDp1L0Bib2xsZXJ3YWdlbnBpY2FyZDp0Y2huY3MuZGU/b3JnL
 mtleW94aWRlLnI9IWRCZlFaeENvR1ZtU1R1amZpdjptYXRyaXgub3JnJm9yZy5rZXlveGlkZS5lPS
 RjWGVqcnQ3dWJ1RUF5aTNsaFVDeWFEUUlBa0lnRktHMnF3TF8yTXl6MDY0UxSAAAAAABIAOHByb29
 mQG1ldGFjb2RlLmJpemh0dHBzOi8vZ2l0LmdnYy1wcm9qZWN0LmRlL0JvbGxlcndhZ2VuUGljYXJk
 L2dpdGVhX3Byb29mFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmiMmowFCQhajfQACgkQVa3qmdMF6
 s2uHgD/dxJ2cY3dVn5DJCkCNdr0wxz0rL5MZtqXfRxGOlH6GZQBALoRq4LFNYIeiuJjVi6iNBjKQg
 0AbjOnM/UCVTAGjAYEtFBGcmFua2Vuc3RlaW45MSAoRGllcyBpc3QgbWVpbmUgU3BhbSBFLU1haWw
 pIDxmcmFua2Vuc3RlaW45MS5pbmZvQGdvb2dsZW1haWwuY29tPojQBBMWCAB4AhsDBQsJCAcCBhUK
 CQgLAgQWAgMBAh4BAheAORSAAAAAABIAHnByb29mQG1ldGFjb2RlLmJpemh0dHBzOi8vbGljaGVzc
 y5vcmcvQC9NVExGcmFuaxYhBIqzlkn93enweqtxJlWt6pnTBerNBQJojJqSBQkIWo30AAoJEFWt6p
 nTBerNeMsBAILdFx36go3uOgLVukgeD+bWu2q38wY29u4icMiCfadsAP9nngHM3BIiY4r0RWWrY8E
 KFcNM+DfPF2j+BCmkpu/LD7RMRnJhbmtlbnN0ZWluOTEgPGZyYW5rZW5zdGVpbjkxLmluZm9AZ21h
 aWwuY29tPiAoc2hvcnQgdmVyc2lvbiBvZiBHb29nbGVtYWlsKYiWBBMWCAA+AhsDBQsJCAcCBhUKC
 QgLAgQWAgMBAh4BAheAFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmiMmpIFCQhajfQACgkQVa3qmd
 MF6s3pOgD/ZEnhUZ7GUWlcuWReqZNI5YX6ZvfiBf/c/Z8Tb+M3kZQA/29ktoeEe78tMiFtBp9nhbK
 sopm1fvM5aaGDn4nXSnMJ
Organization: Privat
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-xCNM6MaFBi+IzOg+72uK"
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TOI-EXPURGATEID: 150726::1766493506-137D31F2-0AAA2627/0/0 CLEAN NORMAL
X-TOI-MSGID: 5a4f3800-599f-4c6d-bab8-c07efbde9f7f


--=-xCNM6MaFBi+IzOg+72uK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

Thank you very much for your quick and helpful feedback on my patch.

Before sending a v3, I'd like to clarify a point. In the bluetooth-next
tree I'm working with, an entry for the USB ID 2c7c:0130 already exists
in the quirks_table.

However, this entry alone does not seem to be sufficient for the device
to be correctly initialized in my setup (tested with a DKMS module on
Arch Linux). I found that adding an additional, identical entry to the
btusb_table resolves the issue and allows the module to function as
expected. My v2 patch therefore adds this entry to the btusb_table.

Given this, I'd like to ask for your guidance on how to proceed. Should
I submit a v3 patch that keeps the entry in the btusb_table and
explains this necessity in the commit log? Or do you perhaps see a
better approach to address this specific behavior?

Thank you for your help.

--=20
Frank Tornack <f-tornack@t-online.de>
Privat

-------- Urspr=C3=BCngliche Nachricht --------
Von: Pauli Virtanen <pav@iki.fi>
An: Frank Tornack <f-tornack@t-online.de>
Kopie: linux-bluetooth@vger.kernel.org
Betreff: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel
NCM865
Datum: 23.12.2025 11:55:43

Hi,

ti, 2025-12-23 kello 10:45 +0100, Frank Tornack kirjoitti:
> Add the USB ID 2c7c:0130 for the Quectel NCM865 module to the
> btusb_device_table. This device is based on the Qualcomm WCN785x
> (FastConnect 7800) and requires the BTUSB_QCA_WCN6855 flag.
>=20
> Signed-off-by: Frank Tornack <f-tornack@t-online.de>
>=20
> v2: Fixed merge conflict with current bluetooth-next HEAD.
> ---
> =C2=A0drivers/bluetooth/btusb.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)

Changelog "v2:" should go below the "---" so it's not included in the
commit message.

/sys/kernel/debug/usb/devices excerpt for the device should be added,
see for example

https://lore.kernel.org/linux-bluetooth/20251210202225.135637-1-elantsew.an=
drew@gmail.com/

>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 646de80c7..70feeb9a9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -172,6 +172,9 @@ static const struct usb_device_id btusb_table[] =3D
> {
> =C2=A0	{ USB_DEVICE(0x8087, 0x0a5a),
> =C2=A0	=C2=A0 .driver_info =3D BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
> =C2=A0
> +	/* Quectel NCM865 */
> +	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info =3D
> BTUSB_QCA_WCN6855 |
> +						=C2=A0=C2=A0=C2=A0=C2=A0
> BTUSB_WIDEBAND_SPEECH },
> =C2=A0	{ }	/* Terminating entry */

This should be added in the position in the list where the other
BTUSB_QCA_WCN6855 entries are, trying to keep them sorted by vendor +
device ID.

> =C2=A0};
> =C2=A0

--=-xCNM6MaFBi+IzOg+72uK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSKs5ZJ/d3p8HqrcSZVreqZ0wXqzQUCaUqNNQAKCRBVreqZ0wXq
zc6cAP9k/KIkh94L/qndgiirtTXajUhHL1Eb2VkVwlxQ7QfOMwD+InvZYwfcwXFP
rcVd+jPwSXs5wbvZO8o05Wz9IphEaQM=
=+G+v
-----END PGP SIGNATURE-----

--=-xCNM6MaFBi+IzOg+72uK--
