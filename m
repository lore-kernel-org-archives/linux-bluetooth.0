Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421931391-13768-1-git-send-email-s.nageshmurt@samsung.com>
References: <1421931391-13768-1-git-send-email-s.nageshmurt@samsung.com>
Date: Thu, 22 Jan 2015 16:33:00 +0200
Message-ID: <CABBYNZLp4uwsTjxi0JP6hMs3+7S=fjFC1B313Wh2sEJWYX_mMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] audio/avrcp: Assign player id during player registration
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

On Thu, Jan 22, 2015 at 2:56 PM, Sagar Nageshmurthy
<s.nageshmurt@samsung.com> wrote:
> ---
>  profiles/audio/avrcp.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 11de6ee..3826a91 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3662,6 +3662,7 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
>         struct avrcp_server *server;
>         struct avrcp_player *player;
>         GSList *l;
> +       static uint16_t id = 0;
>
>         server = find_server(servers, adapter);
>         if (!server)
> @@ -3672,6 +3673,7 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
>         player->cb = cb;
>         player->user_data = user_data;
>         player->destroy = destroy;
> +       player->id = ++id ? id : 1;

It is still possible that the id is taken, that means you would have
to do a lookup in the list the find out what is the next id available,
also the id itself needs to be adjusted otherwise the very next player
would attempt to register id 1 again.

>         server->players = g_slist_append(server->players, player);
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
