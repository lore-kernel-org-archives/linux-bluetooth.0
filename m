Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/16] android/gatt: Add API to remove autoconnect GATT based device
Date: Tue, 02 Sep 2014 17:27:26 +0200
Message-ID: <4381322.9SzXjEeX31@uw000953>
In-Reply-To: <1409652601-28689-8-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com> <1409652601-28689-8-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 02 of September 2014 12:09:52 Lukasz Rymanowski wrote:
> ---
>  android/gatt.c | 23 +++++++++++++++++++++++
>  android/gatt.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 5d04ad8..0d0b56d 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6755,3 +6755,26 @@ bool bt_gatt_add_autoconnect(unsigned int id, const bdaddr_t *addr)
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
> +		device_unref(dev);
> +
> +		if (dev->state == DEVICE_CONNECT_INIT)
> +			device_set_state(dev, DEVICE_DISCONNECTED);

This looks unclear to me since you are using dev after unref.
Shouldn't unref be done after you no longer need to use it? Otherwise
things might crash due to use-after-free.

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
> 

-- 
Best regards, 
Szymon Janc
