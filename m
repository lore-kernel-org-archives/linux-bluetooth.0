Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC013C3D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513156; cv=none; b=NBJOKDtxFocvGYOEAg7AqxtpfizEQpwZXpNa+X3QoT6TzG3GnvXocAp5JOrJCAGUqXPAMUe0xJyLT2RCGztkg7e6ItXg117rCXF2VFsKJRC+xRjW1L7/rM3TSUkW1C6ytCih3OUEhZY91ZzldUMI1njhUheUcGUrZr1mRjaHQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513156; c=relaxed/simple;
	bh=yb85kSQkS/6eEw5nsg+bXO/Tv3hyWYuxIZswQJQrl24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuBCfdLGsyuhPCAeuMIPMBslpYjKYrKPPjZBCM4hEJVeStUQ8vMEYe4bg+p6NuuVoAnl7Mtb1mZmAvXhOGJD/WnM+mme8JdwiX4cXigKbu4n0Ep2TdSWs14QbUsFxHkZJFR8HZKnc7NlFYLCsBHi7TVTZMG6PR28NeLU35ZqQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2ssIBp+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2ssIBp+"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so110312691fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719513153; x=1720117953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns5TSwzb/DNziLpqwi6dvdnVpSbw+mpXnrCvvmDW14U=;
        b=i2ssIBp++cpChxLUrDurA95SpTDlgj8EH/6gkLqhV0PiDNA1VhudWGG/YJCdT0r+dg
         OFoAfukzH2vFQ68fzduJbJdCCFfqEU7WSqqkdgiyJA7R59HFGMeD0+HeTobTeHNaYroN
         aUgBWFQ+3zPdUtuNujKhXCpC6BB+Z/yZ4Rk0WwamFeHZOu+vgBRalOrgFMUKBzPZ/NN5
         Iarsj01j4ZMPJk0aXdI/KytNs236TOPoVmNlwCI4DxFXsp8VnJfWeHIGZdX82M/GfPxB
         M2wwVvuT39931LMLyd9/monzOhliYXkanEgafxq31ypUvGvIoZNZ83dFgGT3J5Gdgh//
         1/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513153; x=1720117953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns5TSwzb/DNziLpqwi6dvdnVpSbw+mpXnrCvvmDW14U=;
        b=DktniqxxEcG1dqwnhABqu2f0w3OEsW8yqj1G6bQhLKlIuNyaiRhFOIKuTjh3IBRduD
         2xLVbWYkRP6RI4m9ncmd7WefOzYoCcQthlX66HwZiB2UJOXnAiS1rJZaMZl4fFNOGiwf
         sfx0XLjfh4+8kfy8ixKdIyrIuma9DBQ7an9kQ3CMXeNxNC97Ie0SlapMIP/pUV1CnJUH
         BHKDRUhtICpxoGaree4vbZ6z1qMvAGfPXobogFOocHfyzgfVPUFYUyJIUHcKrdzeh6nP
         Df7sIaE9pW8R1e6EzCZE59ysigv93Eoksin5TBu/DCM7Z4u/ISjDQqlWUwk3HjfS3duY
         CJgg==
X-Gm-Message-State: AOJu0YxczngDUIrxK0pqs231YMkzxB6de3JDMYrOwUIA1fvtDprXXAf8
	xDO7AQsXkWN8pAF/Zi3LOAKUkAvzNWfatqJ+8wribzvWC24pmU9Vdk6AOiFj02cU4yPvZPLyGLU
	+36uLdsK/qb/dLk+lBvtBoD0YNocWZw==
X-Google-Smtp-Source: AGHT+IGDIK2GJ2dtVO96p6/QxM97iun/t2YwVQkmJmB/Q/LdJGm7kSoAKrKakNiiPJL0N3zYO9GVB1hkc0yhOJ1y6Ms=
X-Received: by 2002:a2e:83d0:0:b0:2eb:d9b3:634b with SMTP id
 38308e7fff4ca-2ec5b36af6emr106918361fa.46.1719513152031; Thu, 27 Jun 2024
 11:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627085652.41303-1-r.smirnov@omp.ru>
In-Reply-To: <20240627085652.41303-1-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Jun 2024 14:32:19 -0400
Message-ID: <CABBYNZKHiirxZ8KRM-rs4361s8mYaSG18iOfT8k_g1h3nKEZCg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] bass: add NULL check to bass_handle_add_src_op()
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Thu, Jun 27, 2024 at 5:00=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> wr=
ote:
>
> This prevents a null pointer from being dereferenced in case
> queue_find() returns NULL.
> ---
>  src/shared/bass.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/bass.c b/src/shared/bass.c
> index c30537dee..f08799714 100644
> --- a/src/shared/bass.c
> +++ b/src/shared/bass.c
> @@ -875,7 +875,8 @@ static void bass_handle_add_src_op(struct bt_bass *ba=
ss,
>                                         attr);
>
>                 queue_remove(bass->ldb->bcast_srcs, src);
> -               bass_bcast_src_free(src);
> +               if (src)
> +                       bass_bcast_src_free(src);

I'd move this check inside bass_bcast_src_free to make it safe to pass
NULL pointers.

>                 bcast_src->attr =3D attr;
>         }
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
