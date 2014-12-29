Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] build: Enable -Wformat -Wformat-security in maintainer mode
Date: Mon, 29 Dec 2014 19:11:03 +0100
Message-ID: <1739197.NJi8TVCMF6@leonov>
In-Reply-To: <DB100955-4134-4A34-A293-21B10D1B494C@holtmann.org>
References: <1419857362-23502-1-git-send-email-szymon.janc@tieto.com> <DB100955-4134-4A34-A293-21B10D1B494C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Monday 29 of December 2014 09:42:46 Marcel Holtmann wrote:
> Hi Szymon,
> 
> > __attribute__((format(printf))) doesn't seem to catch missing format
> > string in function call ie.
> > 
> > char *p = "foo";
> > 
> > printf(p);
> > vs
> > printf("%s", p);
> > 
> > Enabling -Wformat -Wformat-security warns in such case.
> > ---
> > 
> > This should allow to early catch bugs like those fixed in
> > patch "Add missing format specifiers in src/error.c" sent by
> > Mariusz.
> > 
> > acinclude.m4 | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/acinclude.m4 b/acinclude.m4
> > index 960d54c..bc39c6d 100644
> > --- a/acinclude.m4
> > +++ b/acinclude.m4
> > @@ -21,6 +21,7 @@ AC_DEFUN([COMPILER_FLAGS], [
> > 
> > 		with_cflags="$with_cflags -Wredundant-decls"
> > 		with_cflags="$with_cflags -Wcast-align"
> > 		with_cflags="$with_cflags -Wswitch-enum"
> > 
> > +		with_cflags="$with_cflags -Wformat -Wformat-security"
> > 
> > 		with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
> > 		with_cflags="$with_cflags -
DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_28"
> > 		with_cflags="$with_cflags -
DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_28"
> 
> no objections from my side. However I had gcc versions where this one was
> enabled by default.

It looks like Ubuntu 13.04 and newer enable format-security by default.
Maybe some other distros do the same, yet at least F20 doesn't.

-- 
BR
Szymon Janc
