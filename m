Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1350388692-15239-2-git-send-email-luiz.dentz@gmail.com>
References: <1350388692-15239-1-git-send-email-luiz.dentz@gmail.com> <1350388692-15239-2-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 16 Oct 2012 10:58:19 -0300
Message-ID: <CAMOw1v5mMvJqp7=fazgxSVL+95Fjmka1HLaT50WSO90jU3HigQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] AVRCP: Don't respond with errors when no player
 is registered
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 16, 2012 at 8:58 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Some devices w.g. Sony MW600 will stop using certain commands if an
> error happen, so the code now just fake a player and once a real
> player is registered it takes place of the fake one.
> ---
>  audio/avrcp.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 74 insertions(+), 17 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 5a18cb4..cd57358 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -493,6 +493,28 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
>         return;
>  }
>
> +static const char *player_get_string(struct avrcp_player *player, uint32_t attr)
> +{

Instead of adding these wrapper functions, did you consider having a
default_avrcp_player with all hooks set and player pointing to it if
there's no player registered?

Lucas De Marchi
