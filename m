Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1440682565-23653-1-git-send-email-luiz.dentz@gmail.com>
References: <1440682565-23653-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 28 Aug 2015 10:54:10 +0300
Message-ID: <CABBYNZJ5dZsLK+GP24ErA+idhvDhHHjWn3YpK+Wh97hxy9Fq_w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio/avrcp: Fix invalid read
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 27, 2015 at 4:36 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Player pointer cannot be used after being freed.
> ---
>  profiles/audio/avrcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 76e89af..fa95bf9 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3942,9 +3942,10 @@ void avrcp_unregister_player(struct avrcp_player *player)
>                         target->player = g_slist_nth_data(server->players, 0);
>         }
>
> -       player_destroy(player);
>         avrcp_player_event(player,
>                                 AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
> +
> +       player_destroy(player);
>  }
>
>  static gboolean avrcp_handle_set_volume(struct avctp *conn,
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
