Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298462180-17737-1-git-send-email-epx@signove.com>
References: <1298462180-17737-1-git-send-email-epx@signove.com>
Date: Wed, 23 Feb 2011 09:09:13 -0300
Message-ID: <AANLkTimcd+ryA9u9d0-qGm_eWTa3zDnRVOEVPfOek6BS@mail.gmail.com>
Subject: Re: [PATCH] Check malformed notification/indication PDU
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Wed, Feb 23, 2011 at 8:56 AM, Elvis Pfützenreuter <epx@signove.com> wrote:
> This patch implements discard of obviously malformed
> GATT notification/indication PDUs.
> ---
>  attrib/client.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/attrib/client.c b/attrib/client.c
> index 0f9ba3e..dc7ee8b 100644
> --- a/attrib/client.c
> +++ b/attrib/client.c
> @@ -272,9 +272,16 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
>        struct primary *prim;
>        GSList *lprim, *lchr;
>        uint8_t opdu[ATT_MAX_MTU];
> -       guint handle = att_get_u16(&pdu[1]);
> +       guint handle;
>        uint16_t olen;
>
> +       if (len < 3) {
> +               DBG("Malformed notif/indic packet (opcode %x)", pdu[0]);
> +               return;
> +       }
> +
> +       handle = att_get_u16(&pdu[1]);
> +

Patch looks fine, I'd only like to suggest using
"notification/indication" instead of abbreviations, and "0x%02x" for
the opcode format.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
