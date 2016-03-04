Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1457045748-19088-1-git-send-email-olivier@labapart.com>
References: <1457045748-19088-1-git-send-email-olivier@labapart.com>
Date: Fri, 4 Mar 2016 17:14:00 +0200
Message-ID: <CABBYNZ+XgbLvQSTCJh-Ns3P_b1DSU93Gydo1_T5xH4NxH_6CLw@mail.gmail.com>
Subject: Re: [PATCH] gatt-database: Fix GATT object ordering
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Olivier Martin <olivier@labapart.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Olivier Martin <olivier.martin.fr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Olivier,

On Fri, Mar 4, 2016 at 12:55 AM, Olivier Martin <olivier@labapart.com> wrote:
> There is no guarantee the objects returned by GetManagedObjects
> are ordered in the required order which is Service, Characteristic
> Descriptor due to their respective dependencies.
>
> This change ensures the objects are processed in the correct order.
> ---
>  src/gatt-database.c | 109 +++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 79 insertions(+), 30 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index d906e2b..dc020b8 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -89,6 +89,7 @@ struct gatt_app {
>         GDBusClient *client;
>         bool failed;
>         struct queue *services;
> +       struct queue *proxy_objects;

Call it proxies

>  };
>
>  struct external_service {
> @@ -360,11 +361,19 @@ static void service_free(void *data)
>         free(service);
>  }
>
> +static void proxy_object_free(void *data)
> +{
> +       struct GDBusProxy *proxy = data;
> +
> +       g_dbus_proxy_unref(proxy);
> +}
> +
>  static void app_free(void *data)
>  {
>         struct gatt_app *app = data;
>
>         queue_destroy(app->services, service_free);
> +       queue_destroy(app->proxy_objects, proxy_object_free);

I wouldn't even reference them, use a weak reference, in the first
place since they wont go away before ready callback.

>         if (app->client) {
>                 g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
> @@ -1428,39 +1437,12 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
>         if (app->failed)
>                 return;
>
> +       queue_push_tail(app->proxy_objects, g_dbus_proxy_ref(proxy));

Just push the without referencing here should be alright.

>         iface = g_dbus_proxy_get_interface(proxy);
>         path = g_dbus_proxy_get_path(proxy);
>
> -       if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
> -               struct external_service *service;
> -
> -               service = create_service(app, proxy, path);
> -               if (!service) {
> -                       app->failed = true;
> -                       return;
> -               }
> -       } else if (g_strcmp0(iface, GATT_CHRC_IFACE) == 0) {
> -               struct external_chrc *chrc;
> -
> -               chrc = chrc_create(app, proxy, path);
> -               if (!chrc) {
> -                       app->failed = true;
> -                       return;
> -               }
> -       } else if (g_strcmp0(iface, GATT_DESC_IFACE) == 0) {
> -               struct external_desc *desc;
> -
> -               desc = desc_create(app, proxy);
> -               if (!desc) {
> -                       app->failed = true;
> -                       return;
> -               }
> -       } else {
> -               DBG("Ignoring unrelated interface: %s", iface);
> -               return;
> -       }
> -
> -       DBG("Object added: path: %s, iface: %s", path, iface);
> +       DBG("Object received: %s, iface: %s", path, iface);
>  }
>
>  static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
> @@ -2139,12 +2121,78 @@ static bool database_add_app(struct gatt_app *app)
>         return true;
>  }
>
> +void register_service(void *data, void *user_data) {
> +       struct gatt_app *app = user_data;
> +       GDBusProxy *proxy = data;
> +        const char *iface = g_dbus_proxy_get_interface(proxy);
> +        const char *path = g_dbus_proxy_get_path(proxy);
> +
> +        if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
> +                struct external_service *service;
> +
> +                service = create_service(app, proxy, path);
> +                if (!service) {
> +                        app->failed = true;
> +                        return;
> +                }
> +        }
> +}
> +
> +void register_characteristic(void *data, void *user_data) {
> +        struct gatt_app *app = user_data;
> +        GDBusProxy *proxy = data;
> +        const char *iface = g_dbus_proxy_get_interface(proxy);
> +        const char *path = g_dbus_proxy_get_path(proxy);
> +
> +       if (g_strcmp0(iface, GATT_CHRC_IFACE) == 0) {
> +                struct external_chrc *chrc;
> +
> +                chrc = chrc_create(app, proxy, path);
> +                if (!chrc) {
> +                        app->failed = true;
> +                        return;
> +                }
> +        }
> +}
> +
> +void register_descriptor(void *data, void *user_data) {
> +        struct gatt_app *app = user_data;
> +        GDBusProxy *proxy = data;
> +        const char *iface = g_dbus_proxy_get_interface(proxy);
> +        const char *path = g_dbus_proxy_get_path(proxy);
> +
> +       if (g_strcmp0(iface, GATT_DESC_IFACE) == 0) {
> +                struct external_desc *desc;
> +
> +                desc = desc_create(app, proxy);
> +                if (!desc) {
> +                        app->failed = true;
> +                        return;
> +                }
> +        }
> +}
> +
>  static void client_ready_cb(GDBusClient *client, void *user_data)
>  {
>         struct gatt_app *app = user_data;
>         DBusMessage *reply;
>         bool fail = false;
>
> +       /*
> +        * Process received objects
> +        */
> +       if (queue_isempty(app->proxy_objects)) {
> +               error("No object received");
> +                fail = true;
> +                reply = btd_error_failed(app->reg,
> +                                        "No object received");
> +                goto reply;
> +       }
> +
> +       queue_foreach(app->proxy_objects, register_service, app);
> +       queue_foreach(app->proxy_objects, register_characteristic, app);
> +       queue_foreach(app->proxy_objects, register_descriptor, app);
> +
>         if (!app->services || app->failed) {
>                 error("No valid external GATT objects found");
>                 fail = true;
> @@ -2198,6 +2246,7 @@ static struct gatt_app *create_app(DBusConnection *conn, DBusMessage *msg,
>                 goto fail;
>
>         app->services = queue_new();
> +       app->proxy_objects = queue_new();
>         app->reg = dbus_message_ref(msg);
>
>         g_dbus_client_set_disconnect_watch(app->client, client_disconnect_cb,
> --
> 2.1.4

I could fix most of the comments above but there is way too many
coding style problems:

ERROR:CODE_INDENT: code indent should use tabs where possible
#83: FILE: src/gatt-database.c:2127:
+        const char *iface = g_dbus_proxy_get_interface(proxy);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#83: FILE: src/gatt-database.c:2127:
+        const char *iface = g_dbus_proxy_get_interface(proxy);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#84: FILE: src/gatt-database.c:2128:
+        const char *path = g_dbus_proxy_get_path(proxy);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#84: FILE: src/gatt-database.c:2128:
+        const char *path = g_dbus_proxy_get_path(proxy);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#86: FILE: src/gatt-database.c:2130:
+        if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#86: FILE: src/gatt-database.c:2130:
+        if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#87: FILE: src/gatt-database.c:2131:
+                struct external_service *service;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#87: FILE: src/gatt-database.c:2131:
+                struct external_service *service;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#89: FILE: src/gatt-database.c:2133:
+                service = create_service(app, proxy, path);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#89: FILE: src/gatt-database.c:2133:
+                service = create_service(app, proxy, path);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#90: FILE: src/gatt-database.c:2134:
+                if (!service) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#90: FILE: src/gatt-database.c:2134:
+                if (!service) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#91: FILE: src/gatt-database.c:2135:
+                        app->failed = true;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#91: FILE: src/gatt-database.c:2135:
+                        app->failed = true;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#92: FILE: src/gatt-database.c:2136:
+                        return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#92: FILE: src/gatt-database.c:2136:
+                        return;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#93: FILE: src/gatt-database.c:2137:
+                }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#93: FILE: src/gatt-database.c:2137:
+                }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#94: FILE: src/gatt-database.c:2138:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#94: FILE: src/gatt-database.c:2138:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#98: FILE: src/gatt-database.c:2142:
+        struct gatt_app *app = user_data;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#98: FILE: src/gatt-database.c:2142:
+        struct gatt_app *app = user_data;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#99: FILE: src/gatt-database.c:2143:
+        GDBusProxy *proxy = data;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#99: FILE: src/gatt-database.c:2143:
+        GDBusProxy *proxy = data;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#100: FILE: src/gatt-database.c:2144:
+        const char *iface = g_dbus_proxy_get_interface(proxy);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#100: FILE: src/gatt-database.c:2144:
+        const char *iface = g_dbus_proxy_get_interface(proxy);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#101: FILE: src/gatt-database.c:2145:
+        const char *path = g_dbus_proxy_get_path(proxy);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#101: FILE: src/gatt-database.c:2145:
+        const char *path = g_dbus_proxy_get_path(proxy);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#104: FILE: src/gatt-database.c:2148:
+                struct external_chrc *chrc;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#104: FILE: src/gatt-database.c:2148:
+                struct external_chrc *chrc;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#106: FILE: src/gatt-database.c:2150:
+                chrc = chrc_create(app, proxy, path);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#106: FILE: src/gatt-database.c:2150:
+                chrc = chrc_create(app, proxy, path);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#107: FILE: src/gatt-database.c:2151:
+                if (!chrc) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#107: FILE: src/gatt-database.c:2151:
+                if (!chrc) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#108: FILE: src/gatt-database.c:2152:
+                        app->failed = true;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#108: FILE: src/gatt-database.c:2152:
+                        app->failed = true;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#109: FILE: src/gatt-database.c:2153:
+                        return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#109: FILE: src/gatt-database.c:2153:
+                        return;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#110: FILE: src/gatt-database.c:2154:
+                }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#110: FILE: src/gatt-database.c:2154:
+                }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#111: FILE: src/gatt-database.c:2155:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#111: FILE: src/gatt-database.c:2155:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#115: FILE: src/gatt-database.c:2159:
+        struct gatt_app *app = user_data;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#115: FILE: src/gatt-database.c:2159:
+        struct gatt_app *app = user_data;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#116: FILE: src/gatt-database.c:2160:
+        GDBusProxy *proxy = data;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#116: FILE: src/gatt-database.c:2160:
+        GDBusProxy *proxy = data;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#117: FILE: src/gatt-database.c:2161:
+        const char *iface = g_dbus_proxy_get_interface(proxy);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#117: FILE: src/gatt-database.c:2161:
+        const char *iface = g_dbus_proxy_get_interface(proxy);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#118: FILE: src/gatt-database.c:2162:
+        const char *path = g_dbus_proxy_get_path(proxy);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#118: FILE: src/gatt-database.c:2162:
+        const char *path = g_dbus_proxy_get_path(proxy);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#121: FILE: src/gatt-database.c:2165:
+                struct external_desc *desc;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#121: FILE: src/gatt-database.c:2165:
+                struct external_desc *desc;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#123: FILE: src/gatt-database.c:2167:
+                desc = desc_create(app, proxy);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#123: FILE: src/gatt-database.c:2167:
+                desc = desc_create(app, proxy);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#124: FILE: src/gatt-database.c:2168:
+                if (!desc) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#124: FILE: src/gatt-database.c:2168:
+                if (!desc) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#125: FILE: src/gatt-database.c:2169:
+                        app->failed = true;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#125: FILE: src/gatt-database.c:2169:
+                        app->failed = true;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#126: FILE: src/gatt-database.c:2170:
+                        return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#126: FILE: src/gatt-database.c:2170:
+                        return;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#127: FILE: src/gatt-database.c:2171:
+                }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#127: FILE: src/gatt-database.c:2171:
+                }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#128: FILE: src/gatt-database.c:2172:
+        }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#128: FILE: src/gatt-database.c:2172:
+        }$

ERROR:CODE_INDENT: code indent should use tabs where possible
#142: FILE: src/gatt-database.c:2186:
+                fail = true;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#142: FILE: src/gatt-database.c:2186:
+                fail = true;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#143: FILE: src/gatt-database.c:2187:
+                reply = btd_error_failed(app->reg,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#143: FILE: src/gatt-database.c:2187:
+                reply = btd_error_failed(app->reg,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#144: FILE: src/gatt-database.c:2188:
+                                        "No object received");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#144: FILE: src/gatt-database.c:2188:
+                                        "No object received");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#145: FILE: src/gatt-database.c:2189:
+                goto reply;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#145: FILE: src/gatt-database.c:2189:
+                goto reply;$



-- 
Luiz Augusto von Dentz
