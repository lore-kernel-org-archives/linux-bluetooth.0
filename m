Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/bluetooth: Fix handling paring related events
Date: Tue, 02 Sep 2014 17:43:03 +0200
Message-ID: <1599918.5dKu2pKDUe@uw000953>
In-Reply-To: <1409658696-7127-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409658696-7127-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 02 of September 2014 13:51:36 Lukasz Rymanowski wrote:
> As it turns out it is possible that kernel send to user space mgmt
> events related to pairing before device connected event.
> In such case BfA was dropping such event because he does not know
> device.
> 
> With this patch, if device is not in the cache, BfA will create it.
> 
> Issue triggered by test: "Bluetooth Accept Bond - Just Works - Success"
> ---
> v2: build error.
>  android/bluetooth.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 99e2aab..bd1e747 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1240,7 +1240,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
>  		return;
>  	}
>  
> -	dev = find_device(&ev->key.addr.bdaddr);
> +	dev = get_device(&ev->key.addr.bdaddr, ev->key.addr.type);
>  	if (!dev)
>  		return;
>  
> @@ -1335,7 +1335,7 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
>  	ba2str(&ev->addr.bdaddr, dst);
>  	DBG("%s confirm_hint %u", dst, ev->confirm_hint);
>  
> -	dev = find_device(&ev->addr.bdaddr);
> +	dev = get_device(&ev->addr.bdaddr, ev->addr.type);
>  	if (!dev)
>  		return;
>  
> @@ -1363,7 +1363,7 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
>  	ba2str(&ev->addr.bdaddr, dst);
>  	DBG("%s", dst);
>  
> -	dev = find_device(&ev->addr.bdaddr);
> +	dev = get_device(&ev->addr.bdaddr, ev->addr.type);
>  	if (!dev)
>  		return;
>  
> @@ -2288,7 +2288,7 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
>  	}
>  
>  	ba2str(&ev->key.addr.bdaddr, dst);
> -	dev = find_device(&ev->key.addr.bdaddr);
> +	dev = get_device(&ev->key.addr.bdaddr, ev->key.addr.type);
>  	if (!dev)
>  		return;
>  
> @@ -2363,7 +2363,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
>  	DBG("new IRK for %s, RPA %s", dst, rpa);
>  
>  	if (!bacmp(&ev->rpa, BDADDR_ANY)) {
> -		dev = find_device(&addr->bdaddr);
> +		dev = get_device(&addr->bdaddr, addr->type);
>  		if (!dev)
>  			return;
>  	} else {
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
