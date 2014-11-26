Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416832900-16924-1-git-send-email-s.nageshmurt@samsung.com>
References: <1416832900-16924-1-git-send-email-s.nageshmurt@samsung.com>
Date: Wed, 26 Nov 2014 16:15:38 +0200
Message-ID: <CABBYNZL7gqrX1Vnro5Kb+gOxv0omDcrg4HaAw3jCyyyeUroeLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] audio/a2dp: Fix Access session device only when its valid
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

On Mon, Nov 24, 2014 at 2:41 PM, Sagar Nageshmurthy
<s.nageshmurt@samsung.com> wrote:
> session will be NULL if A2DP connection fails because of NO REPLY
> from endpoint or if the configuration is aborted. Accessing session
> device in such a scenario leads to bluetoothd crash.
>
> (gdb) bt full
> 0  avdtp_get_device (session=0x0) at profiles/audio/avdtp.c:3987
> No locals.
> 1  0xb6f0e352 in auto_config (data=<value optimized out>)
>     at profiles/audio/a2dp.c:382
>         setup = 0xb7a4f230
>         dev = <value optimized out>
> 2  0xb6f132f6 in config_cb (endpoint=<value optimized out>,
>     ret=<value optimized out>, size=<value optimized out>,
>     user_data=<value optimized out>) at profiles/audio/media.c:534
>         data = <value optimized out>
> 3  0xb6f1398a in media_endpoint_cancel (endpoint=0xb7a43e78)
>     at profiles/audio/media.c:136
>         endpoint = 0xb7a43e78
> 4  media_endpoint_cancel_all (endpoint=0xb7a43e78)
>     at profiles/audio/media.c:144
> No locals.
> 5  0xb6f13e04 in clear_endpoint (endpoint=0xb7a43e78)
>     at profiles/audio/media.c:245
> No locals.
> 6  0xb6f13f68 in endpoint_reply (call=<value optimized out>,
>     user_data=0xb7a4e538) at profiles/audio/media.c:275
>         request = 0xb7a4e538
>         endpoint = 0xb7a43e78
>         reply = 0xb7a3f560
>         err = {name = 0xb7a5de70 "org.freedesktop.DBus.Error.NoReply"
> ---
>  profiles/audio/a2dp.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index c9dac9a..6b72f99 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -379,7 +379,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
>  static gboolean auto_config(gpointer data)
>  {
>         struct a2dp_setup *setup = data;
> -       struct btd_device *dev = avdtp_get_device(setup->session);
> +       struct btd_device *dev = NULL;
>         struct btd_service *service;
>
>         /* Check if configuration was aborted */
> @@ -389,6 +389,8 @@ static gboolean auto_config(gpointer data)
>         if (setup->err != NULL)
>                 goto done;
>
> +       dev = avdtp_get_device(setup->session);
> +
>         avdtp_stream_add_cb(setup->session, setup->stream,
>                                 stream_state_changed, setup->sep);
>
> --
> 1.7.9.5

Applied, thanks.

-- 
Luiz Augusto von Dentz
