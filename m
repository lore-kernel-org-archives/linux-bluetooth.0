Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334127438-27617-2-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334127438-27617-2-git-send-email-mikel.astiz.oss@gmail.com>
Date: Wed, 11 Apr 2012 14:20:12 +0300
Message-ID: <CABBYNZJF8XSSdVH2PCB7aX2eNyrPq5Nfj7L5gGV-WMcXyUaPhg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 1/7] btio: Fix bind SCO socket only if server
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Apr 11, 2012 at 9:57 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> When the socket is open is client mode, the bind() system call should
> not be used.
> ---
>  btio/btio.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index 9781ec4..7564d85 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -1317,8 +1317,9 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
>                        ERROR_FAILED(err, "socket(SEQPACKET, SCO)", errno);
>                        return NULL;
>                }
> -               if (sco_bind(sock, &opts->src, err) < 0)
> -                       goto failed;
> +               if (server)
> +                       if (sco_bind(sock, &opts->src, err) < 0)
> +                               goto failed;
>                if (!sco_set(sock, opts->mtu, err))
>                        goto failed;
>                break;
> --
> 1.7.7.6

Ack, in future send this kind of trivial/obvious fix in separated so
it can easily be picked.


-- 
Luiz Augusto von Dentz
