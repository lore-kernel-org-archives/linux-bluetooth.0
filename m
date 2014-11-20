Return-Path: <cyrus@holtmann.org>
Message-ID: <546DF03D.3030508@tieto.com>
Date: Thu, 20 Nov 2014 14:44:29 +0100
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/hal-ipc-api: Add av callbacks for Android
 5
References: <1416402606-31762-1-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416402606-31762-1-git-send-email-jakub.tyszkowski@tieto.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 11/19/2014 02:10 PM, Jakub Tyszkowski wrote:
> Android 5 adds audio configuration callback.
> ---
>   android/hal-ipc-api.txt | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index a5ec44b..9502a15 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -1098,6 +1098,15 @@ Notifications:
>   		                         0x01 = Stopped
>   		                         0x02 = Started
>
> +	Opcode 0x83 - Audio Configuration notification
> +
> +		Notification parameters: Remote address (6 octets)
> +					 Sample Rate in Hz (4 octets)
> +					 Channel Count (1 octet)
> +
> +		Valid channel count: 0x01 = Mono
> +		                     0x02 = Stereo
> +
>
>   Bluetooth Health HAL (ID 7)
>   ===========================
>

Please ignore this whole set as it turn out that new callback is for 
sink role only and sink role is implementing the same HAL interface.

This case requires more elaborate documentation and different IPC code.

Regards,
Jakub
