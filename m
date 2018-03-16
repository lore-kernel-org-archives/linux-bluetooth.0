Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1521125138-24229-3-git-send-email-avichal.a@samsung.com>
References: <avichal.a@samsung.com> <CGME20180315144722epcas2p2761b6a90377b142efcf8a725af458810@epcas2p2.samsung.com>
 <1521125138-24229-1-git-send-email-avichal.a@samsung.com> <1521125138-24229-3-git-send-email-avichal.a@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Mar 2018 10:08:02 +0200
Message-ID: <CABBYNZJ_QegMdkc1yE462Dpu6Vfdot3SP3FNuPQZ1-SajwAFEQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] gatt-database : Add support for Included service
To: avichal <avichal.a@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        sachin.dev@samsung.com, Anupam Roy <anupam.r@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi avichal,

On Thu, Mar 15, 2018 at 4:45 PM, avichal <avichal.a@samsung.com> wrote:
>
> Added support of included services in gatt server
> While registring the service new property is added
> "includes"
>
>         array{object} type  [read-only]
>         Array of object paths representing the included
>         services of this service.
>
> Signed-off-by: avichal <avichal.a@samsung.com>

We do not use Signed-off-by in userspace.

> ---
>  src/gatt-database.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 9a33ae7..b2e93ce 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -109,6 +109,7 @@ struct external_service {
>         uint16_t attr_cnt;
>         struct queue *chrcs;
>         struct queue *descs;
> +       struct queue *includes;
>  };
>
>  struct external_profile {
> @@ -444,12 +445,21 @@ static void desc_free(void *data)
>         free(desc);
>  }
>
> +static void inc_free(void *data)
> +{
> +       struct external_desc *inc = data;
> +
> +       free(inc);
> +}
> +

Extra line empty, please remove it.

>  static void service_free(void *data)
>  {
>         struct external_service *service = data;
>
>         queue_destroy(service->chrcs, chrc_free);
>         queue_destroy(service->descs, desc_free);
> +       queue_destroy(service->includes,inc_free );
>
>         if (service->attrib)
>                 gatt_db_remove_service(service->app->database->db,
> @@ -1533,6 +1543,7 @@ static struct external_service *create_service(struct gatt_app *app,
>         service->proxy = g_dbus_proxy_ref(proxy);
>         service->chrcs = queue_new();
>         service->descs = queue_new();
> +       service->includes = queue_new();
>
>         /* Add 1 for the service declaration */
>         if (!incr_attr_count(service, 1)) {
> @@ -1616,6 +1627,44 @@ static bool parse_uuid(GDBusProxy *proxy, bt_uuid_t *uuid)
>         return true;
>  }
>
> +
> +static bool parse_includes(GDBusProxy *proxy, struct external_service * service)
> +{
> +       DBusMessageIter iter;
> +       DBusMessageIter array;
> +       char *obj;
> +
> +       if (!g_dbus_proxy_get_property(proxy, "Includes", &iter))
> +               return false;
> +
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
> +               return false;
> +
> +       dbus_message_iter_recurse(&iter, &array);
> +

Ditto.

> +       do {
> +               if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_OBJECT_PATH)
> +                       return false;
> +
> +               dbus_message_iter_get_basic(&array, &obj);
> +
> +               if(queue_push_tail(service->includes,obj)){
> +                       DBG("Included paths added\n");
> +                       incr_attr_count(service ,1);
> +               }
> +               else{
> +                       error("Failed to add Includes path in que\n");
> +                       return FALSE;
> +               }

Always use a space after if statement, e.g if (cond), also the else
should be in the same like as in the closing }, like in } else {.

> +
> +       } while (dbus_message_iter_next(&array));
> +
> +
> +       return true;
> +}
> +
> +
>  static bool parse_primary(GDBusProxy *proxy, bool *primary)
>  {
>         DBusMessageIter iter;
> @@ -2488,6 +2537,46 @@ fail:
>         gatt_db_attribute_write_result(attrib, id, BT_ATT_ERROR_UNLIKELY);
>  }
>

Again, please remove extra empty lines.

> +
> +static void include_services(void * data ,void *userdata)
> +{
> +       char *obj = (char*)data;
> +       struct external_service * service = (struct external_service *)userdata;
> +       struct gatt_db_attribute *attrib=NULL;
> +       struct external_service  *service_inc=NULL;
> +
> +       DBG("object path recieved %s,",obj);
> +
> +       service_inc = queue_find(service->app->services, match_service_by_path, obj);
> +       if(service_inc) {
> +
> +               if(!(service)->attrib)
> +                       error("service attibute not found\n");
> +

Ditto.

> +               if(!service_inc->attrib)
> +                       error("include attribute not found\n");
> +

Ditto.

> +               attrib = gatt_db_service_add_included((service)->attrib ,service_inc ->attrib);
> +               if(attrib == NULL)
> +                       error("include service attributes failed \n");
> +
> +               else
> +                       (service)->attrib = attrib;
> +
> +       }
> +       else
> +               error("include service not found\n");
> +
> +}
> +
> +static void database_add_includes(struct external_service *service)
> +{
> +       queue_foreach(service->includes,include_services,service );
> +}
> +
>  static bool database_add_chrc(struct external_service *service,
>                                                 struct external_chrc *chrc)
>  {
> @@ -2560,11 +2649,20 @@ static bool database_add_service(struct external_service *service)
>                 return false;
>         }
>

Ditto,

> +       if(!parse_includes(service->proxy,service)){
> +               error("Failed to read \"Includes\" property of service");
> +       }
> +
>         service->attrib = gatt_db_add_service(service->app->database->db, &uuid,
> -                                               primary, service->attr_cnt);
> +                                       primary, service->attr_cnt);
>         if (!service->attrib)
>                 return false;
>
> +       database_add_includes(service);
> +       DBG("ATTR count %d\n",service->attr_cnt);
> +

Ditto.

>         entry = queue_get_entries(service->chrcs);
>         while (entry) {
>                 struct external_chrc *chrc = entry->data;
> --
> 2.7.4

There are probably more code style problems that I miss, but you can
prevent this errors by having checkpatch.pl on your pre-commit and
pre-applypatch hooks like this:

exec git diff --cached | /pathto/checkpatch.pl -q --no-signoff
--ignore INITIALISED_STATIC,GLOBAL_INITIALISERS,PREFER_PACKED,SPACING,FSF_MAILING_ADDRESS,TRAILING_STATEMENTS,RETURN_VOID,,SPLIT_STRING,OPEN_BRACE,STATIC_CONST_CHAR_ARRAY,LINE_SPACING
 --show-types -

-- 
Luiz Augusto von Dentz
