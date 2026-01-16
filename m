Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69D13C9C4
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570943; cv=none; b=fu+EAo+FpXDLO4Em/Wb2vdY2iZ+0oueFzl8/hJNLQ98tRCs7p/Ce59LNmd5E76uyyXuAL/g2gJoEDuDttM6RB5FnQQFiIx1KfD5uk83Rs5IMGf7e2Z9AqLyMIRleXUU7Np7zfrXYrBZbv2sFs2xfw3oY0JdaRC8EfCCS8lhZnJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570943; c=relaxed/simple;
	bh=y14A3rHDRuIyS7Euj0cTzZMLVJNDRVoj9y1mcMmuuHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ibAM6n6B1wt7Frxr7qWnCLn+JkVghvUHerVBuPHuc8Cu+WmtZFifOffM2hDb6zvD0bt1mwV1nBdcApBsW/9TmeM51A5Yf8vspimNfCubhGT/W3ivei9oEgI08pj+Fq2Nr/NvyVwSl/igorS6TjiCgTihdyv0J3Jq9mSiZVwXgzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E322442AC;
	Fri, 16 Jan 2026 13:42:13 +0000 (UTC)
Message-ID: <4a73d9c0852b80fbfcaf80ce662a1638896d6772.camel@hadess.net>
Subject: Re: [PATCH 1/3] Bluetooth: btmtksdio: Simplify dev_pm_ops usage
From: Bastien Nocera <hadess@hadess.net>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 16 Jan 2026 14:42:12 +0100
In-Reply-To: <ebecbe2f-d770-477c-ab61-7513dc95b7a6@molgen.mpg.de>
References: <20260116125803.598552-1-hadess@hadess.net>
	 <20260116125803.598552-2-hadess@hadess.net>
	 <ebecbe2f-d770-477c-ab61-7513dc95b7a6@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeltdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugephefgfedvvdeggedvteevpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehpmhgvnhiivghlsehmohhlghgvnhdrmhhpghdruggvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhth
 hesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: -100

On Fri, 2026-01-16 at 14:33 +0100, Paul Menzel wrote:
> Dear Bastien,
>=20
>=20
> Thank you for your patch.
>=20
> Am 16.01.26 um 13:50 schrieb Bastien Nocera:
> > This increases build coverage and allows to drop a few #ifdef's.
>=20
> Should you resend, you could elaborate on the difference between=20
> SYSTEM_SLEEP_PM_OPS and SET_SYSTEM_SLEEP_PM_OPS.

Noted.

For the record, those become no-ops when the associated CONFIG_PM* is
disabled:

#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif

#ifdef CONFIG_PM
#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
        RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
#else
#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
#endif

>=20
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> > =C2=A0 drivers/bluetooth/btmtksdio.c | 12 +++---------
> > =C2=A0 1 file changed, 3 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/bluetooth/btmtksdio.c
> > b/drivers/bluetooth/btmtksdio.c
> > index fba3ab6d30a5..ec17521d5b9f 100644
> > --- a/drivers/bluetooth/btmtksdio.c
> > +++ b/drivers/bluetooth/btmtksdio.c
> > @@ -1472,7 +1472,6 @@ static void btmtksdio_remove(struct sdio_func
> > *func)
> > =C2=A0=C2=A0	hci_free_dev(hdev);
> > =C2=A0 }
> > =C2=A0=20
> > -#ifdef CONFIG_PM
> > =C2=A0 static int btmtksdio_runtime_suspend(struct device *dev)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct sdio_func *func =3D dev_to_sdio_func(dev);
> > @@ -1538,22 +1537,17 @@ static int btmtksdio_system_resume(struct
> > device *dev)
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static const struct dev_pm_ops btmtksdio_pm_ops =3D {
> > -	SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend,
> > btmtksdio_system_resume)
> > -	RUNTIME_PM_OPS(btmtksdio_runtime_suspend,
> > btmtksdio_runtime_resume, NULL)
> > +	SET_SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend,
> > btmtksdio_system_resume)
> > +	SET_RUNTIME_PM_OPS(btmtksdio_runtime_suspend,
> > btmtksdio_runtime_resume, NULL)
> > =C2=A0 };
> > =C2=A0=20
> > -#define BTMTKSDIO_PM_OPS (&btmtksdio_pm_ops)
> > -#else	/* CONFIG_PM */
> > -#define BTMTKSDIO_PM_OPS NULL
> > -#endif	/* CONFIG_PM */
> > -
> > =C2=A0 static struct sdio_driver btmtksdio_driver =3D {
> > =C2=A0=C2=A0	.name		=3D "btmtksdio",
> > =C2=A0=C2=A0	.probe		=3D btmtksdio_probe,
> > =C2=A0=C2=A0	.remove		=3D btmtksdio_remove,
> > =C2=A0=C2=A0	.id_table	=3D btmtksdio_table,
> > =C2=A0=C2=A0	.drv =3D {
> > -		.pm =3D BTMTKSDIO_PM_OPS,
> > +		.pm =3D &btmtksdio_pm_ops,
> > =C2=A0=C2=A0	}
> > =C2=A0 };
>=20
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>=20
>=20
> Kind regards,
>=20
> Paul
