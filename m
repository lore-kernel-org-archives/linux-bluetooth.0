Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] android/bluetooth: Extend bt_update_sign_counter function with val
Date: Fri, 03 Oct 2014 10:15:25 +0200
Message-ID: <2182954.flUbHxgXIK@uw000953>
In-Reply-To: <1411383247-11461-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411383247-11461-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 22 of September 2014 12:54:06 Lukasz Rymanowski wrote:
> With this patch, gatt can set any value to each local/remote signed
> counter. It is need by next patch
> ---
>  android/bluetooth.c | 7 ++++---
>  android/bluetooth.h | 3 ++-
>  android/gatt.c      | 4 ++--
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 4646a6c..237c221 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -4153,7 +4153,8 @@ static void store_sign_counter(struct device *dev, enum bt_csrk_type type)
>  	g_key_file_free(key_file);
>  }
>  
> -void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type)
> +void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type,
> +								uint32_t val)
>  {
>  	struct device *dev;
>  
> @@ -4162,9 +4163,9 @@ void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type)
>  		return;
>  
>  	if (type == LOCAL_CSRK)
> -		dev->local_sign_cnt++;
> +		dev->local_sign_cnt = val;
>  	else
> -		dev->remote_sign_cnt++;
> +		dev->remote_sign_cnt = val;
>  
>  	store_sign_counter(dev, type);
>  }
> diff --git a/android/bluetooth.h b/android/bluetooth.h
> index fffb3cc..8970559 100644
> --- a/android/bluetooth.h
> +++ b/android/bluetooth.h
> @@ -72,7 +72,8 @@ bool bt_read_device_rssi(const bdaddr_t *addr, bt_read_device_rssi_done cb,
>  bool bt_get_csrk(const bdaddr_t *addr, enum bt_csrk_type type,
>  					uint8_t key[16], uint32_t *sign_cnt);
>  
> -void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type);
> +void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type,
> +								uint32_t val);
>  
>  void bt_store_gatt_ccc(const bdaddr_t *addr, uint16_t value);
>  
> diff --git a/android/gatt.c b/android/gatt.c
> index 83d199f..e06ad1f 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -3168,7 +3168,7 @@ static guint signed_write_cmd(struct gatt_device *dev, uint16_t handle,
>  		return 0;
>  	}
>  
> -	bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK);
> +	bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, sign_cnt++);
>  
>  	return res;
>  }
> @@ -5940,7 +5940,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>  			return;
>  		}
>  		/* Signature OK, proceed with write */
> -		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK);
> +		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, sign_cnt++);
>  		gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
>  								&dev->bdaddr);
>  	}
> 

Although this was RFC I've applied it since otherwise we would have to re-pair
the device if just single command was lost. Thanks.

-- 
Best regards, 
Szymon Janc
