Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0513CAB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555122; cv=none; b=g+yRzKdrG8A+c4GccT9KlHb595PS2EkqEDbBuXbN3rkb2jDAIj1DuQwDW3dTMqFL881lgqOs5Qjb5tcTtdz4eDUNGcuWpJ3fqRVuKCKCWyh5Rp66Wy4CUHr6rN5rK3Cg+j7alEM/tYT7FEoB7JYBPfXAQxmqiYY/XPrdCuHIvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555122; c=relaxed/simple;
	bh=AnZxMlAjE2PLicXIgqx3vh8ls4EfopLFcNKVgiaW12c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUDHTEsOukGIhWgr6Bs+9ivvwWz/KTqSPx2BNqa3YAPEJj0rcdnAz9dmFcp0Nk2Bfxc7qzet3osN8SpCVO6mRl8WoxwW15yXrV4n1cUU2lyaHFJ3B6hJ62oR3N3uhAGFoxZoJIlzdoZ6y0eXYsB4GDJ+MH/4Lq1UPrNrDXuB28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBU9KfLS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBU9KfLS"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2da84f93c99so30666511fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713555119; x=1714159919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6O8CVFfImlAmnbTsydDQ6JRi5BrI0U027Iva/rN9sI=;
        b=VBU9KfLS19bf34wnWKc1BzrzuRnNmr/V024ugXAba+XiAS8RmCsGnD9nCNylRf26zL
         4Yw+6b+V+2llXhpIbr5ra93z6Q//RqtVWStuivX9IS4lp88EvCu3I8ybbzDdFMUSoLDV
         fDxP1TKy9ysPMDH5r/2xKh8sAlssAeHSv0VPani2d3v7CUagqrTWNBmvl2mOUrTVQQfr
         gHF+9UoTVZaNBQEPiaPU90zGuUSn/6qBrOVDpHASuvxzIEu49Zw5qcbTB4fLrG7Ngxt+
         HZxwpT6X7Dcf7bnAuwYoYqlGmy8nnbDDsFNCufhIFFrzTQSUThVsZJWswbTFxsBk/tE+
         DI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713555119; x=1714159919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6O8CVFfImlAmnbTsydDQ6JRi5BrI0U027Iva/rN9sI=;
        b=b+4F7Of4UgQGTQTUU2N07Bd5uZGvQu1eH4Oj+WbWtuJPrtL4Vkw/y2XEkQqrESvWke
         g7HjEVDYuO+CK7rb3ZHfxbq/aHYvHQJM+oWGcWtRXnD2P5Cstyw+1j+fFaiGzcviH62S
         Nips61ri4NqOGVwO9FvCR8CMSq/jWQaPlTDoTnMmNfZ5cNGbgMW9DVMmg50fEXJXCfp+
         mXTacqzC+Mv2h0Bwt9PdYE6jz2uUSfcCFDNR74f4kIvi4FDm/iEVHyBbnKM4WnrEro4g
         wqttWHButjMRuO+gSsnDmVbkH0KgE2v2GvyBPnZQk9Zw+17Dmb8wl8m5+In7JkqazMvu
         E6xg==
X-Gm-Message-State: AOJu0Yw6HuohORKb2bMbxvMDdw3HXPoYGn6UHANSP4GfHpv8xEz1zXPW
	5MnAyXYpTHKD4abk9UaDEupb5D2EMQfdEIH6JRrp9Pz09rr+tuwq/cdYWZ9F6wYEwxThIofRDr9
	v7qNfAR3y4EYzLaDyYEkG2EXwWMo=
X-Google-Smtp-Source: AGHT+IFls7v6vWiOEvxVMc2rjTe0PUa+iSCow1lSEuWNNGoWEfiXo9vwi0TgukgE5ADjM1eblJAdNvWj7p36EFsdZgc=
X-Received: by 2002:a2e:8208:0:b0:2d8:50fd:29b7 with SMTP id
 w8-20020a2e8208000000b002d850fd29b7mr2246243ljg.49.1713555118690; Fri, 19 Apr
 2024 12:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419180752.96699-1-andrei.istodorescu@nxp.com> <20240419180752.96699-4-andrei.istodorescu@nxp.com>
In-Reply-To: <20240419180752.96699-4-andrei.istodorescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Apr 2024 15:31:46 -0400
Message-ID: <CABBYNZ+7BbKNaagx=AS7yFjhEOgfQ6gmt7ABPdwkHe9gABXRLw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] shared/bap: Update stream management to avoid PACs
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Fri, Apr 19, 2024 at 2:08=E2=80=AFPM Andrei Istodorescu
<andrei.istodorescu@nxp.com> wrote:
>
> Set the stream to enabling for BAP Broadcast Sink, when the transport is
> acquired.
> Remove PAC logic for BAP Broadcast Sink stream creation.
> ---
>  src/shared/bap.c | 60 +++++-------------------------------------------
>  1 file changed, 6 insertions(+), 54 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 36f0b0a3b50a..d7a2f9381c53 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2006,7 +2006,7 @@ static unsigned int bap_bcast_enable(struct bt_bap_=
stream *stream,
>                                         void *user_data)
>  {
>         if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SOURCE)
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_STREAMING);
> +               stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);

There is no Enabling state for Broadcast Stream in BAP:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/16212=
-BAP-html5/out/en/index-en.html#UUID-4a295bf2-6e50-be11-e827-c23e63569087_f=
igure-idm4631863059107233170457600297

>         else
>                 stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>
> @@ -5287,7 +5287,6 @@ void bt_bap_cancel_select(struct bt_bap_pac *lpac, =
bt_bap_pac_select_t func,
>
>  static struct bt_bap_stream *bap_bcast_stream_new(struct bt_bap *bap,
>                                         struct bt_bap_pac *lpac,
> -                                       struct bt_bap_pac *rpac,
>                                         struct bt_bap_qos *pqos,
>                                         struct iovec *data)
>  {
> @@ -5298,71 +5297,24 @@ static struct bt_bap_stream *bap_bcast_stream_new=
(struct bt_bap *bap,
>         if (!bap)
>                 return NULL;
>
> -       if (!rpac && (lpac->type !=3D BT_BAP_BCAST_SOURCE)
> -               && queue_isempty(bap->remote_eps))
> -               return NULL;
> -
> -       if (lpac && rpac) {
> -               if ((rpac->type !=3D BT_BAP_BCAST_SOURCE)
> -                       && (!bap_codec_equal(&lpac->codec, &rpac->codec))=
)
> -                       return NULL;
> -       } else {
> -               uint8_t type;
> -
> +       if (lpac->type =3D=3D BT_BAP_BCAST_SOURCE) {
>                 match.lpac =3D lpac;
> -               match.rpac =3D rpac;
> +               match.rpac =3D NULL;
>                 memset(&match.codec, 0, sizeof(match.codec));
>
> -               if (rpac)
> -                       type =3D rpac->type;
> -               else if (lpac) {
> -                       switch (lpac->type) {
> -                       case BT_BAP_BCAST_SOURCE:
> -                               type =3D BT_BAP_BCAST_SINK;
> -                               break;
> -                       case BT_BAP_BCAST_SINK:
> -                               type =3D BT_BAP_BCAST_SOURCE;
> -                               break;
> -                       default:
> -                               return NULL;
> -                       }
> -               } else
> -                       return NULL;
> -
> -               bt_bap_foreach_pac(bap, type, match_pac, &match);
> +               bt_bap_foreach_pac(bap, BT_BAP_BCAST_SINK, match_pac, &ma=
tch);
>                 if ((!match.lpac) || (!lpac))
>                         return NULL;
> -               if (!match.rpac && (lpac->type !=3D BT_BAP_BCAST_SOURCE))
> -                       return NULL;
>
>                 lpac =3D match.lpac;
> -               rpac =3D match.rpac;
> -       }
> -
> -       match.lpac =3D lpac;
> -       match.rpac =3D rpac;
>
> -       if (lpac->type !=3D BT_BAP_BCAST_SOURCE) {
> -               /* Check for existing stream */
> -               ep =3D queue_find(bap->remote_eps, find_ep_pacs, &match);
> -               if (!ep) {
> -                       /* Check for unused ASE */
> -                       ep =3D queue_find(bap->remote_eps, find_ep_unused=
,
> -                                       &match);
> -                       if (!ep) {
> -                               DBG(bap, "Unable to find unused ASE");
> -                               return NULL;
> -                       }
> -               }
> -               stream =3D ep->stream;
> -       } else {
>                 ep =3D queue_find(bap->remote_eps, find_ep_source, NULL);
>                 if (!ep)
>                         return NULL;
>         }
>
>         if (!stream)
> -               stream =3D bap_stream_new(bap, ep, lpac, rpac, data, true=
);
> +               stream =3D bap_stream_new(bap, ep, lpac, NULL, data, true=
);
>
>         return stream;
>  }
> @@ -5415,7 +5367,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_b=
ap *bap,
>         if (bt_bap_get_att(bap))
>                 return bap_ucast_stream_new(bap, lpac, rpac, pqos, data);
>
> -       return bap_bcast_stream_new(bap, lpac, rpac, pqos, data);
> +       return bap_bcast_stream_new(bap, lpac, pqos, data);
>  }
>
>  struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
