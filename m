Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1477405514-2284-1-git-send-email-maxime.chevallier@smile.fr>
References: <1477405514-2284-1-git-send-email-maxime.chevallier@smile.fr>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Oct 2016 17:37:40 +0300
Message-ID: <CABBYNZ+hV0uV0DXPMm0=iktwWXRga3RaQK5MBz_PYb2ZjnkjkA@mail.gmail.com>
Subject: Re: [PATCH v2] profiles/network: Check for any server when accepting connections
To: Maxime Chevallier <maxime.chevallier@smile.fr>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Maxime,

On Tue, Oct 25, 2016 at 5:25 PM, Maxime Chevallier
<maxime.chevallier@smile.fr> wrote:
> When asking confirmation to accept an incoming connection,
> we now only check for any network_server to be registered to
> the adapter.
>
> This fixes GN Master role, that wouldn't accept any connection
> before.
> ---
>  profiles/network/server.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/profiles/network/server.c b/profiles/network/server.c
> index 1bff9f8..aa7f773 100644
> --- a/profiles/network/server.c
> +++ b/profiles/network/server.c
> @@ -454,8 +454,7 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
>                 goto drop;
>         }
>
> -       ns = find_server(na->servers, BNEP_SVC_NAP);
> -       if (!ns || !ns->record_id || !ns->bridge)
> +       if (!na->servers)
>                 goto drop;
>
>         na->setup = g_new0(struct network_session, 1);
> --
> 2.1.4

Applied, thanks. Note that I did remove ns variable since it is no longer used.


-- 
Luiz Augusto von Dentz
