Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1362481619-25815-7-git-send-email-szymon.janc@tieto.com>
References: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
	<1362481619-25815-7-git-send-email-szymon.janc@tieto.com>
Date: Tue, 5 Mar 2013 16:01:50 +0200
Message-ID: <CABBYNZ+byCbXrmFSJmdkk=RUUD-=DKjELXmcXFyXb6KgYwW2Ww@mail.gmail.com>
Subject: Re: [PATCH 6/6] source: Register state callback for specified audio device
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Mar 5, 2013 at 1:06 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> State callback will now be registered and called for specified device
> only. This will allow for more cleaner callback register/unregister
> in roles code.
> ---
>  profiles/audio/source.c    | 9 ++++++++-
>  profiles/audio/source.h    | 3 ++-
>  profiles/audio/transport.c | 5 +----
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/profiles/audio/source.c b/profiles/audio/source.c
> index 4ebe598..5c5568a 100644
> --- a/profiles/audio/source.c
> +++ b/profiles/audio/source.c
> @@ -70,6 +70,7 @@ struct source {
>
>  struct source_state_callback {
>         source_state_cb cb;
> +       struct audio_device *dev;
>         void *user_data;
>         unsigned int id;
>  };
> @@ -96,6 +97,10 @@ static void source_set_state(struct audio_device *dev, source_state_t new_state)
>
>         for (l = source_callbacks; l != NULL; l = l->next) {
>                 struct source_state_callback *cb = l->data;
> +
> +               if (cb->dev != dev)
> +                       return;
> +

The above code should be continue instead of return.
