Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4D82D66
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704908; cv=none; b=gCecL4pB1RNphrqykif1cggtvnPK9NXlhrX70YaRVawL14VeH/7WOHXM9WrLjSPwtYKs4r0RueeoRPHbYCYMWrSAln5f6Hw4TaNZ7Wvi44bjP35c69hYRbznBqJ+9KcLquvyqkClkNsgrgKu9k0fxNQ0xNsbPZ2qIcnwkRT5dKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704908; c=relaxed/simple;
	bh=fOYhxV5M+ODXlwZvOjPcZsb5SgGAcUCC/e6bn5bg2Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpVn6mZJT0pPS8XSRcon5tx2rNGmoycyGJuJ0vPOLgZ9Vv45Nq93f6EjOz66H1WkZCsB8ozkZKGePykR9zSoydl1JPTd4V1xXCuxk2cPkMlcNnZqjplk085Jq0mNPoEUw6DJsQ6qMyry1zmU0Gz2WITMulmGQLtpUh/y6M8QLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOxCnW67; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOxCnW67"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607bfa4c913so11037837b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708704890; x=1709309690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p71Zq9uIxPNTk9F8VJjnL/Vl4VPnBXEwmfPSJFrzaJ4=;
        b=MOxCnW674Wq6D4ADq636Af8y0bDhiIo6RFAoPDZZNip65OpjlnW52tOWsBfwo/Wl9v
         I1A6VQZ36zlDEZMfkvgMseYz8nfCCPbzKmKJpmqgFJreV7JBlRFH296WXwVMb1ys7glb
         p0YToa9Uvrl8Fq1uaNFWDF7+04I5nworhjFyLzJxs0B436qR0c5N/dYUWUEHzztgOInW
         ZuU7px+NPI2wGtvRKOEjKVlxcZ/pEFc/2SDAMn51nqhyaqe9ewcihkZDOwJc+atyv2M0
         EDiPhEraIoGZ5NgnZTGDHx6Bh5KcfDPkeO2AME8jMmyab2zRD8VAJCqKZBoaACKGGhY4
         56tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704890; x=1709309690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p71Zq9uIxPNTk9F8VJjnL/Vl4VPnBXEwmfPSJFrzaJ4=;
        b=PFDV4EfIaDIgRJcnVJnBA9a5caqei/8z1KMVjETHYThHSaPzV21KPMG4Ix/eWgnowU
         Fz0OV35P5fEeCMtDwOQs53yxd9owp5f2nNZ7TqziVo4mahFwiNkVrLUVTgo7931vBjWc
         42Znd1Vds2xvZU0ZaR3ahe7AUdwRT0/sEHAfS5OE5qqr3S2npIMMkYyElfZh9tJ06nXO
         HsvrhG+2i9InGDOeBshBnnJaiIN1LtfQerHhbjJ5nQPi5t7MmUPUoBp/mhHWMp0wNot1
         7sY2+aD9gIbQTXAlPAopje6zmwfAvHWV1DuUkSUCZpZwVkSEyXWJPV0HZzI0jd7Gb+b+
         uUxQ==
X-Gm-Message-State: AOJu0Yyxg+IykeNGh+vYSEKm5SZBJkWIEvIYVyYhKOdCyKaWiyp2GKoE
	n3oouegroMPVQPXTes2u5lq4iLn/elbzWEw02noqEhQC08DWqrDc5wApflmjEECq5DdgXoUe837
	JCfDKQ/VgcNxYEz67PvrPwRKh2wk=
X-Google-Smtp-Source: AGHT+IFp3K/QntL7jD1QAyzmHXVsXIKucOk/nmWPmhUTm+l9/imkivM6CojQ5Qt/mw2QFT8kv/unSTpHFhXt3ojXltM=
X-Received: by 2002:a25:8701:0:b0:dcb:ca7e:7e6f with SMTP id
 a1-20020a258701000000b00dcbca7e7e6fmr278911ybl.55.1708704889774; Fri, 23 Feb
 2024 08:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
 <20240221111901.2807853-2-joakim.tjernlund@infinera.com> <CACvgo52M-Efhp92u=fd8qDjV39SWvuoakLgt2JtFftDmZ2pn4g@mail.gmail.com>
 <4fdde6807ed152d0d24e086fd3357b7c4e410391.camel@infinera.com>
 <CACvgo51GX0e5hHzVSD1AEMOLU8hiaDpE0R9su+jjN0mw5HaSBw@mail.gmail.com> <ad9af3a622120ce0dac4c83296c76eaa0d7fbfaf.camel@infinera.com>
In-Reply-To: <ad9af3a622120ce0dac4c83296c76eaa0d7fbfaf.camel@infinera.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 23 Feb 2024 16:14:37 +0000
Message-ID: <CACvgo51_p7aZ791VVeWLnRLCeE+mmYZnYK8R4k=WDtOpWbhAbw@mail.gmail.com>
Subject: Re: [PATCH] CUPS lives in libexecdir
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 12:01, Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> On Fri, 2024-02-23 at 11:09 +0000, Emil Velikov wrote:
> > On Thu, 22 Feb 2024 at 13:22, Joakim Tjernlund
> > <Joakim.Tjernlund@infinera.com> wrote:
> > >
> > > On Thu, 2024-02-22 at 13:06 +0000, Emil Velikov wrote:
> > > > On Wed, 21 Feb 2024 at 11:19, Joakim Tjernlund
> > > > <joakim.tjernlund@infinera.com> wrote:
> > > > >
> > > > > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > > >
> > > > > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > > > ---
> > > > >  Makefile.tools | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Makefile.tools b/Makefile.tools
> > > > > index 044342e29..b785ebea8 100644
> > > > > --- a/Makefile.tools
> > > > > +++ b/Makefile.tools
> > > > > @@ -538,7 +538,7 @@ endif
> > > > >  endif
> > > > >
> > > > >  if CUPS
> > > > > -cupsdir = $(libdir)/cups/backend
> > > > > +cupsdir = $(libexecdir)/cups/backend
> > > > >
> > > >
> > > > Is this true, can you provide some references?
> > > >
> > > > Looking at Debian [1] (which contrary to Arch has libexec) - backends
> > > > are in /usr/lib. Glancing at the cups backends makefile it's using
> > > > SERVERBIN. Casual grep shows that libexec can be applicable for
> > > > BSD/Darwin platforms [3], which are out of scope for bluez IIRC.
> > >
> > > on Gentoo you have:
> > >
> > > qlist net-print/cups | grep backend
> > > ...
> > > /usr/libexec/cups/backend/implicitclass
> > > /usr/libexec/cups/backend/beh
> > > /usr/libexec/cups/backend/serial
> > > /usr/libexec/cups/backend/parallel
> > > /usr/libexec/cups/backend/driverless-fax
> > > /usr/libexec/cups/backend/driverless
> > > /usr/libexec/cups/backend/cups-pdf
> > >
> > > but now I see this in Gentoo ebuild:
> > >         # Install in /usr/libexec always, instead of using /usr/lib/cups, as that
> > >         # makes more sense when facing multilib support.
> > >         sed -i -e 's:CUPS_SERVERBIN="$exec_prefix/lib/cups":CUPS_SERVERBIN="$exec_prefix/libexec/cups":g' configure ||die
> > >
> > >         econf "${myeconfargs[@]}"
> > >
> > >         sed -i -e "s:SERVERBIN.*:SERVERBIN = \"\$\(BUILDROOT\)${EPREFIX}/usr/libexec/cups\":" Makedefs || die
> > >         sed -i -e "s:#define CUPS_SERVERBIN.*:#define CUPS_SERVERBIN \"${EPREFIX}/usr/libexec/cups\":" config.h || die
> > >         sed -i -e "s:cups_serverbin=.*:cups_serverbin=\"${EPREFIX}/usr/libexec/cups\":" cups-config || die
> > >
> > > so it appears to be a Gentoo addition.
> > > Would perhaps
> > >   pkg-config cups --variable=cups_serverbin
> > > or
> > >   cups-config --serverbin
> > > be acceptable? If no we can just drop this and Gentoo will continue to patch bluez for cups
> > >
> >
> > Using the foo-config tools sounds better than the current hard-coded
> > behaviour. Patch that does that gets a big thumbs-up from me.
> > Personally I have slight inclination towards the pkg-config - although
> > it'll be up-to the maintainers.
>
> This is what I came up with:
>
> From c6776b205b8adbf6e2e29108a1a7ff348546a531 Mon Sep 17 00:00:00 2001
> From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> Date: Fri, 23 Feb 2024 12:56:21 +0100
> Subject: [PATCH] cups: Use pkg-config to find cups backend dir
>
> Some distributions(Gentoo) patch cups backend path to
> something else than libdir. Use pkg-config to find backend
> path for cups.
>
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> ---
>  Makefile.tools | 2 --
>  configure.ac   | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 044342e29..760727557 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -538,8 +538,6 @@ endif
>  endif
>
>  if CUPS
> -cupsdir = $(libdir)/cups/backend
> -
>  cups_PROGRAMS = profiles/cups/bluetooth
>
>  profiles_cups_bluetooth_SOURCES = profiles/cups/main.c \
> diff --git a/configure.ac b/configure.ac
> index bb6380f2f..6a7fefa1d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -242,6 +242,9 @@ AC_SUBST(UDEV_DIR, [${path_udevdir}])
>  AC_ARG_ENABLE(cups, AS_HELP_STRING([--disable-cups],
>                  [disable CUPS printer support]), [enable_cups=${enableval}])
>  AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
> +if (test "${enable_cups}" != "no"); then
> +   AC_SUBST(cupsdir, `$PKG_CONFIG cups --variable=cups_serverbin`/backend)
> +fi
>
>  AC_ARG_ENABLE(mesh, AS_HELP_STRING([--enable-mesh],
>                 [enable Mesh profile support]), [enable_mesh=${enableval}])

AFAICT the existing patterns is to use "AC_SUBST(FOOBARDIR, ...)" in
configure.ac and "foobardir = $(FOOBARDIR)" in the makefiles.

Thanks
Emil
