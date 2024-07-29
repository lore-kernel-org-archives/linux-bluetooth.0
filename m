Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF8146584
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254323; cv=none; b=pXIcb3Km4DUOsODdkLRsWLIevvjUco3xoFG0Dl9pIYKFUZU+m+Zc5ofgGgfKkj++sEKJPETSSg6YjU2WHBCqDMivfKOYN68yYOeoAlMkvnqqF/6HrIQ2he95QbzJI+FJQ7gQ0jGRQCStSHz8/zdcUaueyHdLn7kNb119PQlh0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254323; c=relaxed/simple;
	bh=c72EjlqA28dc0cQ+h0l2X7FgfD4mZ+IPBZQ7Qhv91us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0ypYiRPLvoFPRnhZ6D+QWBa5uaTnFmA6pt+6Zu/LkXN48AB35CiVuIVvQjYxyr7DvRSrGHfOYePvCl2yS4kgh6wAdp15wfesFWnLNhkItdbtfAt8pDdJ90a0xYD2+LJhiaQvnTFfDSRJpZYWUrBy3tbfj1/VtqO2mmXBcmLpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sZPfL+x5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sZPfL+x5"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f025b94e07so43707411fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722254320; x=1722859120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5aKXY+rQL013Kd98lZMP0BnWp1j2sIi9Lubv/zV5lc=;
        b=sZPfL+x5CBB7CNCxr1opT0K06MsnJTjIu7R2UJqWqUPr3c08pqx+z7HehfjD0Fjuys
         XwjrCI7HyllyAgmDcUDsBQjNdbyoTgho1V5x+Xv7YXuCVtutIyDNI4k6jqOTDocjo22E
         4iXOqh98MUgDE+TvAfKWOB7B2pH3+/rUcPP1z6u7H/fq13yVkArxZkETbOmXnF+wEPuU
         Mm8Yu7IQOjiXm9fFoq4HZReMjqVyu3Mxf6vZvyffEmXFJ4lAGDLely+jpG14x/AZk6in
         P8x24aLPVCJ/94RC+pyz1dpkYLdbh+JsLAxJlbHa3hm32betvVPt2hhduCHf6T8MyaRb
         Vo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254320; x=1722859120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5aKXY+rQL013Kd98lZMP0BnWp1j2sIi9Lubv/zV5lc=;
        b=cwA+LDLt50JEYXJrLMszW15MG5c7QfekzTtoYNjLzqlENTx9BlfZSGZrem+IhPEa3I
         XhWK1LpWRph5VMe6lPyKsawk9eshSX4+3UkMKLRcbQGahWQ0cK7esqBYiv5//nlWJXjf
         RgqVICz6gTn/UDN5LHj8ZffyScIqmPGpjvxIoL8UCN+Qbca69mq4k5g8i1Pu+Hw554+k
         kF60WGeJR/XD1oJSrJl2z5AeNykHWQMrTetPWWcVbvfunM7+cm901QtVJTlyyYHdpzu6
         9lAR66DJOuohDJ1qbHCnjF/WlHR4M6H6NXbLvHUa7NqDDIlsl9v6PcoMnk/0QMe7oD/O
         2QmA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ54ofMjAp6EmVbazJbrk0n/aDJMouvuKAkP7KFF0XtcYtlIi8JyG6F+CbE5ZIp47yIvtjlMbs7ofMIa09JqV1hUO46eYC9aYSjkZGGRr8
X-Gm-Message-State: AOJu0Yxlh21LgDKJJbFwPs0Xm0rZwzR0dUmG5lHkmMKUu1ByOYr56N1b
	7ByqpyFeaUZtB4uM/M8jrH5MgFdP4Ly3j8JOz0Seu/FUZj/lYYGz+0aKGTmBs13NNYKiMx/44Qb
	HFYZrTMU1Wd+sC7N+vWCSDhqIWFvlt2UyCy8Ckn6IE6VPkuJL
X-Google-Smtp-Source: AGHT+IHHG7LQv3D/QMCXMSd2qTDF+4AQ+9sT9jnNdxu3pbyDekRAZRSxu1fvZL/uwPOmcaZy06nbOqUENU6gObECHpY=
X-Received: by 2002:ac2:5597:0:b0:52e:fa37:f9ca with SMTP id
 2adb3069b0e04-5309b27231cmr5295449e87.22.1722254319298; Mon, 29 Jul 2024
 04:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j>
 <aa9d6aec-ef94-4137-b2ff-0c86d9a92d42@molgen.mpg.de> <CAA8EJpqGXe0A0yDpEP==60k-bPEbDORpLUtsiPvGSi+b_XphAg@mail.gmail.com>
 <CABBYNZJP2c4L-nFHtug0isqnKPR+Q0CE09o_ACsPLobjLpHtcg@mail.gmail.com>
In-Reply-To: <CABBYNZJP2c4L-nFHtug0isqnKPR+Q0CE09o_ACsPLobjLpHtcg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 29 Jul 2024 13:58:27 +0200
Message-ID: <CAMRc=McB1hY+Lad-gBj9-_Ve2OeW+rXaRqHL2xO4zDPMRD41jw@mail.gmail.com>
Subject: Re: btqca: crash with linux-next on bt power down
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, regressions@lists.linux.dev, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 1:56=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Dmitry,
>
> On Mon, Jul 29, 2024 at 12:01=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > #regzbot: introduced:
> > 973dd9c4db4746200f88fe46e30eada7054fdbea..84f9288208dfcd955446060a53add=
15b9e01af4e
> >
> > On Mon, 29 Jul 2024 at 13:21, Paul Menzel <pmenzel@molgen.mpg.de> wrote=
:
> > > Am 29.07.24 um 04:11 schrieb Dmitry Baryshkov:
> > >
> > > > On Qualcomm Dragonboard 820c (APQ8096, QCA6174) soon after the boot=
 I
> > > > observe the following crash:
> > > >
> > > > Unable to handle kernel NULL pointer dereference at virtual address=
 0000000000000018
> > > > Mem abort info:
> > > >    ESR =3D 0x0000000096000006
> > > >    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > >    SET =3D 0, FnV =3D 0
> > > >    EA =3D 0, S1PTW =3D 0
> > > >    FSC =3D 0x06: level 2 translation fault
> > > > Data abort info:
> > > >    ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> > > >    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > >    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > > user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010da63000
> > > > [0000000000000018] pgd=3D080000010da62003, p4d=3D080000010da62003, =
pud=3D080000010da61003, pmd=3D0000000000000000
> > > > Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > > > Modules linked in: hci_uart btqca
> > > > CPU: 2 UID: 0 PID: 66 Comm: kworker/u19:0 Not tainted 6.10.0-next-2=
0240726-13923-gd3ce7ebd61f9-dirty #2722
> > >
> > > I am unable to find the commit. Your tree also seems dirty. What is t=
he
> > > last working commit?
> >
> > Checked the commit range on the linux-bluetooth branch, hope this helps=
.
>
> Im currently traveling so it would take some time for me to
> investigate this but I suspect it could be some of the changes
> introduced by Bartosz with power sequence, @Bartosz Golaszewski
> perhaps you can help?
>

Hi!

I just came back from last week's vacation to a bunch of different
regressions. I will get to it but it may be later this week.

Bart
