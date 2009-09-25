Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Drop Posix Capabilities
From: Marcel Holtmann <marcel@holtmann.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200909251647.15440.sgrubb@redhat.com>
References: <200909251647.15440.sgrubb@redhat.com>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 14:35:21 -0700
Message-Id: <1253914521.2659.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

> The following patch against the 4.54 codebase drops posix capabilities
> after startup so that the bluetooth daemon is less of a threat to the
> system should there be any way to compromise it. The retained 
> capabilities was compared to selinux policy to make sure that its 
> roughly the same. It uses the libcap-ng library which allows patches
> for dropping capabilities to be much smaller.
> 
> Signed-off-by: Steve Grubb <sgrubb@redhat.com>
> 
> 
> diff -urp bluez-4.54.orig/acinclude.m4 bluez-4.54/acinclude.m4
> --- bluez-4.54.orig/acinclude.m4	2009-09-25 11:33:47.000000000 -0400
> +++ bluez-4.54/acinclude.m4	2009-09-25 16:38:32.000000000 -0400
> @@ -352,3 +352,36 @@ AC_DEFUN([AC_ARG_BLUEZ], [
>  	AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
>  	AM_CONDITIONAL(CABLE, test "${cable_enable}" = "yes" && test "${cable_found}" = "yes")
>  ])

please base the patch against upstream and not the Fedora package.

> +AC_DEFUN([LIBCAP_NG_PATH],
> +[
> +	AC_ARG_WITH(libcap-ng,
> +	[ --with-libcap-ng=[auto/yes/no]  Add Libcap-ng support
> +		[default=auto]],, with_libcap_ng=auto)
> +

I mention this to Bastien already. I want pkgconfig support here and not
some old style aclocal magic.

Regards

Marcel


