Return-Path: <cyrus@holtmann.org>
Message-ID: <1334419295.16897.150.camel@aeonflux>
Subject: Re: [PATCH 1/1] Add DBG() calls to authorization logic
From: Marcel Holtmann <marcel@holtmann.org>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 14 Apr 2012 18:01:35 +0200
In-Reply-To: <1334380599-17052-1-git-send-email-chanyeol.park@samsung.com>
References: <1334380599-17052-1-git-send-email-chanyeol.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> Sometimes BlueZ Agent is disappear suddenly or not registered
> because of agent problem. but Bluez just prints "Operation Not
> permiited"
> 
> This will help debugging.
> ---
>  audio/manager.c |    2 +-
>  src/adapter.c   |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/manager.c b/audio/manager.c
> index aa2547c..20453e6 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -604,7 +604,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
>  	perr = audio_device_request_authorization(device, server_uuid,
>  						gateway_auth_cb, device);
>  	if (perr < 0) {
> -		DBG("Authorization denied!");
> +		DBG("Authorization denied: %s", strerror(-perr));
>  		gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
>  	}

it is fine to keep this as debug messages, ...

>  
> diff --git a/src/adapter.c b/src/adapter.c
> index d10db10..15d502f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3107,6 +3107,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
>  
>  	agent = device_get_agent(device);
>  	if (!agent) {
> +		DBG("Can't find device agent");

..., but this debug message is kinda useless as debug message. It should
be a warning message. Having to enable debug to see is a broken idea.

>  		g_free(auth);
>  		return -EPERM;
>  	}

Regards

Marcel


