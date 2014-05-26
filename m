Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/6] shared/gatt: Define atribute permissions as uint32_t
Date: Mon, 26 May 2014 14:19:20 +0200
Message-ID: <13606412.hJyRAG23iT@uw000953>
In-Reply-To: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Monday 26 of May 2014 11:10:24 Marcin Kraglak wrote:
> ---
>  src/shared/gatt-db.c | 6 +++---
>  src/shared/gatt-db.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 36316af..90c09bb 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -48,7 +48,7 @@ struct gatt_db {
>  struct gatt_db_attribute {
>  	uint16_t handle;
>  	bt_uuid_t uuid;
> -	uint8_t permissions;
> +	uint32_t permissions;
>  	uint16_t value_len;
>  	uint8_t *value;
>  
> @@ -269,7 +269,7 @@ static void set_attribute_data(struct gatt_db_attribute *attribute,
>  
>  uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
>  						const bt_uuid_t *uuid,
> -						uint8_t permissions,
> +						uint32_t permissions,
>  						uint8_t properties,
>  						gatt_db_read_t read_func,
>  						gatt_db_write_t write_func,
> @@ -317,7 +317,7 @@ uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
>  
>  uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
>  						const bt_uuid_t *uuid,
> -						uint8_t permissions,
> +						uint32_t permissions,
>  						gatt_db_read_t read_func,
>  						gatt_db_write_t write_func,
>  						void *user_data)
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 3d46730..350e34e 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -41,7 +41,7 @@ typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
>  
>  uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
>  						const bt_uuid_t *uuid,
> -						uint8_t permissions,
> +						uint32_t permissions,
>  						uint8_t properties,
>  						gatt_db_read_t read_func,
>  						gatt_db_write_t write_func,
> @@ -49,7 +49,7 @@ uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
>  
>  uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
>  						const bt_uuid_t *uuid,
> -						uint8_t permissions,
> +						uint32_t permissions,
>  						gatt_db_read_t read_func,
>  						gatt_db_write_t write_func,
>  						void *user_data);
> 

All patches applied (with some cleanups in the last one), thanks.

-- 
Best regards, 
Szymon Janc
