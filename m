Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Pass device to send_device_property function
Date: Fri, 20 Jun 2014 17:35:38 +0200
Message-ID: <1674514.g4fsiS35xK@uw000953>
In-Reply-To: <1403277735-14070-1-git-send-email-szymon.janc@tieto.com>
References: <1403277735-14070-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 20 of June 2014 17:22:15 Szymon Janc wrote:
> ---
>  android/bluetooth.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index a1e03ce..71458f2 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -846,14 +846,14 @@ static void update_device_state(struct device *dev, uint8_t addr_type,
>  		send_bond_state_change(&dev->bdaddr, status, new_bond);
>  }
>  
> -static  void send_device_property(const bdaddr_t *bdaddr, uint8_t type,
> +static  void send_device_property(struct device *dev, uint8_t type,
>  						uint16_t len, const void *val)
>  {
>  	uint8_t buf[BASELEN_REMOTE_DEV_PROP + len];
>  	struct hal_ev_remote_device_props *ev = (void *) buf;
>  
>  	ev->status = HAL_STATUS_SUCCESS;
> -	bdaddr2android(bdaddr, ev->bdaddr);
> +	bdaddr2android(&dev->bdaddr, ev->bdaddr);
>  	ev->num_props = 1;
>  	ev->props[0].type = type;
>  	ev->props[0].len = len;
> @@ -874,8 +874,7 @@ static void send_device_uuids_notif(struct device *dev)
>  		ptr += sizeof(uint128_t);
>  	}
>  
> -	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_UUIDS, sizeof(buf),
> -									buf);
> +	send_device_property(dev, HAL_PROP_DEVICE_UUIDS, sizeof(buf), buf);
>  }
>  
>  static void set_device_uuids(struct device *dev, GSList *uuids)
> @@ -1065,7 +1064,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
>  
>  static uint8_t get_device_name(struct device *dev)
>  {
> -	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_NAME,
> +	send_device_property(dev, HAL_PROP_DEVICE_NAME,
>  						strlen(dev->name), dev->name);
>  
>  	return HAL_STATUS_SUCCESS;
> @@ -4154,7 +4153,7 @@ static uint8_t get_device_uuids(struct device *dev)
>  
>  static uint8_t get_device_class(struct device *dev)
>  {
> -	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_CLASS,
> +	send_device_property(dev, HAL_PROP_DEVICE_CLASS,
>  					sizeof(dev->class), &dev->class);
>  
>  	return HAL_STATUS_SUCCESS;
> @@ -4164,8 +4163,7 @@ static uint8_t get_device_type(struct device *dev)
>  {
>  	uint8_t type = get_device_android_type(dev);
>  
> -	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_TYPE,
> -							sizeof(type), &type);
> +	send_device_property(dev, HAL_PROP_DEVICE_TYPE, sizeof(type), &type);
>  
>  	return HAL_STATUS_SUCCESS;
>  }
> @@ -4184,7 +4182,7 @@ static uint8_t get_device_friendly_name(struct device *dev)
>  	if (!dev->friendly_name)
>  		return HAL_STATUS_FAILED;
>  
> -	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_FRIENDLY_NAME,
> +	send_device_property(dev, HAL_PROP_DEVICE_FRIENDLY_NAME,
>  				strlen(dev->friendly_name), dev->friendly_name);
>  
>  	return HAL_STATUS_SUCCESS;
> @@ -4195,7 +4193,7 @@ static uint8_t get_device_rssi(struct device *dev)
>  	if (!dev->rssi)
>  		return HAL_STATUS_FAILED;
>  
> -	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_RSSI,
> +	send_device_property(dev, HAL_PROP_DEVICE_RSSI,
>  						sizeof(dev->rssi), &dev->rssi);
>  
>  	return HAL_STATUS_SUCCESS;
> @@ -4216,7 +4214,7 @@ static uint8_t get_device_timestamp(struct device *dev)
>  
>  	timestamp = device_timestamp(dev);
>  
> -	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_TIMESTAMP,
> +	send_device_property(dev, HAL_PROP_DEVICE_TIMESTAMP,
>  						sizeof(timestamp), &timestamp);
>  
>  	return HAL_STATUS_SUCCESS;
> 

Pushed.

-- 
Best regards, 
Szymon Janc
