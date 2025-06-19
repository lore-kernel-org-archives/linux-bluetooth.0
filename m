Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0FB30E82C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359947; cv=none; b=jlOF97TvmV7OlwtyOIqY81DVcGJaaSC9k6WXo0Okj6s/yzTs5Zv5QvDVyEZZAWimfAT7yKOypMF9YPOCoye8Sey9Ne1VJJyyxQtn9hMRysOuiysOUwtLBLEB1HBwCLtOPdRHDUQWolBdccXaimoabByS457OI/kzMT4E6Yqjm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359947; c=relaxed/simple;
	bh=vtpLfiUK4tRabc3RH14f1zcUEgK9uMTTa0IFTUONUTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJcPt+Qp57iYoj4GKRJBY/TU4PAlTKvy+uQt7jfyV067AidpFGVLFlZa8HTQkypyFUO+GHBM56epqXG/kwHxAGsuK96qEEZRxsC9i2OWIBdUBV9SaKo4rCULBkHBshU9StP4CiXxcvVIeWLNT1Zsy4WcVBGvz6r+mJFS7S9ZuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbvwSbOV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbvwSbOV"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b43cce9efso9657241fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750359943; x=1750964743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF6sxreDsieoR+S6KJGbq7Z5NQHOQ/uj89MH/GIqCS0=;
        b=ZbvwSbOVKGLMoGQTd0P0OT4BBqprQ3ZsEnW68o+a5HRSQpLiwuKbIrCpejRP19/UtJ
         j9Y5xnHRBrnXsgiKz/8ryZEbMxkezQOd7/ItZNGl4s9ERsLENp/L7+4+k8PKHGPlTFZq
         k4TR1Zn9f9Gggx2/3gKg7XR6vy7tZsyiGdokq+f+hMNpimmVn3QxqJz/oloYy6IdIZz5
         2+7GO2fgF+7O9qH0UJRVIsFpj6n8UmydBSeawjauaCnt5UFC5Y+f4Xwo52zdBoPiHafS
         5q528hCrCVjl+/bWUAJO2HzL9+A9filKx9hgU1lh8w8XkVd0hqzZGiSjf6xsL7nVcSiu
         KuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750359943; x=1750964743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF6sxreDsieoR+S6KJGbq7Z5NQHOQ/uj89MH/GIqCS0=;
        b=CdKCG4XVndd5ICZ8aGOzPpWK6IOHout3FWhDhlBtBNElAVoWMddv5CwqUdvGR9NoXu
         jf8kMfXQ8e2dTe49JbOUC0qq8BF90vG5v0io+dBwZTyUnvLuc/5uboIvFoVLimk0hx3S
         QmuI1hlYiRinmDcgYY956MTpsn1tpj5NPuY712O8LhCcHH3Rwkr1c+KToCkFMxNJwIOR
         /57Np/XPZB/UNoa+5k5/DUROTg/GWxqpL1On/nAHK96kTdkEg+CyKJg4mwO57zQkgBwp
         Ma4tHSS5vKYLGaJB8MvhQgSOWtn/eOPQFM6qOSOoCdSOB4KLW30KhJzl7H/bLsjaJF7o
         8Jmw==
X-Gm-Message-State: AOJu0YySz2FS17Or14w6SeoU4WWTtPH7vX25vTTrRIFUu4i8+kdPuFyt
	yFEsbcpGVwr0IMvi05W/uutdJ3UJxO5r+k7LfmRtNiPkuqM3jANP5sUrRqkBlZ4dn5sDA5WGgfx
	JokpeDMxlFUlFwtGlioojUpZUGuzBG95AMe+czEw=
X-Gm-Gg: ASbGncvJoK9vG3iH0tmcuqdSPiQd0otrRHqU0btpcc0NeC9vGH5+Ak69/g4ZzlwHs7s
	73I0OFumrQ0aw7VqEocJrFfYfF+xxPuAeAWZCk7EjJ7UvgIm97DGmUGBiaXFl6GRivFh7gIJSGG
	NYlCkRjKDsjKlI9gEHcA1+RHoyhYuyF5i+9u+ujsXbAg==
X-Google-Smtp-Source: AGHT+IEUrnjDgINjxhM3f5ye3FbrJCfRmT0bN2WT26kZ+Chsm8canSrzBaOx/sCVNfeZgc0+icvp2p/CHKJCdLnKpbI=
X-Received: by 2002:a05:651c:324d:b0:32b:6bae:e3fe with SMTP id
 38308e7fff4ca-32b9919f09amr163571fa.9.1750359943035; Thu, 19 Jun 2025
 12:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dae73d42711856e8ea1100d0703cf861f8f5624c.1750359087.git.pav@iki.fi>
In-Reply-To: <dae73d42711856e8ea1100d0703cf861f8f5624c.1750359087.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Jun 2025 15:05:30 -0400
X-Gm-Features: AX0GCFsH23IQ90bea-pGYiSuzl9QZOxnJi2loRwnv-q-L8Mocd7iZE4DX0Mywbw
Message-ID: <CABBYNZL54W-__PJ_xvFN12z1pFheLBxWqY9Ppf4_Jc3P4=Zu-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/shared: allow passing in stream's own metadata
 to enable()
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Jun 19, 2025 at 2:53=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> If metadata is same, it should not be freed as it may be stream's own.
>
> Fixes:
>
> ERROR: AddressSanitizer: heap-use-after-free
> READ of size 8 at 0x7b86a76f5d18 thread T0
>     #0 0x000000836745 in util_iov_dup src/shared/util.c:353
>     #1 0x0000008ea96b in bap_stream_metadata src/shared/bap.c:1991
>     #2 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
>     #3 0x0000009226e7 in bt_bap_stream_enable src/shared/bap.c:6392
>     #4 0x00000044037d in transport_bap_resume profiles/audio/transport.c:=
1981
> freed by thread T0 here:
>     #0 0x7f66a92e5bcb in free.part.0 (/lib64/libasan.so.8+0xe5bcb)
>     #1 0x000000837002 in util_iov_free src/shared/util.c:392
>     #2 0x0000008ea94e in bap_stream_metadata src/shared/bap.c:1990
>     #3 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
> ---
>  src/shared/bap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 8d1c69d47..070f4fc05 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1986,7 +1986,7 @@ static unsigned int bap_stream_metadata(struct bt_b=
ap_stream *stream,
>         iov[0].iov_base =3D &meta;
>         iov[0].iov_len =3D sizeof(meta);
>
> -       if (data) {
> +       if (data && util_iov_memcmp(stream->meta, data)) {
>                 util_iov_free(stream->meta, 1);
>                 stream->meta =3D util_iov_dup(data, 1);
>         }

This makes sense but I do wonder if we shouldn't just be checking if
data and stream->meta pointer are the same, or perhaps we shouldn't be
passing it own stream->meta to bap_stream_metadata since that
internally already uses it anyway.

> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
