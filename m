Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E21D0DF6
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539186; cv=none; b=jApqWK6r4C5ZGBn2Bpn7V6w7cPOgJy/BHCphE+hHMUpQxXa4VXF7+syACPpdbfcxc3nM9ZM5dyR5WLA4EM8+7bdPTirndjMAlFf1RwGZob8QB2JAxRqgeMco8qXzi9Lhf1uB+//bKxY3oh/PqKPikVTXHSWWe4bgeCefwLcLkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539186; c=relaxed/simple;
	bh=q2A11IjgWNtCcYVUjgfItUbNwsDvl1SI57nuwzDu0ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otEvaMR0l3u7s8vBje9ivDqm3s6y8uX/RMH1QewRnPI98FTDQuw8D1mRAKn8GTAqsgBvayd7M8Z1pKGBXvbdsGZ/0Vve2zDu415/VpyzNceAvUX3ovYGz4GuOdPvhM6S4Faq0TVkhYVQLCoWFZ6ljr8DiC8Q+t/K1ZtrqRaBttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMe3la0p; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMe3la0p"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb3110b964so42745411fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729539182; x=1730143982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maqoZYx7Iwl0IQFXE44p1Vrv2cJFgLEu4GsJ1fbYk+Y=;
        b=dMe3la0pZigEJRRIGMGwJ7873cl4p+6pL2h2K7oOQ054DHymRHWYrGwIme9Ily83zE
         fTxMYLEjYlm9J5BszlwtURVC0i3wiYsqWJEgernsQOA78NgYPu+n/ldv4tsV4aWY0Sse
         +VmFC+MPyuQ29LBaTHPUndSNVE2PnXJwiw3M5nkfXJ9bO95yILYVZtWzRbjWam3qVguV
         M311D7ST8BMtHJohfqUvnH20TQhTVS+CwWc9YfGXfKDBu3kAmQNhEyvilhLL98YyusEh
         2htDS15zad2fSHLx60sI/ivmbClHrc7iTsbcFEDpVjYbhT5P4H6gdxUi80nH4OapzLTy
         TCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729539182; x=1730143982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maqoZYx7Iwl0IQFXE44p1Vrv2cJFgLEu4GsJ1fbYk+Y=;
        b=diXoDz06dadQq/6YoSGGNSSr7s8TJpMbqmGfxvyUu7UVirhg8W+QcDEgsepThzCJo3
         1VX32NK+HQsUU+bhh+H4yGyS3nb/5yOyGrP96/9TpuWooLCd+hlE1Lly/QIHW9TXrt7T
         xBHM2htC7mwA4WGRzSdK23GGoV7SlwnXJTZ+/3pQTUKrKKg2n7DuXcoD4aB9lKLUSJsJ
         qrKOqHbTlNDZPR5IH77HffeWn4tIATALjmx/gM6asnxQ+beXNSWzkIYp8aeTX2XWoqq7
         YU8tKg1GYibWOfqWXSsc5uEU5IES4TE9QyeDUyxU1nzO0GLeSzgb+J+0K6V9iewE0Ebf
         cYcg==
X-Forwarded-Encrypted: i=1; AJvYcCWUPYF4fCD1IzoWVJP8xeOpFqgs1rEzjIyLKppS9cOn7QztHczTjEcf2UPQHNY7SQaC5GI570aR/5ntygSPwsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmb6mKN6NQ53X6ECHC3XKhTAEW+YusGr3QQ17N16tUV4ekQl4
	YlNkr56sF9F6opkkV0+MqXAywHMk+XsITUwX0YFjXs6b23bn6Qp+5OAAHB7Z/zGeYJdvd9d5CwU
	SZYuO+9V2kQ7wC6EAtVW0zMdW09Q=
X-Google-Smtp-Source: AGHT+IFrCx6smzponsjv+g5vbcSxVuC1SjYgBVKtNra/F/9U07CqIsmDBNxLWyPhmPNNMGjqiJoaah/voJbPSfAanPQ=
X-Received: by 2002:a05:651c:2109:b0:2fb:61c0:103 with SMTP id
 38308e7fff4ca-2fb82e908fdmr65983121fa.4.1729539182323; Mon, 21 Oct 2024
 12:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005214321.84250-1-marijn.suijten@somainline.org>
 <20241005214321.84250-4-marijn.suijten@somainline.org> <CABBYNZLQexGSfm_0B-0_EFi3MOSZDiGzEdLBWqqUAU6_jRwOZg@mail.gmail.com>
 <brenpr5jeeivae4e2zqalqctcblyq3cvoeqqte36hnmyxh6v57@efpmjykxruj5> <171466b0-ff00-4390-aafd-78b846a9c488@fabianowski.eu>
In-Reply-To: <171466b0-ff00-4390-aafd-78b846a9c488@fabianowski.eu>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Oct 2024 15:32:49 -0400
Message-ID: <CABBYNZLrz74H0KTcDCjeXo6SeoRBXSH+6fK-3Zs_5gNpExzNzQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 3/3] audio/avrcp: Determine Absolute Volume
 support from feature category 2
To: Bartosz Fabianowski <bartosz@fabianowski.eu>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, linux-bluetooth@vger.kernel.org, 
	Yu Liu <yudiliu@google.com>, Pauli Virtanen <pav@iki.fi>, Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Wed, Oct 9, 2024 at 3:36=E2=80=AFPM Bartosz Fabianowski
<bartosz@fabianowski.eu> wrote:
>
> On 09/10/2024 12:30, Marijn Suijten wrote:
> > On 2024-10-07 11:56:06, Luiz Augusto von Dentz wrote:
> >> Hi Marijn,
> >>
> > <snip>
> >>> diff --git a/src/main.conf b/src/main.conf
> >>> index fff13ed2f..b6b32a720 100644
> >>> --- a/src/main.conf
> >>> +++ b/src/main.conf
> >>> @@ -316,6 +316,15 @@
> >>>   # notifications.
> >>>   #VolumeCategory =3D true
> >>>
> >>> +# Require peer AVRCP controllers to have at least version 1.4 before
> >>> +# accessing category-2 (absolute volume) features (depending on the =
value
> >>> +# of VolumeCategory above).  It is common for Android-powered device=
s to not
> >>> +# signal the desired minimum version of 1.4 while still supporting a=
bsolute
> >>> +# volume based on the feature category bit, as mentioned in this com=
ment:
> >>> +# https://android.googlesource.com/platform/system/bt/+/android-12.0=
.0_r1/bta/
> >>> +# av/bta_av_main.cc#621
> >>> +#VolumeVersion =3D false
> >>
> >> I'd change this to have the version e.g. #VolumeVersion =3D 1.4, so th=
e
> >> user can switch to 1.3 or "any" in case he want to bypass version
> >> checking
> >
> > We can surely change this to parse a version which would override the v=
ersion
> > of the remote CT, and rename it to CTVersion since it's no longer only =
affecting
> > volume?  Maybe add a TGVersion as well, and/or something else entirely?
> >
> > That would save the ugly combinatorial explosion.  Maybe the same works=
 for
> > VolumeCategory introduced in the previous patch as well?
> >
> >> also perhaps we should create an issue for Android folks to
> >> fix their version, as it seems they do support browsing features
> >> channel for TG they should be able to do the same for CT.
> >
> > I don't think this patch aged particularly well as hinted by the testin=
g
> > steps in the cover letter: on my Android 14 phone AVRCP 1.5 is the defa=
ult in
> > developer settings, so they might have realized that this was a problem=
 in the
> > past.  Don't think we need to report it anymore, and we should perhaps =
start
> > discussing whether this patch is still desired in the first place?  Eit=
her way
> > I'd appreciate to land the first and second patch.
>
> Even if current Android versions report AVRCP 1.5, there will be a lot
> of phones stuck on older versions for many years to come. Compatibility
> with these should still be very desirable.

They didn't bother backporting it? I wonder if we could somehow detect
this behavior based on the Android version if that is available
somewhere.

> >
> > - Marijn
> >
> >>> +
> >>>   [Policy]
> >>>   #
> >>>   # The ReconnectUUIDs defines the set of remote services that should=
 try
> >>> --
> >>> 2.46.2
> >>>
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
>


--=20
Luiz Augusto von Dentz
