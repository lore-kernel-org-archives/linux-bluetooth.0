Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417405863-8331-1-git-send-email-biradar.a@samsung.com>
References: <1417405863-8331-1-git-send-email-biradar.a@samsung.com>
Date: Mon, 1 Dec 2014 17:20:02 +0200
Message-ID: <CABBYNZLmOWdKpLo-dgFkPt5ZVp-HfbyKo8ozmLTxwMnwnSze=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] pbap: Fix When MaxListCount header missing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anurag Biradar <biradar.a@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anurag,

On Mon, Dec 1, 2014 at 5:51 AM, Anurag Biradar <biradar.a@samsung.com> wrote:
> As per spec(5.3.4.4) when MaxListCount headser is missing then
> PSE should assume MaxListCount value as MAX (65535)
> ---
>  obexd/plugins/pbap.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
> index acac3aa..d3c1986 100644
> --- a/obexd/plugins/pbap.c
> +++ b/obexd/plugins/pbap.c
> @@ -65,6 +65,8 @@
>  #define PHONEBOOKSIZE_TAG      0X08
>  #define NEWMISSEDCALLS_TAG     0X09
>
> +#define PBAP_MAXLISTCOUNT_MAX_VALUE 65535
> +
>  struct cache {
>         gboolean valid;
>         uint32_t index;
> @@ -447,7 +449,7 @@ static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
>  {
>         GObexApparam *apparam;
>         struct apparam_field *param;
> -
> +       gboolean bmaxlistCount = FALSE;
>         apparam = g_obex_apparam_decode(buffer, hlen);
>         if (apparam == NULL)
>                 return NULL;
> @@ -458,13 +460,17 @@ static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
>         g_obex_apparam_get_uint8(apparam, SEARCHATTRIB_TAG,
>                                                 &param->searchattrib);
>         g_obex_apparam_get_uint8(apparam, FORMAT_TAG, &param->format);
> -       g_obex_apparam_get_uint16(apparam, MAXLISTCOUNT_TAG,
> +       bmaxlistCount = g_obex_apparam_get_uint16(apparam, MAXLISTCOUNT_TAG,
>                                                 &param->maxlistcount);
>         g_obex_apparam_get_uint16(apparam, LISTSTARTOFFSET_TAG,
>                                                 &param->liststartoffset);
>         g_obex_apparam_get_uint64(apparam, FILTER_TAG, &param->filter);
>         param->searchval = g_obex_apparam_get_string(apparam, SEARCHVALUE_TAG);
>
> +       /* As per spec when client doesn't include MAXLISTCOUNT_TAG then it should be assume as
> +         * Maximum value in vcardlisting 65535 */
> +       if (bmaxlistCount == FALSE)
> +               param->maxlistcount = PBAP_MAXLISTCOUNT_MAX_VALUE;
>         DBG("o %x sa %x sv %s fil %" G_GINT64_MODIFIER "x for %x max %x off %x",
>                         param->order, param->searchattrib, param->searchval,
>                         param->filter, param->format, param->maxlistcount,
> --
> 1.7.9.5

Applied, but please next time try to adhere to the coding style
(doc/coding-style.txt), this time Ive fixed for you but I might not do
it again.


-- 
Luiz Augusto von Dentz
