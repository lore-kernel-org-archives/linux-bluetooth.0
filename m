Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1453475668-4609-1-git-send-email-luiz.dentz@gmail.com>
References: <1453475668-4609-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 28 Jan 2016 12:12:50 +0200
Message-ID: <CABBYNZ+8ck_jpSGPsfWaF3GpzyzHZZ7QOn+KLX7GPDj2J3mY3g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio/avrcp: Fix not always requesting capabilities
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jan 22, 2016 at 5:14 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This fixes not requesting capabilities of targets that are not player
> category, instead just make the creation of the player object
> conditional to the category 1 so that GetCapabities is still sent in
> order to fetch the supported events which might be still useful even
> without a player.
> ---
>  profiles/audio/avrcp.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 7b60012..076766d 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3843,12 +3843,11 @@ static void controller_init(struct avrcp *session)
>         btd_service_connecting_complete(service, 0);
>
>         /* Only create player if category 1 is supported */
> -       if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
> -               return;
> -
> -       player = create_ct_player(session, 0);
> -       if (player == NULL)
> -               return;
> +       if (controller->features & AVRCP_FEATURE_CATEGORY_1) {
> +               player = create_ct_player(session, 0);
> +               if (player == NULL)
> +                       return;
> +       }
>
>         if (controller->version < 0x0103)
>                 return;
> --
> 2.5.0

Pushed.


-- 
Luiz Augusto von Dentz
