Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 01/11] android/gatt: Add helper for getting device by conn_id
Date: Thu, 27 Mar 2014 22:33:23 +0100
Message-ID: <1965189.dW4yBg2Fyz@athlon>
In-Reply-To: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 27 March 2014 22:12:59 Marcin Kraglak wrote:
> It will look for cgatt_device by conn_id.
> ---
>  android/gatt.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 81bfdc0..7a3db27 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -713,6 +713,17 @@ static struct gatt_device *find_device(bdaddr_t *addr)
>  	return NULL;
>  }
> 
> +static struct gatt_device *find_device_by_conn_id(int32_t conn_id)
> +{
> +	struct gatt_device *dev;
> +
> +	dev = queue_find(conn_list, match_dev_by_conn_id, INT_TO_PTR(conn_id));
> +	if (dev)
> +		return dev;
> +
> +	return NULL;

Wouldn't just return queue_find(); do the same here?
> +}
> +
>  static void handle_client_connect(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_gatt_client_connect *cmd = buf;
> @@ -850,8 +861,7 @@ static void handle_client_disconnect(const void *buf,
> uint16_t len)
> 
>  	ba2str((bdaddr_t *)&cmd->bdaddr, addr);
> 
> -	dev = queue_find(conn_list, match_dev_by_conn_id,
> -						INT_TO_PTR(cmd->conn_id));
> +	dev = find_device_by_conn_id(cmd->conn_id);
>  	if (!dev) {
>  		error("gatt: dev %s with conn_id=%d not found",
>  							addr, cmd->conn_id);
> @@ -916,8 +926,7 @@ static void handle_client_search_service(const void
> *buf, uint16_t len)
> 
>  	DBG("");
> 
> -	dev = queue_find(conn_list, match_dev_by_conn_id,
> -						INT_TO_PTR(cmd->conn_id));
> +	dev = find_device_by_conn_id(cmd->conn_id);
>  	if (!dev) {
>  		error("gatt: dev with conn_id=%d not found", cmd->conn_id);
>  		status = HAL_STATUS_FAILED;
> @@ -1040,8 +1049,7 @@ static bool find_service(int32_t conn_id, struct
> element_id *service_id, struct gatt_device *device;
>  	struct service *service;
> 
> -	device = queue_find(conn_list, match_dev_by_conn_id,
> -							INT_TO_PTR(conn_id));
> +	device = find_device_by_conn_id(conn_id);
>  	if (!device) {
>  		error("gatt: conn_id=%d not found", conn_id);
>  		return false;

-- 
Szymon K. Janc
szymon.janc@gmail.com
