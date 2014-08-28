Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/bluetooth: Fix incoming just works bonding
Date: Thu, 28 Aug 2014 21:01:41 +0200
Message-ID: <3006256.uhzohje5bW@athlon>
In-Reply-To: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 26 August 2014 22:41:48 Lukasz Rymanowski wrote:
> With this patch Android framework will be notified about bonded device
> which initiated bonding and used just works association model.
> ---
>  android/bluetooth.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 984ecba..96f6101 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -889,8 +889,20 @@ static void update_device_state(struct device *dev,
> uint8_t addr_type,
> 
>  	new_bond = device_bond_state(dev);
> 
> -	if (old_bond != new_bond)
> +	if (old_bond != new_bond) {
> +		/*
> +		 * For incoming just works bonding we will switch here from
> +		 * non bonded to bonded directly. This is something Android
> +		 * will not handle in their bond state machine. To make Android
> +		 * handle it corretly we need to send BONDING state before BOND
> +		 */
> +		if (old_bond == HAL_BOND_STATE_NONE &&
> +					new_bond == HAL_BOND_STATE_BONDED)
> +			send_bond_state_change(dev, status,
> +							HAL_BOND_STATE_BONDING);
> +
>  		send_bond_state_change(dev, status, new_bond);
> +	}
>  }
> 
>  static void send_device_property(struct device *dev, uint8_t type,

All patches applied. Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
