Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317316050-12855-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi> <1317316050-12855-2-git-send-email-lucas.demarchi@profusion.mobi>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 29 Sep 2011 15:01:05 -0300
Message-ID: <CAMOw1v5C5w0yORoiwRoDrDop=6bncHU0CNSp95q3M5mr3zjbmA@mail.gmail.com>
Subject: Re: [PATCH 1/3] AVRCP: fix changed notification
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Sep 29, 2011 at 2:07 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> We sure want to send notifications only when section is not NULL.
> Otherwise we either crash or do not send the expected notification.
> ---
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index ac9a107..e5b51db 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -549,7 +549,7 @@ static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
>        uint16_t size;
>        int err;
>
> -       if (mp->session)
> +       if (mp->session == NULL)
>                return -ENOTCONN;

This fixes the issue with recent code move, but thinking about it see
the following scenario:

1) CT connects to TG and registers itself for events
2) CT disconnects
3) CT connects again, but does not register for receiving track-change
notification
4) Track changes and we send the track-change notification


It seems like (4) is wrong and what we really need to do is to
unregister the events when we are disconnected. What do you think?



Lucas De Marchi
