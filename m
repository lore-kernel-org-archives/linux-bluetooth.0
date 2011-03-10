Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1299760873-15742-1-git-send-email-epx@signove.com>
References: <1299760873-15742-1-git-send-email-epx@signove.com>
Date: Thu, 10 Mar 2011 09:46:37 -0400
Message-ID: <AANLkTi=_Wu5X5SstdOe=CEnS6-Tddjd9TLhCQKcwp+7Z@mail.gmail.com>
Subject: Re: [PATCH v3] Implement ATT handle indications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Thu, Mar 10, 2011 at 8:41 AM, Elvis Pfützenreuter <epx@signove.com> wrote:
> ---
>  src/attrib-server.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index b980b28..ec221d1 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -875,6 +875,8 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
>                length = find_by_type(start, end, &uuid, value, vlen,
>                                                        opdu, channel->mtu);
>                break;
> +       case ATT_OP_HANDLE_CNF:
> +               return;
>        case ATT_OP_READ_MULTI_REQ:
>        case ATT_OP_PREP_WRITE_REQ:
>        case ATT_OP_EXEC_WRITE_REQ:
> @@ -972,6 +974,26 @@ static void attrib_notify_clients(struct attribute *attr)
>                        g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
>                                                        NULL, NULL, NULL);
>                }
> +
> +               /* Indication */
> +               if (g_slist_find_custom(channel->indicate,
> +                                       GUINT_TO_POINTER(handle), handle_cmp)) {
> +                       uint8_t pdu[ATT_MAX_MTU];
> +                       uint16_t len;
> +
> +                       len = enc_indication(attr, pdu, channel->mtu);
> +                       if (len == 0)
> +                               return;
> +
> +                       /*
> +                       g_attrib_send() implicitly guarantees that this
> +                       indication is sent only when the previous one has
> +                       been confirmed, so we don't need to keep a queue
> +                       */

I think the comment above can be moved to the commit message instead,
as it is a generic observation that does not apply just to this
g_attrib_send() call.

> +
> +                       g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
> +                                                       NULL, NULL, NULL);
> +               }
>        }
>  }
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
