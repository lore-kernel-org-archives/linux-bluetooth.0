Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8352F94
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676980; cv=none; b=Vk9j0PrrokOUEM8fiAr+ft1uvnsXGBu5WxKt1q0Is04UqNyIQ3mU/mpbfqDmeNe3DNsXhBBGvitrn7XVKXc/A8ue02Uc1/hdCfdn9nUwINkgY8l2yvjMrYZGGiN72dA1FG7KvKSlgjT98hmqkFOq8iOEYCZsdmjt9zZUio0s4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676980; c=relaxed/simple;
	bh=9UzN+URzc/p2guU7t2PTCqFgXfSU3TYfuJEigfBoJ1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdhFpgz+bSx9ESKHC+OAZks7e46siI/3YVXrZbOzjR6izNjccLgrT/siWZYPWe5pTK51IgW/ZhXdgILtXhuBofx3klXOGpqRv+l2kVHiKJt0k3HZDe8Z1gedAMvTpMwf43E0i1HskDmJNvTZi4q/bcHaqJwN7oHMh58qODwKAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeGmnjPe; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeGmnjPe"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cda523725bso9900321fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705676977; x=1706281777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u40MVN77TrRqeuHpMfY0Z4iNomAP7WhGrTHvLu95Xk=;
        b=PeGmnjPeKYWTUmXMXgwMvNapSQ0SMg7bsS9WR5BtnnCJVk/FJLRsrlQFQJApa/ARl7
         dx5yltq4upkMGsAcBGgOxR3bvmeY9eE7ixko2aZtTloR1H/VFtXjs9cPN3h8pbJbYQZV
         UqbhnHA+HFi+82qAMTOh0yDUodaB/5JyEY4Q9XNZrNsAWPzvTLlrDMvDF7/WXy8TOFFc
         95Znr82nHQOagMS1z84tAPufzz+pCyDDtDfCjMJvLFIcRoCu8cug2z8aO7q6ahyFI2We
         18WDqn6KPxG+LHobLs5k2inpUGgEaXazMqR1rrBEq0szF88Hm8BCh/pNtfo9Q3ih0GyL
         EJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705676977; x=1706281777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u40MVN77TrRqeuHpMfY0Z4iNomAP7WhGrTHvLu95Xk=;
        b=xO8fFp0Vr/2ZfguF7ucY8RJX2XKxSFanBpATDO4dBRwjr2/tKaLpX+Xn8rh+F/boOQ
         ExUj2m5y19e7wLCcOTqeafPaWBT28/URGl4Ni396mRo30yLkpXc2Mg0Y7lOdty14r8Hd
         mbF5I6rfEr+/aaHgIveqrhLIxyrXnhKsqejyJzlUfS78B/F6/RdQ/gIhthJs5OBz7Z4L
         atNk6+/walACYQ9Z9Da3c/zYV2CwbSGubN1/gkNj3LbQADoT+lESGhffJVtaRspx4AWr
         uqdoXjQMcNCrVsx1RY1DLhHytOLG/UDOaOEY77NYyClEIxcuSeH0yM82/zF0hTcibmR5
         Zxzg==
X-Gm-Message-State: AOJu0Yy5bDVVYFWKwC+/MipX6DxZ82SmVeo8ESUWFdBLPJAsCILxBsYn
	1PM+D/4lteUNKArEtdimvuv+ah7W4I5cz2uNGYjeP/C0pD/1FAdmGFvifnELRhUbVri9BlVD4n4
	aMp9vodaf9XIXnGKY/8D6T6SLczVcCcPd
X-Google-Smtp-Source: AGHT+IEUJzoEGkcEvUB6DWJciGQ3uku6yuQLvlM8cEO0iXHMGgmzm6tl6c1sNRigvZ+4CDQvK5rZGda+i9IFXCQ51cY=
X-Received: by 2002:a2e:8682:0:b0:2cd:eee1:292 with SMTP id
 l2-20020a2e8682000000b002cdeee10292mr941880lji.44.1705676976724; Fri, 19 Jan
 2024 07:09:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com> <20240116-autofoo-v1-4-626f6b54bd06@gmail.com>
 <CABBYNZJUhmVUNGTsqspc3S802pDwikFf2YOPupESD1m5T-GsJw@mail.gmail.com>
 <CACvgo505kkEr+SZV587XCGoaFKYo=17zgbvHLrv=UJLp5JRLiQ@mail.gmail.com>
 <CACvgo5064TQ5qwNiBgpc5BcdnHWoD7xEc45ZyR_PcexKwubR2A@mail.gmail.com>
 <CABBYNZJckSdAfMziUsMTmjnoGDj+9GOxsn29XPpZ5+ikrNUd4Q@mail.gmail.com> <CACvgo53grTEzKyTudZbRiHAc6c4DM99v7pCKs8rHZg1P3BUrvw@mail.gmail.com>
In-Reply-To: <CACvgo53grTEzKyTudZbRiHAc6c4DM99v7pCKs8rHZg1P3BUrvw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Jan 2024 10:09:23 -0500
Message-ID: <CABBYNZJ248tr43rSp6jHD4ZwCvJsWbQ+irT9Cpx_+MB5r0iC_w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 04/10] build: remove dummy {conf,state}{dir,_DATA}
To: Emil Velikov <emil.l.velikov@gmail.com>, Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil, Tedd,

On Fri, Jan 19, 2024 at 6:09=E2=80=AFAM Emil Velikov <emil.l.velikov@gmail.=
com> wrote:
>
> On Thu, 18 Jan 2024 at 17:05, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Emil,
> >
> > On Thu, Jan 18, 2024 at 11:12=E2=80=AFAM Emil Velikov <emil.l.velikov@g=
mail.com> wrote:
> > >
> > > On Wed, 17 Jan 2024 at 08:39, Emil Velikov <emil.l.velikov@gmail.com>=
 wrote:
> > > >
> > > > On Tue, 16 Jan 2024 at 18:40, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > >
> > > > > This one seems to be causing some build regression, when trying t=
o
> > > > > apply it breaks the builds.
> > > > >
> > > >
> > > > Thanks for the quick feedback Luiz.
> > > >
> > > > Would be happy to help but need some details:
> > > >  - configure options used
> > > >  - autoconf, make, gcc(?) version
> > > >  - the error log
> > > >
> > >
> > > Just went through all the patches and they apply and build just fine.
> > > Both in terms of "./bootstrap-configure && make distcheck" as well as
> > > the Arch specific configure options as seen here [1].
> > >
> > > Any pointers about the issue you're seeing and the platform in
> > > question would be appreciated.
> > >
> > > Thanks again,
> > > Emil
> > >
> > > [1] https://gitlab.archlinux.org/archlinux/packaging/packages/bluez/-=
/blob/main/PKGBUILD?ref_type=3Dheads
> >
> > /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/
> > 9/../../../x86_64-linux-gnu/Scrt1.o: in function `_start':
> > (.text+0x24): undefined reference to `main'
> > collect2: error: ld returned 1 exit status
> > make[1]: *** [Makefile:5864: mesh/bluetooth-meshd] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:4674: all] Error 2
> >
> > This might be due to using scan-build, anyway CI also run into the same=
 problem:
> >
>
> Might be version/platform specific - `scan-build make -j2` works just
> fine here. What are you using - distro, autoconf, clang/scan-build
> version?
>
> > https://github.com/BluezTestBot/bluez/pull/2010#issuecomment-1893971347
> >
>
> Hmm, I was wondering where the bot lives. Will take a closer look.

If I'm not mistaken it runs under a ubuntu VM under a github action,
@Tedd Ho-Jeong An can probably explain it better since he wrote the CI
integration, which btw we intend to move to BlueZ organization at some
point.

> Thanks
> Emil



--=20
Luiz Augusto von Dentz
