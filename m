Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] client: Fix default_ctrl change when new adapter is
 found
To: Yunhan Wang <yunhanw@google.com>
References: <20170901035615.95402-1-yunhanw@google.com>
CC: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <a4eb008e-5c19-c13c-bb35-ac840f80be42@jp.fujitsu.com>
Date: Fri, 1 Sep 2017 16:28:39 +0900
MIME-Version: 1.0
In-Reply-To: <20170901035615.95402-1-yunhanw@google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

Your patch have a regression, since select command can not update the current
advertising manager (cache_ctrl) when it chooses another adapter.

I think that it is better to use proxy->obj_path below:

---
 client/main.c | 57 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/client/main.c b/client/main.c
index 825647d..c6cb995 100644
--- a/client/main.c
+++ b/client/main.c
@@ -525,17 +525,52 @@ static void device_added(GDBusProxy *proxy)
 	}
 }
 
+static struct adapter *find_ctrl(GList *source, const char *path)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+
+		if (!strcasecmp(g_dbus_proxy_get_path(adapter->proxy), path))
+			return adapter;
+	}
+
+	return NULL;
+}
+
+static struct adapter *adapter_new(GDBusProxy *proxy)
+{
+	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
+
+	ctrl_list = g_list_append(ctrl_list, adapter);
+
+	if (!default_ctrl)
+		default_ctrl = adapter;
+
+	return adapter;
+}
+
 static void adapter_added(GDBusProxy *proxy)
 {
-	default_ctrl = g_malloc0(sizeof(struct adapter));
-	default_ctrl->proxy = proxy;
-	ctrl_list = g_list_append(ctrl_list, default_ctrl);
+	struct adapter *ctrl;
+	ctrl = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
+	if (!ctrl)
+		ctrl = adapter_new(proxy);
+
+	ctrl->proxy = proxy;
+
 	print_adapter(proxy, COLORED_NEW);
 }
 
 static void ad_manager_added(GDBusProxy *proxy)
 {
-	default_ctrl->ad_proxy = proxy;
+	struct adapter *ctrl;
+	ctrl = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
+	if (!ctrl)
+		ctrl = adapter_new(proxy);
+
+	ctrl->ad_proxy = proxy;
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
@@ -661,20 +696,6 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	}
 }
 
-static struct adapter *find_ctrl(GList *source, const char *path)
-{
-	GList *list;
-
-	for (list = g_list_first(source); list; list = g_list_next(list)) {
-		struct adapter *adapter = list->data;
-
-		if (!strcasecmp(g_dbus_proxy_get_path(adapter->proxy), path))
-			return adapter;
-	}
-
-	return NULL;
-}
-
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
-- 
2.7.4


Regards,
Eramoto

On 09/01/2017 12:56 PM, Yunhan Wang wrote:
> When another adapter is found, the default adapter would be changed,
> which is not expected. Default adapter can only be changed by select
> command.
> ---
>  client/main.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/client/main.c b/client/main.c
> index 75696c2c1..29b3978e1 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -67,6 +67,7 @@ struct adapter {
>  };
>  
>  static struct adapter *default_ctrl;
> +static struct adapter *cache_ctrl;
>  static GDBusProxy *default_dev;
>  static GDBusProxy *default_attr;
>  static GList *ctrl_list;
> @@ -151,7 +152,7 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
>  
>  	g_list_free_full(ctrl_list, proxy_leak);
>  	ctrl_list = NULL;
> -
> +	cache_ctrl = NULL;
>  	default_ctrl = NULL;
>  }
>  
> @@ -521,15 +522,21 @@ static void device_added(GDBusProxy *proxy)
>  
>  static void adapter_added(GDBusProxy *proxy)
>  {
> -	default_ctrl = g_malloc0(sizeof(struct adapter));
> -	default_ctrl->proxy = proxy;
> -	ctrl_list = g_list_append(ctrl_list, default_ctrl);
> +	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
> +
> +	adapter->proxy = proxy;
> +	cache_ctrl = adapter;
> +	ctrl_list = g_list_append(ctrl_list, adapter);
> +
> +	if (!default_ctrl)
> +		default_ctrl = adapter;
> +
>  	print_adapter(proxy, COLORED_NEW);
>  }
>  
>  static void ad_manager_added(GDBusProxy *proxy)
>  {
> -	default_ctrl->ad_proxy = proxy;
> +	cache_ctrl->ad_proxy = proxy;
>  }
>  
>  static void proxy_added(GDBusProxy *proxy, void *user_data)
> @@ -602,7 +609,6 @@ static void adapter_removed(GDBusProxy *proxy)
>  			print_adapter(proxy, COLORED_DEL);
>  
>  			if (default_ctrl && default_ctrl->proxy == proxy) {
> -				default_ctrl = NULL;
>  				set_default_device(NULL, NULL);
>  			}
>  
> 

