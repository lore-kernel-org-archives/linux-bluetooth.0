Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323943267-14576-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1323943267-14576-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 15 Dec 2011 13:49:14 +0200
Message-ID: <CABBYNZ+pv_dGG5WEB=rZqcg3fGQrgMxumJ_3i2NM+00CbgevUQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] a2dp: return NotSupported error if no server found
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Dec 15, 2011 at 12:01 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> With both sink and sources disabled, the A2DP server is not even
> registered in audio_manager_init. When trying to register the endpoint,
> this should result in the same error as if the server existed but the
> profile was disabled.
> ---
>  audio/a2dp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/a2dp.c b/audio/a2dp.c
> index 5ca105c..9ed2ebb 100644
> --- a/audio/a2dp.c
> +++ b/audio/a2dp.c
> @@ -1590,7 +1590,7 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
>        server = find_server(servers, src);
>        if (server == NULL) {
>                if (err)
> -                       *err = -EINVAL;
> +                       *err = -EPROTONOSUPPORT;
>                return NULL;
>        }
>
> --
> 1.7.6.4

Ack.

-- 
Luiz Augusto von Dentz
