Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B51E3DE8
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261387; cv=none; b=eORGAEAuy+QnvBk/91LivXgmtZsfeP0KVxXO8EB2lj08X3SXec9F36LUTSA9rt9/Vsy4jb4TEMEiqps2lypZXSjqhNQV+n70ZG6ImnsH5Pga8GTrRRUY7Z1oSlPnbSAtdBPCVEjKOhQUXWEUU0Jfts8ZhIDisfrZM0JDuUNIgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261387; c=relaxed/simple;
	bh=GkscUhk/CAHBbNSPlhxx0HwJtkVCYYSK2RI3R+9FlAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMKvfC4AnD0kHZyY1Ik4r0XH+qJBNUYkarI/GQ5Xu6wyJLC5ujGa0ktVVtsprErklVS2s4+Q2yLf7KIvkrM+M8xFA2t68bG3rYBer+eOLQNf5ZfsxcRSOR71OZQBxPv0hVADVQITGpVEkG03pB/NxnWUIB8wmqkArdHoDQCHZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZOlli/x; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZOlli/x"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-304d757a9c1so43039861fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 06:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736261382; x=1736866182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwxBvfp+3GO0pee4l4YthmQWrnG0F9mk7+1daJL8a6U=;
        b=YZOlli/x2lmVK3pTeDav2gpvzib3TV/dMv0gwxOhdhYYxCgr5C2WVlm00Fyg1YNtrH
         F1c9Kq+XLAVnfim2d1y8jtvsNUAFb3XDlS3JMPcUSvnWIuP1zR3FFEUiRjAz55RchBK1
         ceIw1Wh2du8Cb+3vBWEKYj763S8ED0aglbw6D7nSXpGFzv6cTeqg2NLya0z1zuv2DdDc
         jWqD7wnHRpyhVLgdjBbh6w5d5bxTGdQmbwb0VQ3vK8syPf5hvokzOz5SRT+YOww8Ez86
         nfpDdTcPaUrgRyIfWRsUq26s3e8aURMdWGwkPUi8f0s8gL9g5oNGWsentXQW395cWwGI
         ZsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261382; x=1736866182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwxBvfp+3GO0pee4l4YthmQWrnG0F9mk7+1daJL8a6U=;
        b=Wq3DDZ88bitSk61fZaSReYhORzkGyN8GOTARgtYXzZa7GjATPM77+q9SuWKgNQgvVV
         csn4/qvWllBVD58c9IFK/X0Gs38E+v8v3U86I2ADZSiBJ54Z32fZyXJWKnbgpAdb9JX9
         BJuiU/vuQlkBFnWLeBq0nbjsjEdOHTAEkObbmbLx5Ewpozcsn17P83ZIwrAk5lxf9Z2H
         /Pk+7Yxu9A+3aOhFul/4dT09WGUIWlQMaO4Ym11cNpVWcbVg9lvxY70N3XTxH4gkZNG1
         GKauYj8Q9WWWZwIvrrIMvjQruLhlKtlN18X3EDbHWrXWpGLxYutlvUNd3aOCas5o+mVP
         HWlQ==
X-Gm-Message-State: AOJu0YyE+qBrpQv8U8hz1oizndh+rkl6ajxymv9UZ3/3RP6Y5HKrIiyB
	mxBliTuV0AbqsrLjHialqIBkhcxYTrNS2hrekUJHSUZ8ToGgB0hZFMLfv8PVyx6ghGIs2dvgDFc
	JSgqhQF8anIou0SiC09oFCu+q5y8GWw==
X-Gm-Gg: ASbGncsEaQZYxhbu55MTxCvdvfqUmTb/Q91NBscEPkIn2j5aW4tal7Goe4M2IENSiVt
	mi2sQ0ZzsZUfwRnXmCkvqrWCGrUg7qcZ+MzvijKA=
X-Google-Smtp-Source: AGHT+IHzgNMBdy9PKFAy/ZOW92dtAKZDWPjrRN8AEngfCvPd0El6+hawzZtrjNCx9W9CUSdioQCj+D1roichEWoenPw=
X-Received: by 2002:a2e:bc03:0:b0:300:1a4f:4619 with SMTP id
 38308e7fff4ca-305eb1c2967mr10402341fa.1.1736261381985; Tue, 07 Jan 2025
 06:49:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224142424.10572-1-mahesh.talewad@nxp.com>
 <20241224142424.10572-2-mahesh.talewad@nxp.com> <CABBYNZJ8To9fm4j3bcGsmPc6ChJO376yAN-Wr3Se9hs_3GpJoQ@mail.gmail.com>
 <AS5PR04MB9754DA009526DC605DD32C9B89112@AS5PR04MB9754.eurprd04.prod.outlook.com>
In-Reply-To: <AS5PR04MB9754DA009526DC605DD32C9B89112@AS5PR04MB9754.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Jan 2025 09:49:29 -0500
Message-ID: <CABBYNZK0Sgrkyzmr0NQ2s1PJXWfO8YVPtPzda8bt3=ERj+hcAg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] HID device not connecting issue fixed.
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>, 
	Vinit Mehta <vinit.mehta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Tue, Jan 7, 2025 at 7:05=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.c=
om> wrote:
>
> Hi Luiz,
>
> We tried with option - " UserspaceHID=3Dtrue" in input.conf but HID Conne=
ction did not happen.

Do you have the HCI trace? Does it fail to connect or just doesn't
work because your kernel don't have uhid enabled?

> Thanks and regards,
> Mahesh Vithal Talewad
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, January 7, 2025 1:24 AM
> To: Mahesh Talewad <mahesh.talewad@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Devyani Godbole <devyani.godbole@nxp=
.com>; Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>; Vinit Mehta <vinit.meht=
a@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ v1 1/1] HID device not connecting issue f=
ixed.
>
> Caution: This is an external email. Please take care when clicking links =
or opening attachments. When in doubt, report the message using the 'Report=
 this email' button
>
>
> Hi Mahesh,
>
> On Tue, Dec 24, 2024 at 9:24=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nx=
p.com> wrote:
> >
> > While connecting BT-HID device showing br-profile unavailable and
> > connection did not happen.
> > Steps followed:
> >         1. Pair Ref device
> >         2. Connect Ref device
> > With this patch HID device is able to connect and HID traffic can be
> > observed in btmon.
> > ---
> >  profiles/input/device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/profiles/input/device.c b/profiles/input/device.c index
> > 8cf8e5ea7..a6047998a 100644
> > --- a/profiles/input/device.c
> > +++ b/profiles/input/device.c
> > @@ -89,7 +89,7 @@ struct input_device {  };
> >
> >  static int idle_timeout =3D 0;
> > -static uhid_state_t uhid_state =3D UHID_ENABLED;
> > +static uhid_state_t uhid_state =3D UHID_DISABLED;
>
> Well this would contradict input.conf:
>
> https://github.com/bluez/bluez/blob/master/profiles/input/input.conf#L18
>
> Perhaps what is missing is the detection that if uhid is not enabled in t=
he kernel it would switch it off automatically, that said it was intended b=
y the distro to know whether to enable it or not, so we don't have to play =
a guess game runtime.
>
> >  static bool classic_bonded_only =3D true;
> >
> >  void input_set_idle_timeout(int timeout)
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
