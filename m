Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/8] shared/gatt: Extend gatt_db_read function
Date: Tue, 13 May 2014 15:07:58 +0200
Message-ID: <8049216.kSuPQKvL5L@uw000953>
In-Reply-To: <1399899758-4944-3-git-send-email-marcin.kraglak@tieto.com>
References: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com> <1399899758-4944-3-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 12 of May 2014 15:02:32 Marcin Kraglak wrote:
> If value exists in database, return pointer to it instead of returning
> false. It is needed because some attributes don't have read_cb callback
> and their value can be read directly from database. If read_cb is
> registered, it will be called. In case of error false will be returned.
> ---
>  android/gatt.c       |  3 ++-
>  src/shared/gatt-db.c | 17 ++++++++++++++---
>  src/shared/gatt-db.h |  3 ++-
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index d8bcfb5..0a2abe3 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -4105,7 +4105,8 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
>  		return ATT_ECODE_REQ_NOT_SUPP;
>  	}
>  
> -	if (!gatt_db_read(gatt_db, handle, offset, cmd[0], &dev->bdaddr))
> +	if (!gatt_db_read(gatt_db, handle, offset, cmd[0], &dev->bdaddr, NULL,
> +									NULL))
>  		return ATT_ECODE_UNLIKELY;
>  
>  	return 0;
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index ebfd586..adce153 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -684,12 +684,16 @@ static bool find_service_for_handle(const void *data, const void *user_data)
>  }
>  
>  bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
> -				uint8_t att_opcode, bdaddr_t *bdaddr)
> +				uint8_t att_opcode, bdaddr_t *bdaddr,
> +				uint8_t **value, uint16_t *length)
>  {
>  	struct gatt_db_service *service;
>  	uint16_t service_handle;
>  	struct gatt_db_attribute *a;
>  
> +	if (!value || !length)
> +		return false;
> +
>  	service = queue_find(db->services, find_service_for_handle,
>  						INT_TO_PTR(handle));
>  	if (!service)
> @@ -698,10 +702,17 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
>  	service_handle = service->attributes[0]->handle;
>  
>  	a = service->attributes[handle - service_handle];
> -	if (!a || !a->read_func)
> +	if (!a || offset > a->value_len)
>  		return false;
>  
> -	a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
> +	if (!a->read_func) {
> +		*value = &a->value[offset];
> +		*length = a->value_len - offset;
> +	} else {
> +		*value = NULL;
> +		*length = 0;
> +		a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
> +	}

Please keep following convention:

if (func)
  func();

>  
>  	return true;
>  }
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index f704b8e..a5a5f41 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -106,7 +106,8 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>  							struct queue *queue);
>  
>  bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
> -					uint8_t att_opcode, bdaddr_t *bdaddr);
> +					uint8_t att_opcode, bdaddr_t *bdaddr,
> +					uint8_t **value, uint16_t *length);

I think length should be signed. Otherwise if might be clumsy to distinguish
between 0 length data and callback called.

Also please add a comment about that in code.

>  
>  bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
>  					const uint8_t *value, size_t len,
> 

-- 
Best regards, 
Szymon Janc
