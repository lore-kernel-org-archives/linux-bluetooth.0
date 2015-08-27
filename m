Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Will Wang <wiwang@mozilla.com>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/hal-ipc-api: Fix missing HFP WBS callback
Date: Thu, 27 Aug 2015 21:39:04 +0200
Message-ID: <8141009.2HzRx9Rgzr@athlon>
In-Reply-To: <1440676922-29249-2-git-send-email-wiwang@mozilla.com>
References: <1440676922-29249-1-git-send-email-wiwang@mozilla.com> <1440676922-29249-2-git-send-email-wiwang@mozilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Will,

On Thursday 27 August 2015 20:02:00 Will Wang wrote:
> Add definition of HFP WBS Command notification
> ---
>  android/hal-ipc-api.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index 503b47a..e3b7798 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -1068,6 +1068,14 @@ Notifications:
> 
>  		Notification parameters: Remote address (6 octets)
> 
> +	Opcode 0x91 - WBS Command notification
> +
> +		Notification parameters: WBS types (1 octet)
> +		                         Remote address (6 octets)
> +
> +		Valid WBS types: 0x00 = None
> +		                 0x01 = No
> +		                 0x02 = Yes
> 
>  Bluetooth Advanced Audio HAL (ID 6)
>  Bluetooth Advanced Audio Sink HAL (ID 13)

This patch is now applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
