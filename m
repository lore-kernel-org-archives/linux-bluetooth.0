Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348F1DF726
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497185; cv=none; b=FB3Y9eFL+OtWsi6Y1Pimru8Ha+pmleGOew0KOU0sS8ennD1zNoVnWgsOxvBgWt+4+ucZnmTBkape8QjRANtZkgsgARQz+U6xa0rba2J+Ql3KuxOjAgha/OYrlOKqYLDOcTqtZalel6i5RFETvkdn/NPEkuycTMwr/tLbvAya3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497185; c=relaxed/simple;
	bh=O6Nj1GuG6MvYVoFYvVjzmR6PvL6jvcx88hyo7xxGx7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ej/XvnCOyDHoqsiYO/kDYYdwVNEh6/Ef1FE4lQZqCOoJwFlXedg7pQ2G+PP0lVY+SLnMTgfXOWhTpc5Iu+wAyxuGi9ViT+yw4WoCIKA6JlmlGoGnjXXx+0yqaOufsfDY+ciB27Hk56+USGwF5/vxkS8UNul9nUYcpoKYexqEPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBRPVyAi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBRPVyAi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso663651fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2024 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728497182; x=1729101982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIT9zCsBLDtU+GOIo7xjKIub9PKryq4oK2MflqHLF50=;
        b=EBRPVyAivIVl0bbzeUo1Wq/N+7VTnwPn+M5Tat8EzGtfiawjV6qwXyKx0KeT7Yh0sq
         YGc06MI69MGLP8vnVI2tO6CJq0Gqu2jpkutDShjPr2iwcwfYOqJfBekJUE65w3vxkuJ3
         zmAHAQh/8Pjca7lcma2YCyNrHSpK98HWXLnvxbfF1VX9E3+egIooxe/dNo6VuN/KvLZ1
         RAkEchERJTv8eWRZAGHeQlTUo/eQFK+Xu0+yFim8dESb61IXvt1BkazcvIpLZLxyiZEq
         iTkDcxMVTrAEY6D9urJyazgj332EX3Sylj9XXseLiqpDv/I8uMboeGKiKhxjSiaj0xbI
         n3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497182; x=1729101982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIT9zCsBLDtU+GOIo7xjKIub9PKryq4oK2MflqHLF50=;
        b=PALcXOtbyoGqCVClm6LHXVxfgYmeYNm3U8UTXWWcvoGrUlYZU6E1zV3Jt9xDKy63A7
         DxtUVKeiZoTXdt3WEkAm1huqrDVgWwuflwYDuG/8W3KCkBRvWKZYZyurVDxFIL5H0sg+
         dYmm2+lUiUxIU9RekDNm5FezIATwxU2US1CC9ixxPtG5z+PAnvKov42la4fKA9DHdGzv
         +aB5czI/XrdimZ1muDDzKBnqKC2QEgVEbYmc2eW2mkFIGpne9z875pSO0d8KBgNFEqaS
         nEuHg5d5t11lfoNB35D+hKLAFk/6l7hPHWGumb7y9GHQfaqm//1ObS87yQmmRcUJEsNs
         bElA==
X-Gm-Message-State: AOJu0YyF+Ew4ROYuf+0RWrmp5cvDalMNsr9yFYUhvQrOwFmQN8Q84XCM
	U5s4TD2sAuvpG2RB+hjUk0guitlS1U2IgVAW+MVTElbCHKmOoOJXMU3cRbhcHJ6OdBqI3IpoJsO
	CwUn0IFIK1EtBRUrwjyFZtUrtOos=
X-Google-Smtp-Source: AGHT+IFqXGFtOdcNJuPNmhlF3X9oOGyU6dT74tXPSk8h1Pif/RSii1bRURpOtojjAFRUN1KQEc/1WoAJqcpkx2WGfjg=
X-Received: by 2002:a2e:4609:0:b0:2fa:dc24:a374 with SMTP id
 38308e7fff4ca-2fb187fa02dmr17391141fa.37.1728497181640; Wed, 09 Oct 2024
 11:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005214321.84250-1-marijn.suijten@somainline.org>
 <20241005214321.84250-4-marijn.suijten@somainline.org> <CABBYNZLQexGSfm_0B-0_EFi3MOSZDiGzEdLBWqqUAU6_jRwOZg@mail.gmail.com>
 <brenpr5jeeivae4e2zqalqctcblyq3cvoeqqte36hnmyxh6v57@efpmjykxruj5>
In-Reply-To: <brenpr5jeeivae4e2zqalqctcblyq3cvoeqqte36hnmyxh6v57@efpmjykxruj5>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Oct 2024 14:06:08 -0400
Message-ID: <CABBYNZLQCX2u9yqDS-VDaHW3Z_d86NJdKiWyAHTDEcmOOu_+JA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 3/3] audio/avrcp: Determine Absolute Volume
 support from feature category 2
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>, 
	Bartosz Fabianowski <bartosz@fabianowski.eu>, Pauli Virtanen <pav@iki.fi>, 
	Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marijn,

On Wed, Oct 9, 2024 at 6:30=E2=80=AFAM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2024-10-07 11:56:06, Luiz Augusto von Dentz wrote:
> > Hi Marijn,
> >
> <snip>
> > > diff --git a/src/main.conf b/src/main.conf
> > > index fff13ed2f..b6b32a720 100644
> > > --- a/src/main.conf
> > > +++ b/src/main.conf
> > > @@ -316,6 +316,15 @@
> > >  # notifications.
> > >  #VolumeCategory =3D true
> > >
> > > +# Require peer AVRCP controllers to have at least version 1.4 before
> > > +# accessing category-2 (absolute volume) features (depending on the =
value
> > > +# of VolumeCategory above).  It is common for Android-powered device=
s to not
> > > +# signal the desired minimum version of 1.4 while still supporting a=
bsolute
> > > +# volume based on the feature category bit, as mentioned in this com=
ment:
> > > +# https://android.googlesource.com/platform/system/bt/+/android-12.0=
.0_r1/bta/
> > > +# av/bta_av_main.cc#621
> > > +#VolumeVersion =3D false
> >
> > I'd change this to have the version e.g. #VolumeVersion =3D 1.4, so the
> > user can switch to 1.3 or "any" in case he want to bypass version
> > checking
>
> We can surely change this to parse a version which would override the ver=
sion
> of the remote CT, and rename it to CTVersion since it's no longer only af=
fecting
> volume?  Maybe add a TGVersion as well, and/or something else entirely?
>
> That would save the ugly combinatorial explosion.  Maybe the same works f=
or
> VolumeCategory introduced in the previous patch as well?

Yeah, well we could do something to disable strict version check so we
rely only on capabilities, anyway a good way to avoid interoperability
problems is to be very strict to the spec to what we send but more
relaxed to what we receive, the latter may not be possible if there
are qualification tests that requires us to strict though.

> > also perhaps we should create an issue for Android folks to
> > fix their version, as it seems they do support browsing features
> > channel for TG they should be able to do the same for CT.
>
> I don't think this patch aged particularly well as hinted by the testing
> steps in the cover letter: on my Android 14 phone AVRCP 1.5 is the defaul=
t in
> developer settings, so they might have realized that this was a problem i=
n the
> past.  Don't think we need to report it anymore, and we should perhaps st=
art
> discussing whether this patch is still desired in the first place?  Eithe=
r way
> I'd appreciate to land the first and second patch.

Oh, in that case why are we even bothering to change this? Or this is
to allow working with Android when the user has set it to AVRCP 1.3,
well that still sound like a bug if you ask me, even if it is not the
default behavior that should have been 1.4.

> - Marijn
>
> > > +
> > >  [Policy]
> > >  #
> > >  # The ReconnectUUIDs defines the set of remote services that should =
try
> > > --
> > > 2.46.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
