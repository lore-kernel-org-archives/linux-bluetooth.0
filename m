Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334127438-27617-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334127438-27617-3-git-send-email-mikel.astiz.oss@gmail.com>
Date: Wed, 11 Apr 2012 14:21:13 +0300
Message-ID: <CABBYNZ+ymoodi=M=5v3qbybmC3F1aA9AgVY3ukQZjDW5Lkkz8w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 2/7] audio: Fix gateway state check
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
> Gateway should be considered active also if connecting or playing.
>
> This could for example lead to manager_find_device() not returning a
> device that is connecting, and thus the corresponding endpoint would
> never be created in the Media API.
> ---
>  audio/device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/device.c b/audio/device.c
> index a9d35f9..ee1ade1 100644
> --- a/audio/device.c
> +++ b/audio/device.c
> @@ -701,7 +701,7 @@ gboolean audio_device_is_active(struct audio_device *dev,
>                                control_is_active(dev))
>                return TRUE;
>        else if (!strcmp(interface, AUDIO_GATEWAY_INTERFACE) && dev->gateway &&
> -                               gateway_is_connected(dev))
> +                               gateway_is_active(dev))
>                return TRUE;
>
>        return FALSE;
> --
> 1.7.7.6
>
> --

Looks good, ack.


-- 
Luiz Augusto von Dentz
