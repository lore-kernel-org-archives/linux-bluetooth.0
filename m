Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1353351872-10628-3-git-send-email-bart@elbrys.com>
References: <1353351872-10628-1-git-send-email-bart@elbrys.com>
	<1353351872-10628-3-git-send-email-bart@elbrys.com>
Date: Mon, 19 Nov 2012 16:24:04 -0400
Message-ID: <CAJdJm_MSAw2EWV=Tp-ycdfhUi1wJdcdXdH+4YAdfGx1LRpWs-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] sdp: Limit side effects of sdp_get_data_type and sdp_get_data_size
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Bart Westgeest <bart@elbrys.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bart,

On Mon, Nov 19, 2012 at 3:04 PM, Bart Westgeest <bart@elbrys.com> wrote:
> @@ -762,9 +757,6 @@ static int sdp_get_data_size(sdp_buf_t *buf, sdp_data_t *d)
>                 break;
>         }
>
> -       if (!buf->data)
> -               buf->buf_size += data_size;
> -
>         return data_size;
>  }
>
> @@ -783,8 +775,8 @@ static int sdp_gen_buffer(sdp_buf_t *buf, sdp_data_t *d)
>         /* attribute length */
>         buf->buf_size += sizeof(uint8_t) + sizeof(uint16_t);
>
> -       sdp_get_data_type(buf, d->dtd);
> -       sdp_get_data_size(buf, d);
> +       buf->buf_size += sdp_get_data_type_size(d->dtd);
> +       buf->buf_size += sdp_get_data_size(buf, d);

No need to check for "if (!buf->data)" like in the original code?

>
>         if (buf->buf_size > UCHAR_MAX && d->dtd == SDP_SEQ8)
>                 buf->buf_size += sizeof(uint8_t);
> @@ -803,7 +795,7 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
>         uint128_t u128;
>         uint8_t *seqp = buf->data + buf->data_size;
>
> -       pdu_size = sdp_get_data_type(buf, dtd);
> +       pdu_size = sdp_get_data_type_size(dtd);

Same here. Additionally, buf->buf_size is not being updated.

>         buf->data_size += pdu_size;
>
>         data_size = sdp_get_data_size(buf, d);

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
