Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Feb 2011 18:04:41 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: ankushbansal89@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Changing required GLIB version in acinclude.m4
Message-ID: <20110203200440.GD2168@joana>
References: <ankushbansal89@gmail.com>
 <1296677045-12603-1-git-send-email-ankushbansal89@gmail.com>
 <AANLkTi=DdZzYtadsTTOO6Y-R=8Sq7x+EX46g7UDYa-7m@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=DdZzYtadsTTOO6Y-R=8Sq7x+EX46g7UDYa-7m@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-02-03 10:46:08 +0200]:

> Hi,
> 
> On Wed, Feb 2, 2011 at 10:04 PM,  <ankushbansal89@gmail.com> wrote:
> > From: Ankush Bansal <ankushbansal89@gmail.com>
> >
> > ---
> >  acinclude.m4 |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/acinclude.m4 b/acinclude.m4
> > index ecf4b4b..9d3f6b2 100644
> > --- a/acinclude.m4
> > +++ b/acinclude.m4
> > @@ -108,8 +108,8 @@ AC_DEFUN([AC_PATH_DBUS], [
> >  ])
> >
> >  AC_DEFUN([AC_PATH_GLIB], [
> > -       PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.14, dummy=yes,
> > -                               AC_MSG_ERROR(GLib library version 2.14 or later is required))
> > +       PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.16, dummy=yes,
> > +                               AC_MSG_ERROR(GLib library version 2.16 or later is required))
> >        AC_SUBST(GLIB_CFLAGS)
> >        AC_SUBST(GLIB_LIBS)
> >  ])
> > --
> > 1.7.1
> 
> Can you provide more details why this is needed, is there any new
> function we are using which requires 2.16?

It is g_strcmp0(), but it should be a good idea add this info to the commit
message.

-- 
Gustavo F. Padovan
http://profusion.mobi
