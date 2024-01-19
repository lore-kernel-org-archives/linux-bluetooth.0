Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E584C61B
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662571; cv=none; b=mNJUwE7vkONC4/OAk20e6oAt1x6dRGLvg/1WqxpTHYjTUlDpyZi97TKAGowkQ131zlrccZlgkyYOEb159X9un0mS7zEIjjirz10GORPAX0VPWPVz2H+brnpFPY4FFu/vbxTGdkPiR7CnqKy//k/UTAUeK7+QHEqJSgOt7GaQfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662571; c=relaxed/simple;
	bh=8XmR6paeAoddoGctqRw5WUBLxJ4QR38XEQaHyPxGHUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAZc0R2tP3Iih2UNLaApzR1OHBmhVd8AGAytskE4MiD/mM7pmMwQ5lUIivmYhJvwBi1Pg97uQa3l3jNYDDrTAJi1EJN87OEpZ5+IF4ftNxuI6N4PI+BiTlTz7hWKgeGapLeha48O0aQ9oeicVBQlOb49FuVIl9q/tWYMIJl7qS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU+BfJ1C; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU+BfJ1C"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ebca94cf74so6524887b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 03:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705662568; x=1706267368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S80t9r1cvcIqnPsZ2CdBA53EOmgRwM4Zy1LoxQQsf70=;
        b=jU+BfJ1Cyq2PmROfJr8cgkbbBn5MbjHqAkjAlUqz/zEyvBXiKu3K9poz7oPJ9ABbFK
         vnSeHmTgVeIAg2zZS8tdxFjKxbyNNL9q1EyW7Pr9YTwxczM/4Sw+dHP5gbprE6xsStln
         SPNhMKxaUTTHBdI1bob+0FpEzieRMjfvckoQExzmNLzddJlqcRLMFtPO7SwO2Os0zoUT
         Yn70CJE+7jKOqmMMO99DhyjOya6faQyhxekmbhUwiLKP7ZnbZR+9URztXdCdW2mcTEJF
         nc0+FwbVj7cM2wca7CHWaOzgkZzfwNbKzcd0d8bTJJ6JlHa/GWAewLTfufGM+Pt74Huw
         Hb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662568; x=1706267368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S80t9r1cvcIqnPsZ2CdBA53EOmgRwM4Zy1LoxQQsf70=;
        b=cCX1F9va6OzZ1CjpUA9ZzTzUsd3ed39Mrgj+NM1c+djzRSFHbZil5CYAZtPHqWynGp
         pdz2tC99wq5nNmV4Q/4EzEgqb1zcdNumC/gpAvGDzbKlqTazoL6O6omwBizkCVx+Mi8H
         uKHhHy6rKcCYwc7NxUEY4D2XhLGBAoQYFCMt3dk+QcvxbUNXDJlPMLNJVBa9t1nx02pK
         dAk8nVbySOT781VSaIXo3BREDZEeFWag7w5Zy9Uh0cJxBQlE6huCrQ69QCR3OL//JRRR
         nhK+tK9h2QD0jYNkueH0htbh8BNbuwip9d83bqwRvAhBFsdnsWwX6XHrfYd/pR7sbiwe
         458w==
X-Gm-Message-State: AOJu0YyHQVHHvI3CquRfeZ5Q3/9ynVXIkHdGpxxNZiaNLTYwHVqiPHlR
	+w/8DQz08l+AslzoA2jnJNxgwOoMUUKleMHRI4+y7bDLen6P4qKLWQgv11MA5APLX3/KU6cwCNp
	A8cKYltbk1fPvDPaj9AQA8z6GVhg=
X-Google-Smtp-Source: AGHT+IF1jAVyRCJT9TII4girWiCFrqgQw8nKJbUrcJillfSo5abdVk6NsZwfUBqkOcfoVPBVhnNB4WmlmDHJTdtGbHc=
X-Received: by 2002:a81:ab51:0:b0:5ff:404f:e483 with SMTP id
 d17-20020a81ab51000000b005ff404fe483mr2032050ywk.97.1705662568581; Fri, 19
 Jan 2024 03:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com> <20240116-autofoo-v1-4-626f6b54bd06@gmail.com>
 <CABBYNZJUhmVUNGTsqspc3S802pDwikFf2YOPupESD1m5T-GsJw@mail.gmail.com>
 <CACvgo505kkEr+SZV587XCGoaFKYo=17zgbvHLrv=UJLp5JRLiQ@mail.gmail.com>
 <CACvgo5064TQ5qwNiBgpc5BcdnHWoD7xEc45ZyR_PcexKwubR2A@mail.gmail.com> <CABBYNZJckSdAfMziUsMTmjnoGDj+9GOxsn29XPpZ5+ikrNUd4Q@mail.gmail.com>
In-Reply-To: <CABBYNZJckSdAfMziUsMTmjnoGDj+9GOxsn29XPpZ5+ikrNUd4Q@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 19 Jan 2024 11:09:16 +0000
Message-ID: <CACvgo53grTEzKyTudZbRiHAc6c4DM99v7pCKs8rHZg1P3BUrvw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 04/10] build: remove dummy {conf,state}{dir,_DATA}
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jan 2024 at 17:05, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Emil,
>
> On Thu, Jan 18, 2024 at 11:12=E2=80=AFAM Emil Velikov <emil.l.velikov@gma=
il.com> wrote:
> >
> > On Wed, 17 Jan 2024 at 08:39, Emil Velikov <emil.l.velikov@gmail.com> w=
rote:
> > >
> > > On Tue, 16 Jan 2024 at 18:40, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > >
> > > >
> > > > This one seems to be causing some build regression, when trying to
> > > > apply it breaks the builds.
> > > >
> > >
> > > Thanks for the quick feedback Luiz.
> > >
> > > Would be happy to help but need some details:
> > >  - configure options used
> > >  - autoconf, make, gcc(?) version
> > >  - the error log
> > >
> >
> > Just went through all the patches and they apply and build just fine.
> > Both in terms of "./bootstrap-configure && make distcheck" as well as
> > the Arch specific configure options as seen here [1].
> >
> > Any pointers about the issue you're seeing and the platform in
> > question would be appreciated.
> >
> > Thanks again,
> > Emil
> >
> > [1] https://gitlab.archlinux.org/archlinux/packaging/packages/bluez/-/b=
lob/main/PKGBUILD?ref_type=3Dheads
>
> /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/
> 9/../../../x86_64-linux-gnu/Scrt1.o: in function `_start':
> (.text+0x24): undefined reference to `main'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:5864: mesh/bluetooth-meshd] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:4674: all] Error 2
>
> This might be due to using scan-build, anyway CI also run into the same p=
roblem:
>

Might be version/platform specific - `scan-build make -j2` works just
fine here. What are you using - distro, autoconf, clang/scan-build
version?

> https://github.com/BluezTestBot/bluez/pull/2010#issuecomment-1893971347
>

Hmm, I was wondering where the bot lives. Will take a closer look.

Thanks
Emil
