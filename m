Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Nov 2013 18:29:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/10] android/hal-bluetooth: Remove not needed check in
 get_adapter_property
Message-ID: <20131119162958.GB7562@x220.p-661hnu-f1>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
 <1384876314-31347-10-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384876314-31347-10-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 19, 2013, Szymon Janc wrote:
> Properties types are verified on daemon side and proper error is
> returned on wrong type. No need to double check that on HAL side.
> ---
>  android/hal-bluetooth.c | 15 ---------------
>  1 file changed, 15 deletions(-)

All patches in this set have been applied. Thanks.

> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -476,21 +476,6 @@ static int get_adapter_property(bt_property_type_t type)
>  	if (!interface_ready())
>  		return BT_STATUS_NOT_READY;
>  
> -	switch (type) {
> -	case BT_PROPERTY_BDNAME:
> -	case BT_PROPERTY_BDADDR:
> -	case BT_PROPERTY_UUIDS:
> -	case BT_PROPERTY_CLASS_OF_DEVICE:
> -	case BT_PROPERTY_TYPE_OF_DEVICE:
> -	case BT_PROPERTY_SERVICE_RECORD:
> -	case BT_PROPERTY_ADAPTER_SCAN_MODE:
> -	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
> -	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
> -		break;
> -	default:
> -		return BT_STATUS_PARM_INVALID;
> -	}
> -

We should be consistent about this across all HALs. I just applied
patches from Ravi that added validity check to the HAL side, however now
it seems these should actually be on the daemon side (and now that I
think about it the daemon must in the name of robustness check them
anyway).

Johan
