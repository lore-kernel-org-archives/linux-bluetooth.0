Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323943267-14576-2-git-send-email-mikel.astiz.oss@gmail.com>
References: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1323943267-14576-2-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 15 Dec 2011 13:46:06 +0200
Message-ID: <CABBYNZL7-Aufrfa7e_S_n70LrkurL3Q6m0ncrM6tc4XGMmavkA@mail.gmail.com>
Subject: Re: [PATCH 1/4] audio: remove unnecessary method call
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
> Calling gateway_suspend_stream should not be necessary given that
> gateway_unlock with rw flags already does it.
> ---
>  audio/transport.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/audio/transport.c b/audio/transport.c
> index 7bde32d..6029528 100644
> --- a/audio/transport.c
> +++ b/audio/transport.c
> @@ -535,7 +535,6 @@ static guint suspend_gateway(struct media_transport *transport,
>                return 0;
>        }
>
> -       gateway_suspend_stream(device);
>        gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
>        g_idle_add(gateway_suspend_complete, owner);
>        return id++;
> --

gateway_suspend_stream as it is useless, but I think we should fix it
to work similarly to headset_suspend_stream so we properly wait until
the socket is closed before we unlock and reply, this is necessary in
order to properly synchronize switching profiles otherwise
gateway_suspend_complete maybe called without SCO being completely
disconnected. Also when a fd is passed over to another process calling
close/g_io_channel_shutdown is not enough since this only release our
reference, in this case shutdown must be called.

-- 
Luiz Augusto von Dentz
