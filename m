Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1440583515-30033-1-git-send-email-hychao@chromium.org>
References: <1440583515-30033-1-git-send-email-hychao@chromium.org>
Date: Fri, 28 Aug 2015 11:42:40 +0300
Message-ID: <CABBYNZKD_-viP1DSZvWPaTLQ128bgqZGutu10AsVRt2+PgC-3A@mail.gmail.com>
Subject: Re: [PATCH] audio/media - Fix crash at deferencing NULL pointer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 26, 2015 at 1:05 PM, Hsin-Yu Chao <hychao@chromium.org> wrote:
> The boolean pointer passed in to config_cb could be NULL
> in media_endpoint_cancel(). In that case we should not
> derefence it but pass FALSE instead to indicate error.
>
> Below is the core dump to demonstrate the crash:
>
> config_cb (endpoint=0xb814ff40, ret=0x0, size=-1,
>     user_data=0xb8157758) at profiles/audio/media.c:537
> 0xb6eb7ba4 in media_endpoint_cancel (request=0xb815b4d0)
>     at profiles/audio/media.c:141
> 0xb6eb7c98 in media_endpoint_cancel_all (endpoint=0xb814ff40)
>     at profiles/audio/media.c:149
> clear_endpoint (endpoint=endpoint@entry=0xb814ff40)
>     at profiles/audio/media.c:250
> 0xb6eb7e74 in endpoint_reply (call=<optimized out>, user_data=0xb815b4d0)
>     at profiles/audio/media.c:277
> 0xb6d50336 in ?? () from /usr/lib/libdbus-1.so.3
> ---
>  profiles/audio/media.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index ed441d0..cad9cce 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -534,7 +534,7 @@ static void config_cb(struct media_endpoint *endpoint, void *ret, int size,
>         struct a2dp_config_data *data = user_data;
>         gboolean *ret_value = ret;
>
> -       data->cb(data->setup, *ret_value ? TRUE : FALSE);
> +       data->cb(data->setup, ret_value ? *ret_value : FALSE);
>  }
>
>  static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
> --
> 2.5.0.457.gab17608

Applied, thanks.


-- 
Luiz Augusto von Dentz
