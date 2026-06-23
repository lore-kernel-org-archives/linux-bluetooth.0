Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BDB37C109
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225069; cv=pass; b=KApuYlTZWkUa6YOEh7MhvBvnK4cXC0W7UqFN+a7RjgcG5t6cjSF7KlP0q1tf5BxD4Z6qVHdRihsfpU/awiCJ1XqukXhPDetjMjTDCz2aH+I32bmMOmZYgWQdWAbYrs7apRud3UPVJ5zKh5YRyGh8xRUQO+u9k5MmevRKtaGBWn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225069; c=relaxed/simple;
	bh=RwbdbiLwcSbG9s4MXtTCUHUya8wploYtmJJ4/olP8jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUhouaQt6xO/TBDs5lp5ys8FqsLZGSw9rMMo5uReDHAZbeOuxfnlPLIUPiwdkjnwFf8kgEVoPJKjaqOCncxHhdwAxq1Shj/EMHyOb2jQf0BDX6DP9a5Pq/OS5wszj5R6NLOkEqTIfQzqZ0VHSjNMO7gZV+HC4rbA/ECeWxq8XkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/u1AFix; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/u1AFix"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-662bcc30fafso5945055d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 07:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782225067; cv=none;
        d=google.com; s=arc-20240605;
        b=lIHNjkoDSteMdPY/2iaSsysNAnCeAD7K8MXtlMaE0oFi87GbmGbweVNo0sk591+eBy
         m2GajFcRcv8NulfCORFvi611WhLvvnXHOSEJW+wK0QCQdjhPg0AXaD5hf2ctNqg1DBUt
         YEYYoPz/z4Ds4mN6WiMjZEb0g9wdYyA/FDFAJ0JV/u29oJWFfseKkHg3bduMdqe9pJQm
         /Y71ntZTLyiBDPH53KWZqvWzf1kMBEbnZ0won+ooB4i3v3QUzczmdnH8hPWfG+xLpJmg
         6qhhZvI0hjrIjeINa+l/+WJ89uIJSHrSvIcjKE3d/39FukSW6+VBKtYsSwPly2k5xplv
         LkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zfmdLv56yMlFPKwkzRihNVJcs5x1WmYfE2NJp7reQZQ=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=VQZHoXMR+TSEW5iiZYMbwm7258h/gJC8/b8HssPWNjFYq0dlJXhyejsVeMivTkJBrS
         mivpBRJhvr1IkUeBZ6Jo2rVV7+NlNNCyOCcMUzj5xLaLC3xBbBqTZTpeAbvMVGYX/IVQ
         k/kZudegCV99yYnCJTqNrmNg5HqRl2qZOvrYFQERdHHZg4S9PQtCkh+aWfnogB08A9QH
         jhWHcWTSdvxMw9DTf3Ppw2Pk8oKpGHwJhwBwjPmBa7f1sY3dVp8JHAAhb59+gKBqHFaW
         si2nSjg+Z8sAxWurn/2CQ4ghrnBV4s6ZJ3fWYDvuWvIjU74vtWVa2P/7+bnm8ApEwd2+
         Hmxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225067; x=1782829867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfmdLv56yMlFPKwkzRihNVJcs5x1WmYfE2NJp7reQZQ=;
        b=R/u1AFix0AV4gISvPPYHkmaHvtpKOgSV9xRdAt5dVTKY13ccSivqXdqmVr6DRAvCIa
         WF/Tj8qtl1jNCkqN9i2mzhnuxziLjahLFIsUaDWl3ka6DwKxgW4WKX0y19NEhIkN/xz7
         Kzhlm1XcYwMVB0N6JVu87/lAeV4ROkKbd4m5mdIhxMhhUbIg+4USLQNU1T+xcdFq4V2y
         1lJmIgIPT/MtEU+n2qvEG1XGfpa6/cRFeQA8AJ19CK57xh6hSHdm6Z5lEAF0pamxXo3h
         Y7y7DHlfL0rsexfu766rXatav6Al6MBQbyQFByktV7Wiwg9esw6Wi9JzMXGvGcywETgO
         JGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225067; x=1782829867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zfmdLv56yMlFPKwkzRihNVJcs5x1WmYfE2NJp7reQZQ=;
        b=o5o8IuwVI5Fw+2O1Fia7t++0fhNZ8za9QhxMix7m/yCI36woC7LiEa8czSw5W6FRG7
         qkCrYs0lDTPGIVbnhEWenk1g0zNTILfcDHslO4RV+a/8TOXzXBszEgUffzGIyK270lFO
         F1payVYBbgpHos3/79QbsMCZh/n8cMD0qiwgLFdznj35qw1wkmpQpIchjkGb2SSlbCaK
         tSEE0jqTF7tyMBbJIFrRzSM19lA38atYu3l/jteN3ttgN0JKvubARYR5Q5DzNGbp/+d2
         b4iE7IeB0us3k1vHsP28BRpkSWitjCfr2+vMERGApJHlQI/E9MfyxU6lxuQw1zIFkNOD
         DjLA==
X-Gm-Message-State: AOJu0Yx/cJWqzUGeZBTisECNyEiduzjYTfCh3b97yrVxa3SctbRp4NHp
	nm/f6g/ySKyVbUlfQr8c2ZRm/8FkpUq/7pb+z+bzIOR76Z5yzbFXDBbPLiLjRxAaHxGZ7YLBaOf
	YbJcclDGAyaUkMlWmqQHpb5/eljdtEY4kfXGoC91u8g==
X-Gm-Gg: AfdE7cmvWwn4IN2xMJdqJEGYGKPmmPT5Avkkhc364ykqFSJ5ZLzkRu3m6/K5NVKY+hR
	DRzbnHWHfWFHRpaAYiOMOGr0rohvaC4zJ15t7wxzEdR6W9AgjpUXQOVBnQjOerGXeArrhN93xV4
	2KR7bugCk7+SpmcLW4VMEaRNZO7JqH2gd+9Cot3lQMK93Injy9up9CZcq2IAu2aGld0RU78rDt9
	MCwfeCQD/t4v5p0sB9Pp5axHdTFCn/qGacf899nvBk4e44aLnTxkqZ3xyLlMLrcNR0BRqelllmi
	RO7dIuJnriLSp0uaFnf9joVR2ohqb+uw3aLabXH4ND1NsECos1IiwmXKa7A=
X-Received: by 2002:a05:690e:120d:b0:660:6d41:df5d with SMTP id
 956f58d0204a3-662fff5183fmr18748399d50.46.1782225067150; Tue, 23 Jun 2026
 07:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622155621.675255-1-luiz.dentz@gmail.com> <95343429b8f06e1c88e2c642471f6f8495e11280.camel@hadess.net>
In-Reply-To: <95343429b8f06e1c88e2c642471f6f8495e11280.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jun 2026 10:30:55 -0400
X-Gm-Features: AVVi8Cew3LQaeTTVbnEkKwAjqAWzpqSZBMVDEF1r_BCWlk-R8kM9wXD3S4VZNZc
Message-ID: <CABBYNZLWKRTnFEg3vuoqs0yzD4nEQW6Pajn7WdQf-pT6KtvPSw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] a2dp: Fix handling of codec capability storage
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Jun 23, 2026 at 8:18=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Mon, 2026-06-22 at 11:56 -0400, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Codec capability is one byte long (max 255) the storage format is
> > 02hhx which means each byte ends up as 2 characters so the buffer
> > needs to be doubled in order to handle capabilities of that size.
> >
> > Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero
> > Day Initiative
> > Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
> > ---
> >  profiles/audio/a2dp.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index a5e002784c02..c8adc3122563 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -971,7 +971,7 @@ static void store_remote_sep(void *data, void
> > *user_data)
> >  {
> >       struct a2dp_remote_sep *sep =3D data;
> >       GKeyFile *key_file =3D user_data;
> > -     char seid[4], value[256];
> > +     char seid[4], value[9 + 512];
>
> What's the "9" value from? Shouldn't it be 11 for the length of:
> "%02hhx:%02hhx:%02hhx:"

3 * 2 (%02hhx) + 3 (:) =3D 9

> The "Try loading with delay_reporting first" variant?
>
> >       struct avdtp_service_capability *service =3D
> > avdtp_get_codec(sep->sep);
> >       struct avdtp_media_codec_capability *codec;
> >       unsigned int i;
> > @@ -2373,7 +2373,7 @@ static void load_remote_sep(struct a2dp_channel
> > *chan, GKeyFile *key_file,
> >               uint8_t codec;
> >               uint8_t delay_reporting;
> >               GSList *l =3D NULL;
> > -             char caps[256];
> > +             char caps[513];
> >               uint8_t data[128];
> >               int i, size;
> >
> > @@ -2386,10 +2386,10 @@ static void load_remote_sep(struct
> > a2dp_channel *chan, GKeyFile *key_file,
> >                       continue;
> >
> >               /* Try loading with delay_reporting first */
> > -             if (sscanf(value, "%02hhx:%02hhx:%02hhx:%s", &type,
> > &codec,
> > +             if (sscanf(value, "%02hhx:%02hhx:%02hhx:%512s",
> > &type, &codec,
> >                                       &delay_reporting, caps) !=3D
> > 4) {
> >                       /* Try old format */
> > -                     if (sscanf(value, "%02hhx:%02hhx:%s", &type,
> > &codec,
> > +                     if (sscanf(value, "%02hhx:%02hhx:%512s",
> > &type, &codec,
> >                                                               caps
> > ) !=3D 3) {
> >                               warn("Unable to load Endpoint: seid
> > %u", rseid);
> >                               g_free(value);
> > @@ -2398,7 +2398,7 @@ static void load_remote_sep(struct a2dp_channel
> > *chan, GKeyFile *key_file,
> >                       delay_reporting =3D false;
> >               }
> >
> > -             for (i =3D 0, size =3D strlen(caps); i < size; i +=3D 2) =
{
> > +             for (i =3D 0, size =3D strlen(caps); i < size && i >=3D 2=
;
> > i +=3D 2) {
> >                       uint8_t *tmp =3D data + i / 2;
> >
> >                       if (sscanf(caps + i, "%02hhx", tmp) !=3D 1) {



--=20
Luiz Augusto von Dentz
