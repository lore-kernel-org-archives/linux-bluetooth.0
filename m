Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/gatt: Fix for scan non discoverable devices
Date: Fri, 11 Apr 2014 16:08:04 +0200
Message-ID: <3680668.o1WelZYoBR@uw000953>
In-Reply-To: <1397208298-15979-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397208298-15979-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 11 of April 2014 11:24:58 Lukasz Rymanowski wrote:
> With this patch Android framework will not be notify with non
> discoverable LE devices.
> ---
>  android/bluetooth.c | 10 ++++++++--
>  android/bluetooth.h |  2 +-
>  android/gatt.c      |  5 +++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 4e4397a..e9df704 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1362,8 +1362,14 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  	eir_data_free(&eir);
>  
>  	/* Notify Gatt if its registered for LE events */
> -	if (bdaddr_type != BDADDR_BREDR && gatt_device_found_cb)
> -		gatt_device_found_cb(bdaddr, bdaddr_type, rssi, data_len, data);
> +	if (bdaddr_type != BDADDR_BREDR && gatt_device_found_cb) {
> +		bool discoverable;
> +
> +		discoverable = (eir.flags & (EIR_LIM_DISC | EIR_GEN_DISC));
> +
> +		gatt_device_found_cb(bdaddr, bdaddr_type, rssi, data_len, data,
> +								discoverable);
> +	}
>  
>  	if (dev->bond_state != HAL_BOND_STATE_BONDED)
>  		cache_device(dev);
> diff --git a/android/bluetooth.h b/android/bluetooth.h
> index 8dbc623..807ebe7 100644
> --- a/android/bluetooth.h
> +++ b/android/bluetooth.h
> @@ -37,7 +37,7 @@ void bt_adapter_remove_record(uint32_t handle);
>  
>  typedef void (*bt_le_device_found)(const bdaddr_t *addr, uint8_t addr_type,
>  					int rssi, uint16_t eir_len,
> -					const void *eir);
> +					const void *eir, bool discoverable);
>  bool bt_le_discovery_start(bt_le_device_found cb);
>  
>  typedef void (*bt_le_discovery_stopped)(void);
> diff --git a/android/gatt.c b/android/gatt.c
> index a33ce25..50f1c41 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -705,13 +705,14 @@ static bool is_device_wating_for_connect(const bdaddr_t *addr,
>  
>  static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>  						int rssi, uint16_t eir_len,
> -							const void *eir)
> +							const void *eir,
> +							bool discoverable)
>  {
>  	uint8_t buf[IPC_MTU];
>  	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
>  	char bda[18];
>  
> -	if (!scanning)
> +	if (!scanning || !discoverable)
>  		goto connect;
>  
>  	ba2str(addr, bda);
> 

Applied with minor changes, thanks.

-- 
Best regards, 
Szymon Janc
