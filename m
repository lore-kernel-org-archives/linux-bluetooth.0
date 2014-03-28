Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/8] android/gatt: Add helper for getting device by conn_id
Date: Fri, 28 Mar 2014 11:28:27 +0100
Message-ID: <2797203.zJz3ML6XFU@uw000953>
In-Reply-To: <1395999959-2396-1-git-send-email-marcin.kraglak@tieto.com>
References: <1395999959-2396-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 28 of March 2014 10:45:52 Marcin Kraglak wrote:
> It will look for cgatt_device by conn_id.
> ---
>  android/gatt.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 81b29af..92e16d4 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -722,6 +722,11 @@ static struct gatt_device *find_device(bdaddr_t *addr)
>  	return NULL;
>  }
>  
> +static struct gatt_device *find_device_by_conn_id(int32_t conn_id)
> +{
> +	return queue_find(conn_list, match_dev_by_conn_id, INT_TO_PTR(conn_id));
> +}
> +
>  static void handle_client_connect(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_gatt_client_connect *cmd = buf;
> @@ -858,8 +863,7 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
>  
>  	ba2str((bdaddr_t *)&cmd->bdaddr, addr);
>  
> -	dev = queue_find(conn_list, match_dev_by_conn_id,
> -						INT_TO_PTR(cmd->conn_id));
> +	dev = find_device_by_conn_id(cmd->conn_id);
>  	if (!dev) {
>  		error("gatt: dev %s with conn_id=%d not found",
>  							addr, cmd->conn_id);
> @@ -924,8 +928,7 @@ static void handle_client_search_service(const void *buf, uint16_t len)
>  
>  	DBG("");
>  
> -	dev = queue_find(conn_list, match_dev_by_conn_id,
> -						INT_TO_PTR(cmd->conn_id));
> +	dev = find_device_by_conn_id(cmd->conn_id);
>  	if (!dev) {
>  		error("gatt: dev with conn_id=%d not found", cmd->conn_id);
>  		status = HAL_STATUS_FAILED;
> @@ -1048,8 +1051,7 @@ static bool find_service(int32_t conn_id, struct element_id *service_id,
>  	struct gatt_device *device;
>  	struct service *service;
>  
> -	device = queue_find(conn_list, match_dev_by_conn_id,
> -							INT_TO_PTR(conn_id));
> +	device = find_device_by_conn_id(conn_id);
>  	if (!device) {
>  		error("gatt: conn_id=%d not found", conn_id);
>  		return false;
> 

This patch is now upstream. Thanks.

-- 
Best regards, 
Szymon Janc
