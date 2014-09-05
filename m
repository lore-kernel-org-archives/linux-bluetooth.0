Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/6] android/gatt: Add API to remove autoconnect GATT based device
Date: Fri, 05 Sep 2014 11:11:51 +0200
Message-ID: <8060157.bhBlHtOcd8@uw000953>
In-Reply-To: <1409755353-6027-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409755353-6027-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 03 of September 2014 16:42:28 Lukasz Rymanowski wrote:
> ---
> v2: Fixed issue found by Szymon
> v3: Fixes according to Luiz comments
> 
>  android/gatt.c | 24 ++++++++++++++++++++++++
>  android/gatt.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index aff5dc5..a3486ca 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6768,3 +6768,27 @@ bool bt_gatt_add_autoconnect(unsigned int id, const bdaddr_t *addr)
>  
>  	return true;
>  }
> +
> +void bt_gatt_remove_autoconnect(unsigned int id, const bdaddr_t *addr)
> +{
> +	struct gatt_device *dev;
> +
> +	DBG("");
> +
> +	dev = find_device_by_addr(addr);
> +	if (!dev) {
> +		error("gatt: Device not found");
> +		return;
> +	}
> +
> +	queue_remove(dev->autoconnect_apps, INT_TO_PTR(id));
> +
> +	if (queue_isempty(dev->autoconnect_apps)) {
> +		bt_auto_connect_remove(addr);
> +
> +		if (dev->state == DEVICE_CONNECT_INIT)
> +			device_set_state(dev, DEVICE_DISCONNECTED);
> +
> +		device_unref(dev);
> +	}
> +}
> diff --git a/android/gatt.h b/android/gatt.h
> index 40699b2..3382df9 100644
> --- a/android/gatt.h
> +++ b/android/gatt.h
> @@ -40,3 +40,4 @@ bool bt_gatt_connect_app(unsigned int id, const bdaddr_t *addr);
>  bool bt_gatt_disconnect_app(unsigned int id, const bdaddr_t *addr);
>  bool bt_gatt_set_security(const bdaddr_t *bdaddr, int sec_level);
>  bool bt_gatt_add_autoconnect(unsigned int id, const bdaddr_t *addr);
> +void bt_gatt_remove_autoconnect(unsigned int id, const bdaddr_t *addr);

Patches 1-5 are now applied. 6th requires rebase, thanks. 

-- 
Best regards, 
Szymon Janc
