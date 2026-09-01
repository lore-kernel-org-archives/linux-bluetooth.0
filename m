Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057B33EB1B;
	Tue,  1 Sep 2026 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272668; cv=none; b=iV3wKYZQJdlIy3f2IewcAQRdkj/Fq2v6i9JfH1tVBjpiZiF3oJT0kEetb1qp5ECpzIC53ksvSep9siy44TJ1d5ObkXQzADj2DQpDnvAwCvqSgbWvRKSg2XJzx8Soa9BD0xlNatc+yssDA9mNmiKf4kKvbJ06qRMA0xs+uDkTi7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272668; c=relaxed/simple;
	bh=R0wYwCGJ8KvgZZlN+djOS8ZDU9JP1lx7HijwAfvGr2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nb6czec3Vu4ZPaEsBX0Ak3tgfX/mtKuSkpcsfP9pPiIN4wRLHu0G+vDBBkvpnmRWgRB9V2AiI7CpjgSy8to+gEydsx9SpUbeygU2xXGWMYM3rjjnHC/LIYvqZlQXi30xTSgNC30CPCcDWyasWnxf8JpOFYQMcB4Cd82zNWYtxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=SP0XSyik; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SP0XSyik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1788272658;
	bh=R0wYwCGJ8KvgZZlN+djOS8ZDU9JP1lx7HijwAfvGr2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SP0XSyikwyXPFzPMspfIQRhZ0OCagU3Nm6TKkoH4GDbkQAbsgCg1VXWwKiU2D3Z6/
	 qIbTxjF8tKzdqVnNlAd33pbvk71Ygpm4rxs8HtffbScQddOfKolUQdc9xYW9iur6lq
	 i1xq06IfwzGtU0WBSKazKhsoE0/JquAVfn4zd1+I=
Message-ID: <bca0949bf284f9246376473821bea3bb6728a93a.camel@crapouillou.net>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Default to 4 Mbps
From: Paul Cercueil <paul@crapouillou.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 01 Sep 2026 16:24:09 +0200
In-Reply-To: <CABBYNZKNSbc7CNsJG3W2AgU_JLng7+Y2Jh4KUbKZQXOMGJ8ALw@mail.gmail.com>
References: <20260829100205.113655-1-paul@crapouillou.net>
	 <CABBYNZKNSbc7CNsJG3W2AgU_JLng7+Y2Jh4KUbKZQXOMGJ8ALw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

Le lundi 31 ao=C3=BBt 2026 =C3=A0 10:56 -0400, Luiz Augusto von Dentz a =C3=
=A9crit=C2=A0:
> Hi Paul,
>=20
> On Sat, Aug 29, 2026 at 6:02=E2=80=AFAM Paul Cercueil <paul@crapouillou.n=
et>
> wrote:
> >=20
> > The ACPI path already did default to 4000000 baud, while the OF
> > path did
> > not, for some reason. This meant that unless overridden with the
> > 'max-speed' OF property, the serial port would stay at the init
> > speed of
> > 115200 bps, making it unsuitable with high-speed Bluetooth devices
> > like
> > audio equipment.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> > =C2=A0drivers/bluetooth/hci_bcm.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/bluetooth/hci_bcm.c
> > b/drivers/bluetooth/hci_bcm.c
> > index 9a103db7e355..c44d552f9ad5 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -1224,6 +1224,7 @@ static int bcm_acpi_probe(struct bcm_device
> > *dev)
> >=20
> > =C2=A0static int bcm_of_probe(struct bcm_device *bdev)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdev->oper_speed =3D 4000000;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdev->use_autobaud_mode =3D =
device_property_read_bool(bdev-
> > >dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > "brcm,requires-autobaud-mode");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_property_read_u32(bde=
v->dev, "max-speed", &bdev-
> > >oper_speed);
> > --
> > 2.53.0
>=20
> Sashiko flagged a problem with this:
>=20
> https://sashiko.dev/#/patchset/20260829100205.113655-1-paul%40crapouillou=
.net

Noted.

The argument about breaking Devicetree backwards compatibility is a
good point, I didn't think about that.

Disregard this patch then.

Cheers,
-Paul
