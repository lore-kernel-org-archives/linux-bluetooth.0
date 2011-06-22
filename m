Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308695065-3784-4-git-send-email-adamek.kuba@gmail.com>
References: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
	<1308695065-3784-4-git-send-email-adamek.kuba@gmail.com>
Date: Wed, 22 Jun 2011 10:05:46 +0300
Message-ID: <BANLkTimaKzGiy8tOHUKws3R0hbuVmSwRbg@mail.gmail.com>
Subject: Re: [PATCH obexd v2 03/11] Add function to create fresh a_header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Adamek <adamek.kuba@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jun 22, 2011 at 1:24 AM, Jakub Adamek <adamek.kuba@gmail.com> wrote:
> ---
>  gwobex/obex-xfer.c |   25 +++++++++++++++++++++++++
>  gwobex/obex-xfer.h |    3 +++
>  2 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
> index 1430f10..55ea842 100644
> --- a/gwobex/obex-xfer.c
> +++ b/gwobex/obex-xfer.c
> @@ -422,6 +422,31 @@ out:
>     return ret;
>  }
>
> +struct a_header *make_a_header(uint8_t hi, obex_headerdata_t hv,
> +        unsigned int hlen) {

Align this to right until you cross the parentesis or reaches the 80
columns limit, iirc the gwobex uses a different code style but I guess
this is also valid here.

> +    struct a_header *ah = g_new0(struct a_header, 1);
> +    ah->hi = hi;
> +    ah->hv_size = hlen;
> +    switch (hi & OBEX_HDR_TYPE_MASK) {
> +        case OBEX_HDR_TYPE_UINT8:
> +        case OBEX_HDR_TYPE_UINT32:
> +            ah->hv = hv;
> +            break;
> +        case OBEX_HDR_TYPE_BYTES:
> +        case OBEX_HDR_TYPE_UNICODE:
> +            ah->hv.bs = g_try_malloc(hlen);
> +            if (ah->hv.bs != NULL)
> +                memcpy((void *) ah->hv.bs, hv.bs, hlen);
> +            else if (hlen > 0) {
> +                g_free(ah);
> +                return NULL;
> +            }
> +            ah->hv_size = hlen;
> +        break;
> +    }
> +    return ah;
> +}
> +
>  void a_header_free(struct a_header *ah) {
>     switch (ah->hi & OBEX_HDR_TYPE_MASK) {
>         case OBEX_HDR_TYPE_BYTES:
> diff --git a/gwobex/obex-xfer.h b/gwobex/obex-xfer.h
> index b1e2ff0..7c59827 100644
> --- a/gwobex/obex-xfer.h
> +++ b/gwobex/obex-xfer.h
> @@ -93,6 +93,9 @@ struct a_header {
>
>  void a_header_free(struct a_header *ah);
>
> +struct a_header *make_a_header(uint8_t hi, obex_headerdata_t hv,
> +                                             unsigned int hlen);
> +
>  struct gw_obex_xfer *gw_obex_xfer_new(struct gw_obex *ctx, gboolean async, int stream_fd);
>
>  void _gw_obex_xfer_free(struct gw_obex_xfer *xfer);
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
