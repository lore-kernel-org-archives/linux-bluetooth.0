Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <eb7933e20908270824w2dc3ae2x8257d20d307ce6fd@mail.gmail.com>
References: <eb7933e20908270824w2dc3ae2x8257d20d307ce6fd@mail.gmail.com>
Date: Thu, 27 Aug 2009 14:08:44 -0300
Message-ID: <2d5a2c100908271008v67bb1b86xa5ad5ef6e95ba49a@mail.gmail.com>
Subject: Re: [PATCH] AVDTP start/stop handling during disconnection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Aug 27, 2009 at 12:24 PM, Daniel
Örstadius<daniel.orstadius@gmail.com> wrote:
> A suggested patch for rejecting AVDTP CLOSE and START requests when a
> CLOSE request has been initiated. The check is done by testing the
> close_int flag in the avdtp_stream struct. The flag is reset when
> receiving a timeout or rejection from the remote.
>
> Changes in unix.c were made to call avdtp_unref() in case an AVDTP
> session was marked by avdtp_ref(), but no SEP was found. This could
> happen if START is called on a session being disconnected.
>
> We found that these changes help to improve behavior both in case the
> audio streaming application tries to start the stream during a
> disconnection procedure, and if avdtp_close() is called twice.

It probably works better if you place it on avdtp struct so it works
even if we don't have a stream configured, I also prefer closing
instead of close_int.

The other parts looks good except this:

> diff --git a/audio/unix.c b/audio/unix.c
> index 0829630..61cc369 100644
> --- a/audio/unix.c
> +++ b/audio/unix.c
> @@ -1051,14 +1051,17 @@ static void start_resume(struct audio_device
> *dev, struct unix_client *client)
>        struct a2dp_data *a2dp;
>        struct headset_data *hs;
>        unsigned int id;
> +       gboolean ref_session = FALSE;
>
>        switch (client->type) {
>        case TYPE_SINK:
>        case TYPE_SOURCE:
>                a2dp = &client->d.a2dp;
>
> -               if (!a2dp->session)
> +               if (!a2dp->session) {
>                        a2dp->session = avdtp_get(&dev->src, &dev->dst);
> +                       ref_session = TRUE;
> +               }
>
>                if (!a2dp->session) {
>                        error("Unable to get a session");
> @@ -1067,6 +1070,12 @@ static void start_resume(struct audio_device
> *dev, struct unix_client *client)
>
>                if (!a2dp->sep) {
>                        error("seid not opened");
> +
> +                       if (ref_session) {
> +                               avdtp_unref(a2dp->session);
> +                               a2dp->session = NULL;
> +                       }
> +
>                        goto failed;
>                }

Normally we should wait for the client to disconnect then we release
its avdtp session, if it is closing/closed we shouldn't even attempt
to create another session to destroy a few lines ahead. So in this
case the client probably need fixing so it don't even try to start
while closing/closed.

ps: There is a patch to pulseaudio already that should fix this:
http://git.0pointer.de/?p=pulseaudio.git;a=commitdiff;h=8169a6a6c921215c1353e8a34fccbdc4e2e20440

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
