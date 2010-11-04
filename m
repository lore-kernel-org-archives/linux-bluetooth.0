Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Nov 2010 18:16:06 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix add disconnect watch in connecting state
Message-ID: <20101104181606.GA15745@jh-x301>
References: <AANLkTikyPtikmH=ep2va2iLke9NoteTr5wpThfR6v=vf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikyPtikmH=ep2va2iLke9NoteTr5wpThfR6v=vf@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Nov 04, 2010, Daniel Örstadius wrote:
> If disconnect_cb is added only in the connected state, the callback
> will not be triggered if Device.Disconnected is called during a
> connection setup and the RFCOMM channel of HFP will not be cleanly
> disconnected.
> ---
>  audio/device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/device.c b/audio/device.c
> index 9554c7b..2e75538 100644
> --- a/audio/device.c
> +++ b/audio/device.c
> @@ -231,7 +231,7 @@ static void device_set_state(struct audio_device *dev, audio_state_t new_state)
>  							priv->dc_id);
>  			priv->dc_id = 0;
>  		}
> -	} else if (new_state == AUDIO_STATE_CONNECTED)
> +	} else
>  		priv->dc_id = device_add_disconnect_watch(dev->btd_dev,
>  						disconnect_cb, dev, NULL);
>  

This doesn't seem quite right to me. Aren't you now adding a disconnect
callback twice: once for CONNECTING and a second time for CONNECTED? It
seems like you should only add it when new_state == CONNECTING, right?

Johan
