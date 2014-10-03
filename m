Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/hal-ipc-api: Add MCE HAL
Date: Fri, 03 Oct 2014 13:17:49 +0200
Message-ID: <10702950.eQvIYeUa7I@uw000953>
In-Reply-To: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 22 of September 2014 13:01:43 Grzegorz Kolodziejczyk wrote:
> ---
>  android/hal-ipc-api.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index f6e1680..38f75e6 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -2396,3 +2396,54 @@ Notifications:
>  	Opcode 0x95 - Ring Indication notification
>  
>  		Notification parameters: <none>
> +
> +
> +Bluetooth MCE HAL (ID 11)
> +=========================

I'd prefer if we stick to term 'map client' instead of MCE.

> +
> +Android HAL name: "map_client" (BT_PROFILE_MAP_CLIENT_ID)
> +
> +Structures:

Since this is used only in one place I'd defined it there (see below).

> +
> +	MAS instance: Instance ID (1 octet)
> +	              Channel (1 octet)
> +	              Message type (1 octet)

This should be named 'Message types'.

> +	              Name (string)
> +
> +	Valid Message type: 0x01 = EMAIL
> +	                    0x02 = SMS_GSM
> +	                    0x04 = SMS_CDMA
> +	                    0x08 = MMS

I think we should not define that in IPC since this is not defined in HAL.
Especially that this should be bitmask, not values. Just pass whatever we
get from remote SDP.

> +
> +Commands and responses:
> +
> +	Opcode 0x00 - Error response
> +
> +		Response parameters: Status (1 octet)
> +
> +		Valid status values: 0x01 = Fail
> +		                     0x02 = Not ready
> +		                     0x03 = No memory
> +		                     0x04 = Busy
> +		                     0x05 = Done (already completed)
> +		                     0x06 = Unsupported
> +		                     0x07 = Parameter invalid
> +		                     0x08 = Unhandled
> +		                     0x09 = Authentication failure
> +		                     0x0a = Remote device down
> +
> +	Opcode 0x01 - Get Remote MAS Instances
> +
> +		Command parameters: Remote address (6 octets)
> +		Response parameters: <none>
> +
> +		In case of an error, the error response will be returned.
> +
> +Notifications:
> +
> +	Opcode 0x81 - Remote MAS Instances notification
> +
> +		Notification parameters: Status (1 octet)
> +		                         Remote address (6 octets)
> +		                         Number of instances (1 octet)
> +		                         MAS instance (variable)

Number of instances (1 octet)
Instance ID #(1 octet)
Channel #(1 octet)
Message type #(1 octet)
Name # (string)

-- 
Best regards, 
Szymon Janc
