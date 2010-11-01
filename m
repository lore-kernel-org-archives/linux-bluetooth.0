Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288608899-23032-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1288608899-23032-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Date: Tue, 2 Nov 2010 01:10:52 +0200
Message-ID: <AANLkTi=DYpOHkifzuUNjwz7tm0vY-CimRaPx27qE40A1@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add support for sending PBAP response in many parts
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 1, 2010 at 12:54 PM, Radoslaw Jablonski
<ext-jablonski.radoslaw@nokia.com> wrote:
> Previously pull result from PBAP was returned always in one big
> part - a lot of memory was used to store all data. Now it is
> possible to send data from pbap in many smaller chunks.
> ---
>  plugins/pbap.c |   29 ++++++++++++++++++++++++++++-
>  1 files changed, 28 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/pbap.c b/plugins/pbap.c
> index 3ea7d6b..b4c1f00 100644
> --- a/plugins/pbap.c
> +++ b/plugins/pbap.c
> @@ -143,6 +143,7 @@ struct pbap_session {
>        uint32_t find_handle;
>        GString *buffer;
>        struct cache cache;
> +       gboolean partial_resp;
>  };
>
>  static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
> @@ -262,6 +263,10 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
>                pbap->buffer = g_string_append_len(pbap->buffer, buffer,
>                                                                bufsize);
>
> +       /* If partial_resp will be set to TRUE, then we won't end transmission
> +        * after sending one part of results to the client via obex*/
> +       pbap->partial_resp = missed ? TRUE : FALSE;
> +
>        obex_object_set_io_flags(pbap, G_IO_IN, 0);
>  }
>
> @@ -829,6 +834,28 @@ fail:
>        return NULL;
>  }
>
> +static ssize_t string_read_part(void *object, void *buf, size_t count,
> +                               gboolean partial)
> +{
> +       GString *string = object;
> +       ssize_t len;
> +
> +       if (string->len == 0) {
> +               /* if more data will be available later, returning -EAGAIN
> +               * instead of 0 (it will suspend request) */
> +               if (partial)
> +                       return -EAGAIN;
> +               else
> +                       return 0;
> +       }
> +
> +       len = MIN(string->len, count);
> +       memcpy(buf, string->str, len);
> +       string = g_string_erase(string, 0, len);
> +
> +       return len;
> +}
> +
>  static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
>                                                                uint8_t *hi)
>  {
> @@ -847,7 +874,7 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
>                /* Stream data */
>                *hi = OBEX_HDR_BODY;
>
> -       return string_read(pbap->buffer, buf, count);
> +       return string_read_part(pbap->buffer, buf, count, pbap->partial_resp);
>  }

Im not sure why you decided to create another string_read copy to
handle this, why not using string_read return and check if it is a
partial response on directly on vobject_pull_read? Sounds simple to me
and don't duplicate any code.

>  static ssize_t vobject_list_read(void *object, void *buf, size_t count,
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
Computer Engineer
