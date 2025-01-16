Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483A1367;
	Thu, 16 Jan 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736989810; cv=none; b=HUVt2yuCmC6ZOnonCFfc4EGJ9LmLHq1esc3LzCJd2+1Q5eKNxj5Ngw/GxlwlbMBAyogApqQ/UoPGZJ5MWKRu+tGy7KexuevgzYw9bVb/CVKYL34mgXIPUHgc3UpPoSLSEBs5REObkbaQhSc0h1pWkuGa+H5GOmsDPJp2FYiU9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736989810; c=relaxed/simple;
	bh=1eTM2Tm/LrFjfMnZCSlox9P1gvQBByhuQO5dRvaQHaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGyrIDWC7JZn7fIib8QOT76jhhqSR/LH46ZrfIgw4AEMvnlwyxz4Beq6lMwksTFamXwT/Hf4lb1akzuZMmRr/onueeXprAsff9Y9+U9kw3CbvkEayEWGtzKo96ukKphDpPJ+3U8NSDZCs9fgsDFXQUI3I1HVR1xo4rSE6yyvHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2ejQ+zF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2ejQ+zF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763A5C4CEE6;
	Thu, 16 Jan 2025 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736989809;
	bh=1eTM2Tm/LrFjfMnZCSlox9P1gvQBByhuQO5dRvaQHaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2ejQ+zFrcA4lOBlgPhI+qz8pt/P7dKtgyXGTYSwj4nFqfXBegkZ3BZvyj0jsVl5s
	 kCpO5++pgla3u3gOXJx8pYKcZ3kAIpnRNw8B0uIOulOYxEb0feKZm8lKhDLuXLlTET
	 5Uq1+CeTYYD8xW/NlJFrpjWnMnRgKn+0XBYDFaCCwkoohfdEbYuvkqHeO89M0K5eIu
	 fCEEQyGlsi8zROLCjFfGdpeGzf8u+6Ws5xmiF9A2njN7e0rn++ucPmzSp3u5lSnZ8Z
	 uRxY5O584x1I6XMUwSVQyuFy3MUTY2dIgn421j8/MoSEoRAFLAYw2zBK6SJuL4rir3
	 4HGnTIhk87Tzg==
Received: by mercury (Postfix, from userid 1000)
	id 0E3A41060350; Thu, 16 Jan 2025 02:10:07 +0100 (CET)
Date: Thu, 16 Jan 2025 02:10:06 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, marcel@holtmann.org, 
	luiz.dentz@gmail.com, pmenzel@molgen.mpg.de, jirislaby@kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	tomi.valkeinen@ideasonboard.com, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>, 
	robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <xlnssb5ifmxcgklaraxhoreu6ub4oq6jjxev6cx2b6dtcn3lax@3wsm7szrjki2>
References: <20240606183032.684481-1-andreas@kemnade.info>
 <Z4ZREdC3aPkkxB2l@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ge5llijsz6fx3qsr"
Content-Disposition: inline
In-Reply-To: <Z4ZREdC3aPkkxB2l@hovoldconsulting.com>


--ge5llijsz6fx3qsr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
MIME-Version: 1.0

Hi,

On Tue, Jan 14, 2025 at 12:57:05PM +0100, Johan Hovold wrote:
> [ +CC: Sebastian ]
>=20
> Hi Andreas,
>=20
> and sorry about the late reply on this.
>=20
> On Thu, Jun 06, 2024 at 08:30:28PM +0200, Andreas Kemnade wrote:
> > Some of these chips have GNSS support. In some vendor kernels
> > a driver on top of misc/ti-st can be found providing a /dev/tigps
> > device which speaks the secretive Air Independent Interface (AI2) proto=
col.
>=20
> Please expand the cover letter and commit messages with more details on
> the protocols and backstory here. I spent hours over the Christmas break
> digging through drivers, git logs and mail archives for information that
> should have been part of the series.
>=20
> Specifically, give a better description of these chips which are WiFi
> controllers with Bluetooth primarily and then some have (optional?) FM
> radio and GPS support as well. Some even seem to support NFC too (also
> over HCI?).

Your TI WiLink chip description matches my understanding. In
addition to some chips not support the optional features, there
may also be some boards with cripped support (i.e. when an antenna
is not connected). So having a DT property flag to describe working
GPS would be an option.

> Provide some background on the ti-st driver, which have now been
> removed; the fact that we already had two drivers for these chips with
> one only supporting the Bluetooth (and later some PM) bits; say
> something about the FM driver which someone also recently decided to
> remove on questionable grounds.
>=20
> Please also refer to the prior attempts at adding support for the
> various subfunctions to the driver (e.g. Sebastian's discussion with
> Marcel on how to possibly abstract this in Bluetooth core), such as:
>=20
> 	https://lore.kernel.org/lkml/0C9AD246-B511-4E59-888F-47EAB034D4BF@holtma=
nn.org/

I haven't really worked with TI WiLink in the last 5 years. The
Droid 4, which I played around with, is no usable for me since
the 3G network has been killed (and the Droid 4 only supports the
US band for 4G). As visible from the series you linked, my last
plans were to kill ti-st, which pre-dates serdev. The hcill
bluetooth driver was introduced by Rob Herring together with
the initial serdev core as a cleaner replacement.

Greetings,

-- Sebastian

--ge5llijsz6fx3qsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmeIXGsACgkQ2O7X88g7
+pr8PxAAiLC61a4OTcbkANscHgxtXcJxaokwmZXoPsMgBm+9bCvinWF60zRKadyQ
p9rWuQ0exTWRLgifGdmw+adKierRnTxIxXW5fSx4jqSqKittuNMwiaVT4pUh4lNI
RzhJa7UO+aQtRFJl8y8WIgYpyeqn2edyL890XBJBBMIuO0zGLKoPUJkF4t5TIoO7
7cm/BxlTpIfy0JIdc2MsXTfLWmA+IEhZ5rBKOgfdqGdIVPxzWuOr5ob5xItF2Tck
MuirZ6rWt3nYh4ePoCaDcRJD7KzU1HmBpMhzp3uJildp5TXnS2cENxzHoFhUD541
ZJ0eNIF0mpmOQrv61TLtSR06CujN0sv9OtED7pqgbQK8aBgaFbdyPzqBhdv+FB+Z
yK7yHaNfWeCh5mxjTsc6Lx9Q4GpdiJ9jlN+Dbmy2GrdbEekp+p8sVNzic6ssXzUF
ckoI60fWgbXii5W5TGLz6SWb+6xe9QA2gjPhQUVEoyIPUYm3GqdR+ZIc7VVM2Gcc
EA8GGsjr+0waZPaCdQqQubQmbxFRwQbRyb/EFNAAn6RzOIS3qOSuGsNHxI9IFI74
VpdryPLeQAkJEQCMPxwooXm8ggUVw++h65zRuPcmbBn7IMreb4XIB/4WB7KI5+uk
q24IHNV9EJJjVcaZiLR/sJYn4FTQqc8MAKf/t3cVvXMo4MeB56w=
=uAGK
-----END PGP SIGNATURE-----

--ge5llijsz6fx3qsr--
