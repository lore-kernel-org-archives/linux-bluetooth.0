Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/8] android/ipc: Add Mode parameter to register service command
Date: Tue, 04 Mar 2014 10:20:36 +0100
Message-ID: <4359625.mvsyXnKOJC@uw000953>
In-Reply-To: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
References: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 03 of March 2014 00:50:42 Szymon Janc wrote:
> This will allow to run daemon services in non-default mode.
> ---
>  android/hal-ipc-api.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index 0518c2f..6bf9af3 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -124,12 +124,16 @@ Core Service (ID 0)
>  	Opcode 0x01 - Register module command/response
>  
>  		Command parameters: Service id (1 octet)
> +		                    Mode (1 octet)
>  		Response parameters: <none>
>  
>  		In case a command is sent for an undeclared service ID, it will
>  		be rejected. Also there will be no notifications for undeclared
>  		service ID.
>  
> +		Valid Mode values: 0x00 = Default Mode
> +		                   0xXX = as defined by service
> +
>  		In case of an error, the error response will be returned.
>  
>  	Opcode 0x02 - Unregister module command/response
> @@ -749,6 +753,8 @@ Bluetooth Handsfree HAL (ID 5)
>  
>  Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
>  
> +	Service modes:               0x01 = Headset Profile only mode
> +
>  	Opcode 0x00 - Error response
>  
>  		Response parameters: Status (1 octet)
> 

Pushed.

-- 
Best regards, 
Szymon Janc
