Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/3] shared/gatt: Return bool in gatt_db_get_attribute_permissions
Date: Sun, 01 Jun 2014 18:43:20 +0200
Message-ID: <5434705.gW0UxoHRjg@leonov>
In-Reply-To: <1401442662-11475-2-git-send-email-marcin.kraglak@tieto.com>
References: <1401442662-11475-1-git-send-email-marcin.kraglak@tieto.com> <1401442662-11475-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 30 of May 2014 11:37:41 Marcin Kraglak wrote:
> It will return true if attribute with given handle exists in db and
> set permissions value, otherwise it will return false.
> Now, if get_permissions failed, we should reply with
> ATT_ECODE_ATTR_NOT_FOUND.
> ---
>  android/gatt.c       | 23 +++++++++++++++++------
>  src/shared/gatt-db.c | 11 +++++++----
>  src/shared/gatt-db.h |  3 ++-
>  3 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 80d9f30..421cae4 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4070,8 +4070,13 @@ static void read_requested_attributes(void *data,
> void *user_data) uint8_t *value;
>  	int value_len;
> 
> -	permissions = gatt_db_get_attribute_permissions(gatt_db,
> -							resp_data->handle);
> +	if (!gatt_db_get_attribute_permissions(gatt_db,
> +							resp_data->handle,
> +							&permissions)) {
> +		resp_data->error = ATT_ECODE_ATTR_NOT_FOUND;
> +		resp_data->state = REQUEST_DONE;
> +		return;
> +	}
> 
>  	/*
>  	 * Check if it is attribute we didn't declare permissions, like service
> @@ -5067,7 +5072,9 @@ static void write_cmd_request(const uint8_t *cmd,
> uint16_t cmd_len, if (!len)
>  		return;
> 
> -	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
> +	if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
> +		return;
> +
>  	if (check_device_permissions(dev, cmd[0], permissions))
>  		return;
> 
> @@ -5093,7 +5100,9 @@ static void write_signed_cmd_request(const uint8_t
> *cmd, uint16_t cmd_len,
> 
>  	len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
> 
> -	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
> +	if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
> +		return;
> +
>  	if (check_device_permissions(dev, cmd[0], permissions))
>  		return;
> 
> @@ -5133,7 +5142,8 @@ static uint8_t write_req_request(const uint8_t *cmd,
> uint16_t cmd_len, if (!len)
>  		return ATT_ECODE_INVALID_PDU;
> 
> -	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
> +	if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
> +		return ATT_ECODE_ATTR_NOT_FOUND;
> 
>  	error = check_device_permissions(dev, cmd[0], permissions);
>  	if (error)
> @@ -5181,7 +5191,8 @@ static uint8_t write_prep_request(const uint8_t *cmd,
> uint16_t cmd_len, if (!len)
>  		return ATT_ECODE_INVALID_PDU;
> 
> -	permissions = gatt_db_get_attribute_permissions(gatt_db, handle);
> +	if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
> +		return ATT_ECODE_ATTR_NOT_FOUND;
> 
>  	error = check_device_permissions(dev, cmd[0], permissions);
>  	if (error)
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 998e93e..c11c5d1 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -734,7 +734,8 @@ uint16_t gatt_db_get_end_handle(struct gatt_db *db,
> uint16_t handle) return service->attributes[0]->handle +
> service->num_handles - 1; }
> 
> -uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t
> handle) +bool gatt_db_get_attribute_permissions(struct gatt_db *db,
> uint16_t handle, +							uint32_t *permissions)
>  {
>  	struct gatt_db_attribute *attribute;
>  	struct gatt_db_service *service;
> @@ -743,7 +744,7 @@ uint32_t gatt_db_get_attribute_permissions(struct
> gatt_db *db, uint16_t handle) service = queue_find(db->services,
> find_service_for_handle,
>  							INT_TO_PTR(handle));
>  	if (!service)
> -		return 0;
> +		return false;
> 
>  	service_handle = service->attributes[0]->handle;
> 
> @@ -754,7 +755,9 @@ uint32_t gatt_db_get_attribute_permissions(struct
> gatt_db *db, uint16_t handle) */
>  	attribute = service->attributes[handle - service_handle];
>  	if (!attribute)
> -		return 0;
> +		return false;
> +
> +	*permissions = attribute->permissions;
> +	return true;
> 
> -	return attribute->permissions;
>  }
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index f2f2f4d..a88f637 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -92,4 +92,5 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db
> *db,
> 
>  uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
> 
> -uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t
> handle); +bool gatt_db_get_attribute_permissions(struct gatt_db *db,
> uint16_t handle, +							uint32_t *permissions);

Patches 2/3 and 3/3 are now applied, thanks.

-- 
BR
Szymon Janc
