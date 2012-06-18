Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338998771-18683-5-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-5-git-send-email-michal.labedzki@tieto.com>
Date: Mon, 18 Jun 2012 12:48:27 +0300
Message-ID: <CABBYNZLsQuOj1eJcX6hKGA0moVPR71-rBJQWevm-f-DwfJ3jHQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] AVRCP: Register AVRCP before MEDIA interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Jun 6, 2012 at 7:06 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Register AVRCP before MEDIA interface to avoid searching for or
> accessing non-existent AVRCP server.
> ---
>  audio/manager.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/audio/manager.c b/audio/manager.c
> index d442d1d..076346a 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -1238,6 +1238,9 @@ proceed:
>        if (enabled.socket)
>                unix_init();
>
> +       if (enabled.control)
> +               btd_register_adapter_driver(&avrcp_server_driver);
> +
>        if (enabled.media)
>                btd_register_adapter_driver(&media_server_driver);
>
> @@ -1250,9 +1253,6 @@ proceed:
>        if (enabled.source || enabled.sink)
>                btd_register_adapter_driver(&a2dp_server_driver);
>
> -       if (enabled.control)
> -               btd_register_adapter_driver(&avrcp_server_driver);
> -
>        btd_register_device_driver(&audio_driver);
>
>        *enable_sco = (enabled.gateway || enabled.headset);
> --
> on behalf of ST-Ericsson

Ack


-- 
Luiz Augusto von Dentz
