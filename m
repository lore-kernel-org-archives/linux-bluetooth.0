Return-Path: <cyrus@holtmann.org>
Message-ID: <1360322491.20763.1.camel@aeonflux>
Subject: Re: [PATCH BlueZ] configure.ac: call AC_SUBST unconditionally
From: Marcel Holtmann <marcel@holtmann.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Feb 2013 13:21:31 +0200
In-Reply-To: <20130207115044.ad0c33fb97da1d5ab1f1984e@studenti.unina.it>
References: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
	 <1360226227.15783.12.camel@aeonflux>
	 <20130207115044.ad0c33fb97da1d5ab1f1984e@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

> > > Call AC_SUBST unconditionally, otherwise options like
> > > --with-dbusconfdir=DIR or --with-udevdir=DIR have no effect.
> > > 
> > > Before this change, configuring with:
> > > 
> > >   $ mkdir build
> > >   $ ./configure --disable-systemd \
> > >                 --prefix=$(pwd)/build \
> > >                 --with-dbusconfdir=$(pwd)/build/etc
> > > 
> > > resulted in the option value to be ignored at "make install" time, with
> > > this error:
> > > 
> > >   /bin/mkdir: cannot create directory '/dbus-1/system.d': Permission denied
> > > 
> > > After the patch the option value is respected.
> > > ---
> > > 
> > > Hi,
> > > 
> > > the issue was highlighted by the use "--prefix=" and running "make install" as
> > > a restricted user, maybe the are still other issues with this use case.
> > > Anyone willing to take a deeper look?
> > 
> > why are you doing --prefix="" in the first place? I do not get that
> > part.
> 
> Sorry, poor communication choice from my part, in the sentence above the
> _whole_ --prefix= was enclosed in double quotes to mean "the --prefix
> parameter", but I see this could be misleading, I am actually using:
> 
>   --prefix=$(pwd)/build
> 
> > > For instance, is "--prefix=DIR" supposed to be prepended to manually specified
> > > paths too?
> > >
> > > Thanks,
> > >    Antonio
> > > 
> > >  configure.ac |   16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/configure.ac b/configure.ac
> > > index 070acea..fe2893a 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -71,8 +71,8 @@ if (test -z "${path_dbusconfdir}"); then
> > >  		AC_MSG_ERROR([D-Bus configuration directory is required])
> > >  	fi
> > >  	AC_MSG_RESULT([${path_dbusconfdir}])
> > > -	AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
> > >  fi
> > > +AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
> > 
> > I am failing to see the bug here. you are providing the
> > --with-dbusconfdir=DIR and thus is should work. What is causing the
> > wrong mkdir actually.
> >
> 
> This is what I understand is going on in configure.ac right now:
> 
>   # define the option
>   AC_ARG_WITH([dbusconfdir] ... [path_dbusconfdir=${withval}])
> 
>   # when --with-dbusconfdir is NOT used
>   if (test -z "${path_dbusconfdir}"); then
>     ...
> 
>     # define the config dir
>     path_dbusconfdir="`$PKG_CONFIG --variable=sysconfdir dbus-1`"
>     
>     ...
>     
>     # set DBUS_CONFDIR
>     AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
>   endif
> 
> when --with-dbusconfdir=SOMEDIR is used the test above fails, and the
> result is that ${path_dbusconfdir} is indeed defined, but DBUS_CONFDIR
> is not, and the latter is going to be used in Makefile.am:
> 
>   dbusdir = @DBUS_CONFDIR@/dbus-1/system.d
> 
> The wrong makedir is exposed by my use of the "prefix" option and the
> fact that I am running "make install" as a normal user, otherwise
> /dbus-1/system.d would be happily (and wrongly) created.
> 
> By always setting DBUS_CONFDIR we cover the case when
> --with-dbusconfdir=SOMEDIR is used.

I see your point here. This one is valid. Please send separate patches
for that.

> 
> > >  AC_ARG_WITH([dbussystembusdir], AC_HELP_STRING([--with-dbussystembusdir=DIR],
> > >  				[path to D-Bus system bus services directory]),
> > > @@ -84,8 +84,8 @@ if (test -z "${path_dbussystembusdir}"); then
> > >  		AC_MSG_ERROR([D-Bus system bus services directory is required])
> > >  	fi
> > >  	AC_MSG_RESULT([${path_dbussystembusdir}])
> > > -	AC_SUBST(DBUS_SYSTEMBUSDIR, [${path_dbussystembusdir}])
> > >  fi
> > > +AC_SUBST(DBUS_SYSTEMBUSDIR, [${path_dbussystembusdir}])
> > >  
> > >  AC_ARG_WITH([dbussessionbusdir], AC_HELP_STRING([--with-dbussessionbusdir=DIR],
> > >  				[path to D-Bus session bus services directory]),
> > > @@ -97,8 +97,8 @@ if (test -z "${path_dbussessionbusdir}"); then
> > >  		AC_MSG_ERROR([D-Bus session bus services directory is required])
> > >  	fi
> > >  	AC_MSG_RESULT([${path_dbussessionbusdir}])
> > > -	AC_SUBST(DBUS_SESSIONBUSDIR, [${path_dbussessionbusdir}])
> > >  fi
> > > +AC_SUBST(DBUS_SESSIONBUSDIR, [${path_dbussessionbusdir}])
> > >  
> > >  AC_ARG_ENABLE(library, AC_HELP_STRING([--enable-library],
> > >  		[install Bluetooth library]), [enable_library=${enableval}])
> > > @@ -121,8 +121,6 @@ AC_ARG_ENABLE(usb, AC_HELP_STRING([--disable-usb],
> > >  if (test "${enable_tools}" != "no" && test "${enable_usb}" != "no"  ); then
> > >  	PKG_CHECK_MODULES(USB, libusb, dummy=yes,
> > >  			AC_MSG_ERROR(USB library support is required))
> > > -	AC_SUBST(USB_CFLAGS)
> > > -	AC_SUBST(USB_LIBS)
> > >  	AC_CHECK_LIB(usb, usb_get_busses, dummy=yes,
> > >  		AC_DEFINE(NEED_USB_GET_BUSSES, 1,
> > >  			[Define to 1 if you need the usb_get_busses() function.]
> > > @@ -133,6 +131,8 @@ if (test "${enable_tools}" != "no" && test "${enable_usb}" != "no"  ); then
> > >  on.]))
> > >  	AC_DEFINE(HAVE_LIBUSB, 1, [Define to 1 if you have USB library.])
> > >  fi
> > > +AC_SUBST(USB_CFLAGS)
> > > +AC_SUBST(USB_LIBS)
> > 
> > What are these changes for? I don't see any reason for them. And also
> > they should not intermix in the patch. They need to explained
> > separately.
> > 
> 
> They are meant to follow the same logic used for
> 
> AC_SUBST(UDEV_CFLAGS)
> AC_SUBST(UDEV_LIBS)
> 
> which are outside of the test.

I do not see this being valid. The logic does not work since it will
abort if enabled.

Regards

Marcel


