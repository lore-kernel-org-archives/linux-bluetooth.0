Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313162877-14945-8-git-send-email-frederic.dalleau@linux.intel.com>
References: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1313162877-14945-8-git-send-email-frederic.dalleau@linux.intel.com>
Date: Sun, 14 Aug 2011 20:07:06 +0300
Message-ID: <CABBYNZ+iWTs6Xt7R=TbjGyvKxTkN7h=WcCEqSrHoVhzhLyhPwA@mail.gmail.com>
Subject: Re: [PATCH 7/7] Introduce new state GATEWAY_STATE_PLAY_IN_PROGRESS
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/12 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> ---
>  audio/device.c  |    1 +
>  audio/gateway.c |    5 +++++
>  audio/gateway.h |    1 +
>  audio/media.c   |    2 +-
>  4 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/audio/device.c b/audio/device.c
> index abf8da4..667bab0 100644
> --- a/audio/device.c
> +++ b/audio/device.c
> @@ -549,6 +549,7 @@ static void device_gateway_cb(struct audio_device *dev,
>                                priv->sink_state == SINK_STATE_CONNECTING)
>                        device_set_state(dev, AUDIO_STATE_CONNECTED);
>                break;
> +       case GATEWAY_STATE_PLAY_IN_PROGRESS:
>        case GATEWAY_STATE_PLAYING:
>                break;
>        }
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 805b8cb..60f84e0 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -90,6 +90,7 @@ static const char *state2str(gateway_state_t state)
>        case GATEWAY_STATE_CONNECTING:
>                return "connecting";
>        case GATEWAY_STATE_CONNECTED:
> +       case GATEWAY_STATE_PLAY_IN_PROGRESS:
>                return "connected";
>        case GATEWAY_STATE_PLAYING:
>                return "playing";
> @@ -140,6 +141,7 @@ void gateway_set_state(struct audio_device *dev, gateway_state_t new_state)
>                break;
>        case GATEWAY_STATE_CONNECTING:
>        case GATEWAY_STATE_CONNECTED:
> +       case GATEWAY_STATE_PLAY_IN_PROGRESS:
>        case GATEWAY_STATE_PLAYING:
>                break;
>        }
> @@ -216,6 +218,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>
>        g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>                                (GIOFunc) sco_io_cb, dev);
> +
> +       change_state(dev, GATEWAY_STATE_PLAYING);
>  }
>
>  static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
> @@ -786,6 +790,7 @@ gboolean gateway_request_stream(struct audio_device *dev,
>                        g_error_free(err);
>                        return FALSE;
>                }
> +               change_state(dev, GATEWAY_STATE_PLAY_IN_PROGRESS);
>        } else if (cb)
>                cb(dev, err, user_data);
>
> diff --git a/audio/gateway.h b/audio/gateway.h
> index 32b5d6d..80d3dfc 100644
> --- a/audio/gateway.h
> +++ b/audio/gateway.h
> @@ -30,6 +30,7 @@ typedef enum {
>        GATEWAY_STATE_DISCONNECTED,
>        GATEWAY_STATE_CONNECTING,
>        GATEWAY_STATE_CONNECTED,
> +       GATEWAY_STATE_PLAY_IN_PROGRESS,
>        GATEWAY_STATE_PLAYING,
>  } gateway_state_t;
>
> diff --git a/audio/media.c b/audio/media.c
> index 5ab3eab..db16b71 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -592,7 +592,7 @@ static void gateway_state_changed(struct audio_device *dev,
>                                        gateway_setconf_cb, dev, NULL);
>                break;
>        case GATEWAY_STATE_CONNECTED:
> -               break;
> +       case GATEWAY_STATE_PLAY_IN_PROGRESS:
>        case GATEWAY_STATE_PLAYING:
>                break;
>        }
> --
> 1.7.1

Looks good, but I would add a description why you are adding this,
actually now I realized you didn't have much in the commit messages
for the other patches, so while you are at it please improve them.

-- 
Luiz Augusto von Dentz
