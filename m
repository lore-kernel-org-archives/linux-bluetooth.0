Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338998771-18683-2-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-2-git-send-email-michal.labedzki@tieto.com>
Date: Thu, 7 Jun 2012 11:27:05 +0300
Message-ID: <CABBYNZK7SE-fSxPdyORsLDWiUa2nOvAr2tH2aERkDqqs144PLQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] AVRCP: Use name "addressed" instead of "active"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Jun 6, 2012 at 7:06 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> AVRCP 1.4 named currently controlled player as "addressed", so use
> this name instead of "active". In future there where be more "browsing"
> player that will be active, but not addressed.
> ---
>  audio/avrcp.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 196d6a5..7576e19 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -199,7 +199,7 @@ struct avrcp_server {
>        uint32_t tg_record_id;
>        uint32_t ct_record_id;
>        GSList *players;
> -       struct avrcp_player *active_player;
> +       struct avrcp_player *addressed_player;
>  };
>
>  struct pending_pdu {
> @@ -1253,7 +1253,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
>        if (!server)
>                return;
>
> -       player = server->active_player;
> +       player = server->addressed_player;
>        if (!player)
>                return;
>
> @@ -1446,7 +1446,7 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
>        player->destroy = destroy;
>
>        if (!server->players)
> -               server->active_player = player;
> +               server->addressed_player = player;
>
>        if (!avctp_id)
>                avctp_id = avctp_add_state_cb(state_changed, NULL);
> @@ -1462,8 +1462,8 @@ void avrcp_unregister_player(struct avrcp_player *player)
>
>        server->players = g_slist_remove(server->players, player);
>
> -       if (server->active_player == player)
> -               server->active_player = g_slist_nth_data(server->players, 0);
> +       if (server->addressed_player == player)
> +               server->addressed_player = g_slist_nth_data(server->players, 0);
>
>        player_destroy(player);
>  }
> @@ -1498,7 +1498,7 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
>        if (server == NULL)
>                return -EINVAL;
>
> -       player = server->active_player;
> +       player = server->addressed_player;
>        if (player == NULL)
>                return -ENOTSUP;
>
> --
> on behalf of ST-Ericsson


The concept of active and addressed are a bit different, the active
means the player can be addressed but not necessary in use, this is to
allow bluetoothd to control the addressed player without another
component setting it. Iirc I have said this before in irc, but Im not
sure if was you or someone else, we can detect if a player is active
e.g by checking its status, this way we can probably pick the first
player active so they don't have to compete to set themselves as
addressed or anything like that, then if the player is stopped/become
inactive we can pick the next active, same goes if the remote device
change the addressed player we just change it, the player or other
components don't need to know about the details of which is being
addressed.

Btw, do you realize that addressed player is controlled by the remote
device, as far audio is concern it can be mixed with several different
playbacks in the same stream, so it more a matter of which player's
metadata the remote would like to display, which is probably idiotic
since you limit the events and commands to only the addressed and push
some complexity to the target where it could just have the signalling
working to as many as the controller can handle.

-- 
Luiz Augusto von Dentz
