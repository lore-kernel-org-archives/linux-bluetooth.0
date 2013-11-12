Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 15:02:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v2 1/3] android: Update bond state on incoming bonding
Message-ID: <20131112130231.GA22931@x220.p-661hnu-f1>
References: <1384260700-16621-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1384260700-16621-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384260700-16621-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Nov 12, 2013, Lukasz Rymanowski wrote:
> Before sending any ssp request or pin code request up to HAL library we
> need to send bond state change with bonding state. Otherwise incoming
> bonding is impossible.
> Add bonding tracking to adapter.
> ---
>  android/adapter.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index 65b3170..f92301e 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -74,6 +74,8 @@ struct bt_adapter {
>  
>  	bool discovering;
>  	uint32_t discoverable_timeout;
> +
> +	bool bonding;
>  };
>  
>  struct browse_req {
> @@ -486,6 +488,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
>  	send_bond_state_change(&addr->bdaddr, HAL_STATUS_SUCCESS,
>  							HAL_BOND_STATE_BONDED);
>  
> +	adapter->bonding = false;
>  	browse_remote_sdp(&addr->bdaddr);
>  }
>  
> @@ -501,6 +504,13 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
>  		return;
>  	}
>  
> +	if (!adapter->bonding) {
> +		adapter->bonding = true;
> +		/* Update bonding state */
> +		send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
> +						HAL_BOND_STATE_BONDING);
> +	}

Is there something explicitly blocking multiple parallel bonding
attempts (to different remote devices) in Android? If not this should
really be a list or hash-table with entries identifiable using the
remote bdaddr. In fact since we need this anyway for our LE address type
cache I don't see why it would hurt to have the infrastructure ready for
it now.

Johan
