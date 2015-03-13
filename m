Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426066462-32151-1-git-send-email-marcin.kraglak@tieto.com>
References: <1426066462-32151-1-git-send-email-marcin.kraglak@tieto.com>
Date: Fri, 13 Mar 2015 14:10:34 +0200
Message-ID: <CABBYNZL=O0Ks_Ps3WjGeE_pY+UnBmbQyJGRhVHtarYPyrSLsdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] audio/avrcp: Remove redundant check
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Mar 11, 2015 at 11:34 AM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> There is no need to check if device has specific services,
> it was checked in session_init_control.
> ---
>  profiles/audio/avrcp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index b1552b1..a57756e 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3394,8 +3394,7 @@ static void target_init(struct avrcp *session)
>         DBG("%p version 0x%04x", target, target->version);
>
>         service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
> -       if (service != NULL)
> -               btd_service_connecting_complete(service, 0);
> +       btd_service_connecting_complete(service, 0);
>
>         player = g_slist_nth_data(server->players, 0);
>         if (player != NULL) {
> @@ -3440,8 +3439,7 @@ static void controller_init(struct avrcp *session)
>                 session->supported_events |= (1 << AVRCP_EVENT_VOLUME_CHANGED);
>
>         service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
> -       if (service != NULL)
> -               btd_service_connecting_complete(service, 0);
> +       btd_service_connecting_complete(service, 0);
>
>         /* Only create player if category 1 is supported */
>         if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
> --
> 2.1.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
