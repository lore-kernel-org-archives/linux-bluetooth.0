Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414577015-11215-1-git-send-email-bharat.panda@samsung.com>
References: <1414577015-11215-1-git-send-email-bharat.panda@samsung.com>
Date: Wed, 29 Oct 2014 13:32:04 +0200
Message-ID: <CABBYNZ+8Ab_Z_EibMyyJurmRPq7XQif_CpLzJYXP4qZK7J8LFg@mail.gmail.com>
Subject: Re: [PATCH ] profiles/audio: Fix bluetoothd crash in a2dp
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 29, 2014 at 12:03 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Checks for NULL session before calling avdtp_get_device, as
> setup->session will be NULL if configuraion was aborted.

Could you please add the backtrace of the crash?

> ---
>  profiles/audio/a2dp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index c9dac9a..810d1e6 100644
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
> @@ -389,6 +389,10 @@ static gboolean auto_config(gpointer data)
>         if (setup->err != NULL)
>                 goto done;
>
> +       /* session will be NULL if configuration was aborted */
> +       if (setup->session)
> +               dev = avdtp_get_device(setup->session);
> +
>         avdtp_stream_add_cb(setup->session, setup->stream,
>                                 stream_state_changed, setup->sep);

Perhaps this is caused by g_idle_add in endpoint_setconf_ind, but by
looking at it seems that we have some better options as either call it
auto_config directly which may cause the session to be freed before
returning to avdtp_setconf_cmd, take a extra reference which might
still cause some problems since the session would still exists while
we may be disconnected already, or the one I prefer is to take the id
of g_idle_add and do g_source_remove if the setup is aborted.




-- 
Luiz Augusto von Dentz
