Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 17:28:38 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Paul Seidler <pl.seidler@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] build: modifing behavior of systemdunitdir switch
Message-ID: <20120203202837.GB29936@samus>
References: <1327870497-4260-1-git-send-email-pl.seidler@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327870497-4260-1-git-send-email-pl.seidler@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 21:54 Sun 29 Jan, Paul Seidler wrote:
> Currently it's not possible to disable the installation of the systemd
> service file. If you use --without the file get installed into /no/.
> 
> Changes with this patch:
> --without-systemdunitdir disables the installation of the service file
> --with-systemdunitdir installs the file in the directory reported by
> pkg-config
> --with-systemdunitdir=/foo installs the file to /foo
> 
> Without giving the systemdunitdir switch, pkg-config checks for systemd and
> installs the file if available.
> 
> Signed-off-by: Paul Seidler <pl.seidler@googlemail.com>

Patch looks good. Just a minor nitpick, we don't use the Signed-off-by:
line on userspace code.

> ---
>  configure.ac |   20 ++++++++++++--------
>  1 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 5b81f28..b96dc5d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -62,14 +62,18 @@ if (test "${enable_capng}" = "yes"); then
>  	AC_DEFINE(HAVE_CAPNG, 1, [Define to 1 if you have capabilities library.])
>  fi
>  
> -AC_ARG_WITH([systemdunitdir], AC_HELP_STRING([--with-systemdunitdir=DIR],
> -	[path to systemd system service directory]), [path_systemdunit=${withval}],
> -		[path_systemdunit="`$PKG_CONFIG --variable=systemdsystemunitdir systemd`"])
> -if (test -n "${path_systemdunit}"); then
> -	SYSTEMD_UNITDIR="${path_systemdunit}"
> -	AC_SUBST(SYSTEMD_UNITDIR)
> -fi
> -AM_CONDITIONAL(SYSTEMD, test -n "${path_systemdunit}")
> +AC_ARG_WITH([systemdunitdir],
> +	AC_HELP_STRING([--with-systemdunitdir@<:@=DIR@:>@],
> +		[Installing systemd service file (auto)
> +		@<:@path to systemd system service directory@:>@]),
> +	[path_systemdunit="${withval}"],
> +	[PKG_CHECK_MODULES(SYSTEMD, systemd,
> +		path_systemdunit=yes, path_systemdunit=no)])
> +AS_IF([test "${path_systemdunit}" = yes],
> +	[path_systemdunit="`$PKG_CONFIG --variable=systemdsystemunitdir systemd`"])
> +AS_IF([test "${path_systemdunit}" != no],
> +	[AC_SUBST(SYSTEMD_UNITDIR,["${path_systemdunit}"])])
> +AM_CONDITIONAL(SYSTEMD, test "${path_systemdunit}" != no)
>  
>  AC_OUTPUT(Makefile scripts/bluetooth.rules doc/version.xml
>  			src/bluetoothd.8 src/bluetooth.service bluez.pc)
> -- 
> 1.7.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
