Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3] android/hidhost: Fix connecting HOGP over BREDR
Date: Fri, 22 May 2015 15:17:04 +0200
Message-ID: <1614758.WFjxB6mBNu@leonov>
In-Reply-To: <1432115799-30849-1-git-send-email-mariusz.skamra@tieto.com>
References: <2648839.tQezcmsJ0R@leonov> <1432115799-30849-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 20 of May 2015 11:56:39 Mariusz Skamra wrote:
> This patch fixes issue related to HID connection over BREDR.
> To avoid HOG connection with dual mode device connected over
> BREDR, bearer type is checked not the features of remote device.
> ---
>  android/hidhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 729b884..a2b820f 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -891,7 +891,7 @@ static void bt_hid_connect(const void *buf, uint16_t
> len) ba2str(&dev->dst, addr);
>  	DBG("connecting to %s", addr);
> 
> -	if (bt_is_device_le(&dst)) {
> +	if (bt_device_last_seen_bearer(&dev->dst) != BDADDR_BREDR) {
>  		if (!hog_connect(dev)) {
>  			status = HAL_STATUS_FAILED;
>  			hid_device_remove(dev);

Patch applied, thanks.

-- 
BR
Szymon Janc
