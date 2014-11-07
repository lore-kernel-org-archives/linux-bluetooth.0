Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Nov 2014 14:20:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 10/11] shared/gatt-client: Fix alignment warnings.
Message-ID: <20141107122043.GA14496@t440s.lan>
References: <1415347791-11716-1-git-send-email-armansito@chromium.org>
 <1415347791-11716-11-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415347791-11716-11-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Fri, Nov 07, 2014, Arman Uguray wrote:
> This patch addresses warnings that arise when compiled with
> -W=cast-align.
> ---
>  src/shared/gatt-client.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index b4f28b2..2e321b2 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1647,7 +1647,7 @@ bool bt_gatt_characteristic_iter_init(struct bt_gatt_characteristic_iter *iter,
>  		return false;
>  
>  	memset(iter, 0, sizeof(*iter));
> -	iter->service = (struct service_list *) service;
> +	iter->service = (void *) service;
>  
>  	return true;
>  }
> @@ -1677,7 +1677,7 @@ bool bt_gatt_include_service_iter_init(struct bt_gatt_incl_service_iter *iter,
>  		return false;
>  
>  	memset(iter, 0, sizeof(*iter));
> -	iter->service = (struct service_list *) service;
> +	iter->service = (void *) service;
>  
>  	return true;
>  }
> @@ -2387,7 +2387,7 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>  	struct chrc_data *chrc = NULL;
>  	struct bt_gatt_service_iter iter;
>  	const bt_gatt_service_t *service;
> -	size_t i;
> +	size_t i, offset;
>  
>  	if (!client || !chrc_value_handle || !callback)
>  		return false;
> @@ -2402,7 +2402,8 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>  	while (bt_gatt_service_iter_next(&iter, &service)) {
>  		if (chrc_value_handle >= service->start_handle &&
>  				chrc_value_handle <= service->end_handle) {
> -			svc_data = (struct service_list *) service;
> +			offset = offsetof(struct service_list, service);
> +			svc_data = (void *) (service - offset);
>  			break;

Are you sure a (void *) case isn't enough for the last one too? After
all offsetof() should be returning 0 which in the end results in a void *
cast of the service pointer anyway.

Btw, if we at any point find the need to really do this kind of pointer
math I'd suggest adding a container_of() helper macro like the kernel
uses.

Johan
