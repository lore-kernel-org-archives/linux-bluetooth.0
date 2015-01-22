Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421837662-25727-1-git-send-email-s.nageshmurt@samsung.com>
References: <1421837662-25727-1-git-send-email-s.nageshmurt@samsung.com>
Date: Thu, 22 Jan 2015 11:12:02 +0200
Message-ID: <CABBYNZL90zddWUdPbQovdBVfd8CcnQvsSk4BP05KrQx55MDcpw@mail.gmail.com>
Subject: Re: [PATCH 1/1] audio/avrcp: Assign player id during player registration
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

On Wed, Jan 21, 2015 at 12:54 PM, Sagar Nageshmurthy
<s.nageshmurt@samsung.com> wrote:
> ---
>  profiles/audio/avrcp.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 11de6ee..d258c28 100644
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
> +       player->id = ++id;
>
>         server->players = g_slist_append(server->players, player);
>
> --
> 1.7.9.5

Id reuse the id if possible, but we are not really using the id for
anything in the TG so I wonder what is you plan regarding it?


-- 
Luiz Augusto von Dentz
