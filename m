Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v3] client: Fix default_ctrl change when new adapter is
 found
To: Yunhan Wang <yunhanw@google.com>
References: <20170913073627.59799-1-yunhanw@google.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <6087b552-0cbe-962c-74c1-10ad931c4331@jp.fujitsu.com>
Date: Wed, 13 Sep 2017 17:08:02 +0900
MIME-Version: 1.0
In-Reply-To: <20170913073627.59799-1-yunhanw@google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On 09/13/2017 04:36 PM, Yunhan Wang wrote:
> When another adapter is found, the default adapter would be changed, which is not expected. Default adapter can only be changed by select command.
> ---
>  client/main.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/client/main.c b/client/main.c
> index 75696c2c1..e6737b961 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -148,10 +148,8 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
>  	printf("\r");
>  	rl_on_new_line();
>  	rl_redisplay();
> -
>  	g_list_free_full(ctrl_list, proxy_leak);
>  	ctrl_list = NULL;
> -
>  	default_ctrl = NULL;
>  }
>  
> @@ -521,15 +519,36 @@ static void device_added(GDBusProxy *proxy)
>  
>  static void adapter_added(GDBusProxy *proxy)
>  {
> -	default_ctrl = g_malloc0(sizeof(struct adapter));
> -	default_ctrl->proxy = proxy;
> -	ctrl_list = g_list_append(ctrl_list, default_ctrl);
> +	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
> +
> +	adapter->proxy = proxy;
> +	ctrl_list = g_list_append(ctrl_list, adapter);
> +
> +	if (!default_ctrl)
> +		default_ctrl = adapter;
> +
>  	print_adapter(proxy, COLORED_NEW);
>  }
>  
> +static int match_proxy(const void *a, const void *b)
> +{
> +	GDBusProxy *proxy1 = (void *) a;
> +	GDBusProxy *proxy2 = (void *) b;
> +
> +	return strcmp(g_dbus_proxy_get_path(proxy1),
> +				  g_dbus_proxy_get_path(proxy2));
> +}
> +
>  static void ad_manager_added(GDBusProxy *proxy)
>  {
> -	default_ctrl->ad_proxy = proxy;
> +	GList *list;
> +
> +	for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
> +		struct adapter *adapter = list->data;
> +
> +		if (match_proxy(proxy, adapter->proxy) == 0)
> +			adapter->ad_proxy = proxy;
> +	}

I think that you should use find_ctrl(), which does the similar thing as 
match_proxy() and the for loop statement of above ad_manager_added().

Let's see ad_manager_added() of my attached patch at the URL:
  https://www.spinics.net/lists/linux-bluetooth/msg71731.html


Regards,
Eramoto

