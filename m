Return-Path: <cyrus@holtmann.org>
Message-ID: <4C08B86A.70602@linux.intel.com>
Date: Fri, 04 Jun 2010 16:25:14 +0800
From: Zhu Yanhai <yanhai.zhu@linux.intel.com>
MIME-Version: 1.0
To: Zhu Yanhai <yanhai.zhu@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gateway_server_remove should unref audio_adapter
References: <1275639598-22048-1-git-send-email-yanhai.zhu@linux.intel.com>
In-Reply-To: <1275639598-22048-1-git-send-email-yanhai.zhu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/04/2010 04:19 PM, Zhu Yanhai wrote:
> gateway_server_remove should unrefer the adapter, not refer it.
>
> Signed-off-by: Zhu Yanhai<yanhai.zhu@linux.intel.com>
> ---
>   audio/manager.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/manager.c b/audio/manager.c
> index 28fd8af..f6a98cd 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -932,7 +932,7 @@ static void gateway_server_remove(struct btd_adapter *adapter)
>   		adp->hfp_hs_server = NULL;
>   	}
>
> -	audio_adapter_ref(adp);
> +	audio_adapter_unref(adp);
>   }
>
>   static int a2dp_server_probe(struct btd_adapter *adapter)

The current BlueZ 4.65 can't register itself on DBUS after system 
resume, as the interface org.bluez.Adapter wasn't unregistered during 
system suspend due to the non-zero ref numbers.

Regards,
Zhu Yanhai
