Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337614287-28938-1-git-send-email-frederic.danis@linux.intel.com>
References: <1337614287-28938-1-git-send-email-frederic.danis@linux.intel.com>
Date: Tue, 22 May 2012 16:40:33 +0300
Message-ID: <CABBYNZ+r+=8E2ncdYRQb1cPTnPxGdaCGSzSsjXFwM48b+V1zXA@mail.gmail.com>
Subject: Re: [PATCH] audio: Fix media transport creation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Mon, May 21, 2012 at 6:31 PM, Frédéric Danis
<frederic.danis@linux.intel.com> wrote:
> Prevents set_configuration() to be called on another adapter
> than connecting one
> ---
>  audio/media.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/audio/media.c b/audio/media.c
> index 427087a..8b29ac7 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -491,6 +491,9 @@ static void headset_state_changed(struct audio_device *dev,
>                }
>                break;
>        case HEADSET_STATE_CONNECTING:
> +               if (bacmp(&endpoint->adapter->src, &dev->src) != 0)
> +                       break;
> +
>                set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
>                                                                dev, NULL);
>                break;
> --
> 1.7.9.5

This patch is now applied, Ive just moved the check to the beginning
of the function and also fixed gateway_state_changed that was doing
the same.

-- 
Luiz Augusto von Dentz
