Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72C21517E
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999782; cv=none; b=jLkb0FUAy69jJYUpz6UU5fKfdlKaFncfOLheAwFUlYdZMv2V/JDnpuBBMn2YwCszyejwXIkvXheMflrbp0r5mnKPuomwHVaEuUF5KJj87429uQLyncDpo48qf4RuEAiN4XtMeXVzSBogz9pymGeaqFF9ixfD9mV05OSzS1ch8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999782; c=relaxed/simple;
	bh=oFYTD/FJgvZZDuA0VX7i1T4hOwZv4GVlqM7Y+kk5w8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSgVvsqoNn1ueZ4eEtjePqswZJxiHLpZkLqgv/6cm0ZyXPd1AFQg8U16GDPpsBWsrRidsfELq84sz35SOnnEE8OChVPxivt0MrPKfw4jos6Q2/x1o65qXobEEXUWLvnpVbWhVfj7rPKBiy/GQ/61MUkM8zY6/m32sGVqgukFR94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Shy1hi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Shy1hi"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so18630971fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744999779; x=1745604579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpSkW4zTTVuOa7Gql3Gq0kDAoGyWClAy4zbJ3v1cK20=;
        b=h7Shy1hiNdrVmgdIGxIoIagsOug4kSEY28Qoz45XizSEBVzv30nPBYgEvA1RjnlpsG
         QDRRd7coKeN1CjnrYIKVcuKJ2XJjNwY6oiiCYIeHPNB3CxRNcyedFAK9PSeAQ/ctu0Bv
         02iwuz+vzzxlZz/ZC7dNWqKI0xMYnN2MmiDQp1ZX30JSvhRR6o4lhqUuU/dykG+QEKrn
         sujpx0FfKuMZSP7Zodw4HYRlj4g4nLP/dO7RW4aZAnGqJQkcqKRk3F75yfyD+aZ8Y2UL
         agrByCbFr6uuMZdd5W6jr7emfm9O7OepckGWVetSGA48UuLO7vmngvuCKHf0LUtamuVY
         fwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744999779; x=1745604579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpSkW4zTTVuOa7Gql3Gq0kDAoGyWClAy4zbJ3v1cK20=;
        b=B5WiDTzQmK7FB0QeNI8SW8UUVtiDFk7Rc/4xK4a4t1a7pV7tY+osgGUlxcJTN52lct
         pTj97648Pi3fiNliywkTTf0wcb0OBvDH4ovT/uMAVL8XE2toA11yf49RufoERltddiA1
         D81krkL8r8W/nrvxfEUvtKX+FPvcxmQBdCtlfmud/6o7DFWEuAND5QMhxNrjUZyWRwSS
         qsqYfobgCOksyhcbjwUnVHBwlbba4C9v6yZJ9W7kDNoBaFgIoODCCcSzgV8il1tb8AFX
         DQJwgypepUEY+6U+f4NbI6TqC0MZHJYluMdzCzl6zCLdZcRUhQ5+fAwto0ayA1oavyBs
         vN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNogKcGArgP3cNkc4HmhFGS/cFr+oJyRTF9aSdmuee2vP7LUxHehuo0vyPFrD94SV9I8s2Dd00RScjyVFM/SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXU3yyf6g1na5fctrFsGuVprySj8R7AqB5c+YVtBjLd21YLrA
	Je2QHdRfLIfXBz2eNtnV9Q2Tp3XTxAwSao0UKyN/IG7EyWAZ+vE2v4UNSj3+T6gvCPsIff1Jvfj
	BayaitW6h/Y4tiJt/nj2HRRTgeAA=
X-Gm-Gg: ASbGnctafNjwFOYX3R2fiCxcGNjiTipxU773LrQL1mrlRm99WUSvISgcy7d1mG38kXJ
	NqbUsimPQ8fhs1YKdAjOuiQ0zEM1LZl0bP5eUxxDKutsT6cgA4i5pnUGLjAn7AajKgp1U+zDYa5
	6rJzgdlbgNLTBqI+EhzYke
X-Google-Smtp-Source: AGHT+IHA4ge3FV09VaFt1HkjzCQ0nHqkrnJsegQ1yikDQ8L7hSR3zx3h1i7UDeD+dr9UiwM4hXKd0lWvQD+x30sFb1U=
X-Received: by 2002:a05:651c:2120:b0:30b:f274:d1e2 with SMTP id
 38308e7fff4ca-310904c789cmr11632561fa.1.1744999778601; Fri, 18 Apr 2025
 11:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418153115.1714964-1-kernel.org@pileofstuff.org>
 <20250418153115.1714964-2-kernel.org@pileofstuff.org> <CABBYNZ+ig2=VWOwFQvkmZB4WebtY03C9AYktSXLmz6XZHXppMg@mail.gmail.com>
 <71a14d3e-7625-4414-9873-9105c991684d@pileofstuff.org> <29aef2f3132a7212a84294aa513200f9c0482e07.camel@iki.fi>
In-Reply-To: <29aef2f3132a7212a84294aa513200f9c0482e07.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 18 Apr 2025 14:09:26 -0400
X-Gm-Features: ATxdqUHA51ibCqljraM_s4uJVmsRys91b_bPUNgQBznFPIo5EDxfAKDZ7f_5CHQ
Message-ID: <CABBYNZ+aty-K_Y1hOMLVvQWqaDK5-7k38x+Jf7TfH64xc63tFQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] build: add bluez.tmpfiles
To: Pauli Virtanen <pav@iki.fi>
Cc: Andrew Sayers <kernel.org@pileofstuff.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Apr 18, 2025 at 1:26=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> pe, 2025-04-18 kello 17:40 +0100, Andrew Sayers kirjoitti:
> > On 18/04/2025 16:35, Luiz Augusto von Dentz wrote:
> > > Hi Andrew,
> > >
> > > On Fri, Apr 18, 2025 at 11:31=E2=80=AFAM Andrew Sayers
> > > <kernel.org@pileofstuff.org> wrote:
> > > > Systemd tmpfiles ensure the status of particular files.
> > > > Add a file that bluez can use in future.
> > > >
> > > > Distributors should install the new "tools/bluez.tmpfiles" file, e.=
g. by
> > > > moving it to `debian/bluez.tmpfile` or using Fedora's `%{_tmpfilesd=
ir}`
> > > > variable.
> > > I thought we would not be adding this anymore with the addition to '-=
'
> > > prefix and the added comments that should be left to distros to figur=
e
> > > it out.
> >
> > Ah sorry, I thought you meant to add the comment *instead of* the '-'.
> > Leaving it to distro's feels a bit dangerous, but Pauli Virtanen's idea
> > seems like a better approach anyway (thanks Pauli!).
> >
> > I'll take a look at that and should be back with a v3 next week.
>
> Note though that the seat state monitoring also has some drawbacks,
> e.g. ssh logins are not considered "active" so for headless / system-
> wide obexd configurations you'd probably want some command-line or
> configuration option to disable the feature.

I wonder if it wouldn't make sense to add seat options directly into
the systemd service file so it does the monitoring by itself rather
than each component having to do it on its own.

> > > > Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> > > > ---
> > > >   .gitignore              | 1 +
> > > >   configure.ac            | 1 +
> > > >   tools/bluez.tmpfiles.in | 0
> > > >   3 files changed, 2 insertions(+)
> > > >   create mode 100644 tools/bluez.tmpfiles.in
> > > >
> > > > diff --git a/.gitignore b/.gitignore
> > > > index 108c3b820..e4431443f 100644
> > > > --- a/.gitignore
> > > > +++ b/.gitignore
> > > > @@ -157,6 +157,7 @@ obexd/src/obex.service
> > > >   obexd/src/org.bluez.obex.service
> > > >   tools/obex-client-tool
> > > >   tools/obex-server-tool
> > > > +tools/bluez.tmpfiles
> > > >   unit/test-gobex
> > > >   unit/test-gobex-apparam
> > > >   unit/test-gobex-header
> > > > diff --git a/configure.ac b/configure.ac
> > > > index 1e089aaa7..4ebd513d6 100644
> > > > --- a/configure.ac
> > > > +++ b/configure.ac
> > > > @@ -530,5 +530,6 @@ AC_CONFIG_FILES(
> > > >          src/bluetooth.service
> > > >          tools/bluetooth-logger.service
> > > >          tools/mpris-proxy.service
> > > > +       tools/bluez.tmpfiles
> > > >   )
> > > >   AC_OUTPUT
> > > > diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
> > > > new file mode 100644
> > > > index 000000000..e69de29bb
> > > > --
> > > > 2.49.0
> > > >
> > > >
> > >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
