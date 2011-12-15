Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323943267-14576-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1323943267-14576-3-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 15 Dec 2011 13:48:50 +0200
Message-ID: <CABBYNZLQT1q783mOnXFy25qTLhpNs=WtXt2SqJxdtFHX8q62Lg@mail.gmail.com>
Subject: Re: [PATCH 2/4] audio: gateway_unlock together with in_use = FALSE
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
> Calling gateway_unlock seems safer in gateway_suspend_complete, in
> combination with the update of transport->in_use. This avoids the
> transitional state of having the gateway unlocked but the transport
> still in use.
>
> This approach is also more consistent with the way headset and a2dp
> handle it.
> ---
>  audio/transport.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/audio/transport.c b/audio/transport.c
> index 6029528..fc7026e 100644
> --- a/audio/transport.c
> +++ b/audio/transport.c
> @@ -510,6 +510,7 @@ static gboolean gateway_suspend_complete(gpointer user_data)
>  {
>        struct media_owner *owner = user_data;
>        struct media_transport *transport = owner->transport;
> +       struct audio_device *device = transport->device;
>
>        /* Release always succeeds */
>        if (owner->pending) {
> @@ -518,6 +519,7 @@ static gboolean gateway_suspend_complete(gpointer user_data)
>                media_owner_remove(owner);
>        }
>
> +       gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
>        transport->in_use = FALSE;
>        media_transport_remove(transport, owner);
>        return FALSE;
> @@ -535,7 +537,6 @@ static guint suspend_gateway(struct media_transport *transport,
>                return 0;
>        }
>
> -       gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
>        g_idle_add(gateway_suspend_complete, owner);
>        return id++;
>  }
> --
> 1.7.6.4

Ack, but see my comments about the first patch.

-- 
Luiz Augusto von Dentz
