Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH] android/gatt: Fix regression introduced by b278efa5
Date: Mon, 31 Mar 2014 00:07:09 +0200
Message-ID: <4849796.2zhvJRlmh5@athlon>
In-Reply-To: <1396159471-1773-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396159471-1773-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Sunday 30 March 2014 08:04:31 Lukasz Rymanowski wrote:
> Seems that GattService onScanResult is only looking into remote uuids in
> adverisement data. No device object is created in the Android framework,
> Therefore we need to send regular device found for BLE devices as well.
> Otherwise the Android GATT application will not be aware of remote device
> properties like name etc.
> ---
>  android/bluetooth.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 690aaf6..734adeb 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1331,9 +1331,6 @@ static bool is_new_device(const struct device *dev)
>  	if (dev->found)
>  		return false;
> 
> -	if (adapter.cur_discovery_type != SCAN_TYPE_DUAL)
> -		return false;
> -
>  	if (dev->bond_state == HAL_BOND_STATE_BONDED)
>  		return false;

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
