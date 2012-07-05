Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340878959-1343-8-git-send-email-michal.labedzki@tieto.com>
References: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
	<1340878959-1343-8-git-send-email-michal.labedzki@tieto.com>
Date: Thu, 5 Jul 2012 12:52:44 +0300
Message-ID: <CABBYNZJ9oaVhUY+1TNYpBORvkT96rhpwZm16XUJu2QKnvALWzw@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] AVRCP: Register AVRCP before MEDIA interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Jun 28, 2012 at 1:22 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Register AVRCP before MEDIA interface to avoid searching for or
> accessing non-existent AVRCP server.
> ---
>  audio/manager.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/audio/manager.c b/audio/manager.c
> index d442d1d..076346a 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -1238,6 +1238,9 @@ proceed:
>         if (enabled.socket)
>                 unix_init();
>
> +       if (enabled.control)
> +               btd_register_adapter_driver(&avrcp_server_driver);
> +
>         if (enabled.media)
>                 btd_register_adapter_driver(&media_server_driver);
>
> @@ -1250,9 +1253,6 @@ proceed:
>         if (enabled.source || enabled.sink)
>                 btd_register_adapter_driver(&a2dp_server_driver);
>
> -       if (enabled.control)
> -               btd_register_adapter_driver(&avrcp_server_driver);
> -
>         btd_register_device_driver(&audio_driver);
>
>         *enable_sco = (enabled.gateway || enabled.headset);
> --
> on behalf of ST-Ericsson

Applied thanks, please rebase the rest.


-- 
Luiz Augusto von Dentz
