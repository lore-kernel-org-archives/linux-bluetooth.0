Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] android/gatt: Remove discoverable flag from device found callback
Date: Thu, 18 Dec 2014 10:05:49 +0100
Message-ID: <4493539.SvR4e9GtP0@uw000953>
In-Reply-To: <1418290185-4617-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418290185-4617-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 11 of December 2014 10:29:44 Lukasz Rymanowski wrote:
> Android is interested in all of the Scan Responses. Also the ones which
> are set as non discoverable. It is in order to support
> Observer\Broadcaster mode. Therefore discoverable flag can be removed
> from the device found callback. This patch does it.
> ---
>  android/bluetooth.c | 5 +----
>  android/bluetooth.h | 3 +--
>  android/gatt.c      | 5 ++---
>  3 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 6443cfe..44bfe4d 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1946,12 +1946,9 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  
>  	/* Notify Gatt if its registered for LE events */
>  	if (bdaddr_type != BDADDR_BREDR && gatt_device_found_cb) {
> -		bool discoverable;
>  		bdaddr_t *addr;
>  		uint8_t addr_type;
>  
> -		discoverable = eir.flags & (EIR_LIM_DISC | EIR_GEN_DISC);
> -
>  		/*
>  		 * If RPA is set it means that IRK was received and ID address
>  		 * is being used. Android Framework is still using old RPA and
> @@ -1967,7 +1964,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  		}
>  
>  		gatt_device_found_cb(addr, addr_type, rssi, data_len, data,
> -						discoverable, dev->le_bonded);
> +								dev->le_bonded);
>  	}
>  
>  	if (!dev->bredr_paired && !dev->le_paired)
> diff --git a/android/bluetooth.h b/android/bluetooth.h
> index 8970559..4b7a70d 100644
> --- a/android/bluetooth.h
> +++ b/android/bluetooth.h
> @@ -42,8 +42,7 @@ void bt_adapter_remove_record(uint32_t handle);
>  
>  typedef void (*bt_le_device_found)(const bdaddr_t *addr, uint8_t addr_type,
>  					int rssi, uint16_t eir_len,
> -					const void *eir, bool discoverable,
> -					bool bonded);
> +					const void *eir, bool bonded);
>  bool bt_le_register(bt_le_device_found cb);
>  void bt_le_unregister(void);
>  
> diff --git a/android/gatt.c b/android/gatt.c
> index b2ce9c1..519e347 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1648,15 +1648,14 @@ static void bt_le_discovery_stop_cb(void)
>  
>  static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>  						int rssi, uint16_t eir_len,
> -						const void *eir,
> -						bool discoverable, bool bonded)
> +						const void *eir, bool bonded)
>  {
>  	uint8_t buf[IPC_MTU];
>  	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
>  	struct gatt_device *dev;
>  	char bda[18];
>  
> -	if (!scanning || (!discoverable && !bonded))
> +	if (!scanning)
>  		goto connect;
>  
>  	ba2str(addr, bda);
> 

This patch is now applied, thanks.

Second needs to be rebased.

-- 
Best regards, 
Szymon Janc
