Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1442320893-31536-1-git-send-email-luiz.dentz@gmail.com>
References: <1442320893-31536-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2015 13:21:42 +0300
Message-ID: <CABBYNZJxZUWnbtzUd5Biwvqw-EoLhGkOmy7C=S7+p4wmrQVPhQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/5] audio/avrcp: Fix missing event for volume control
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 15, 2015 at 3:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> CT and TG are always relative to client and server role, so although TG is
> associated with a player and CT with a remote controller in case of volume
> control the CT is in fact the player and the TG the remote controller,
> because of that PTS will not register any TG record when testing this thus
> controller_init will not register the necessary events.
> ---
>  profiles/audio/avrcp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 750bdd9..703d084 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3805,7 +3805,8 @@ static void target_init(struct avrcp *session)
>
>         session->supported_events |=
>                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
>
>         /* Only check capabilities if controller is not supported */
>         if (session->controller == NULL)
> @@ -3831,9 +3832,6 @@ static void controller_init(struct avrcp *session)
>
>         DBG("%p version 0x%04x", controller, controller->version);
>
> -       if (controller->version >= 0x0104)
> -               session->supported_events |= (1 << AVRCP_EVENT_VOLUME_CHANGED);
> -
>         service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
>         btd_service_connecting_complete(service, 0);
>
> --
> 2.4.3

Pushed.


-- 
Luiz Augusto von Dentz
