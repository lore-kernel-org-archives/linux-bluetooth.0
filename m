Return-Path: <cyrus@holtmann.org>
Message-ID: <1446285158.4629.2.camel@cortland.com>
Subject: Re: [PATCH BlueZ] core/service: Fix failing to connect external
 profile
From: Steve Brown <sbrown@cortland.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Sat, 31 Oct 2015 05:52:38 -0400
In-Reply-To: <1446212344-10641-1-git-send-email-luiz.dentz@gmail.com>
References: <1446212344-10641-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,

On Fri, 2015-10-30 at 15:39 +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When initiating a connection to a external profile
> btd_service_connect
> will be called which will change the service state to
> BTD_SERVICE_STATE_CONNECTING but then once the connection completes
> service_accept is called but since it now checks the state it would
> return -EALREADY to prevent driver accept to be called more than
> once.
> ---
>  src/service.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/service.c b/src/service.c
> index 2ed72fb..7da922c 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -191,7 +191,7 @@ int service_accept(struct btd_service *service)
>  		break;
>  	case BTD_SERVICE_STATE_CONNECTING:
>  	case BTD_SERVICE_STATE_CONNECTED:
> -		return -EALREADY;
> +		return 0;
>  	case BTD_SERVICE_STATE_DISCONNECTING:
>  		return -EBUSY;
>  	}

This patch solves my hfp headset connect problem.

Thanks,

Steve


