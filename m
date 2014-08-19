Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Fix device found notification
Date: Tue, 19 Aug 2014 18:50:17 +0200
Message-ID: <2852516.jjknLa9UKB@leonov>
In-Reply-To: <1408455929-8219-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1408455929-8219-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 19 of August 2014 15:45:29 Lukasz Rymanowski wrote:
> If device is dual mode and can be seen on both LE and BREDR, then
> bdaddr_type in device struct keeps LE address type of that device.
> 
> During discovery, we should take current bdaddr_type to decide about
> passing that device up to application or not. Using dev->braddr_type might
> be misleading
> 
> This patch fix scenario when remote device is known as LE device and
> recently has been found on inquiry seesion as DUAL mode device. In such
> case, based on braddr_type and eir flags we could incorectly skip
> new device notification for Android framework.
> ---
>  android/bluetooth.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 5f163f1..64a7696 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1830,7 +1830,8 @@ static void update_device(struct device *dev, int8_t
> rssi, HAL_EV_REMOTE_DEVICE_PROPS, size, buf);
>  }
> 
> -static bool is_new_device(const struct device *dev, unsigned int flags)
> +static bool is_new_device(const struct device *dev, unsigned int flags,
> +							uint8_t bdaddr_type)
>  {
>  	if (dev->found)
>  		return false;
> @@ -1838,7 +1839,7 @@ static bool is_new_device(const struct device *dev,
> unsigned int flags) if (dev->bredr_paired || dev->le_paired)
>  		return false;
> 
> -	if (dev->bdaddr_type != BDADDR_BREDR &&
> +	if (bdaddr_type != BDADDR_BREDR &&
>  				!(flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
>  		return false;
> 
> @@ -1867,7 +1868,7 @@ static void update_found_device(const bdaddr_t
> *bdaddr, uint8_t bdaddr_type, * Device found event needs to be send also
> for known device if this is * new discovery session. Otherwise framework
> will ignore it.
>  	 */
> -	if (is_new_device(dev, eir.flags))
> +	if (is_new_device(dev, eir.flags, bdaddr_type))
>  		update_new_device(dev, rssi, &eir);
>  	else
>  		update_device(dev, rssi, &eir, bdaddr_type);

Patch applied, thanks.

-- 
BR
Szymon Janc
