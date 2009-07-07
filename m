Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] fix UDEV_DATADIR fallback if pkg-config fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20090707095710.4ab1e03c@stoetzler>
References: <20090707095710.4ab1e03c@stoetzler>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 10:18:44 -0700
Message-Id: <1246987124.3384.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> ---
>  acinclude.m4 |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/acinclude.m4 b/acinclude.m4
> index 48728e8..2018169 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -111,9 +111,11 @@ AC_DEFUN([AC_INIT_BLUEZ], [
>  	AC_SUBST(CONFIGDIR, "${configdir}")
>  	AC_SUBST(STORAGEDIR, "${storagedir}")
>  
> -	UDEV_DATADIR="`$PKG_CONFIG --variable=udevdir udev`/rules.d"
> +	UDEV_DATADIR="`$PKG_CONFIG --variable=udevdir udev`"
>  	if (test -z "${UDEV_DATADIR}"); then
>  		UDEV_DATADIR="${sysconfdir}/udev/rules.d"
> +	else
> +		UDEV_DATADIR="${UDEV_DATADIR}/rules.d"
>  	fi
>  	AC_SUBST(UDEV_DATADIR)
>  ])

brown paper bag is one me :(

Patch has been applied. Thanks.

Regards

Marcel


