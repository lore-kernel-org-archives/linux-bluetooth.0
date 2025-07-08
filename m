Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EA22127E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985217; cv=none; b=ALjKhADZ1Yk3qLMWK8rB29c0YwYdBvPhgfX2RTYL5AWT6DhC5Vx7NYqb97Q18QSvYJCkl/2JyJZQwTK3Wxy/UQsiqTvEsU//IGlqOKxG75aeuoiGNZHdhMSod66TM/CTz9IPwii/grrDWutmtbdiCefbsgmKTojSCKCVbg3otiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985217; c=relaxed/simple;
	bh=WFddEclrlIWblV4ncYwtxiyRjrPNLbWFZth0q6bJ23I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wb1ZpbVO4CfW9A8mCJnCTBiuNSPR4aXUbyYDl68jI52H9nVYJUAek9NE3Fqb72H4g2n31mrOxCxUUBvHSLzeICmkqzyELlbToiJ7kIm8sF7MSOMUPQmuCt4Xax4g5/eYZ8fCMbuf5x66GsV+OZZjHuEF25Udb65UG8KOo+i86F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlyxfhJ2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlyxfhJ2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237311f5a54so41751205ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985216; x=1752590016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hU1zcUDdgxt3r95ImxtQJetIlOAU1CJfX4jO7Fr+fU=;
        b=QlyxfhJ2RPElGReKtT/qWLRr3GJPTbhQvDbKnO61KRVVGYAQuuKXJ5yOJ7XKopSC85
         plsIu8GorM9gJ574n3u/tLI80YKudEIM9MA8GYrESahQwflqIZsXp9P9exMZDW/6Pf8/
         +tBZouKaHjgvxiaHlNCS/h1PSTxL/pIfTFphJMOCSAVHfr5vGKX3xxlFXIIfsry4UUeI
         zkfn8tB6TAeVAUD+bviNAl2G9cInefC+EhyAy5kYOTK8yDsnDzO111sheLWdY6F3BxNH
         oKLj6mBPhcOI5o5ulFFrgHCMVcAlgr6jKfQ7bCbUvmWZCZTj1uzvoDaG387ssIHnitFD
         ueFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985216; x=1752590016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hU1zcUDdgxt3r95ImxtQJetIlOAU1CJfX4jO7Fr+fU=;
        b=kh6TB1CEUPpTpog1KpHqpBMfkrzbmJoftMyrgKlvCDu7PVEX2SiXO8skPL5X45fdeZ
         WlELJq932czHUcRfdexVV0rtGdivcICLDYK5dKLrBqfWJhY5kbcfPz5rYzowwwlQ5sxb
         Eq62xKm9pmn23m7j4rZAVhoTLAIKqhD9U8ABAwywKnDxm0mBG+DllYH2FXzT5ak+pgw5
         sec+N2Zc0bB2o8GJDhFrvPqYPX7/F+LR4Fq9ELx0l+CxLw4SccEXdYP7URfytcGJMZWb
         ba5z78iAvdSET43Aow9JGTgDTa/q9tLED8C9bP7WeIsjm23FPP9+C/1NqRr/eiq9o1u3
         otEA==
X-Gm-Message-State: AOJu0YyLF90Uz8ikpzTYL3vgl5FTvLICaFI9NiR5IcShtnb+EgLCmWOk
	bfmNCfwjWIDLmUU1jpbglp8gS95PHA14/ayupdwnC4ZorTjUtgSJhLDaXxvuW1d1as3L428fW3h
	1hs7XwKBsQQDBikQoQFCFzIz4GdTI2saxuA==
X-Gm-Gg: ASbGncvz1BeYAym/1LZOP7Zdyv8r9lok20f6Kommy5l0HD5J9et3ejvZFmWmVw5synB
	XQChocs0ZqeGYH7P2QV2Htyh4CboLr44crHVb0D9M3c4yd9eiDD0psLkpMeNynVexaJ+zznWQLY
	907rjbrDwo4Om/b1vvr/MvAPI8nLxUKzGm8V1yL9uiew==
X-Google-Smtp-Source: AGHT+IHMWLjLeWBebcu1LB3f/L134X66hngYARA3eZzEVIzc2sZ8HyjPXobZyoWG64exWP4xcgY1M+gOdBo9wPd+lpo=
X-Received: by 2002:a17:90b:3b44:b0:311:a314:c2d1 with SMTP id
 98e67ed59e1d1-31aadcf8350mr22961091a91.6.1751985215494; Tue, 08 Jul 2025
 07:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708110909.2626286-1-i.iskakov@omp.ru> <20250708110909.2626286-11-i.iskakov@omp.ru>
In-Reply-To: <20250708110909.2626286-11-i.iskakov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 10:33:20 -0400
X-Gm-Features: Ac12FXycPqSf78eZzFWY_GUlCwyhtgzOG5IkCqN1JHtJyyKflU3wkf7kGfsR6X8
Message-ID: <CABBYNZ++JzV++kRvT6BtpprJ1pTRw_wSY+G7B5Qo75MRTU3Ycw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 10/11] profiles/audio: fix io_unlink args order
To: Ismagil Iskakov <i.iskakov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ismagil,

On Tue, Jul 8, 2025 at 7:12=E2=80=AFAM Ismagil Iskakov <i.iskakov@omp.ru> w=
rote:
>
> Seems like a breaking bug. Analogous to bt_bap_stream_io_link,
> but there the order is correct.

The order doesn't change anything, the exact same operations are
performed on both parameters, we could just name it stream and stream1
instead of link if that confuses the static analyzer, that said I
don't think that should use the argument names are indication of the
semantics of the function, specially since it can see the underline
code.

> ---
>  profiles/audio/bass.c      | 2 +-
>  profiles/audio/transport.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> index f617efa2c..e1c05e05a 100644
> --- a/profiles/audio/bass.c
> +++ b/profiles/audio/bass.c
> @@ -457,7 +457,7 @@ static void stream_unlink(void *data, void *user_data=
)
>         struct bt_bap_stream *link =3D data;
>         struct bt_bap_stream *stream =3D user_data;
>
> -       bt_bap_stream_io_unlink(link, stream);
> +       bt_bap_stream_io_unlink(stream, link);
>  }
>
>  static void bass_remove_bis(struct bass_setup *setup)
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index a1fdf948b..a355bde24 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -2015,7 +2015,7 @@ static void transport_unlink(void *data, void *user=
_data)
>                 return;
>         }
>
> -       bt_bap_stream_io_unlink(link, stream);
> +       bt_bap_stream_io_unlink(stream, link);
>
>         bap_update_links(transport);
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
