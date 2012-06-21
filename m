Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 Jun 2012 18:11:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] build: fix MISC_LDFLAGS typo to fix "--enable-pie"
Message-ID: <20120621151114.GA8441@x220.ger.corp.intel.com>
References: <4FE2ED4E.5010503@message-id.googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FE2ED4E.5010503@message-id.googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

On Thu, Jun 21, 2012, Stefan Seyfried wrote:
> From: Stefan Seyfried <seife+obs@b1-systems.com>
> Date: Thu, 21 Jun 2012 11:28:47 +0200
> Subject: [PATCH] build: fix MISC_LDFLAGS typo to fix "--enable-pie"
> 
> ---
>  acinclude.m4 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/acinclude.m4 b/acinclude.m4
> index 6505ad3..1d6d736 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -360,7 +360,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
>  	fi
>  
>  	AC_SUBST([MISC_CFLAGS], $misc_cflags)
> -	AC_SUBST([MISC_LDLAGS], $misc_ldlags)
> +	AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
>  
>  	if (test "${usb_enable}" = "yes" && test "${usb_found}" = "yes"); then
>  		AC_DEFINE(HAVE_LIBUSB, 1, [Define to 1 if you have USB library.])

Applied. Thanks.

Johan
