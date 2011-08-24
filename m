Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314027047-5476-6-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314027047-5476-6-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 24 Aug 2011 13:54:02 +0300
Message-ID: <CABBYNZJ6-i4naab_3Uc1SjVF5O+Z_Ns1t6sQ9SxTmPxS_j5X2A@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] Fix RFCOMM disconnect on suspend request
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/22 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> When pulseaudio release an audio stream, gateway.c disconnects
> RFCOMM instead of disconnecting only SCO.
> ---
>  audio/gateway.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 805b8cb..425ad16 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -811,7 +811,7 @@ int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
>
>  gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id)
>  {
> -       gateway_close(dev);
> +       gateway_suspend_stream(dev);
>        return TRUE;
>  }
>
> --
> 1.7.1
>
> --

Ack

-- 
Luiz Augusto von Dentz
