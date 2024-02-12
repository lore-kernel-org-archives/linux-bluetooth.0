Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014847A53
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776288; cv=none; b=Ge5ZB8YbvDtZcVSeFX+CrJxaUmxytiRZNMa8kmqv4ivMCjyK/MrDUsOcxcNQZH7wQ2LRYveDR7az5V4OV8hR+M8jICaK2FAOFfRqr1NIUVDdv/f+6DUVBqEuc+y4nnbUSlWZOOCbn6nd8wk/CHPMtcSshHJSImn5QA0t1OQEh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776288; c=relaxed/simple;
	bh=sYwVbHLK05RmWYU6tMXarHgXiMJ/sVyNbJKJymf2WB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tizy/OtfS7xZZY5Si2vDLyZQzMChpiGGWv7y44nN6bRMow1FodeHEX4b+ioapKKGw+W8Ch7aOlsAdZREL2leAGCrOi4fNQJcnkReimJ7YpdNAikj9rHMR6LR6qP8GrAO2Rheh948Vk8Cvn6LWxvryx3Evc4/OkbiH9MeprVKDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4p8hkk9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4p8hkk9"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso49253831fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 14:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707776284; x=1708381084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY33wlNxUbis34gZFjS1OCAARF3v45p4zZMAxR0g4lQ=;
        b=g4p8hkk9Xwf3zbFiJt89sfhteFukrFMzpLjxxp+iD9gqsCOqMFKPsx40tLLpJzgUzk
         3XGjgc0ZoZiEBckpzPszUyGckcF7HHAHIj8vq2yaiB5OyVDER+2EFDDaKmlvYzPNSMZy
         1/Cew435WwIzeKCK2J0tuSbPzObJU0hyOzDgg2RWzo08y35C/AWSmEESZyhn89bNAHMZ
         kJX7HkyzJbS4ILWMkSM+dOYU9vDw03RxAQSzdJDfL3D3Tsu/zW2yS9tIIW4lFx/AQtOs
         cswWob4mV3xBrV9FfcNl9g3xUmGg6k6F/oyRsFllZIx+C1WYefzz+HLEHx+Yd9KHsKky
         ujFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776284; x=1708381084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY33wlNxUbis34gZFjS1OCAARF3v45p4zZMAxR0g4lQ=;
        b=iHu1lUH7HpVQyuJ1PXBZ1LhcEYbxSaKWt3WnBRGMkfsY2mlolm80isn8UbT8V+T4kj
         Z9iR2IHj7Ar7CiODXkFsFqDAbibdM3jP6HM7dGB3YMlQrAmmteyiUIf2VbtOCfTwbP04
         qyG+IgM5uT1reQU8c7OstgVVIBoHSPyQv85INPUiu73/UqQHiUc9LPuqWHxgSBkQePGU
         fhi2Oy0n/9PQ2Q/9IAR6iHjeZzu6L5sWYv1J/PngDmDljMBbxwGe8eQq522MdrHKTyAA
         vXuHonz+4KeVeE0jCBYDNwTclo8quFuLxX2Z6SGeKZSF74ip2lZKwzX9p9h7YA6lc0FC
         niIw==
X-Gm-Message-State: AOJu0YyniGdIrmXOUPpqtUxI+R2WYkkUqwgEOA/3d0fTy+yKjU/M6+wG
	QrB9bjzlkAsLKvi+jIoSa3ebcoRWTSS3Oj74rU4XgminCHX9H0Usgh+UUkjgOO60eMsp8VN8RdN
	AevaEphW0kAjoZpWJ4dW9vsNLo7MlmqpL
X-Google-Smtp-Source: AGHT+IESAmUOgMPzh5ygl/DHh5OMHsPx7HqjhDa4VkTdNCXMno1zSEwaOMBPS3puz6kfgsHJss5ji76QL4wYh8zg+xE=
X-Received: by 2002:a2e:9550:0:b0:2d0:bf87:b3a6 with SMTP id
 t16-20020a2e9550000000b002d0bf87b3a6mr5077364ljh.37.1707776284283; Mon, 12
 Feb 2024 14:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212153222.8191-1-silviu.barbulescu@nxp.com> <20240212153222.8191-3-silviu.barbulescu@nxp.com>
In-Reply-To: <20240212153222.8191-3-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Feb 2024 17:17:52 -0500
Message-ID: <CABBYNZ+EsY+P=sbZ-QDeWzzgNk-Q0A_8THxJDg-hONjyv-LXVg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/7] shared/bap: Create multiple streams for the
 same pac
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Mon, Feb 12, 2024 at 10:32=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Broadcast source requires to create multiple streams for one pac.
> This is required for multiple BISes support.
> ---
>  src/shared/bap.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index e26dbf944..f0ffdebfe 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -5156,7 +5156,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_b=
ap *bap,
>                                         struct iovec *data)
>  {
>         struct bt_bap_stream *stream;
> -       struct bt_bap_endpoint *ep;
> +       struct bt_bap_endpoint *ep =3D NULL;
>         struct match_pac match;
>
>         if (!bap)
> @@ -5212,12 +5212,32 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt=
_bap *bap,
>         match.lpac =3D lpac;
>         match.rpac =3D rpac;
>
> -       /* Check for existing stream */
> -       ep =3D queue_find(bap->remote_eps, find_ep_pacs, &match);
> +       /* Broadcast source supports multiple endpoints (multiple BISes)
> +        * for one pac so allow it to register a new endpoint even if
> +        * others already exist.
> +        */
> +       if (lpac->type !=3D BT_BAP_BCAST_SOURCE) {
> +               /* Check for existing stream */
> +               ep =3D queue_find(bap->remote_eps, find_ep_pacs, &match);
> +       }
> +
>         if (!ep) {
>                 /* Check for unused ASE */
>                 ep =3D queue_find(bap->remote_eps, find_ep_unused, &match=
);
> -               if (!ep) {
> +               if (!ep && lpac->type =3D=3D BT_BAP_BCAST_SOURCE) {
> +                       /* Push a new remote endpoint with direction
> +                        * broadcast source
> +                        */
> +                       ep =3D bap_endpoint_new_broadcast(bap->rdb,
> +                                       BT_BAP_BCAST_SOURCE);
> +
> +                       if (ep)
> +                               queue_push_tail(bap->remote_eps, ep);
> +                       else {
> +                               DBG(bap, "Unable to create endpoint");
> +                               return NULL;
> +                       }
> +               } else if (!ep) {

Perhaps we need a dedicated callback from creating streams to avoid
having to add such checks everywhere, that said I don't quite
understand why we have Broadcast Source to find a remote endpoint, it
shall use a local one instead and perhaps have the ep struct support
multiple streams to be attached so we don't have to create dummy
endpoints just to be able to create new streams.

>                         DBG(bap, "Unable to find unused ASE");
>                         return NULL;
>                 }
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
