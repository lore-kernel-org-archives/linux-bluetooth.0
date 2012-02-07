Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328607191-9550-1-git-send-email-sancane@gmail.com>
References: <1328607191-9550-1-git-send-email-sancane@gmail.com>
Date: Tue, 7 Feb 2012 06:53:12 -0400
Message-ID: <CAJdJm_PjNBaSP=nK1QitX8z0v0TtTqkBusMHRCN1DmUiFXbsKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] attrib-server: Fix memory leak attaching attribute channels
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Feb 7, 2012 at 5:33 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> Channel is not being released when the channel is attached over
> an uninitialized GATT server.
> ---
>  src/attrib-server.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 2995167..a23d5d2 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -1020,8 +1020,14 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
>        }
>
>        server = find_gatt_server(&channel->src);
> -       if (server == NULL)
> +       if (server == NULL) {
> +               char src[18];
> +
> +               ba2str(&channel->src, src);
> +               error("Not GATT server found in %s", src);

Looks ok, except for the typo: Not -> No

> +               g_free(channel);
>                return 0;
> +       }
>
>        channel->server = server;
>
> --
> 1.7.9

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
