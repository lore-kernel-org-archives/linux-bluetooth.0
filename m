Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/client: Add support for client->listen
Date: Mon, 14 Apr 2014 11:58:23 +0200
Message-ID: <1859629.3ngPynJzro@uw000953>
In-Reply-To: <1397465919-12677-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397465919-12677-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 14 of April 2014 10:58:37 Lukasz Rymanowski wrote:
> ---
>  android/client/if-gatt.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
> index 250472a..f421421 100644
> --- a/android/client/if-gatt.c
> +++ b/android/client/if-gatt.c
> @@ -576,6 +576,13 @@ static void gattc_read_remote_rssi_cb(int client_if, bt_bdaddr_t *bda, int rssi,
>  			client_if, bt_bdaddr_t2str(bda, buf), rssi, status);
>  }
>  
> +/* Callback invoked in response to listen */
> +static void gattc_listen_cb(int status, int client_if)
> +{
> +	haltest_info("%s: client_if=%d status=%d\n", __func__, client_if,
> +								status);
> +}
> +
>  static const btgatt_client_callbacks_t btgatt_client_callbacks = {
>  	.register_client_cb = gattc_register_client_cb,
>  	.scan_result_cb = gattc_scan_result_cb,
> @@ -593,7 +600,8 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
>  	.read_descriptor_cb = gattc_read_descriptor_cb,
>  	.write_descriptor_cb = gattc_write_descriptor_cb,
>  	.execute_write_cb = gattc_execute_write_cb,
> -	.read_remote_rssi_cb = gattc_read_remote_rssi_cb
> +	.read_remote_rssi_cb = gattc_read_remote_rssi_cb,
> +	.listen_cb = gattc_listen_cb,
>  };
>  
>  /* BT-GATT Server callbacks */
> @@ -922,6 +930,27 @@ static void disconnect_p(int argc, const char **argv)
>  	EXEC(if_gatt->client->disconnect, client_if, &bd_addr, conn_id);
>  }
>  
> +/* listen */
> +
> +/* Same completion as unregister for now, start stop is not auto completed */
> +#define listen_c unregister_client_c
> +
> +static void listen_p(int argc, const char **argv)
> +{
> +	int client_if;
> +	int start = 1;
> +
> +	RETURN_IF_NULL(if_gatt);
> +
> +	VERIFY_CLIENT_IF(2, client_if);
> +
> +	/* start */
> +	if (argc >= 4)
> +		start = atoi(argv[3]);
> +
> +	EXEC(if_gatt->client->listen, client_if, start);
> +}
> +
>  /* refresh */
>  
>  static void refresh_c(int argc, const char **argv, enum_func *enum_func,
> @@ -1405,6 +1434,7 @@ static struct method client_methods[] = {
>  	STD_METHODCH(get_device_type, "<addr>"),
>  	STD_METHODCH(test_command,
>  			"<cmd> <addr> <uuid> [u1] [u2] [u3] [u4] [u5]"),
> +	STD_METHODCH(listen, "<client_if> [1|0]"),
>  	END_METHOD
>  };

This patch is now upstream, thanks.

-- 
Best regards, 
Szymon Janc
