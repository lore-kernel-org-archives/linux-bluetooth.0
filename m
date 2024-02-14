Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308C55C1A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952937; cv=none; b=QvVHyZoGwc3p0T/s3LF2ITlnmR7IzNDVdRGOYh46okkQ4BVeZjnV5WOh/cB0lTXjgWB4JT/gYAMPcmRTDOHuynnDpiQ6rW953f3ZAaVU0F4DpszIUC+Ns/voPSL0T3krIPOEqnSoc4GkOPvtHB6i6yqANe3QmuS7JRLeWST03RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952937; c=relaxed/simple;
	bh=THd28p1YjBVUA6LfnWNhKdVWnEz/nEtwTdG4xhG5hj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ce9tA5IEO+ymj31yMS+QIPkKGN1qlmbzKeLZH4PIGeUWjz+Rc/Oo9NHGTY/yb84wxIYghr1l1pOTFJR9KejWi984HL3GbY6ppOzpQjuU9BmnRs3kFg4gqddmV7e3iHlWZmSgUIi04UqbFHCcwfKjtYS8TSLMOYX5jlVMHYczre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeZrIGIW; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeZrIGIW"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db3a09e96daso201210276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707952935; x=1708557735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys/nQ0ha61bwGy1dbtJbhp1Rpp2I03YYi/QebgHNd60=;
        b=LeZrIGIWIsF+Fhqwvl7biYpY3K5jhQN7w72eVsbAR4gZP1N0cE1utjc+Uyc0slsv1P
         ymONnqEbEieMk8tEG8MaC7FNo3Bua3HuNUkpEPPS0y+KOL+SIKIoezwYlhcvt9HudXEZ
         h47gvlbrai38ueeMkKqsDPYxTCZL1F8mnVTHmT3wbRRk6EliTVZl+E5ZqK9VTxIVxwJQ
         1XJnjny7ayBuIfsP/DK85xaTFIVjjjnDlBCtcglWx4wKUIPiv8u0gxw10PDgJ6OYCeCL
         TriveaxFbWxo8tIuEZ88XPHNuY8LPMnhq/4pAySzEUG6ah+svz5EZbNp764l9aqqV90k
         DB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952935; x=1708557735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys/nQ0ha61bwGy1dbtJbhp1Rpp2I03YYi/QebgHNd60=;
        b=bZvDCGeJ/j/wuqtP3yQx9h9Ah29gt+tBHU8vi5ldruEUrKfH7PAd0u4MQY117UYuc/
         WqPGJU1tH244sU/x9fai5NuBA80UyRF9odj+wnTpTI7QEeJYMR1TGfntEdkzjrvdJppk
         qCjAPIevvNkXwsrvjcNPpeQr8bWIyUhkLKBbTOrj6IiUXcAnUt5mj0mAECptMoI/o5Y4
         KP+GE+MmZZE0OH+KadtCzgibb1X4whTb1DKY3iT5GTvTOVDD2UcchyZ4H/6unnImvVlS
         KajnMLFvEYjO0a1JHf91eF1kB9gLe6SHUSTakFk5eiEkY303mC1vXtT0T0Rt+WKxYqJy
         0qSg==
X-Gm-Message-State: AOJu0YxCkhCA7zkBm0c8tESckUUXOeMF1UtoQDPA4+32fFLEwrGoDbKr
	U9Fbd/oor2u/6Rkaxts6v4+JsaXbIw/h9tuyCYKItLRzETlGOF6DM9JVtbjHhb2zsCFKLJUZtSl
	iXnNmjybNn9Zw5UApYmqtVm4FX4w=
X-Google-Smtp-Source: AGHT+IGrJccDEE58jFXKPh3t9HpsOiqGAlEDGuzeP6No5NwlIe+k/aFFnTIqKF3VsEMLBS0ZWQuYcAW/yayEc/GISBM=
X-Received: by 2002:a25:d68b:0:b0:dc6:aed5:718a with SMTP id
 n133-20020a25d68b000000b00dc6aed5718amr16884ybg.26.1707952935253; Wed, 14 Feb
 2024 15:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
 <20240214-hook-fixup-v1-1-0e158ffea140@gmail.com> <CABBYNZJE6h9MKo8Eyh9SNyYWBSH9Kq6q5o3bcH-wEb41QXaAvw@mail.gmail.com>
In-Reply-To: <CABBYNZJE6h9MKo8Eyh9SNyYWBSH9Kq6q5o3bcH-wEb41QXaAvw@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Feb 2024 23:22:03 +0000
Message-ID: <CACvgo53n2Xz-O3zo_45gfsgi5Z4kKVpYQ7jtiZX5agoZXOy7Lg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] build: fold separate install-data-hooks
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, 14 Feb 2024 at 22:23, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Emil,
>
> On Wed, Feb 14, 2024 at 5:02=E2=80=AFPM Emil Velikov via B4 Relay
> <devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
> >
> > From: Emil Velikov <emil.l.velikov@gmail.com>
> >
> > Autoconfigure throws a useful error, that I've missed previously. As-is
> > with two identical hooks `make install` will fail.
> >
> > Just fold them into single place - not particularly pretty but works.
> >
> > Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> > ---
> >  Makefile.am    | 9 +++++++++
> >  Makefile.obexd | 6 ------
> >  2 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 5207c172b..e67551761 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -34,6 +34,15 @@ statedir =3D $(localstatedir)/lib/bluetooth
> >  install-data-hook:
> >         install -dm555 $(DESTDIR)$(confdir)
> >         install -dm700 $(DESTDIR)$(statedir)
> > +if OBEX
> > +if SYSTEMD
> > +       $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-o=
rg.bluez.obex.service
> > +
> > +uninstall-hook:
> > +       rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.serv=
ice
> > +endif
> > +endif
> > +
> >  if DATAFILES
> >  dbusdir =3D $(DBUS_CONFDIR)/dbus-1/system.d
> > diff --git a/Makefile.obexd b/Makefile.obexd
> > index 81456544d..b91ca6644 100644
> > --- a/Makefile.obexd
> > +++ b/Makefile.obexd
> > @@ -2,12 +2,6 @@
> >  if SYSTEMD
> >  systemduserunitdir =3D $(SYSTEMD_USERUNITDIR)
> >  systemduserunit_DATA =3D obexd/src/obex.service
> > -
> > -install-data-hook:
> > -       $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-o=
rg.bluez.obex.service
> > -
> > -uninstall-hook:
> > -       rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.serv=
ice
> >  endif
>
> Hmm, isn't it possible to do target specific install hooks?
>

Good point - will have a try tomorrow/day after.
Hopefully we will be able to keep the obex specifics in Makefile.obex
without adding too many new if blocks.

Thanks
Emil
