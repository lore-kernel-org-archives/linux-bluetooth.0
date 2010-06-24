Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1277320206-6969-1-git-send-email-harri.mahonen@gmail.com>
References: <1277320206-6969-1-git-send-email-harri.mahonen@gmail.com>
Date: Thu, 24 Jun 2010 10:52:47 +0300
Message-ID: <AANLkTikqyXXpC0guYSAZb4L-V6Cg5A_L6MJdcc5ChRpJ@mail.gmail.com>
Subject: Re: [PATCH] audio: fix memory leak with typefinding
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: harri.mahonen@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 23, 2010 at 10:10 PM,  <harri.mahonen@gmail.com> wrote:
> From: Harri Mahonen <harri.mahonen@gmail.com>
>
> sbc structure gets leaked each time when there is no data or SBC
> syncword, because sbc_finalize is not called. Call sbc_init after
> checking the data for syncword.
>
> Signed-off-by: Harri Mahonen <harri.mahonen@gmail.com>
> ---
>  audio/gstbluetooth.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/audio/gstbluetooth.c b/audio/gstbluetooth.c
> index 26dd4a5..11aefd7 100644
> --- a/audio/gstbluetooth.c
> +++ b/audio/gstbluetooth.c
> @@ -50,10 +50,10 @@ static void sbc_typefind(GstTypeFind *tf, gpointer ignore)
>        sbc_t sbc;
>        guint8 *data = gst_type_find_peek(tf, 0, 32);
>
> -       if (sbc_init(&sbc, 0) < 0)
> +       if (data == NULL || *data != 0x9c)      /* SBC syncword */
>                return;
>
> -       if (data == NULL || *data != 0x9c)      /* SBC syncword */
> +       if (sbc_init(&sbc, 0) < 0)
>                return;
>
>        aux = g_new(guint8, 32);

We might want to have this fix inside sbc_init instead since others
projects like pulseaudio may run into the same problem, also I guess
it is a good practice to free any data allocated when returning an
error.


-- 
Luiz Augusto von Dentz
Computer Engineer
