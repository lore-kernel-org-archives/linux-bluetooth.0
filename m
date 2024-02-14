Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFA2208E
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944812; cv=none; b=TjkBy1AztxgyXG19dBZNUz7dCc8W7QXAGfi+n5JslaAGnjmn5JI9baife2NsYRrrulW3+wDB6H433t/O6qFja9fFI+OLWklu7DctgxpQmlS/efCIqZiuF24LNrJSl81qgQhkMiZ3Wjbkm7fxDe8OFm4n81DaHfSbsz9vHxRHM8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944812; c=relaxed/simple;
	bh=IN+H7RnnTKNNPlLRX6H51HgpIt/dc2dh0GgRGB/TKt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbIgc0NqeE/n37w3nfdhhtMBLr60taPJ6C5VC7nj1J68IP5V5x2jRjS8HKmjgRmn07a0BsOJs7BA54qRLu92V0bkRda6bAGTW6sXxeIKB1yIxxhIVcPtGjHUbyPneZyXOCsoVeJz/GKrPy+vhKSnu8DBgDFaBCSVkLGdy7cClGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTRMozgO; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTRMozgO"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso118114276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707944810; x=1708549610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmbP7b9Cl3ec1oQPgrmikyiQyFnVTwUTRgUG46RJxPY=;
        b=RTRMozgOIBNXvkJj+1Lv5Y61MrY/ToVqWGNQh10I4QqNSw2KuMqg/6JDWj9EzpR7fC
         UQmZjvYbxtkif03VHWawh+cuBIMrOuT2KLdqY8VMdCMT2xgsyEw4UspWXlkT/yGc/fdH
         U6mWIIrMdcl9TzQ+aLVV82uhcqjTz6TNJhhF8QKCNWCCzo3a0TvRfooMWShZrm7Bv7qm
         VoChWeXrNtHE4j2mBHJ7NiWTo6BKVzSE09zZyCk7Z3VGFDyQOw3k+t5ZSrJuKuk29V4+
         XOc27AQzkHTdxTETNLAFsOTtVEMurU/kMxjDvVI4cNw5cMp/GVQlxBqV8j6vd/26JmAz
         IxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707944810; x=1708549610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmbP7b9Cl3ec1oQPgrmikyiQyFnVTwUTRgUG46RJxPY=;
        b=Xz5JvWNTLHhrCp1cnYsL2HgiFyFD2tYgvFn3GdjuqjGIRacWTkspWlVhNrX5b8w5jP
         covcjtoSMrnqmoVnOaIuiu9zEEupn/iTPdRXe3Dji544yfuzL8T65C7FpmjRNFI+7zLz
         YcX/grTk+TUltvBWPYGfnx8NNjbi5RMU4AztKda73mm27cL8X/oMRfJHLfzdGToffdEG
         cMkwDXiz23Ok+tFuTAz0it53ZUuXydAlaw9Wy0CJOX/Z9K4jCERpiuikeksVERvynKok
         nuGjb5ac7hgGLitFxDfWBiQ+2bstjL/BiH4kyS2zgoQjlyjKpBx8t49AabmTP0EKaAJC
         UDHg==
X-Gm-Message-State: AOJu0Yw5CIZ7sqgyFibBE3zwDMDrHhppHJrUdryjj033V2L3PTahY159
	2JAgx7AbhikeLvryrb1H7nUVM6vXwc21fMDN3ZHNvE4uE2xf774QBDVSbR0sNES04EfUwlnTRlX
	MJX+tNIZClqIa4rGwpdwMx7C738A=
X-Google-Smtp-Source: AGHT+IERh2IEKWKaAWU239Uql2Tl2Nrig3W+vRDiLhx10KamwQUgCC0/tJSUrivP6XA/KIh94WVH+XPM6DKhDxswCcE=
X-Received: by 2002:a25:aba8:0:b0:dc7:1d:5db4 with SMTP id v37-20020a25aba8000000b00dc7001d5db4mr3464744ybi.34.1707944808653;
 Wed, 14 Feb 2024 13:06:48 -0800 (PST)
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
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Feb 2024 21:06:36 +0000
Message-ID: <CACvgo51WwzAa7M=sjLyh+mKQM2=V6pOgBwR6dtWQ2Dad9mv1Qw@mail.gmail.com>
Subject: Re: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 20:48, Emil Velikov <emil.l.velikov@gmail.com> wrote=
:
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
>
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
>

I may have gone a little overboard with the amount of information and
references ;-)

Sorry about that Luiz and team
-Emil
