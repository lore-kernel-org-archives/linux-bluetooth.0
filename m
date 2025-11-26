Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2C1F4CBB
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176482; cv=pass; b=Jk9aQAg032RHWCZZpIgOHSz0WXlkZz1NLp2vZ/Nwll4fDjL1j1QbDBinUHZQ4PkxTawxXTk/gLiwk5FdBYQkpY4dxNK5e+VIMRj16ioisgSyyz4IzlMo/Aw399NjfS/Gfq9zHKqzAjuoCkfN0WmNUezeKe+ISqM+ALViiBCjY1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176482; c=relaxed/simple;
	bh=GsVWb+c6TvpdWIS+wMQBpugfpsll4lY5Qyx2O/VvEQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emgJRmeAXA19GQs2XESP5Of3opWPh+fduqzxut8YWKI89eAOnNtsIAbE59BIbC38R3e+1qACcd3Yck2/ONciN0jqkW/weZPFfDrzy0hP+3IucTvTif3jrV0RX+iS4jXFvPJjlJ/3pHvvN8TlV5z3lrf79Y1T+I6KuCtEToG6ymk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=DcZxdjvL; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="DcZxdjvL"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dGlv92dvWz49PvX;
	Wed, 26 Nov 2025 18:51:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1764175877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nui4Qu5bYwhqjfeVqMkN6Jy031/E27CQjsUtGwRMCA4=;
	b=DcZxdjvLvuCns4Fv9qrhgBnpUnT6KbgEwa/ejfDwxaIaZmuxLtGf6X2X2UeKFH1XphdLWI
	SnMB7S9JMiCGHQOetOKuTeZZHaaMEot6wA2Buxvv+Lg2AVnJrMEyhX1wptsmFCTMgKx1Z2
	FZbzr8Amx6YPtd/Yyx2QrAXe/mMdaceJ+7UahVmKB6ocAbczSttmoHSAZSacy6W8A5s/+C
	5T5pHzLwSFql9i2b9tXlr1bKy0DpMQf2OwEAqH8l2/uDP2e1PQAPcq0Kbs9TKn1Tj8kcgm
	8+FTFL97ykrKhPkyfEZXz8ARxPFBRqD3/Nrdf7iXTvim4iLHXobIfkZUuPFViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1764175877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nui4Qu5bYwhqjfeVqMkN6Jy031/E27CQjsUtGwRMCA4=;
	b=YHKPQTYweJjT+VqcVexIO/vKTfePcnX407+TLRI93i4XyTCZlAcilRmCIj30P/lmQ3oYfx
	nSFHgtpjIjGGgVHCeZlTMisQW/RKwA4Rur6MxLWI2yFgCrpR/D3JAdFDIUuVcp4hzXPz0L
	VwWNiPdPP0dI/9pqHXl6pVkT4f/gYOdMhxWvqeuDn0a+zkXyt8BkCPrtNGGgupY7AYiRA3
	D/+o9Duk36ti7mAlVruWlL9YBOOQeF5k3dyALkRvWsezz29XXqZd1rnUlMVUsRW8mTu8xh
	Comx9xaKD5eAYGd1TltyEWuhHDomWVea4yLRlOM6yR+jdq1p60bY+tv6b4dULg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1764175877;
	b=rMH090wp5++phmKg9cHHq7ILWzo7sZIe5AN4gm+bUTc7C3YOwwmUw1V7cn1qJ9C2PCDki9
	HbeAQZKMywrMcCxS5rNflIxMUhELTVWWpAmECfP5gPU+f4JShnx6rcwJ/4YG16Hs8nh8xN
	NS3ctJPRHBoooxEp6Ukow1ELGWObvXivQfHJ+QSP9WcRucACp1Tf7CdosPRfaNFEmODqa7
	YDXACiFDcxVGVoPAPGEK4xpwdDKWEJ63KJMwiICd5xgQZfk/mgtxBfE0cd87EhHUIe4QJg
	bL7yrrL0nJVfy9JrlbL2W/ZSswDlV4eiQAvxfUbjjtiofwH/Y17cAfsDucGDvA==
Message-ID: <3263f58f41462e195f5d7b247d89d609b36971e7.camel@iki.fi>
Subject: Re: [PATCH BlueZ] transport: fix VCP volume updating and sink
 volumes
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 26 Nov 2025 18:51:16 +0200
In-Reply-To: <CABBYNZ+7CCN2r6GjUEi1jh7Sn00OnVkY4+sho=2eUosgtMdTTw@mail.gmail.com>
References: 
	<68b8ba8dd63306081aa7630e3b1f8a186e558b6c.1764090857.git.pav@iki.fi>
	 <CABBYNZ+7CCN2r6GjUEi1jh7Sn00OnVkY4+sho=2eUosgtMdTTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ke, 2025-11-26 kello 10:48 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Tue, Nov 25, 2025 at 12:16=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > Signaling VCP volume value update was broken in
> > media_transport_update_device_volume() due to inverted strcasecmp(), it
> > also has to be done for all transports since they show the volume.
> >=20
> > VCP output volume was incorrectly shown on input transports.  Don't
> > expose Volume for BAP input transports, since AICS is only partly
> > implemented.
> > ---
> >  profiles/audio/transport.c | 36 +++++++++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> > index fc23cf33d..d466ec9b6 100644
> > --- a/profiles/audio/transport.c
> > +++ b/profiles/audio/transport.c
> > @@ -2308,16 +2308,32 @@ static void bap_connecting(struct bt_bap_stream=
 *stream, bool state, int fd,
> >  static int transport_bap_get_volume(struct media_transport *transport)
> >  {
> >  #ifdef HAVE_VCP
> > -       return bt_audio_vcp_get_volume(transport->device);
> > -#else
> > -       return -ENODEV;
> > +       const char *uuid =3D media_endpoint_get_uuid(transport->endpoin=
t);
> > +
> > +       /* TODO: PAC_SINK_UUID needs AICS */
> > +       /* TODO: VOCS */
> > +
> > +       if (strcasecmp(uuid, PAC_SOURCE_UUID) =3D=3D 0 ||
> > +                               strcasecmp(uuid, BAA_SERVICE_UUID) =3D=
=3D 0)
> > +               return bt_audio_vcp_get_volume(transport->device);
> >  #endif /* HAVE_VCP */
> > +
> > +       return -ENODEV;
> >  }
> >=20
> >  static int transport_bap_set_volume(struct media_transport *transport,
> >                                                                 int vol=
ume)
> >  {
> >  #ifdef HAVE_VCP
> > +       const char *uuid =3D media_endpoint_get_uuid(transport->endpoin=
t);
> > +
> > +       /* TODO: PAC_SINK_UUID needs AICS */
> > +       /* TODO: VOCS */
> > +
> > +       if (strcasecmp(uuid, PAC_SOURCE_UUID) &&
> > +                               strcasecmp(uuid, BAA_SERVICE_UUID))
> > +               return -ENODEV;
> > +
> >         if (volume < 0 || volume > 255)
> >                 return -EINVAL;
> >=20
> > @@ -2802,7 +2818,6 @@ void media_transport_update_device_volume(struct =
btd_device *dev,
> >         if (dev =3D=3D NULL || volume < 0)
> >                 return;
> >=20
> > -#ifdef HAVE_A2DP
> >         /* Attempt to locate the transport to set its volume */
> >         for (l =3D transports; l; l =3D l->next) {
> >                 struct media_transport *transport =3D l->data;
> > @@ -2811,16 +2826,19 @@ void media_transport_update_device_volume(struc=
t btd_device *dev,
> >                         continue;
> >=20
> >                 /* Volume is A2DP and BAP only */
> > -               if (media_endpoint_get_sep(transport->endpoint) ||
> > -                               strcasecmp(uuid, PAC_SINK_UUID) ||
> > -                               strcasecmp(uuid, PAC_SOURCE_UUID) ||
> > -                               strcasecmp(uuid, BAA_SERVICE_UUID)) {
> > +#ifdef HAVE_A2DP
> > +               if (media_endpoint_get_sep(transport->endpoint)) {
> >                         media_transport_update_volume(transport, volume=
);
> >                         break;
> >                 }
> > -       }
> >  #endif
> >=20
> > +               /* This is sink volume */
> > +               if (strcasecmp(uuid, PAC_SOURCE_UUID) =3D=3D 0 ||
> > +                               strcasecmp(uuid, BAA_SERVICE_UUID) =3D=
=3D 0)
> > +                       media_transport_update_volume(transport, volume=
);
> > +       }
>=20
> Current code sounds quite messy with respect to callbacks, we should
> really only add the callback if the feature is supported per UUID,
> perhaps we have to rethink how media.c interfaces with profiles to
> avoid having to do #ifdef everywhere.

Sure, this is something that will need to be revisited as AICS
integration has to be completed, however it could make sense to have
whatever quick fix in the meanwhile as the current code is wrong.

>=20
> >         btd_device_set_volume(dev, volume);
> >  }
> >=20
> > --
> > 2.51.1
> >=20
> >=20
>=20

--=20
Pauli Virtanen
