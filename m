Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FEB33BBA9
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641409; cv=none; b=dmCnrx1d0NHuVBthk5xnF+ByEhU69ARKq/HNhxoAVhrrZcU6PEbtwsIPS1BvHpNMe+VmPwPEXGj1PXhlI2KIe5XghzJSiZP1+AZFGnWX+czX8narwE3EBBHljbbGD0t5PVf1Gv3RwsYwb66ZIV3a2H4K+KlW5vMJg13sQHC69Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641409; c=relaxed/simple;
	bh=sk9SyV6OGoG2LoQmXtZrJRZA/jthg9MaNaD8/2e7Ux0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyWqSGr2vdNTyzAjiI8ijt37ZalMKKkgoZa10Smk0SFrGc51bi7mx67Hks3Ap+qTbgg7vzLVmSB29jEPJcesUaUWIFsyae3xncD3VHP9+Qi9SMeKgwUx9gKS8WS+wFCY242DbRhatAgyhmcp0dXH3amBMfmvECfrIMMy3y4zLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPVi/P1t; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPVi/P1t"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78f89501423so24602927b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 11:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767641407; x=1768246207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csPfH2mwhImwAf7on8VfO0GqVDPFbxvTO4GXGA+RG/0=;
        b=PPVi/P1twVWMJLjNApHmx5F1XPg6fLJ+pG8CxrZAAPkcN2LSyQya8fvYf0D8M9f6pj
         81dYgPi7ydvLRqT9KUkqzml3px2d5tyLvXBaHgc25zTtCwf1Pq1AILGA+YspDq9VlFGD
         R6iXlLmYrO74LyOAH9e+tZBhq76IL7iy62gvEq412fR76m4TSIi5GNweKoSY+5KgzHqx
         oxNAtUvD6Mc8hivv6ApagjpDDrBndrayzqqMNSiCsSdDdrF1XiFwiLN6sAavsrAMpCI0
         hyjFslHuaPd40nwRvzPFQc3hZ8rUA+NLrnDmre4s1a1cUC0HO1JxgiAKvuSBjg3ARjO6
         gpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767641407; x=1768246207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=csPfH2mwhImwAf7on8VfO0GqVDPFbxvTO4GXGA+RG/0=;
        b=Uk6az61vAIWNprIUz5/Rf+nuXRNe70YZq/2NJrhj0JJQ629x21cw4YMTkAy6qz3fXp
         jQH5/ID1lDSdsroFFdOl7IvpZYGVCRloMxKUues9ENMtSHbe/tkPfJVLX902Sb7soFN9
         QUXcJYkOJEZJBtLhG4+FkH6X7mU5JSsReKA6FGwkDiszD7DJtR4NCWaTjYizihCg7P1U
         HbmKTXipnWm7sWu82wlJHaTz9FjWYSRfIW+48TIUN/9yuPg0s70KYA8T84YZLdJJwIqZ
         vBhv6LSaLutuMMn8Zyd03DDtIwLuwR3VijC36HMTy3n9xmIto6M/C+YlaTksMIu7nEpk
         LZ8Q==
X-Gm-Message-State: AOJu0YxX25vjx79p2yddHLXYFGyw21VHlMlegGa0WEatKFGPSS342X37
	Za2hHjjtrpNd4bts1sv+vpbo1j4f+2hOv/Pgiox0v4FumTc8i0ulAnLPhnpg5ZncVH+RO/+WiCD
	lF+8e82FrcfsUellAi/8whoOTptw5Rj30u51g
X-Gm-Gg: AY/fxX5Kpkg5vrE5GqZXBjFFz85BkXNizRpRHWJEXts70B5vG83kU2sJ4w2NebNTfKy
	DpWL8u2xyfwir9nMPiG4JeXDz6Bgjvk2Lw4t0NWeEuGnF2Tc1VKJe3n2tvft+3/X5NwPOKFUEqf
	uxQyw71ib6YxkGWxyg4B/gm5XoH5LSGgXaPiZIoKQJKNGJr1v6hPN4tPokKOo+f0JtnlwkjVck2
	h6huV+LWVdC7pdXIO7f/OmHVIdjRwT0kZIuxRJZ2ROSJwldLptcVcgrJiLDbaY0mNvG2DCXhJ+4
	fkCMWRybtRoYtYKJXulKSryxQMAMh8BGqCoTFgYnAduJ5pmWiOuzBmGX1I9Mv9fe4ER/
X-Google-Smtp-Source: AGHT+IFg6kTgO3cGXrV5NcI//zP0SnNKDvF186ac5VZm/8aHGF2kr6plgIgdGUYWGa/R6WTfe5294cHnXQPuySyQ2U4=
X-Received: by 2002:a05:690e:140d:b0:644:50c7:a50a with SMTP id
 956f58d0204a3-6470d2f3e09mr199191d50.32.1767641406657; Mon, 05 Jan 2026
 11:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767559459.git.pav@iki.fi> <ce1ecf069f0856ff58471bbc39c6e38ad4acf0a9.1767559459.git.pav@iki.fi>
 <CABBYNZJ5gFe1N-NGU-ni7TybTraCh3yFDjwSEzYUzeC84_Kqyg@mail.gmail.com> <afee37a9062cab55f853b25ec1550eab005d6306.camel@iki.fi>
In-Reply-To: <afee37a9062cab55f853b25ec1550eab005d6306.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Jan 2026 14:29:54 -0500
X-Gm-Features: AQt7F2o9dlv2uQDbd_B-5__TWt5jlSak7eIZ0S7PGbCcpGBL_7ScppPHWqpig4c
Message-ID: <CABBYNZ+t35ShsD2C+Hee8tOLpBgsq4L+keS6bozqPr5m+rn6ig@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/bap: add bt_bap_stream_is_server
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Jan 5, 2026 at 2:09=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2026-01-05 kello 13:45 -0500, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sun, Jan 4, 2026 at 3:51=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrot=
e:
> > >
> > > Add function for determining whether a given stream is a BAP Server
> > > stream or not.
> > > ---
> > >  src/shared/bap.c | 6 ++++++
> > >  src/shared/bap.h | 2 ++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > > index 6a35e4e1d..d0425318c 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -4270,6 +4270,12 @@ uint8_t bt_bap_stream_get_type(struct bt_bap_s=
tream *stream)
> > >         return 0x00;
> > >  }
> > >
> > > +bool bt_bap_stream_is_server(struct bt_bap_stream *stream)
> > > +{
> >
> > It is probably a good idea to check if the stream is valid first
> > before attempting to check if the client field is valid.
>
> Yes
>
> > > +       /* Stream is a BAP Server stream (not Broadcast or BAP Client=
) */
> > > +       return !stream->client;
> >
> > Hmm, so the assumption here is that stream->client is set for
> > broadcast as well? Perhaps the terminology is misleading here, perhaps
> > initiator would have been better, otherwise this may be confused with
> > BAP client/server role which only applies to unicast, anyway Im fine
> > rewording it later but I think it would be clearer to have something
> > like bt_bap_stream_is_initiator.
>
> Yes, client=3Dtrue is set for bcast in bap_bcast_stream_new().
>
> This is intented to returns whether the stream is BAP Unicast Server
> stream, hence the is_server() suffix, but maybe it's slightly strange
> API with broadcast.
>
> Maybe bt_bap_stream_is_initiator() is clearer here,
>
> Local is Initiator Sink (Unicast only) -> MICP
> Local is Initiator Source (Unicast or Broadcast) -> VCP
> Local is Acceptor Sink (Unicast or Broadcast) -> VCS
> Local is Acceptor Source (Unicast only) -> MICS
>
> where Initiator is assumed to also be Commander, with the definitions
> from CAP.

Yep, I guess that is clearer than reusing the client in the context of
stream, or perhaps MICP/VCP have role definitions for these?

>
> > > +}
> > > +
> > >  static void notify_pac_removed(void *data, void *user_data)
> > >  {
> > >         struct bt_bap_pac_changed *changed =3D data;
> > > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > > index 80e91f10a..983b9d9a6 100644
> > > --- a/src/shared/bap.h
> > > +++ b/src/shared/bap.h
> > > @@ -113,6 +113,8 @@ struct iovec *bt_bap_pac_get_metadata(struct bt_b=
ap_pac *pac);
> > >
> > >  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
> > >
> > > +bool bt_bap_stream_is_server(struct bt_bap_stream *stream);
> > > +
> > >  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
> > >
> > >  /* Session related function */
> > > --
> > > 2.52.0
> > >
> > >
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
