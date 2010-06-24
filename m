Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1277390241-9449-1-git-send-email-harri.mahonen@gmail.com>
References: <1277390241-9449-1-git-send-email-harri.mahonen@gmail.com>
Date: Thu, 24 Jun 2010 17:54:53 +0300
Message-ID: <AANLkTikImy_4RNrqbgC352F9eOJrU1FDRiE5_XSgDLoI@mail.gmail.com>
Subject: Re: [PATCH v2] audio: fix memory leak with typefinding
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: harri.mahonen@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 24, 2010 at 5:37 PM,  <harri.mahonen@gmail.com> wrote:
> From: Harri Mahonen <harri.mahonen@gmail.com>
>
> Each time sbc_typefind is called and there is no syncword, sbc_finalize
> never gets called. Instead of hardcoded syncword check, rely on
> sbc_parse to do it properly.
>
> Signed-off-by: Harri Mahonen <harri.mahonen@gmail.com>
> ---
>  audio/gstbluetooth.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/audio/gstbluetooth.c b/audio/gstbluetooth.c
> index 26dd4a5..3bc0690 100644
> --- a/audio/gstbluetooth.c
> +++ b/audio/gstbluetooth.c
> @@ -50,21 +50,25 @@ static void sbc_typefind(GstTypeFind *tf, gpointer ignore)
>        sbc_t sbc;
>        guint8 *data = gst_type_find_peek(tf, 0, 32);
>
> -       if (sbc_init(&sbc, 0) < 0)
> +       if (data == NULL)
>                return;
>
> -       if (data == NULL || *data != 0x9c)      /* SBC syncword */
> +       if (sbc_init(&sbc, 0) < 0)
>                return;
>
>        aux = g_new(guint8, 32);
>        memcpy(aux, data, 32);
> -       sbc_parse(&sbc, aux, 32);
> -       g_free(aux);
> -       caps = gst_sbc_parse_caps_from_sbc(&sbc);
> -       sbc_finish(&sbc);
>
> +       if (sbc_parse(&sbc, aux, 32) < 0)
> +               goto done;
> +
> +       caps = gst_sbc_parse_caps_from_sbc(&sbc);
>        gst_type_find_suggest(tf, GST_TYPE_FIND_POSSIBLE, caps);
>        gst_caps_unref(caps);
> +
> +done:
> +       g_free(aux);
> +       sbc_finish(&sbc);
>  }
>
>  static gchar *sbc_exts[] = { "sbc", NULL };

Looks great, but we don't use the signed-off-by thing.

-- 
Luiz Augusto von Dentz
Computer Engineer
