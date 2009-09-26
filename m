Return-Path: <cyrus@holtmann.org>
From: Steve Grubb <sgrubb@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Drop Posix Capabilities
Date: Sat, 26 Sep 2009 10:29:06 -0400
References: <200909251647.15440.sgrubb@redhat.com> <1253914521.2659.1.camel@localhost.localdomain>
In-Reply-To: <1253914521.2659.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200909261029.06609.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 25 September 2009 05:35:21 pm Marcel Holtmann wrote:
> > diff -urp bluez-4.54.orig/acinclude.m4 bluez-4.54/acinclude.m4
> > --- bluez-4.54.orig/acinclude.m4      2009-09-25 11:33:47.000000000 -0400
> > +++ bluez-4.54/acinclude.m4   2009-09-25 16:38:32.000000000 -0400
> > @@ -352,3 +352,36 @@ AC_DEFUN([AC_ARG_BLUEZ], [
> >       AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
> >       AM_CONDITIONAL(CABLE, test "${cable_enable}" = "yes" && test
> > "${cable_found}" = "yes") ])
> 
> please base the patch against upstream and not the Fedora package.

I just retried against the 4.54 tarball and it applies, but with some fuzz.

patch -p1 < ../bluez-4.54-capability.patch 
patching file acinclude.m4
Hunk #1 succeeded at 336 with fuzz 2 (offset -16 lines).
patching file configure.ac
Hunk #1 succeeded at 44 (offset -1 lines).
patching file Makefile.am
Hunk #1 succeeded at 191 (offset -9 lines).
patching file src/main.c


> > +AC_DEFUN([LIBCAP_NG_PATH],
> > +[
> > +     AC_ARG_WITH(libcap-ng,
> > +     [ --with-libcap-ng=[auto/yes/no]  Add Libcap-ng support
> > +             [default=auto]],, with_libcap_ng=auto)
> > +
> 
> I mention this to Bastien already. I want pkgconfig support here and not
> some old style aclocal magic.

libcap-ng itself does not provide any pkgconfig support. I'll check on this.

-Steve
