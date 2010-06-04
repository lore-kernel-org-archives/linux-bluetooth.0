Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1275646613-32639-4-git-send-email-gustavo@padovan.org>
References: <1275646613-32639-1-git-send-email-gustavo@padovan.org>
	<1275646613-32639-2-git-send-email-gustavo@padovan.org>
	<1275646613-32639-3-git-send-email-gustavo@padovan.org>
	<1275646613-32639-4-git-send-email-gustavo@padovan.org>
Date: Fri, 4 Jun 2010 13:59:36 +0300
Message-ID: <AANLkTik4_azVzpkBRogCpNXhY2tZ3CIcH1i5wn8EylbR@mail.gmail.com>
Subject: Re: [PATCH 4/4] Adjust define name to the name of the file
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Jun 4, 2010 at 1:16 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> ---
>  src/log.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/log.h b/src/log.h
> index 235430e..7a5942c 100644
> --- a/src/log.h
> +++ b/src/log.h
> @@ -21,8 +21,8 @@
>  *
>  */
>
> -#ifndef __LOGGING_H
> -#define __LOGGING_H
> +#ifndef __LOG_H
> +#define __LOG_H
>
>  extern int debug_enabled;
>
> @@ -61,4 +61,4 @@ struct btd_debug_desc {
>                                         __FILE__, __FUNCTION__ , ## arg); \
>  } while (0)
>
> -#endif /* __LOGGING_H */
> +#endif /* __LOG_H */

I remember Marcel being against this since it hides real dependency circle.


-- 
Luiz Augusto von Dentz
Computer Engineer
