Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/6] android/gatt: Move not used devices to disconnected dev queue
Date: Thu, 10 Apr 2014 14:40:08 +0200
Message-ID: <21498123.GVIzOAgyxH@uw000953>
In-Reply-To: <1397119381-13294-7-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397119381-13294-1-git-send-email-lukasz.rymanowski@tieto.com> <1397119381-13294-7-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 10 of April 2014 10:43:01 Lukasz Rymanowski wrote:
> With this patch, devices from conn_list and conn_wait_queue which are
> without a client e.g. because client has unregister without any
> cleaning, are move to the disconnected device queue.
> ---
>  android/gatt.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index d9c5773..4d7a3e4 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -295,6 +295,13 @@ static bool match_dev_by_conn_id(const void *data, const void *user_data)
>  	return dev->conn_id == conn_id;
>  }
>  
> +static bool match_dev_without_client(const void *data, const void *user_data)
> +{
> +	const struct gatt_device *dev = data;
> +
> +	return queue_isempty(dev->clients);
> +}
> +
>  static bool match_srvc_by_element_id(const void *data, const void *user_data)
>  {
>  	const struct element_id *exp_id = user_data;
> @@ -575,17 +582,32 @@ static void put_device_on_disc_list(struct gatt_device *dev)
>  	queue_push_tail(disc_dev_list, dev);
>  }
>  
> +static void park_not_used_devices(struct queue *q)
> +{
> +	struct gatt_device *dev;
> +
> +	/* Find device without client */
> +	dev = queue_remove_if(q, match_dev_without_client, NULL);
> +	while (dev) {
> +		/* Park device on disconnected device queue */
> +		put_device_on_disc_list(dev);
> +		dev = queue_remove_if(q, match_dev_without_client, NULL);
> +	};
> +}
> +
>  static void remove_client_from_devices(int32_t client_id)
>  {
>  	queue_foreach(conn_list, remove_cl_from_connected_dev_and_notify,
>  							INT_TO_PTR(client_id));
>  
> -	/*TODO: Check if there is any zombie device (connected no client)*/
> +	/*If there is any device without client, move it to disc list*/
> +	park_not_used_devices(conn_list);

Shouldn't those devices be disconnected as well? Also 'park' term is a bit
unusual, maybe just call it cleanup?

>  
>  	queue_foreach(conn_wait_queue, remove_cl_from_connecting_dev_and_notify,
>  							INT_TO_PTR(client_id));
>  
> -	/*TODO: Check if there is not zombie device plus stop scan */
> +	/*If there is any device without client, move it to disc list*/
> +	park_not_used_devices(conn_wait_queue);
>  }
>  
>  static void handle_client_unregister(const void *buf, uint16_t len)
> 

-- 
Best regards, 
Szymon Janc
