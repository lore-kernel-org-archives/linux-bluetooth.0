Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1353351872-10628-4-git-send-email-bart@elbrys.com>
References: <1353351872-10628-1-git-send-email-bart@elbrys.com>
	<1353351872-10628-4-git-send-email-bart@elbrys.com>
Date: Mon, 19 Nov 2012 16:38:07 -0400
Message-ID: <CAJdJm_N1hJkdEqvOrgD8ErAzDT56wzPEYAiA+7KDR0Pah4P6sA@mail.gmail.com>
Subject: Re: [PATCH 3/3] sdp: Upgrade datatype SEQ8 to SEQ16 when data size is
 greater than 256
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Bart Westgeest <bart@elbrys.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bart,

On Mon, Nov 19, 2012 at 3:04 PM, Bart Westgeest <bart@elbrys.com> wrote:
> Fixes a bug where the complete sequence data is written, but the size
> is truncated to one byte.
> ---
>  lib/sdp.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/lib/sdp.c b/lib/sdp.c
> index 026163e..ceb1192 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -786,23 +786,29 @@ static int sdp_gen_buffer(sdp_buf_t *buf, sdp_data_t *d)
>
>  int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
>  {
> -       uint32_t pdu_size = 0, data_size = 0;
> +       uint32_t pdu_size, data_size;
>         unsigned char *src = NULL, is_seq = 0, is_alt = 0;
> -       uint8_t dtd = d->dtd;
>         uint16_t u16;
>         uint32_t u32;
>         uint64_t u64;
>         uint128_t u128;
>         uint8_t *seqp = buf->data + buf->data_size;
> +       uint32_t orig_data_size = buf->data_size;
>
> -       pdu_size = sdp_get_data_type_size(dtd);
> +recalculate:
> +       pdu_size = sdp_get_data_type_size(d->dtd);
>         buf->data_size += pdu_size;
>
>         data_size = sdp_get_data_size(buf, d);
> +       if (data_size > UCHAR_MAX && d->dtd == SDP_SEQ8) {
> +               buf->data_size = orig_data_size;
> +               d->dtd = SDP_SEQ16;
> +               goto recalculate;

IMHO, using "goto" here is too complicated for 3 lines of code that
will just be run at most twice. So I would simply duplicate them
inside the if(). But others may have different opinion on this regard.

> +       }
>
> -       *seqp = dtd;
> +       *seqp = d->dtd;
>
> -       switch (dtd) {
> +       switch (d->dtd) {
>         case SDP_DATA_NIL:
>                 break;
>         case SDP_UINT8:

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
