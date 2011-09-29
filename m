Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317316050-12855-3-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1317316050-12855-3-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 29 Sep 2011 22:18:23 +0300
Message-ID: <CABBYNZ+92-G4zO-BXYQtMx24ucc=-2H1zvyOmRoq8iPv2gOTKQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] AVRCP: fix missing bytes on notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Sep 29, 2011 at 8:07 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/avrcp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index e5b51db..6e8b8ff 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -591,7 +591,7 @@ static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
>
>        err = avctp_send_vendordep(mp->session, mp->transaction_events[id],
>                                        AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
> -                                       buf, size);
> +                                       buf, size + AVRCP_HEADER_LENGTH);
>        if (err < 0)
>                return err;
>
> --
> 1.7.6.4

Ack.

-- 
Luiz Augusto von Dentz
