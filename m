Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308445186-27135-11-git-send-email-adamek.kuba@gmail.com>
References: <1308445186-27135-1-git-send-email-adamek.kuba@gmail.com>
	<1308445186-27135-11-git-send-email-adamek.kuba@gmail.com>
Date: Mon, 20 Jun 2011 13:13:34 +0300
Message-ID: <BANLkTi==9OKfA1iOnyu5KPuL3QQRd14ZtQ@mail.gmail.com>
Subject: Re: [PATCH obexd 10/10] Add func for fetching header by id from list
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Adamek <adamek.kuba@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Sun, Jun 19, 2011 at 3:59 AM, Jakub Adamek <adamek.kuba@gmail.com> wrote:
> ---
>  gwobex/obex-xfer.c |   10 ++++++++++
>  gwobex/obex-xfer.h |    2 ++
>  2 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/gwobex/obex-xfer.c b/gwobex/obex-xfer.c
> index 20a3221..413fed9 100644
> --- a/gwobex/obex-xfer.c
> +++ b/gwobex/obex-xfer.c
> @@ -472,6 +472,16 @@ void a_header_free(struct a_header *ah) {
>     g_free(ah);
>  }
>
> +struct a_header *a_header_find(GSList *aheaders, uint8_t hi) {
> +    while (aheaders) {

Avoid casts, use a proper variable e.g. struct a_header *ah =
aheaders->data and avoid braces for single line if statements.

> +        if (((struct a_header *)aheaders->data)->hi == hi) {
> +            return aheaders->data;
> +        }
> +        aheaders = g_slist_next(aheaders);
> +    }
> +    return NULL;
> +}
> +
>  void _gw_obex_xfer_free(struct gw_obex_xfer *xfer) {
>     GSList *aheaders = xfer->aheaders;
>     while (aheaders) {
> diff --git a/gwobex/obex-xfer.h b/gwobex/obex-xfer.h
> index 61aa048..50dadad 100644
> --- a/gwobex/obex-xfer.h
> +++ b/gwobex/obex-xfer.h
> @@ -95,6 +95,8 @@ void a_header_free(struct a_header *ah);
>
>  struct a_header *a_header_copy(struct a_header *ah);
>
> +struct a_header *a_header_find(GSList *aheaders, uint8_t hi);
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
