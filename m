Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7BF1642C
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686582; cv=none; b=nuyGUlZp2g7j4mEnV56EOuZXfA2zuc8qW6qfO9+ovF+mCizU+itRt/wLjcY0GMLAiSB5FJEzwlP8Fvqdwg6xF9nZwDp5FSq+VWqQzVL6URV5I7Xqx7AlUEnWawZmEeMt9TlX0D/O9ujgXHUoL2+HDELmQXkK9k4fwDWJFdBtQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686582; c=relaxed/simple;
	bh=d0xl5bwWtDcme+EwGue/DINCbOXC0VhhRz7Mhfzpn3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dajVHFvTHGIr7g7Gl9GIx5dnHnx8rnSQBqG3aCIsoYwvD93h4xrojTrCzdGf2GQB/JG8DtOXzqh6ZqqG/GLFKk5+8TgClg+dTqszpR50EYmTF+TtIOJadFD7L0xELXfm6CdEDpwy0QhvHBPu0BVh3Gj7XvKgy2+6GxjDNc6zobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEv2q/d4; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEv2q/d4"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso654006276.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708686580; x=1709291380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcICJGzgbLWy9m0CXJdNveAkuvxF3jNkBgSoz2brhkM=;
        b=IEv2q/d43s1+/durJi4H3bINWowZIiA4WavsrbvWZPa3rp8r0Ah1Z9jjpwEhgQqFk6
         2ICAb1QDy0TI0uGNCqkB+T6ipSzq+bmyhPYrvJQapB/3Na2UPnKrmgij5PvUecyahpIJ
         +LJCau5pr+y/n/0EsmiyB692vOiDxbTgSfCzJPKIlFdaxnPAMaSHXaPnCLxrq5n0dfdr
         jaOLgdRP+vyKwa8W2MIfncZX3Dil+6GAr66mBkC160OkJGdUNVAaMidwqgoSgeAzYJDY
         KZP+JgWIS4UtmEJOAvwgLSSnCNAE1paIAmOO8X/RAsrE9L6W3m5lNEU8w87zAbzSGwFR
         5lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708686580; x=1709291380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcICJGzgbLWy9m0CXJdNveAkuvxF3jNkBgSoz2brhkM=;
        b=p5LYDACJQAtkmgHlJ88QXOgRzoFj5zdrmtzP6Bc5ErphZY07E3mN9QfQrkFjBqabsq
         rMHt1FSfNqWZEXOyutkFaxZYlKAxuGT5VB7tWmMcseeTMgZp7RJfpTSxSBZiAxihOXHq
         xwYwApBl7zZw/KgWjDyRjRPDyQDQNVUJPmbEk//K1rdbgkOIHDcZHUfybW3HBkABctCN
         hw7mNfnXQmshTFkFI11X1Dd/ECAAUKCrYi2LpxHoSnQ9B3LVrM1WqczpcnUapFsftD8P
         cb0q/GIiCDhUlhsAw8wj1SfWP/PRA1IHoN+viopNobWw5LaBTurWMFAVIZxMicfOsNuj
         OxWQ==
X-Gm-Message-State: AOJu0YzQ8F6xCrAxq3FBNbBuxMwUIYKEwyj7dRj/6+zENGLBl2J8GsSU
	zjzJL6nh5g/4NjQtwZ0iNOL1jtR5B0c4+9HhBGowu/McNJ7dWwvx90OVbBtkW8ZrfRrf3os0/+r
	JD6SatK7t26+OXLU7gVOl2koWGYA=
X-Google-Smtp-Source: AGHT+IGRh3YQARmmivtRb2a1wliB4pqxfau+PANBYXAWnOI1WwUmtjjay020CLSA1p+fZn4953p9R6vEW0OedxQs/WI=
X-Received: by 2002:a25:7909:0:b0:dc2:2895:6c79 with SMTP id
 u9-20020a257909000000b00dc228956c79mr1649674ybc.23.1708686579699; Fri, 23 Feb
 2024 03:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
 <20240221111901.2807853-2-joakim.tjernlund@infinera.com> <CACvgo52M-Efhp92u=fd8qDjV39SWvuoakLgt2JtFftDmZ2pn4g@mail.gmail.com>
 <4fdde6807ed152d0d24e086fd3357b7c4e410391.camel@infinera.com>
In-Reply-To: <4fdde6807ed152d0d24e086fd3357b7c4e410391.camel@infinera.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 23 Feb 2024 11:09:27 +0000
Message-ID: <CACvgo51GX0e5hHzVSD1AEMOLU8hiaDpE0R9su+jjN0mw5HaSBw@mail.gmail.com>
Subject: Re: [PATCH] CUPS lives in libexecdir
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 13:22, Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> On Thu, 2024-02-22 at 13:06 +0000, Emil Velikov wrote:
> > On Wed, 21 Feb 2024 at 11:19, Joakim Tjernlund
> > <joakim.tjernlund@infinera.com> wrote:
> > >
> > > From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > >
> > > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> > > ---
> > >  Makefile.tools | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile.tools b/Makefile.tools
> > > index 044342e29..b785ebea8 100644
> > > --- a/Makefile.tools
> > > +++ b/Makefile.tools
> > > @@ -538,7 +538,7 @@ endif
> > >  endif
> > >
> > >  if CUPS
> > > -cupsdir = $(libdir)/cups/backend
> > > +cupsdir = $(libexecdir)/cups/backend
> > >
> >
> > Is this true, can you provide some references?
> >
> > Looking at Debian [1] (which contrary to Arch has libexec) - backends
> > are in /usr/lib. Glancing at the cups backends makefile it's using
> > SERVERBIN. Casual grep shows that libexec can be applicable for
> > BSD/Darwin platforms [3], which are out of scope for bluez IIRC.
>
> on Gentoo you have:
>
> qlist net-print/cups | grep backend
> ...
> /usr/libexec/cups/backend/implicitclass
> /usr/libexec/cups/backend/beh
> /usr/libexec/cups/backend/serial
> /usr/libexec/cups/backend/parallel
> /usr/libexec/cups/backend/driverless-fax
> /usr/libexec/cups/backend/driverless
> /usr/libexec/cups/backend/cups-pdf
>
> but now I see this in Gentoo ebuild:
>         # Install in /usr/libexec always, instead of using /usr/lib/cups, as that
>         # makes more sense when facing multilib support.
>         sed -i -e 's:CUPS_SERVERBIN="$exec_prefix/lib/cups":CUPS_SERVERBIN="$exec_prefix/libexec/cups":g' configure ||die
>
>         econf "${myeconfargs[@]}"
>
>         sed -i -e "s:SERVERBIN.*:SERVERBIN = \"\$\(BUILDROOT\)${EPREFIX}/usr/libexec/cups\":" Makedefs || die
>         sed -i -e "s:#define CUPS_SERVERBIN.*:#define CUPS_SERVERBIN \"${EPREFIX}/usr/libexec/cups\":" config.h || die
>         sed -i -e "s:cups_serverbin=.*:cups_serverbin=\"${EPREFIX}/usr/libexec/cups\":" cups-config || die
>
> so it appears to be a Gentoo addition.
> Would perhaps
>   pkg-config cups --variable=cups_serverbin
> or
>   cups-config --serverbin
> be acceptable? If no we can just drop this and Gentoo will continue to patch bluez for cups
>

Using the foo-config tools sounds better than the current hard-coded
behaviour. Patch that does that gets a big thumbs-up from me.
Personally I have slight inclination towards the pkg-config - although
it'll be up-to the maintainers.

Aside: It'll be great if the Gentoo team probably propose their cups
change upstream - either as the default or opt-in behaviour.

HTH
Emil
