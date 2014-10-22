Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 11/14] shared/gatt: Add gatt-client include service iterator
Date: Wed, 22 Oct 2014 20:29:21 +0200
Message-ID: <12297005.3fX06ItIqc@athlon>
In-Reply-To: <1413454646-23076-12-git-send-email-marcin.kraglak@tieto.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com> <1413454646-23076-12-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 16 October 2014 12:17:23 Marcin Kraglak wrote:
> It will allow user to take value, handle, start and end handle
> of included service.
> ---
>  src/shared/gatt-client.c | 30 ++++++++++++++++++++++++++++++
>  src/shared/gatt-client.h | 10 ++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 971788c..28865da 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1674,6 +1674,36 @@ bool bt_gatt_characteristic_iter_next(struct
> bt_gatt_characteristic_iter *iter, return true;
>  }
> 
> +bool bt_gatt_include_service_iter_init(struct bt_gatt_incl_service_iter
> *iter, +					const bt_gatt_service_t *service)
> +{
> +	if (!iter || !service)
> +		return false;
> +
> +	memset(iter, 0, sizeof(*iter));
> +	iter->service = (struct service_list *) service;


I know that this is based on existing code but I'll comment on it here :)

This cast is really confusing. Either it should be casted to void* as service 
field inside iter or service should be const in iter if we are passing const 
data there. Or it should be of type service_list and named services?

This list interface is kinda hard to read and I don't really like it without 
proper macros (like in kernel code)...

> +
> +	return true;
> +}
> +
> +bool bt_gatt_include_service_iter_next(struct bt_gatt_incl_service_iter
> *iter, +					const bt_gatt_included_service_t **incl)
> +{
> +	struct service_list *service;
> +
> +	if (!iter || !incl)
> +		return false;
> +
> +	service = iter->service;
> +
> +	if (iter->pos >= service->num_includes)
> +		return false;
> +
> +	*incl = &service->includes[iter->pos++];
> +
> +	return true;
> +}
> +
>  struct read_op {
>  	bt_gatt_client_read_callback_t callback;
>  	void *user_data;
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 05b4838..bf4e7bb 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -113,6 +113,11 @@ struct bt_gatt_characteristic_iter {
>  	size_t pos;
>  };
> 
> +struct bt_gatt_incl_service_iter {
> +	void *service;
> +	size_t pos;
> +};
> +
>  bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
>  						struct bt_gatt_client *client);
>  bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
> @@ -129,6 +134,11 @@ bool bt_gatt_characteristic_iter_init(struct
> bt_gatt_characteristic_iter *iter, bool
> bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
> const bt_gatt_characteristic_t **chrc);
> 
> +bool bt_gatt_include_service_iter_init(struct bt_gatt_incl_service_iter
> *iter, +					const bt_gatt_service_t *service);
> +bool bt_gatt_include_service_iter_next(struct bt_gatt_incl_service_iter
> *iter, +					const bt_gatt_included_service_t **inc);
> +
>  typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t
> att_ecode, const uint8_t *value, uint16_t length,
>  					void *user_data);

-- 
Szymon K. Janc
szymon.janc@gmail.com
