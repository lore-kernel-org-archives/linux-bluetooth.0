Return-Path: <cyrus@holtmann.org>
Message-ID: <1360226227.15783.12.camel@aeonflux>
Subject: Re: [PATCH BlueZ] configure.ac: call AC_SUBST unconditionally
From: Marcel Holtmann <marcel@holtmann.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 07 Feb 2013 10:37:07 +0200
In-Reply-To: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
References: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

> Call AC_SUBST unconditionally, otherwise options like
> --with-dbusconfdir=DIR or --with-udevdir=DIR have no effect.
> 
> Before this change, configuring with:
> 
>   $ mkdir build
>   $ ./configure --disable-systemd \
>                 --prefix=$(pwd)/build \
>                 --with-dbusconfdir=$(pwd)/build/etc
> 
> resulted in the option value to be ignored at "make install" time, with
> this error:
> 
>   /bin/mkdir: cannot create directory '/dbus-1/system.d': Permission denied
> 
> After the patch the option value is respected.
> ---
> 
> Hi,
> 
> the issue was highlighted by the use "--prefix=" and running "make install" as
> a restricted user, maybe the are still other issues with this use case.
> Anyone willing to take a deeper look?

why are you doing --prefix="" in the first place? I do not get that
part.

> For instance, is "--prefix=DIR" supposed to be prepended to manually specified
> paths too?
> 
> Thanks,
>    Antonio
> 
>  configure.ac |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 070acea..fe2893a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -71,8 +71,8 @@ if (test -z "${path_dbusconfdir}"); then
>  		AC_MSG_ERROR([D-Bus configuration directory is required])
>  	fi
>  	AC_MSG_RESULT([${path_dbusconfdir}])
> -	AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
>  fi
> +AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])

I am failing to see the bug here. you are providing the
--with-dbusconfdir=DIR and thus is should work. What is causing the
wrong mkdir actually.
 
>  AC_ARG_WITH([dbussystembusdir], AC_HELP_STRING([--with-dbussystembusdir=DIR],
>  				[path to D-Bus system bus services directory]),
> @@ -84,8 +84,8 @@ if (test -z "${path_dbussystembusdir}"); then
>  		AC_MSG_ERROR([D-Bus system bus services directory is required])
>  	fi
>  	AC_MSG_RESULT([${path_dbussystembusdir}])
> -	AC_SUBST(DBUS_SYSTEMBUSDIR, [${path_dbussystembusdir}])
>  fi
> +AC_SUBST(DBUS_SYSTEMBUSDIR, [${path_dbussystembusdir}])
>  
>  AC_ARG_WITH([dbussessionbusdir], AC_HELP_STRING([--with-dbussessionbusdir=DIR],
>  				[path to D-Bus session bus services directory]),
> @@ -97,8 +97,8 @@ if (test -z "${path_dbussessionbusdir}"); then
>  		AC_MSG_ERROR([D-Bus session bus services directory is required])
>  	fi
>  	AC_MSG_RESULT([${path_dbussessionbusdir}])
> -	AC_SUBST(DBUS_SESSIONBUSDIR, [${path_dbussessionbusdir}])
>  fi
> +AC_SUBST(DBUS_SESSIONBUSDIR, [${path_dbussessionbusdir}])
>  
>  AC_ARG_ENABLE(library, AC_HELP_STRING([--enable-library],
>  		[install Bluetooth library]), [enable_library=${enableval}])
> @@ -121,8 +121,6 @@ AC_ARG_ENABLE(usb, AC_HELP_STRING([--disable-usb],
>  if (test "${enable_tools}" != "no" && test "${enable_usb}" != "no"  ); then
>  	PKG_CHECK_MODULES(USB, libusb, dummy=yes,
>  			AC_MSG_ERROR(USB library support is required))
> -	AC_SUBST(USB_CFLAGS)
> -	AC_SUBST(USB_LIBS)
>  	AC_CHECK_LIB(usb, usb_get_busses, dummy=yes,
>  		AC_DEFINE(NEED_USB_GET_BUSSES, 1,
>  			[Define to 1 if you need the usb_get_busses() function.]
> @@ -133,6 +131,8 @@ if (test "${enable_tools}" != "no" && test "${enable_usb}" != "no"  ); then
>  on.]))
>  	AC_DEFINE(HAVE_LIBUSB, 1, [Define to 1 if you have USB library.])
>  fi
> +AC_SUBST(USB_CFLAGS)
> +AC_SUBST(USB_LIBS)

What are these changes for? I don't see any reason for them. And also
they should not intermix in the patch. They need to explained
separately.

Regards

Marcel


