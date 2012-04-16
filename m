Return-Path: <cyrus@holtmann.org>
Message-ID: <1334565413.16897.167.camel@aeonflux>
Subject: Re: [PATCH 1/2] Add function for printing warnings
From: Marcel Holtmann <marcel@holtmann.org>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Apr 2012 10:36:53 +0200
In-Reply-To: <1334564820-31556-1-git-send-email-chanyeol.park@samsung.com>
References: <1334562608.16897.164.camel@aeonflux>
	 <1334564820-31556-1-git-send-email-chanyeol.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> ---
>  src/log.c |   12 ++++++++++++
>  src/log.h |    1 +
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/src/log.c b/src/log.c
> index 4a50117..adbfba9 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -55,6 +55,18 @@ void error(const char *format, ...)
>  	va_end(ap);
>  }
>  
> +void warn(const char *format, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, format);
> +
> +	vsyslog(LOG_WARNING, format, ap);
> +
> +	va_end(ap);
> +}
> +
> +

the patch is fine, but just for consistence sake, you should put warn()
after info() function.

And no double empty lines between functions please. That is not part of
our coding style. And if you saw it somewhere else in the code, then
that is an oversight.

>  void btd_debug(const char *format, ...)
>  {
>  	va_list ap;
> diff --git a/src/log.h b/src/log.h
> index 51c52e6..cdcb146 100644
> --- a/src/log.h
> +++ b/src/log.h
> @@ -23,6 +23,7 @@
>  
>  void info(const char *format, ...) __attribute__((format(printf, 1, 2)));
>  void error(const char *format, ...) __attribute__((format(printf, 1, 2)));
> +void warn(const char *format, ...) __attribute__((format(printf, 1, 2)));

Same here. warn() comes after info().

>  
>  void btd_debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
>  

Regards

Marcel


