Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8443A0EBC
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574508; cv=none; b=EgF3N2Ahl8Ji8v67od9vfUgHzh5eOz5HLN3IjIAq/GkicewgKqNx64C2J9yXJ04Y6Qx3kz/TinNWO+tucQn1VLHs8Bp/rjfRs6yCMzfNr8X1jcblJSYb1gO8bVplyxo/PvBS/1Pq0LTY9I+TzXt/lsxycSjRa3qn+NL+VTVyl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574508; c=relaxed/simple;
	bh=jKKfb6fZv+CUCf1RA7dSi3UurYKpyKbMxQnXAErIt7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gA3CkB37nGuJQXC2V58en8aaX5YXX5sGupGm8V3to4w9QIlelZpp7fQ3lz0xV2VhsIScizxqIGmWgcIkGozuiEfF/7rHGy20JxxcZjN8RFjwt/XTcJPiCBU1XKmgiX2t8LzICrSwlNdwNVymjs3WuipQiFZeyqhpxfMXiQCArmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6874E2007D;
	Fri, 16 Jan 2026 14:41:39 +0000 (UTC)
Message-ID: <2037765f5fd28fc5b82e156ffef8782bf3ebe886.camel@hadess.net>
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM
 ifdef
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 16 Jan 2026 15:41:39 +0100
In-Reply-To: <CABBYNZ+Bkeuwogyj3TiZZV=kvv1oAw4y2gt8MfQb-WaYS-zQSQ@mail.gmail.com>
References: <20260116125803.598552-1-hadess@hadess.net>
	 <20260116125803.598552-3-hadess@hadess.net>
	 <CABBYNZ+Bkeuwogyj3TiZZV=kvv1oAw4y2gt8MfQb-WaYS-zQSQ@mail.gmail.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepieekjeeggfdvtddtjeffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehluhhiiiguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesv
 hhgvghrrdhkvghrnhgvlhdrohhrgh

On Fri, 2026-01-16 at 09:35 -0500, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Fri, Jan 16, 2026 at 7:58=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > The functions are already disabled through the use of pm_ptr() when
> > CONFIG_PM is disabled, and won't be included in the final code if
> > not
> > needed.
>=20
> I guess it would be more correct to say that compilers will detect
> that these functions are not in use (aka. dead code) and just remove
> them.

I don't know whether it's the linker or the compiler that will remove
them. Do you want me to send a v2 or will you amend the commit message?

>=20
> > This increases build coverage and allows to drop an #ifdef.
> >=20
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> > =C2=A0drivers/bluetooth/btnxpuart.c | 2 --
> > =C2=A01 file changed, 2 deletions(-)
> >=20
> > diff --git a/drivers/bluetooth/btnxpuart.c
> > b/drivers/bluetooth/btnxpuart.c
> > index 3b1e9224e965..13daa174aaaa 100644
> > --- a/drivers/bluetooth/btnxpuart.c
> > +++ b/drivers/bluetooth/btnxpuart.c
> > @@ -1947,7 +1947,6 @@ static void nxp_serdev_remove(struct
> > serdev_device *serdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hci_free_dev(hdev);
> > =C2=A0}
> >=20
> > -#ifdef CONFIG_PM_SLEEP
> > =C2=A0static int nxp_serdev_suspend(struct device *dev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btnxpuart_dev *nxpdev=
 =3D dev_get_drvdata(dev);
> > @@ -1975,7 +1974,6 @@ static int nxp_serdev_resume(struct device
> > *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ps_control(psdata->hdev, PS_=
STATE_AWAKE);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> > -#endif
> >=20
> > =C2=A0#ifdef CONFIG_DEV_COREDUMP
> > =C2=A0static void nxp_serdev_coredump(struct device *dev)
> > --
> > 2.52.0
> >=20
> >=20
>=20
