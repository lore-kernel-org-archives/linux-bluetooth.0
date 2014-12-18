Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] android/gatt: Add connectable flag to device found callback
Date: Thu, 18 Dec 2014 18:15:45 +0100
Message-ID: <2541693.ruOR8MzMAR@uw000953>
In-Reply-To: <1418903276-25261-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418903276-25261-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 18 of December 2014 12:47:56 Lukasz Rymanowski wrote:
> GATT is interested in advertising event type. i.e if it is connectable
> or not. It is because GATT does not want to triggers connection to
> devices doing non-connectable advertising.
> This patch add such support.
> ---
> v3: rebase only
>  android/bluetooth.c |  9 ++++++---
>  android/bluetooth.h |  3 ++-
>  android/gatt.c      | 10 +++++++---
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 48085e9..96808b7 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1917,6 +1917,7 @@ static bool is_new_device(const struct device *dev, unsigned int flags,
>  
>  static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  					int8_t rssi, bool confirm,
> +					bool connectable,
>  					const uint8_t *data, uint8_t data_len)
>  {
>  	struct eir_data eir;
> @@ -1964,7 +1965,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  		}
>  
>  		gatt_device_found_cb(addr, addr_type, rssi, data_len, data,
> -								dev->le_bonded);
> +						connectable, dev->le_bonded);
>  	}
>  
>  	if (!dev->bredr_paired && !dev->le_paired)
> @@ -2000,6 +2001,7 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
>  	uint16_t eir_len;
>  	uint32_t flags;
>  	bool confirm_name;
> +	bool connectable;
>  	char addr[18];
>  
>  	if (length < sizeof(*ev)) {
> @@ -2026,9 +2028,10 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
>  				index, addr, ev->rssi, flags, eir_len);
>  
>  	confirm_name = flags & MGMT_DEV_FOUND_CONFIRM_NAME;
> +	connectable = !(flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
>  
>  	update_found_device(&ev->addr.bdaddr, ev->addr.type, ev->rssi,
> -						confirm_name, eir, eir_len);
> +				confirm_name, connectable, eir, eir_len);
>  }
>  
>  static void mgmt_device_connected_event(uint16_t index, uint16_t length,
> @@ -2043,7 +2046,7 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
>  		return;
>  	}
>  
> -	update_found_device(&ev->addr.bdaddr, ev->addr.type, 0, false,
> +	update_found_device(&ev->addr.bdaddr, ev->addr.type, 0, false, false,
>  					&ev->eir[0], le16_to_cpu(ev->eir_len));
>  
>  	hal_ev.status = HAL_STATUS_SUCCESS;
> diff --git a/android/bluetooth.h b/android/bluetooth.h
> index 4b7a70d..d09b6f2 100644
> --- a/android/bluetooth.h
> +++ b/android/bluetooth.h
> @@ -42,7 +42,8 @@ void bt_adapter_remove_record(uint32_t handle);
>  
>  typedef void (*bt_le_device_found)(const bdaddr_t *addr, uint8_t addr_type,
>  					int rssi, uint16_t eir_len,
> -					const void *eir, bool bonded);
> +					const void *eir, bool connectable,
> +					bool bonded);
>  bool bt_le_register(bt_le_device_found cb);
>  void bt_le_unregister(void);
>  
> diff --git a/android/gatt.c b/android/gatt.c
> index ce55b26..3020047 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1658,7 +1658,8 @@ static void bt_le_discovery_stop_cb(void)
>  
>  static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>  						int rssi, uint16_t eir_len,
> -						const void *eir, bool bonded)
> +						const void *eir,
> +						bool connectable, bool bonded)
>  {
>  	uint8_t buf[IPC_MTU];
>  	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
> @@ -1666,7 +1667,7 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>  	char bda[18];
>  
>  	if (!scanning)
> -		goto connect;
> +		goto done;
>  
>  	ba2str(addr, bda);
>  	DBG("LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi, !!eir);
> @@ -1681,7 +1682,10 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>  						HAL_EV_GATT_CLIENT_SCAN_RESULT,
>  						sizeof(*ev) + ev->len, ev);
>  
> -connect:
> +done:
> +	if (!connectable)
> +		return;
> +
>  	/* We use auto connect feature from kernel if possible */
>  	if (bt_kernel_conn_control())
>  		return;
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
