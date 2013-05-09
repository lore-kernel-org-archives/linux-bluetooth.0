Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1368073016-28434-5-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1368073016-28434-5-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 9 May 2013 06:55:05 -0400
Message-ID: <CAJdJm_MaTBC+bT-aTbKPPDQrziq4WJArow_ERbzRiq54pp+ZJg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 05/26] attrib: Get rid of guint* types
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, May 9, 2013 at 12:16 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> diff --git a/attrib/gatt.h b/attrib/gatt.h
> index 305b4c6..d5758b7 100644
> --- a/attrib/gatt.h
> +++ b/attrib/gatt.h
> @@ -22,6 +22,7 @@
>   *
>   */
>
> +#include <inttypes.h>
>  #include <bluetooth/sdp.h>

We used to avoid adding includes into headers, and instead add them on
the .c files only. (The existing include above is a unfortunate
exception). Not sure if this convention has changed since.

> diff --git a/attrib/gattrib.h b/attrib/gattrib.h
> index 3fe92c7..a1f2dd8 100644
> --- a/attrib/gattrib.h
> +++ b/attrib/gattrib.h
> @@ -28,6 +28,8 @@
>  extern "C" {
>  #endif
>
> +#include <inttypes.h>
> +
>  #define GATTRIB_ALL_EVENTS 0xFF
>  #define GATTRIB_ALL_REQS 0xFE
>  #define GATTRIB_ALL_HANDLES 0x0000

Same thing here.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
