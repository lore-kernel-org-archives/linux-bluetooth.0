Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/bluetooth: Extract function sending bond state
Date: Tue, 02 Sep 2014 18:04:08 +0200
Message-ID: <2746016.MXfPcXTOpL@uw000953>
In-Reply-To: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 02 of September 2014 15:54:59 Lukasz Rymanowski wrote:
> ---
>  android/bluetooth.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index bd1e747..7c3c198 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -877,6 +877,27 @@ static uint8_t device_bond_state(struct device *dev)
>  	return HAL_BOND_STATE_NONE;
>  }
>  
> +static void update_bond_state(struct device *dev, uint8_t status,
> +					uint8_t old_bond, uint8_t new_bond)
> +{
> +	if (old_bond == new_bond)
> +		return;
> +
> +	/*
> +	 * For incoming just works bonding we will switch here from
> +	 * non bonded to bonded directly. This is something Android
> +	 * will not handle in their bond state machine. To make Android
> +	 * handle it corretly we need to send BONDING state before BOND
> +	 */
> +	if (old_bond == HAL_BOND_STATE_NONE &&
> +				new_bond == HAL_BOND_STATE_BONDED)
> +		send_bond_state_change(dev, status,
> +						HAL_BOND_STATE_BONDING);
> +
> +	send_bond_state_change(dev, status, new_bond);
> +
> +}
> +
>  static void update_device_state(struct device *dev, uint8_t addr_type,
>  				uint8_t status, bool pairing, bool paired,
>  				bool bonded)
> @@ -892,20 +913,7 @@ static void update_device_state(struct device *dev, uint8_t addr_type,
>  
>  	new_bond = device_bond_state(dev);
>  
> -	if (old_bond != new_bond) {
> -		/*
> -		 * For incoming just works bonding we will switch here from
> -		 * non bonded to bonded directly. This is something Android
> -		 * will not handle in their bond state machine. To make Android
> -		 * handle it corretly we need to send BONDING state before BOND
> -		 */
> -		if (old_bond == HAL_BOND_STATE_NONE &&
> -					new_bond == HAL_BOND_STATE_BONDED)
> -			send_bond_state_change(dev, status,
> -							HAL_BOND_STATE_BONDING);
> -
> -		send_bond_state_change(dev, status, new_bond);
> -	}
> +	update_bond_state(dev, status, old_bond, new_bond);
>  }
>  
>  static void send_device_property(struct device *dev, uint8_t type,
> 

All 5 patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
