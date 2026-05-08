Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186641B370
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267380; cv=pass; b=dwR51Mg1UP/0XC5JZDvxIBpmG3hJTuHdnBMSmPy8jd4yeT2+2jB+u3qdxv2ee9XU9fbKZJN1NAXqOExjWZJJ4LC/BRtyWv05KAgm8ooWp+bHP9l8zKYCrgvwupCM5rJ91JMadDQgqVpTRe++rSFevfFcJoXhLBLf6hHaYafSCr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267380; c=relaxed/simple;
	bh=j/OlUjGQLKZa6/OFgkTqrBNEiM0tiBcVstxBdXVRgh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=coKEAw7NOl7xRIrfaZuJc8J3fjCOwhvY55Tf1d3fpygwN8kN1g9hSMlHlSYCY9/Wr4rDWciiYjVnPy+ar3VmlGhyPlXDdXTcw7qT1/WF3zc+z4zn4J3wXisWGZr10K3cVUVFcSqXKY+ZCbSvFgD3wIJhfmPKPNSlRQMR2wWfSFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=t/1cMybe; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="t/1cMybe"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gBzFJ5KJTz49PwQ;
	Fri, 08 May 2026 22:09:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1778267365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpIzEXx6yI+h4BE+7hAvWi5f72vzY6YBKNCtjzlcHIA=;
	b=t/1cMybeK1wJr9f6axLp+VuU5PspcaAp4TvECvYPAQLpDEElPQGfj1R6Mbdr3nVtz2JVGY
	t3szxz9F9kV1N9SkpEX6bNr7i3Bif7pMXgh+Zy+M13aajeQs3a9QYWAXZcUmye6yo4WmlX
	iXF7cd8vXgNOntguNsgk1nXX4PwPzHJ/oAqfzpBS5TDGBPNGPvlv7eKW1DsTsjxRZAPUIF
	5mnxB2PgvWddH5Ui/LlabuL8ib4Pmzn3ucm1HAB/bbOz/YKzP2rtO+u7zlFCJJ7Htnu1PT
	Lou2pNxaUtK8rNLO7RXkVAumskEAoTnX1klpd45aGJ8bjzK7cTEPmTY3RC2x5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1778267365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpIzEXx6yI+h4BE+7hAvWi5f72vzY6YBKNCtjzlcHIA=;
	b=EQteS+NdyT2hP5jrxZ6xvc08ZLv57lBQWXmcMIsAUzSYcbruiLn8iiJzK9grhkGLdZygP8
	9xW0GQc7UkYoJoWBQyOwJYxughhvUyDf7EbkLuiz97mlsZ5TUbfFHttwTB9GxRUQRWKzd1
	hurax0J7MZia2nXVFe9Vm2k2BPgEcWAG0jITDIuEz2McwnbHfqF01TuqaQE1lzJKajlGe0
	q++BbXbWxwv46IiN39+87o7Q63Sii/iA6rP5LTqnm2/jqlmqTn49ZD4WTWy1GxJH0YxW2K
	ry90Bi36sDts+j8AIGJqIpMS3/7WkHlXbP5LjifDpx+V3mmbg0QAiyDSBAdT1A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1778267365;
	b=rmXbfpG2Szjmb/Nl8nEC2Rf90F6RUZOdGR+Sj4XHQq2LmfaJNB3ZuQaGbfFX3yN1r4ekBW
	iMm2VQ6AzTspkc799+ntcYwbAPReR3dYLagxbhGBZASoq4/FWHUxihHAvIoYSQC1DiFjw/
	FQsQFxZylJfKgsGrziOJUh5F4B7+bW4+LN6eIv0cFeZfDTl6Ivgfs4eoZz0vaZCQgZNEGA
	PcoT3ENeDaL71xGayOPuvTB4T00lJOyBZwyJgQ3op1mXuPHDhAE2mQXS/wG9Hrbj+OLoLv
	qrYeQ6Ojv7YFSu5jPqTDCWyj0eGGFrQ9FOHNpV3LjC5hSfvibKL5jRnibz/HWg==
Message-ID: <d9fe37aa17175290bc406ccad8ed4cf533dfd8b8.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Mikhail Gavrilov
	 <mikhail.v.gavrilov@gmail.com>
Date: Fri, 08 May 2026 22:09:22 +0300
In-Reply-To: <CABBYNZ+jM+2BQ4Fek87OCKbyvuxjsyeCG0qpGRkAO4LA=pj4xw@mail.gmail.com>
References: 
	<770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
	 <CABBYNZ+jM+2BQ4Fek87OCKbyvuxjsyeCG0qpGRkAO4LA=pj4xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

pe, 2026-04-24 kello 15:38 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli, Tristan,
>=20
> On Fri, Apr 24, 2026 at 3:25=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > MT7925 (USB ID 0e8d:e025) on fw version 20260106153314 sends WMT
> > FUNC_CTRL events that are missing the status field.
> >=20
> > Prior to commit 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB
> > length before struct access") the status was read from out-of-bounds of
> > SKB data, which usually would result to success with
> > BTMTK_WMT_ON_UNDONE, although I don't know the intent here.  The bounds
> > check added in that commit returns with error instead, producing
> > "Bluetooth: hci0: Failed to send wmt func ctrl (-22)" and makes the
> > device unusable.
> >=20
> > Fix the regression by interpreting too short packet as status
> > BTMTK_WMT_ON_UNDONE, which makes the device work normally again.
> >=20
> > Fixes: 006b9943b982 ("Bluetooth: btmtk: validate WMT event SKB length b=
efore struct access")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >     AFAICS the commit is not yet pulled and is only in bluetooth-next, =
so
> >     maybe this should be just fixup?
>=20
> Yeah, I'll most likely fix it in place and add your Signed-off-by.

Looks like this got pulled to net without this fix, so it's broken now

>=20
> >  drivers/bluetooth/btmtk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > index ab34f1dd42bc..68a32d11e5ec 100644
> > --- a/drivers/bluetooth/btmtk.c
> > +++ b/drivers/bluetooth/btmtk.c
> > @@ -719,8 +719,8 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *h=
dev,
> >         case BTMTK_WMT_FUNC_CTRL:
> >                 if (!skb_pull_data(data->evt_skb,
> >                                    sizeof(wmt_evt_funcc->status))) {
> > -                       err =3D -EINVAL;
> > -                       goto err_free_skb;
> > +                       status =3D BTMTK_WMT_ON_UNDONE;
> > +                       break;
>=20
> This probably means the original change was never tested on real
> hardware. We likely need input from the MediaTek team on how to handle
> these events, as I don't think a public spec exists.
>=20
> >                 }
> >=20
> >                 wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)wmt=
_evt;
> > --
> > 2.53.0
> >=20
>=20

--=20
Pauli Virtanen
