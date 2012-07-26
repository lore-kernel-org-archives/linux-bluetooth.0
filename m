Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343145150-6427-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1343145150-6427-3-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 26 Jul 2012 10:37:32 +0300
Message-ID: <CABBYNZ+nnCkUNqyXygEp_oHJw2k5dYL=HV_HAueTZ+4agSO86w@mail.gmail.com>
Subject: Re: [RFC v1 2/4] media: Add boolean playing field to transport
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Jul 24, 2012 at 6:52 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> This flag represents whether the transport is actually streaming, which
> is mapped trivially after the state changes in gateway, headset and A2DP
> sink or sources.
> ---
>  audio/media.c     |   26 ++++++++++++++++++++++++--
>  audio/transport.c |    7 +++++++
>  audio/transport.h |    2 ++
>  3 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index 1a54f4a..d12445f 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -494,21 +494,26 @@ static void headset_state_changed(struct audio_device *dev,
>         switch (new_state) {
>         case HEADSET_STATE_DISCONNECTED:
>                 transport = find_device_transport(endpoint, dev);
> -
>                 if (transport != NULL) {
>                         DBG("Clear endpoint %p", endpoint);
> +                       media_transport_set_playing(transport, FALSE);
>                         clear_configuration(endpoint, transport);
>                 }
>                 break;
>         case HEADSET_STATE_CONNECTING:
>                 set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
>                                                                 dev, NULL);
> +               transport = find_device_transport(endpoint, dev);
> +               media_transport_set_playing(transport, FALSE);
>                 break;
>         case HEADSET_STATE_CONNECTED:
> -               break;
>         case HEADSET_STATE_PLAY_IN_PROGRESS:
> +               transport = find_device_transport(endpoint, dev);
> +               media_transport_set_playing(transport, FALSE);
>                 break;
>         case HEADSET_STATE_PLAYING:
> +               transport = find_device_transport(endpoint, dev);
> +               media_transport_set_playing(transport, TRUE);
>                 break;
>         }
>  }

Looks like we can move transport = find_device_transport(endpoint,
dev); above so we don't have do it  in each case.

> @@ -660,16 +665,23 @@ static void gateway_state_changed(struct audio_device *dev,
>                 transport = find_device_transport(endpoint, dev);
>                 if (transport != NULL) {
>                         DBG("Clear endpoint %p", endpoint);
> +                       media_transport_set_playing(transport, FALSE);
>                         clear_configuration(endpoint, transport);
>                 }
>                 break;
>         case GATEWAY_STATE_CONNECTING:
>                 set_configuration(endpoint, dev, NULL, 0,
>                                         gateway_setconf_cb, dev, NULL);
> +               transport = find_device_transport(endpoint, dev);
> +               media_transport_set_playing(transport, FALSE);
>                 break;
>         case GATEWAY_STATE_CONNECTED:
> +               transport = find_device_transport(endpoint, dev);
> +               media_transport_set_playing(transport, FALSE);
>                 break;
>         case GATEWAY_STATE_PLAYING:
> +               transport = find_device_transport(endpoint, dev);
> +               media_transport_set_playing(transport, TRUE);
>                 break;
>         }
>  }

Same here.

-- 
Luiz Augusto von Dentz
