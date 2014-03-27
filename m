Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 02/11] android/gatt: Add helper to get client by id
Date: Thu, 27 Mar 2014 22:49:31 +0100
Message-ID: <5391615.38ozq05xKo@athlon>
In-Reply-To: <1395954789-32459-2-git-send-email-marcin.kraglak@tieto.com>
References: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com> <1395954789-32459-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 27 March 2014 22:13:00 Marcin Kraglak wrote:
> It will look for gatt_client by client_id.
> ---
>  android/gatt.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 7a3db27..1af7e33 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -148,6 +148,11 @@ static bool match_client_by_id(const void *data, const
> void *user_data) return client->id == exp_id;
>  }
> 
> +static struct gatt_client *find_client_by_id(int32_t id)
> +{
> +	return queue_find(gatt_clients, match_client_by_id, INT_TO_PTR(id));
> +}
> +
>  static bool match_by_value(const void *data, const void *user_data)
>  {
>  	return data == user_data;
> @@ -628,8 +633,7 @@ static void handle_client_scan(const void *buf, uint16_t
> len)
> 
>  	DBG("new state %d", cmd->start);
> 
> -	registered = queue_find(gatt_clients, match_client_by_id,
> -						INT_TO_PTR(cmd->client_if));
> +	registered = find_client_by_id(cmd->client_if);
>  	if (!registered) {
>  		error("gatt: Client not registered");
>  		status = HAL_STATUS_FAILED;
> @@ -736,8 +740,7 @@ static void handle_client_connect(const void *buf,
> uint16_t len) DBG("");
> 
>  	/* Check if client is registered */
> -	l = queue_find(gatt_clients, match_client_by_id,
> -						INT_TO_PTR(cmd->client_if));
> +	l = find_client_by_id(cmd->client_if);
>  	if (!l) {
>  		error("gatt: Client id %d not found", cmd->client_if);
>  		status = HAL_STATUS_FAILED;

This patch is now applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
