Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Drop Posix Capabilities
From: Marcel Holtmann <marcel@holtmann.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200909261029.06609.sgrubb@redhat.com>
References: <200909251647.15440.sgrubb@redhat.com>
	 <1253914521.2659.1.camel@localhost.localdomain>
	 <200909261029.06609.sgrubb@redhat.com>
Content-Type: text/plain
Date: Sun, 27 Sep 2009 13:31:25 -0700
Message-Id: <1254083485.2659.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

> > > diff -urp bluez-4.54.orig/acinclude.m4 bluez-4.54/acinclude.m4
> > > --- bluez-4.54.orig/acinclude.m4      2009-09-25 11:33:47.000000000 -0400
> > > +++ bluez-4.54/acinclude.m4   2009-09-25 16:38:32.000000000 -0400
> > > @@ -352,3 +352,36 @@ AC_DEFUN([AC_ARG_BLUEZ], [
> > >       AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
> > >       AM_CONDITIONAL(CABLE, test "${cable_enable}" = "yes" && test
> > > "${cable_found}" = "yes") ])
> > 
> > please base the patch against upstream and not the Fedora package.
> 
> I just retried against the 4.54 tarball and it applies, but with some fuzz.
> 
> patch -p1 < ../bluez-4.54-capability.patch 
> patching file acinclude.m4
> Hunk #1 succeeded at 336 with fuzz 2 (offset -16 lines).
> patching file configure.ac
> Hunk #1 succeeded at 44 (offset -1 lines).
> patching file Makefile.am
> Hunk #1 succeeded at 191 (offset -9 lines).
> patching file src/main.c

and git am will not like fuzz that much. So I prefer to have patches
against the upstream GIT repository and not the Fedora tree.

> > > +AC_DEFUN([LIBCAP_NG_PATH],
> > > +[
> > > +     AC_ARG_WITH(libcap-ng,
> > > +     [ --with-libcap-ng=[auto/yes/no]  Add Libcap-ng support
> > > +             [default=auto]],, with_libcap_ng=auto)
> > > +
> > 
> > I mention this to Bastien already. I want pkgconfig support here and not
> > some old style aclocal magic.
> 
> libcap-ng itself does not provide any pkgconfig support. I'll check on this.

According to the bug you guys have open for this, you try to fix this
upstream in libcap-ng. So please push a pkgconfig file to libcap-ng and
then I am more than happy to accept a patch for this.

I like to have capability dropping in bluetoothd, but I do wanna do it
with a proper upstream project. And not having pkgconfig support in
library is just not cutting it anymore. Since the project seems to be
maintained by you, it should be easy to fix ;)

Regards

Marcel



