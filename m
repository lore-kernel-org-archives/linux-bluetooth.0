Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B241B7E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943708; cv=none; b=SDiuiiFFcy6d5cI3lvtpBoFURi8DfybCvpyqpyc9giCAwdB2nHDX3ou6hsy0JEPF7H+LqF6UkQF9PhNn3RHIfVyrwGFAAnOp/h2NY6rnhyPnuPofYC3+ZajgecLVGcJRlVIXiOGaUy3zO5l4O2X92cVRH/ZXiFYBz0hRDDlrkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943708; c=relaxed/simple;
	bh=FAz7DiaR2e/W3SkfuBKBsYFHzqLHkgJO3jD2EkQ/59A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2/eXiYeb7Jx0A9/UcI9ykd4xQGhj6QlOKuY+HsHJ3j0qs+ROH2xuo+GxrMct3ZylQmOYhcq+jy6MSHG2btATr63tqOUlWk8DeLAQUim7hj485Sc5McYDjJ9L0W8nPU//+AO/gXEM58XyOfQMCdhz4qHcP+tYAYxPHcyc3q4Jjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldTXy3Ck; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldTXy3Ck"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed0710c74so100683276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707943706; x=1708548506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHMi3tmT8R8nkUY50hY6z4Q5ehZ5mvsi+ww2+GbgJiQ=;
        b=ldTXy3CkF8T2cVRM1TDTAoPq6Ne7jHgSBNCFS/rOJnnO5o4wycTQX6wHuGDE+x+y6v
         vrs1KscCXAgnNEOhjiiduz2DjcoiKxf7LlkVYhel0rUdkw/dcMNgneLoiAm1BiC/FhzI
         Dp49OOgMs1TQd56vtRSRAvMsWlMVQq1VtUmDeePAHW7ouX+Y6uIYbJDogJemiRNT7Qeo
         gi4A3ULkzdaVJVqf0gQSO8VpvM2I8ZWCtlJIbyCmnMpIVhn7XuWZBUZ7m8w/wpd5Y2BI
         g14j5k7ZRKb35giHf12+IUrBVbD3nsucQR1DtdVeZpVP/pE8q381HulertzIFW66yKA0
         PDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707943706; x=1708548506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHMi3tmT8R8nkUY50hY6z4Q5ehZ5mvsi+ww2+GbgJiQ=;
        b=AiYyDJgcsfYWy/iilmmQL3F/H7alAXdC3kKMPmsSmvR3U/ZL4ajCvWst+oGGB1ZtdK
         3p7nX+ualZs/FpxDRJO032OHP/NZ8RcWT/+Fplj31sJo7tAZtEs8ZgXc1XoUf5RMjpb7
         fLdXYGrARmN0cSUYwQqhyHmgwRaMmRBanY8bUjvCXBhpBJdkgdBbzp5buyvMIrX5bcZk
         f71YR1Z4apdwDQN8PtTXxdZWEdx5KaNJP49RzyDHb7XXFlvAuQQqKr800h+CX93OEICd
         bU71sf3gZ73z4/HFBJdPeT4x/7V08/1I6sIFWQE/aX4YGxq4RfmAS3/btcR78u/4bGWi
         jBNw==
X-Gm-Message-State: AOJu0YyFsZl9Lvt06WNcu7wXAp8ZL5SRC4Kn6sw/Zy33TqDB9+g2ZWxr
	cXBWb49OJS++jDaL4vgsdsfrl/p47RKiB1wE+kAdtH5Qmc+EHXGurbzz2Fl7ht7kElrtcGx35Ex
	xEtSQL/2Vk5YFytDzScnkvc5VMWo=
X-Google-Smtp-Source: AGHT+IEgr3Iv9q5TL32wWErcdUk8G9dcqZYAXRoTVyJzZT9Wn0w1dwoqVwwzxtK8mxHCrdaoCHPeqZFO7dsjQHAaU0Q=
X-Received: by 2002:a25:ae8b:0:b0:dc6:d457:ac92 with SMTP id
 b11-20020a25ae8b000000b00dc6d457ac92mr3668911ybj.31.1707943705997; Wed, 14
 Feb 2024 12:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACvgo50dSAw_L3uC7WST_+9ixMWLBdfVJc8cQNQNZ48dWdUijw@mail.gmail.com>
 <CABBYNZLrg=gYTuzB=u60_AJPSQ6YVs87u1s47fjD6v7S45M3GA@mail.gmail.com>
 <CACvgo519JTmp1B4pMGJzHyeVsKzBxyC9ODqq9SFmcxspEX7_yg@mail.gmail.com> <CABBYNZLkJziPw-_pdmpHWzf9Xi3EcWsZ2SLiLo0PtctkqW92pg@mail.gmail.com>
In-Reply-To: <CABBYNZLkJziPw-_pdmpHWzf9Xi3EcWsZ2SLiLo0PtctkqW92pg@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Feb 2024 20:48:14 +0000
Message-ID: <CACvgo52uHwf-0UZbdNWukAvjnNFTvrYTY=f4Yx1raYQjmVyUzQ@mail.gmail.com>
Subject: Re: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, 14 Feb 2024 at 19:34, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Emil,
>
> On Wed, Feb 14, 2024 at 2:15=E2=80=AFPM Emil Velikov <emil.l.velikov@gmai=
l.com> wrote:
> >
> > On Wed, 14 Feb 2024 at 18:01, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Emil,
> > >
> > > On Wed, Feb 14, 2024 at 12:04=E2=80=AFPM Emil Velikov <emil.l.velikov=
@gmail.com> wrote:
> > > >
> > > > Hello Luiz,
> > > >
> > > > Due to a bug in the CI bot, I've scraped this off the ML. Hope it's
> > > > not too badly formatted :-)
> > > >
> > > > > Here is the summary with links:
> > > > >  - [BlueZ,v2,01/10] Return at least the title attribute from play=
er_list_metadata()
> > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df2671=
bf8f951
> > > > >  - [BlueZ,v2,02/10] adapter: Remove experimental flag for PowerSt=
ate
> > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd3aea=
e79de4b
> > > > >  - [BlueZ,v2,03/10] test: consistently use /usr/bin/env python3 s=
hebang
> > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd31f0=
4aa928a
> > > > >  - [BlueZ,v2,04/10] profiles: remove unused suspend-dummy.c
> > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D13133=
51f7144
> > > > >  - [BlueZ,v2,05/10] obex: remove unused syncevolution plugin
> > > > >    (no matching commit)
> > > > >  - [BlueZ,v2,06/10] obex: remove unused mas/messages-tracker impl
> > > > >    (no matching commit)
> > > > >  - [BlueZ,v2,07/10] obex: remove phonebook tracker backend
> > > > >    (no matching commit)
> > > > >  - [BlueZ,v2,08/10] build: ship all config files with --enable-da=
tafiles
> > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dbe0e7=
96299b0
> > > > >  - [BlueZ,v2,09/10] obex: Use GLib helper function to manipulate =
paths
> > > > >    (no matching commit)
> > > > >  - [BlueZ,v2,10/10] Allow using obexd without systemd in the user=
 session
> > > > >    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Db16b1=
9885c53
> > > >
> > > > Massive thanks for applying the above.
> > > >
> > > > Out of curiosity: is there anything wrong with the few remaining on=
es?
> > > > I had a look through the ML archives on lore.kernel.org as well as =
my
> > > > inbox and could not find any replies.
> > >
> > > I don't think we should remove the syncevolution and tracker backends=
,
> > > they shall probably be disabled first so we don't break platforms
> > > still using them. As for the GLib helper I don't think that is really
> > > needed, at least there doesn't seem to be a problem with current
> > > handling.
> > >
> >
> > Unless I am missing something, all four backends/implementations are
> > effectively disabled and unused.
> >
> > Ignoring the first that you've merged already, the other three are
> > syncevolution, messages-tracker, phonebook tracker. All of those obexd
> > specific and have been practically dead code for approximately 6
> > years. In particular ever since the obexd git repo was imported into
> > bluez, they were never wired into the build system.
>
> --with-phonebook=3Dtracker
>
> It does seem to work,

I think you meant to say s/work/is allowed/ :-) Commit "obex: remove
phonebook tracker backend" bans this as an option.

> even though it doesn't track dependencies
> particularly well:
>
> obexd/plugins/phonebook-tracker.c:21:10: fatal error:
> libtracker-sparql/tracker-sparql.h: No such file or directory
>    21 | #include <libtracker-sparql/tracker-sparql.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>

In order to get past this, a small hack as mentioned previously is
needed. While-space might be off:

---
diff --git a/Makefile.obexd b/Makefile.obexd
index 81456544d..2e954c92e 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -88,6 +88,7 @@ obexd_src_obexd_LDADD =3D lib/libbluetooth-internal.la \
             gdbus/libgdbus-internal.la \
             src/libshared-glib.la \
             $(ICAL_LIBS) $(DBUS_LIBS) $(LIBEBOOK_LIBS) \
+            $(TRAK_LIBS) \
             $(LIBEDATASERVER_LIBS) $(GLIB_LIBS) -ldl

 if EXTERNAL_PLUGINS
@@ -95,6 +96,7 @@ obexd_src_obexd_LDFLAGS =3D $(AM_LDFLAGS) -Wl,--export-dy=
namic
 endif

 obexd_src_obexd_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) =
\
+               $(TRAK_CFLAGS) \
                 $(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
                 -DPLUGINDIR=3D\""$(obex_plugindir)"\" \
                 -D_FILE_OFFSET_BITS=3D64 \
diff --git a/configure.ac b/configure.ac
index 05c76dddb..38853476f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -449,6 +449,7 @@ if (test "${plugin_phonebook}" =3D "ebook"); then
     PKG_CHECK_MODULES(LIBEBOOK, libebook-1.2 >=3D 3.3)
     PKG_CHECK_MODULES(LIBEDATESERVER, libedataserver-1.2 >=3D 3.3)
 fi
+PKG_CHECK_MODULES(TRAK, tracker-sparql-3.0)
 AC_SUBST(PLUGIN_PHONEBOOK, [${plugin_phonebook}])

 AC_CONFIG_FILES(
---

Getting past that, one gets over a dozen errors. The most indicative
of which being:
error: implicit declaration of function =E2=80=98tracker_sparql_connection_=
get_direct'

Looking around shows that the API is from the tracker-1 days, where
the last ones in that series 1.10.6 [1] and 1.12.4 [2]. Both of which
released some 6 years ago. Looking at Debian Buster aka
oldoldstable[3], it does not have tracker-1 [4].

Honestly I am struggling to see how this can be built on any remotely
recent distribution, even with the build snippet/hack above.

[1] https://gitlab.gnome.org/GNOME/tracker/-/tags/1.10.6
[2] https://gitlab.gnome.org/GNOME/tracker/-/tags/1.12.4
[3] https://wiki.debian.org/DebianOldOldStable
[4] https://packages.debian.org/search?suite=3Dbuster&keywords=3Dtracker



> That said the message backends don't seem to have a similar backend
> selection, not really where we drop support for it or it was never an
> option for some reason, perhaps we can remove the messages backend
> first, but afaik there was some support for syncevolution at least I
> recall using it some ages ago to sync contacts with the phone, but I
> guess things have changed quite a lot in the meantime and now everyone
> sync directly with the Google Account, etc.
>

Digging a bit into this shows that each of those had an option within
the original obexd repo [5]. Seemingly these were lost (or never
ported if you will) when the obexd repo was "git filter-branch"
imported into bluez.

[5] https://git.kernel.org/pub/scm/bluetooth/obexd.git/tree/configure.ac


I cannot find any Linux distribution that has built them over the last
~5 years, that has built those.

The fact that loudly nobody complained for years, means that we can
`git rm` them.
There is nothing stopping the developer of tomorrow from "git revert",
fixing the build and properly testing.

Does that make sense?

-Emil
