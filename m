Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDA1E4B7
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939277; cv=none; b=jOQpEI5s+VceQrUgyi+BdEhzPpz75WwPN8O2woucHz/OT3kOhOVttbV9OTIkgWiGtSDnwIlr02sWX8OEtMlq0/NZc620Xi2TOu3EdabvUPppaEpZah4sTkt4yZzSPHpNJpbHUdcBNfn8oCM1N4dX/h+jEeWP0wdRGZ5k9dKOw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939277; c=relaxed/simple;
	bh=+y2iUM+wMMUtr+Db+ZKmxvIr6vAkIzvIGXJxmCxc7Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es9N/PQUMFfBD33+u7jZCTVL+gp5U8DtNox6ctxcIocAdp9h/G4MeACL/MtzBPzlZp3VIdJhDAH/rn+F6XBYLadAOD+E+DahsD74UzYS4FYZiPid5GGdC3YA+edxs/U/r14V4maeURpT1OCi4l7yak/xzXzPDLK4bsVbcLMvjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAneh4sF; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAneh4sF"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0f1ec376bso659041fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939274; x=1708544074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBz6yJsMK2519bfC1wm+eoM+X9TCiMxrCZv9gIy8SME=;
        b=IAneh4sF6ZI1Nxn80wPJVSqLPi2CyTbGeDl79vqA5dDQYLQNrcXJkXMGgbgadDXewR
         QiX0JgGX4iUOmjI5PJ2fAncBbmuTNrgyDawZUEu2RMSHKYUFEKmjAJwwXqh97N1xPfuN
         1GOSmY7FH2M8g+GiDYoEthCEtb/EFVZCY6BoskECLrvpGCb41ZPzaWOPHJfKVY73FYzT
         KZR7VjEV8wVk2fbgA+rdGSyvQ0snUvRetCkXmoXDMtI8qmCudLrRf502SZW//eSO9C2g
         3T/+lvy9dGkOYM7BSrVRj22L9iuj5yp7uZcD/+jptGCGmJH43VfXfTb8oCtpUzZIzHc/
         97ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939274; x=1708544074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBz6yJsMK2519bfC1wm+eoM+X9TCiMxrCZv9gIy8SME=;
        b=C+wJHcBkzkvDk51TwZ4KxQBGiF04iNkVHzUwwbK3XYdhtbHRpVjTeB8wY2uqjVMLoG
         DeoekcPIcRngXlIf1g1Si+1M333rYIaKxGMa39nJHbfwXKLRPF/5QiSzKqPsQhzlcfqF
         pzyBHIOTQ7ZKLVqhBFzYp3djdnW82fqqGqYNN+hbbhgLzgdI3ISHpM1/n9UAF4jS9ZGq
         k5jeiUZPkqxEDXWXvQEdeNCyg620RPOXg5gPbqZkUlJt1GAgGVsyLDo/YVy4bF0AOqeY
         pS6oJPsRkLc6jRoHfqWajsZkKGX3jWVd8COkDiC88Vr1k5ssHu1ZFAs0O8PJjPDouLKp
         V68g==
X-Gm-Message-State: AOJu0Yxt+921+ISDJFe2HfwkCkO3grDOxE6kglfXHu74k5WGm4tPRMpl
	IRK58cAVhpgkusZvJ9/b5JQWjVwexvPr+vDb0Qu+MmvomS0W+M6vkblAyYff3SAqDBrEGbugoVC
	0Ekv1vChx+Ag7YcUWfo1gnqMy/QY=
X-Google-Smtp-Source: AGHT+IElFB6h7+EPWUOjeDhZnhlEKTW6vy+EToprUJ/rAAIyZ/lZeT9IfvAqyAfFe6j+XE5OGZEOxcTMNVBDwJWfP/8=
X-Received: by 2002:a05:651c:b2b:b0:2d0:ffda:c44c with SMTP id
 b43-20020a05651c0b2b00b002d0ffdac44cmr3236534ljr.5.1707939273624; Wed, 14 Feb
 2024 11:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACvgo50dSAw_L3uC7WST_+9ixMWLBdfVJc8cQNQNZ48dWdUijw@mail.gmail.com>
 <CABBYNZLrg=gYTuzB=u60_AJPSQ6YVs87u1s47fjD6v7S45M3GA@mail.gmail.com> <CACvgo519JTmp1B4pMGJzHyeVsKzBxyC9ODqq9SFmcxspEX7_yg@mail.gmail.com>
In-Reply-To: <CACvgo519JTmp1B4pMGJzHyeVsKzBxyC9ODqq9SFmcxspEX7_yg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Feb 2024 14:34:21 -0500
Message-ID: <CABBYNZLkJziPw-_pdmpHWzf9Xi3EcWsZ2SLiLo0PtctkqW92pg@mail.gmail.com>
Subject: Re: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Wed, Feb 14, 2024 at 2:15=E2=80=AFPM Emil Velikov <emil.l.velikov@gmail.=
com> wrote:
>
> On Wed, 14 Feb 2024 at 18:01, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Emil,
> >
> > On Wed, Feb 14, 2024 at 12:04=E2=80=AFPM Emil Velikov <emil.l.velikov@g=
mail.com> wrote:
> > >
> > > Hello Luiz,
> > >
> > > Due to a bug in the CI bot, I've scraped this off the ML. Hope it's
> > > not too badly formatted :-)
> > >
> > > > Here is the summary with links:
> > > >  - [BlueZ,v2,01/10] Return at least the title attribute from player=
_list_metadata()
> > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df2671bf=
8f951
> > > >  - [BlueZ,v2,02/10] adapter: Remove experimental flag for PowerStat=
e
> > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd3aeae7=
9de4b
> > > >  - [BlueZ,v2,03/10] test: consistently use /usr/bin/env python3 she=
bang
> > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd31f04a=
a928a
> > > >  - [BlueZ,v2,04/10] profiles: remove unused suspend-dummy.c
> > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1313351=
f7144
> > > >  - [BlueZ,v2,05/10] obex: remove unused syncevolution plugin
> > > >    (no matching commit)
> > > >  - [BlueZ,v2,06/10] obex: remove unused mas/messages-tracker impl
> > > >    (no matching commit)
> > > >  - [BlueZ,v2,07/10] obex: remove phonebook tracker backend
> > > >    (no matching commit)
> > > >  - [BlueZ,v2,08/10] build: ship all config files with --enable-data=
files
> > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dbe0e796=
299b0
> > > >  - [BlueZ,v2,09/10] obex: Use GLib helper function to manipulate pa=
ths
> > > >    (no matching commit)
> > > >  - [BlueZ,v2,10/10] Allow using obexd without systemd in the user s=
ession
> > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Db16b198=
85c53
> > >
> > > Massive thanks for applying the above.
> > >
> > > Out of curiosity: is there anything wrong with the few remaining ones=
?
> > > I had a look through the ML archives on lore.kernel.org as well as my
> > > inbox and could not find any replies.
> >
> > I don't think we should remove the syncevolution and tracker backends,
> > they shall probably be disabled first so we don't break platforms
> > still using them. As for the GLib helper I don't think that is really
> > needed, at least there doesn't seem to be a problem with current
> > handling.
> >
>
> Unless I am missing something, all four backends/implementations are
> effectively disabled and unused.
>
> Ignoring the first that you've merged already, the other three are
> syncevolution, messages-tracker, phonebook tracker. All of those obexd
> specific and have been practically dead code for approximately 6
> years. In particular ever since the obexd git repo was imported into
> bluez, they were never wired into the build system.

--with-phonebook=3Dtracker

It does seem to work, even though it doesn't track dependencies
particularly well:

obexd/plugins/phonebook-tracker.c:21:10: fatal error:
libtracker-sparql/tracker-sparql.h: No such file or directory
   21 | #include <libtracker-sparql/tracker-sparql.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

That said the message backends don't seem to have a similar backend
selection, not really where we drop support for it or it was never an
option for some reason, perhaps we can remove the messages backend
first, but afaik there was some support for syncevolution at least I
recall using it some ages ago to sync contacts with the phone, but I
guess things have changed quite a lot in the meantime and now everyone
sync directly with the Google Account, etc.

> In order to use them, one has to manually hack the bluez build system.
> Furthermore for people using the release tarball, the source files for
> syncevolution, messages-tracker are missing all together.
> Based on my archeology session - distributions (Fedora, Gentoo, Arch,
> Debian and OpenWRT at least) use the tarball and none of them change
> the build system to support/enable these.
>
> So I think they are pretty much safe to remove.
>
> Will have another look at the GLib helper and reply inline, with a
> specific example/failure mode.
>
> Thanks again o/
> Emil



--=20
Luiz Augusto von Dentz
