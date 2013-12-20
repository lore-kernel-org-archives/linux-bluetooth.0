Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 15:28:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Add remote device found success test case
Message-ID: <20131220132821.GB1550@x220.p-661hnu-f1>
References: <1387544266-3159-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387544266-3159-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Dec 20, 2013, Jakub Tyszkowski wrote:
> Add checking for remote device being found.
> 
> ---
>  android/android-tester.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 3fbcb2f..9a5824c 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -70,7 +70,8 @@ enum hal_bluetooth_callbacks_id {
>  	ADAPTER_PROP_SERVICE_RECORD,
>  	ADAPTER_PROP_BONDED_DEVICES,
>  	ADAPTER_DISCOVERY_STATE_ON,
> -	ADAPTER_DISCOVERY_STATE_OFF
> +	ADAPTER_DISCOVERY_STATE_OFF,
> +	REMOTE_DEVICE_FOUND
>  };

Just add the ',' even to the last entry so subsequent additions become
more readable in patch form. I fixed this myself this time and applied
the patch.

Johan
