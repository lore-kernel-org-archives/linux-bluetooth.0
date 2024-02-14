Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E01DDD1
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946275; cv=none; b=pd/T511Xf+eMZ1So8Gy1zZtnyuEHki+l321w2I8Fg6G399odmH7V8Fi1m9CpIFnYvWKcJAAXHMuOCikeJU15UVmbwRYA9Pxj8xoWJ9vLfxMMVeGIum6zDYcO/SKon4Dnabz5FjqWLOipMnq3poCWS7ii2W3WE8q2hvMBOiu3fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946275; c=relaxed/simple;
	bh=Gy+OGNTCx3H1idd5FB3l+q7sWQJVI8n/OJ9S2WHm644=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie8v/4ZjKkPK6X26tifxjjv67enbL78Kac02PRJBn8dmHbgqVls7itFUhG1cXQCmSerJLia9XkBAn9rSLGa33HBQPN67m5WTD+zTCEpHxOTm3gb46CWVbo+HSg1V5/dgaJBawE3RmtlulgPfrPX24gJHW5WcsaXFc3ayzzJj3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGtMT7OC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGtMT7OC"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d09cf00214so2497651fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707946271; x=1708551071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csM9axeDLOPQLVR+5CPb4QOrx/yIBFftgAYOqNInFp8=;
        b=CGtMT7OCjL42c+W+TdgRQyaBZ5bgZ6Htssd+kW01HdlmL9wRP7ceOP0U1w+KLF60Jg
         6VMmR/KIMWFF5YJPTVdtca8KNMsupO4XTPSFzo/SvXZRpzEuq6pqMNRq5Y0MwaOXbnt6
         qBgGYp3PlS+MApG0DJXPCYrOewqITObkR/3XJqFyX7Ct8qTSd5yKY3e4M31fl2zxaZ+b
         5e9/DbH5lEDty19hh1Y1baC9P5ZycMfiCUV5bNzwFO7czNwzlyDDk1JNSW8fm3Erc7Gb
         /FXOsXKCwueSUmQzA09mas7UI0EJySNBw9R+fR9bvP9LrWhp51OH60SYurd9lgP6j4B5
         4N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946271; x=1708551071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csM9axeDLOPQLVR+5CPb4QOrx/yIBFftgAYOqNInFp8=;
        b=d6fyfilh0yunHPO859jYJljUsa3lZF5oA8AcLnCwNcx4k45vJR1JD+fEC5zKDa1heM
         7ebYET3VrQe1480WWExdXzUJpP3Y3MNeMG32tXK/iEC3NpA+oX/EDlm5TKAcdhZKdJdz
         2UVFePIaAPyic1oTj6L1HTV9fPVqh1u4NdJfEZEhA9XvokNv6nk+/HjrmRQFfmKOU7mf
         Xyf7UTLbZSfviOvlgCBH39gkAHFurO67Lfqe7Q0BliRaGxyNVYfpSrMi+bF44U1KkwO9
         Z3C4LGvDZEWFUSgAdmh36T0L/+yduD6f30TDT4QABEafD3s70eGoy3OfugeCVEwmZjJd
         Zk8g==
X-Gm-Message-State: AOJu0YzyN5qT+C/8SRtckgbUdj2WHKperqnHj0c4QV2ucgdy0Faba1v1
	PDuFpQWFMqVmCN2qQaPyENofW0qhsDxZcRZKsr+ijf5lZ2zq/gtm0lQsDl+BL1IzAqSzgZAgxSo
	2xjWtVDMOuu60mg+4ve/z1iaszlg=
X-Google-Smtp-Source: AGHT+IHZ/Pb/ndqiajSs64y/Op0x0P3A4IWvTX5vQ2v219jNd2Ogfj95h2jFg7EfiEwsgqK7LRSuaqrmqI6mpg0NoYI=
X-Received: by 2002:a2e:9891:0:b0:2d1:1d7d:9e51 with SMTP id
 b17-20020a2e9891000000b002d11d7d9e51mr1826347ljj.11.1707946271181; Wed, 14
 Feb 2024 13:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACvgo50dSAw_L3uC7WST_+9ixMWLBdfVJc8cQNQNZ48dWdUijw@mail.gmail.com>
 <CABBYNZLrg=gYTuzB=u60_AJPSQ6YVs87u1s47fjD6v7S45M3GA@mail.gmail.com>
 <CACvgo519JTmp1B4pMGJzHyeVsKzBxyC9ODqq9SFmcxspEX7_yg@mail.gmail.com>
 <CABBYNZLkJziPw-_pdmpHWzf9Xi3EcWsZ2SLiLo0PtctkqW92pg@mail.gmail.com> <CACvgo52uHwf-0UZbdNWukAvjnNFTvrYTY=f4Yx1raYQjmVyUzQ@mail.gmail.com>
In-Reply-To: <CACvgo52uHwf-0UZbdNWukAvjnNFTvrYTY=f4Yx1raYQjmVyUzQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Feb 2024 16:30:58 -0500
Message-ID: <CABBYNZLe6R0T90SkOqVyBpwO4p0ZgeR0=jyBtyAcoQvKX9YwWQ@mail.gmail.com>
Subject: Re: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Wed, Feb 14, 2024 at 3:48=E2=80=AFPM Emil Velikov <emil.l.velikov@gmail.=
com> wrote:
>
> Hi Luiz,
>
> On Wed, 14 Feb 2024 at 19:34, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Emil,
> >
> > On Wed, Feb 14, 2024 at 2:15=E2=80=AFPM Emil Velikov <emil.l.velikov@gm=
ail.com> wrote:
> > >
> > > On Wed, 14 Feb 2024 at 18:01, Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Emil,
> > > >
> > > > On Wed, Feb 14, 2024 at 12:04=E2=80=AFPM Emil Velikov <emil.l.velik=
ov@gmail.com> wrote:
> > > > >
> > > > > Hello Luiz,
> > > > >
> > > > > Due to a bug in the CI bot, I've scraped this off the ML. Hope it=
's
> > > > > not too badly formatted :-)
> > > > >
> > > > > > Here is the summary with links:
> > > > > >  - [BlueZ,v2,01/10] Return at least the title attribute from pl=
ayer_list_metadata()
> > > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df26=
71bf8f951
> > > > > >  - [BlueZ,v2,02/10] adapter: Remove experimental flag for Power=
State
> > > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd3a=
eae79de4b
> > > > > >  - [BlueZ,v2,03/10] test: consistently use /usr/bin/env python3=
 shebang
> > > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd31=
f04aa928a
> > > > > >  - [BlueZ,v2,04/10] profiles: remove unused suspend-dummy.c
> > > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D131=
3351f7144
> > > > > >  - [BlueZ,v2,05/10] obex: remove unused syncevolution plugin
> > > > > >    (no matching commit)
> > > > > >  - [BlueZ,v2,06/10] obex: remove unused mas/messages-tracker im=
pl
> > > > > >    (no matching commit)
> > > > > >  - [BlueZ,v2,07/10] obex: remove phonebook tracker backend
> > > > > >    (no matching commit)
> > > > > >  - [BlueZ,v2,08/10] build: ship all config files with --enable-=
datafiles
> > > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dbe0=
e796299b0
> > > > > >  - [BlueZ,v2,09/10] obex: Use GLib helper function to manipulat=
e paths
> > > > > >    (no matching commit)
> > > > > >  - [BlueZ,v2,10/10] Allow using obexd without systemd in the us=
er session
> > > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Db16=
b19885c53
> > > > >
> > > > > Massive thanks for applying the above.
> > > > >
> > > > > Out of curiosity: is there anything wrong with the few remaining =
ones?
> > > > > I had a look through the ML archives on lore.kernel.org as well a=
s my
> > > > > inbox and could not find any replies.
> > > >
> > > > I don't think we should remove the syncevolution and tracker backen=
ds,
> > > > they shall probably be disabled first so we don't break platforms
> > > > still using them. As for the GLib helper I don't think that is real=
ly
> > > > needed, at least there doesn't seem to be a problem with current
> > > > handling.
> > > >
> > >
> > > Unless I am missing something, all four backends/implementations are
> > > effectively disabled and unused.
> > >
> > > Ignoring the first that you've merged already, the other three are
> > > syncevolution, messages-tracker, phonebook tracker. All of those obex=
d
> > > specific and have been practically dead code for approximately 6
> > > years. In particular ever since the obexd git repo was imported into
> > > bluez, they were never wired into the build system.
> >
> > --with-phonebook=3Dtracker
> >
> > It does seem to work,
>
> I think you meant to say s/work/is allowed/ :-) Commit "obex: remove
> phonebook tracker backend" bans this as an option.

Hmm, I don't have anything like that on git log, do you have the actual has=
h?

> > even though it doesn't track dependencies
> > particularly well:
> >
> > obexd/plugins/phonebook-tracker.c:21:10: fatal error:
> > libtracker-sparql/tracker-sparql.h: No such file or directory
> >    21 | #include <libtracker-sparql/tracker-sparql.h>
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
>
> In order to get past this, a small hack as mentioned previously is
> needed. While-space might be off:
>
> ---
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 81456544d..2e954c92e 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -88,6 +88,7 @@ obexd_src_obexd_LDADD =3D lib/libbluetooth-internal.la =
\
>              gdbus/libgdbus-internal.la \
>              src/libshared-glib.la \
>              $(ICAL_LIBS) $(DBUS_LIBS) $(LIBEBOOK_LIBS) \
> +            $(TRAK_LIBS) \
>              $(LIBEDATASERVER_LIBS) $(GLIB_LIBS) -ldl
>
>  if EXTERNAL_PLUGINS
> @@ -95,6 +96,7 @@ obexd_src_obexd_LDFLAGS =3D $(AM_LDFLAGS) -Wl,--export-=
dynamic
>  endif
>
>  obexd_src_obexd_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS=
) \
> +               $(TRAK_CFLAGS) \
>                  $(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
>                  -DPLUGINDIR=3D\""$(obex_plugindir)"\" \
>                  -D_FILE_OFFSET_BITS=3D64 \
> diff --git a/configure.ac b/configure.ac
> index 05c76dddb..38853476f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -449,6 +449,7 @@ if (test "${plugin_phonebook}" =3D "ebook"); then
>      PKG_CHECK_MODULES(LIBEBOOK, libebook-1.2 >=3D 3.3)
>      PKG_CHECK_MODULES(LIBEDATESERVER, libedataserver-1.2 >=3D 3.3)
>  fi
> +PKG_CHECK_MODULES(TRAK, tracker-sparql-3.0)
>  AC_SUBST(PLUGIN_PHONEBOOK, [${plugin_phonebook}])
>
>  AC_CONFIG_FILES(
> ---
>
> Getting past that, one gets over a dozen errors. The most indicative
> of which being:
> error: implicit declaration of function =E2=80=98tracker_sparql_connectio=
n_get_direct'
>
> Looking around shows that the API is from the tracker-1 days, where
> the last ones in that series 1.10.6 [1] and 1.12.4 [2]. Both of which
> released some 6 years ago. Looking at Debian Buster aka
> oldoldstable[3], it does not have tracker-1 [4].
>
> Honestly I am struggling to see how this can be built on any remotely
> recent distribution, even with the build snippet/hack above.
>
> [1] https://gitlab.gnome.org/GNOME/tracker/-/tags/1.10.6
> [2] https://gitlab.gnome.org/GNOME/tracker/-/tags/1.12.4
> [3] https://wiki.debian.org/DebianOldOldStable
> [4] https://packages.debian.org/search?suite=3Dbuster&keywords=3Dtracker
>
>
>
> > That said the message backends don't seem to have a similar backend
> > selection, not really where we drop support for it or it was never an
> > option for some reason, perhaps we can remove the messages backend
> > first, but afaik there was some support for syncevolution at least I
> > recall using it some ages ago to sync contacts with the phone, but I
> > guess things have changed quite a lot in the meantime and now everyone
> > sync directly with the Google Account, etc.
> >
>
> Digging a bit into this shows that each of those had an option within
> the original obexd repo [5]. Seemingly these were lost (or never
> ported if you will) when the obexd repo was "git filter-branch"
> imported into bluez.
>
> [5] https://git.kernel.org/pub/scm/bluetooth/obexd.git/tree/configure.ac
>
>
> I cannot find any Linux distribution that has built them over the last
> ~5 years, that has built those.
>
> The fact that loudly nobody complained for years, means that we can
> `git rm` them.
> There is nothing stopping the developer of tomorrow from "git revert",
> fixing the build and properly testing.
>
> Does that make sense?

For messages I guess you are right, we can just remove them since they
were never really used, but at least the phonebook-ebook was used at
some point, so perhaps we just switch to use it by default, so we can
remove the backend options, etc.


--=20
Luiz Augusto von Dentz
