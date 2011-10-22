Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319219908-2819-4-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1319219908-2819-4-git-send-email-lucas.demarchi@profusion.mobi>
Date: Sat, 22 Oct 2011 13:10:50 +0300
Message-ID: <CABBYNZJBUDH-P2dzdo6sZXd-XuME89RLo9qoGpAqgf98n3Fe2Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] Unregister players' events when disconnected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Oct 21, 2011 at 8:58 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/avrcp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index e908bf4..f06afbf 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -1119,6 +1119,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>        switch (new_state) {
>        case AVCTP_STATE_DISCONNECTED:
>                player->session = NULL;
> +               player->registered_events = 0;
>
>                if (player->handler) {
>                        avctp_unregister_pdu_handler(player->handler);
> --
> 1.7.7
>

Ack.

-- 
Luiz Augusto von Dentz
