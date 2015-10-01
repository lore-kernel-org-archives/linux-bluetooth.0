Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1443534331-27997-1-git-send-email-luiz.dentz@gmail.com>
References: <1443534331-27997-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 1 Oct 2015 17:37:24 +0300
Message-ID: <CABBYNZ+gMFjaQu6jjJhJB7uQr36yb1dzZnEiUVxKygiz8g2ipw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] audio/avrcp: Fix possible crash when current
 player is removed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 29, 2015 at 4:45 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If current player is removed a new player should be assigned.
>
> Note: In normal condition this should never happen since player 0 works
> as a place holder but there have been some cases where addressed player
> changed don't match with any player returned by GetFolderList which
> cause a new player to be created and the old one to be destroyed.
> ---
>  profiles/audio/avrcp.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 24deac5..a3ed16a 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3320,10 +3320,15 @@ static void player_remove(gpointer data)
>
>         for (l = player->sessions; l; l = l->next) {
>                 struct avrcp *session = l->data;
> +               struct avrcp_data *controller = session->controller;
>
> -               session->controller->players = g_slist_remove(
> -                                               session->controller->players,
> -                                               player);
> +               controller->players = g_slist_remove(controller->players,
> +                                                               player);
> +
> +               /* Check if current player is being removed */
> +               if (controller->player == player)
> +                       controller->player = g_slist_nth_data(
> +                                                       controller->players, 0);
>         }
>
>         player_destroy(player);
> @@ -3374,9 +3379,6 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
>                 i += len;
>         }
>
> -       if (g_slist_find(removed, session->controller->player))
> -               session->controller->player = NULL;
> -
>         g_slist_free_full(removed, player_remove);
>
>         return FALSE;
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
