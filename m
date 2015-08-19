Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1439932371-10446-1-git-send-email-jpawlowski@google.com>
References: <1439932371-10446-1-git-send-email-jpawlowski@google.com>
Date: Wed, 19 Aug 2015 11:47:03 +0300
Message-ID: <CABBYNZJbqM88Y5Fwh8k17osb+30g0MwM=s1PPj0xwjP0zd=Qmw@mail.gmail.com>
Subject: Re: [BlueZ v2] src/device: gatt database persistence
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Aug 19, 2015 at 12:12 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch changes how gatt database for paired devices is stored between
> restarts of bluetoothd. Right now only definition of services is stored.
> After applying this patch whole gatt database will be stored/restored.
>
> Storing whole database can have big impact on reconnection time for paired
> devices, because full discovery can take up to 10 seconds.
> ---
>  src/device.c | 503 ++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 373 insertions(+), 130 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 3dde8b8..7815a8e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -87,6 +87,11 @@
>
>  #define RSSI_THRESHOLD         8
>
> +#define GATT_PRIM_SVC_UUID_STR "2800"
> +#define GATT_SND_SVC_UUID_STR  "2801"
> +#define GATT_INCLUDE_UUID_STR "2802"
> +#define GATT_CHARAC_UUID_STR "2803"
> +
>  static DBusConnection *dbus_conn = NULL;
>  static unsigned service_state_cb_id;
>
> @@ -1889,67 +1894,143 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
>         return btd_error_failed(msg, strerror(-err));
>  }
>
> -static void store_services(struct btd_device *device)
> +struct gatt_saver {
> +       struct btd_device *device;
> +       GKeyFile *key_file;
> +};
> +
> +static void store_desc(struct gatt_db_attribute *attr, void *user_data)
> +{
> +       struct gatt_saver *saver = user_data;
> +       GKeyFile *key_file = saver->key_file;
> +       char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
> +       const bt_uuid_t *uuid;
> +       uint16_t handle_num;
> +
> +       handle_num = gatt_db_attribute_get_handle(attr);
> +       sprintf(handle, "%04hx", handle_num);
> +
> +       uuid = gatt_db_attribute_get_type(attr);
> +       bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
> +       sprintf(value, "%s", uuid_str);
> +       g_key_file_set_string(key_file, "GattDB", handle, value);
> +}
> +
> +static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
> +{
> +       struct gatt_saver *saver = user_data;
> +       GKeyFile *key_file = saver->key_file;
> +       char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
> +       uint16_t handle_num, value_handle;
> +       uint8_t properties;
> +       bt_uuid_t uuid;
> +
> +       if (!gatt_db_attribute_get_char_data(attr, &handle_num, &value_handle,
> +                                                       &properties, &uuid)) {
> +               warn("Error storing characteristic - can't get data");
> +               return;
> +       }
> +
> +       sprintf(handle, "%04hx", handle_num);
> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +       sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s", value_handle,
> +                                                       properties, uuid_str);
> +       g_key_file_set_string(key_file, "GattDB", handle, value);
> +
> +       gatt_db_service_foreach_desc(attr, store_desc, saver);
> +}
> +
> +static void store_incl(struct gatt_db_attribute *attr, void *user_data)
> +{
> +       struct gatt_saver *saver = user_data;
> +       GKeyFile *key_file = saver->key_file;
> +       struct gatt_db_attribute *service;
> +       char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
> +       uint16_t handle_num, start, end;
> +       bt_uuid_t uuid;
> +
> +       if (!gatt_db_attribute_get_incl_data(attr, &handle_num, &start, &end)) {
> +               warn("Error storing included service - can't get data");
> +               return;
> +       }
> +
> +       service = gatt_db_get_attribute(saver->device->db, start);
> +       if (!service) {
> +               warn("Error storing included service - can't find it");
> +               return;
> +       }
> +
> +       sprintf(handle, "%04hx", handle_num);
> +
> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +       sprintf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%s", start,
> +                                                               end, uuid_str);
> +
> +       g_key_file_set_string(key_file, "GattDB", handle, value);
> +}
> +
> +static void store_service(struct gatt_db_attribute *attr, void *user_data)
> +{
> +       struct gatt_saver *saver = user_data;
> +       GKeyFile *key_file = saver->key_file;
> +       char uuid_str[MAX_LEN_UUID_STR], handle[4], value[256];
> +       uint16_t start, end;
> +       bt_uuid_t uuid;
> +       bool primary;
> +       char *type;
> +
> +       if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
> +                                                               &uuid)) {
> +               warn("Error storing service - can't get data");
> +               return;
> +       }
> +
> +       sprintf(handle, "%04hx", start);
> +
> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +
> +       if (primary)
> +               type = GATT_PRIM_SVC_UUID_STR;
> +       else
> +               type = GATT_SND_SVC_UUID_STR;
> +
> +       sprintf(value, "%s:%04hx:%s", type, end, uuid_str);
> +
> +       g_key_file_set_string(key_file, "GattDB", handle, value);
> +
> +       gatt_db_service_foreach_incl(attr, store_incl, saver);
> +       gatt_db_service_foreach_char(attr, store_chrc, saver);
> +}
> +
> +static void store_gatt_db(struct btd_device *device)
>  {
>         struct btd_adapter *adapter = device->adapter;
>         char filename[PATH_MAX];
>         char src_addr[18], dst_addr[18];
> -       uuid_t uuid;
> -       char *prim_uuid;
>         GKeyFile *key_file;
>         GSList *l;
>         char *data;
>         gsize length = 0;
> +       struct gatt_saver saver;
>
>         if (device_address_is_private(device)) {
> -               warn("Can't store services for private addressed device %s",
> +               warn("Can't store GATT db for private addressed device %s",
>                                                                 device->path);
>                 return;
>         }
>
> -       sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> -       prim_uuid = bt_uuid2string(&uuid);
> -       if (prim_uuid == NULL)
> -               return;
> -
>         ba2str(btd_adapter_get_address(adapter), src_addr);
>         ba2str(&device->bdaddr, dst_addr);
>
>         snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", src_addr,
>                                                                 dst_addr);
> +
>         key_file = g_key_file_new();
>
> -       for (l = device->primaries; l; l = l->next) {
> -               struct gatt_primary *primary = l->data;
> -               char handle[6], uuid_str[33];
> -               int i;
> +       saver.key_file = key_file;
> +       saver.device = device;
>
> -               sprintf(handle, "%hu", primary->range.start);
> -
> -               bt_string2uuid(&uuid, primary->uuid);
> -               sdp_uuid128_to_uuid(&uuid);
> -
> -               switch (uuid.type) {
> -               case SDP_UUID16:
> -                       sprintf(uuid_str, "%4.4X", uuid.value.uuid16);
> -                       break;
> -               case SDP_UUID32:
> -                       sprintf(uuid_str, "%8.8X", uuid.value.uuid32);
> -                       break;
> -               case SDP_UUID128:
> -                       for (i = 0; i < 16; i++)
> -                               sprintf(uuid_str + (i * 2), "%2.2X",
> -                                               uuid.value.uuid128.data[i]);
> -                       break;
> -               default:
> -                       uuid_str[0] = '\0';
> -               }
> -
> -               g_key_file_set_string(key_file, handle, "UUID", prim_uuid);
> -               g_key_file_set_string(key_file, handle, "Value", uuid_str);
> -               g_key_file_set_integer(key_file, handle, "EndGroupHandle",
> -                                       primary->range.end);
> -       }
> +       gatt_db_foreach_service(device->db, NULL, store_service, &saver);
>
>         data = g_key_file_to_data(key_file, &length, NULL);
>         if (length > 0) {
> @@ -1957,7 +2038,6 @@ static void store_services(struct btd_device *device)
>                 g_file_set_contents(filename, data, length, NULL);
>         }
>
> -       free(prim_uuid);
>         g_free(data);
>         g_key_file_free(key_file);
>  }
> @@ -2051,7 +2131,7 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
>                 store_device_info(dev);
>
>         if (bdaddr_type != BDADDR_BREDR && err == 0)
> -               store_services(dev);
> +               store_gatt_db(dev);
>
>         if (!req)
>                 return;
> @@ -2678,94 +2758,6 @@ next:
>                 store_device_info(device);
>  }
>
> -static void load_att_info(struct btd_device *device, const char *local,
> -                               const char *peer)
> -{
> -       char filename[PATH_MAX];
> -       GKeyFile *key_file;
> -       char *prim_uuid, *str;
> -       char **groups, **handle, *service_uuid;
> -       struct gatt_primary *prim;
> -       uuid_t uuid;
> -       char tmp[3];
> -       int i;
> -
> -       sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
> -       prim_uuid = bt_uuid2string(&uuid);
> -
> -       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", local,
> -                       peer);
> -
> -       key_file = g_key_file_new();
> -       g_key_file_load_from_file(key_file, filename, 0, NULL);
> -       groups = g_key_file_get_groups(key_file, NULL);
> -
> -       for (handle = groups; *handle; handle++) {
> -               gboolean uuid_ok;
> -               int end;
> -
> -               str = g_key_file_get_string(key_file, *handle, "UUID", NULL);
> -               if (!str)
> -                       continue;
> -
> -               uuid_ok = g_str_equal(str, prim_uuid);
> -               g_free(str);
> -
> -               if (!uuid_ok)
> -                       continue;
> -
> -               str = g_key_file_get_string(key_file, *handle, "Value", NULL);
> -               if (!str)
> -                       continue;
> -
> -               end = g_key_file_get_integer(key_file, *handle,
> -                                               "EndGroupHandle", NULL);
> -               if (end == 0) {
> -                       g_free(str);
> -                       continue;
> -               }
> -
> -               prim = g_new0(struct gatt_primary, 1);
> -               prim->range.start = atoi(*handle);
> -               prim->range.end = end;
> -
> -               switch (strlen(str)) {
> -               case 4:
> -                       uuid.type = SDP_UUID16;
> -                       sscanf(str, "%04hx", &uuid.value.uuid16);
> -               break;
> -               case 8:
> -                       uuid.type = SDP_UUID32;
> -                       sscanf(str, "%08x", &uuid.value.uuid32);
> -                       break;
> -               case 32:
> -                       uuid.type = SDP_UUID128;
> -                       memset(tmp, 0, sizeof(tmp));
> -                       for (i = 0; i < 16; i++) {
> -                               memcpy(tmp, str + (i * 2), 2);
> -                               uuid.value.uuid128.data[i] =
> -                                               (uint8_t) strtol(tmp, NULL, 16);
> -                       }
> -                       break;
> -               default:
> -                       g_free(str);
> -                       g_free(prim);
> -                       continue;
> -               }
> -
> -               service_uuid = bt_uuid2string(&uuid);
> -               memcpy(prim->uuid, service_uuid, MAX_LEN_UUID_STR);
> -               free(service_uuid);
> -               g_free(str);
> -
> -               device->primaries = g_slist_append(device->primaries, prim);
> -       }
> -
> -       g_strfreev(groups);
> -       g_key_file_free(key_file);
> -       free(prim_uuid);
> -}
> -
>  static void device_register_primaries(struct btd_device *device,
>                                                 GSList *prim_list, int psm)
>  {
> @@ -2792,6 +2784,257 @@ static void add_primary(struct gatt_db_attribute *attr, void *user_data)
>         *new_services = g_slist_append(*new_services, prim);
>  }
>
> +static int load_desc(char *handle, char *value,
> +                                       struct gatt_db_attribute *service)
> +{
> +       char uuid_str[MAX_LEN_UUID_STR];
> +       struct gatt_db_attribute *att;
> +       uint16_t handle_int;
> +       bt_uuid_t uuid;
> +
> +       if (sscanf(handle, "%04hx", &handle_int) != 1)
> +               return -EIO;
> +
> +       if (sscanf(value, "%s", uuid_str) != 1)
> +               return -EIO;
> +
> +       bt_string_to_uuid(&uuid, uuid_str);
> +
> +       DBG("loading descriptor handle: 0x%04x, uuid: %s", handle_int,
> +                                                               uuid_str);
> +
> +       att = gatt_db_service_insert_descriptor(service, handle_int, &uuid, 0,
> +                                                       NULL, NULL, NULL);
> +
> +       if (!att || gatt_db_attribute_get_handle(att) != handle_int) {
> +               warn("loading descriptor to db failed");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int load_chrc(char *handle, char *value,
> +                                       struct gatt_db_attribute *service)
> +{
> +       uint16_t properties, value_handle, handle_int;
> +       char uuid_str[MAX_LEN_UUID_STR];
> +       struct gatt_db_attribute *att;
> +       bt_uuid_t uuid;
> +
> +       if (sscanf(handle, "%04hx", &handle_int) != 1)
> +               return -EIO;
> +
> +       if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s", &value_handle,
> +                                               &properties, uuid_str) != 3)
> +               return -EIO;
> +
> +       bt_string_to_uuid(&uuid, uuid_str);
> +
> +       /* Log debug message. */
> +       DBG("loading characteristic handle: 0x%04x, value handle: 0x%04x,"
> +                               " properties 0x%04x uuid: %s", handle_int,
> +                               value_handle, properties, uuid_str);
> +
> +       att = gatt_db_service_insert_characteristic(service, value_handle,
> +                                                       &uuid, 0, properties,
> +                                                       NULL, NULL, NULL);
> +
> +       if (!att || gatt_db_attribute_get_handle(att) != value_handle) {
> +               warn("saving characteristic to db failed");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int load_incl(struct gatt_db *db, char *handle, char *value,
> +                                       struct gatt_db_attribute *service)
> +{
> +       char uuid_str[MAX_LEN_UUID_STR];
> +       struct gatt_db_attribute *att;
> +       uint16_t start, end;
> +       bt_uuid_t uuid;
> +
> +       if (sscanf(handle, "%04hx", &start) != 1)
> +               return -EIO;
> +
> +       if (sscanf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%s", &start, &end,
> +                                                               uuid_str) != 3)
> +               return -EIO;
> +
> +       bt_string_to_uuid(&uuid, uuid_str);
> +
> +       /* Log debug message. */
> +       DBG("loading included service: 0x%04x, end: 0x%04x, uuid: %s", start,
> +                                                               end, uuid_str);
> +
> +       att = gatt_db_get_attribute(db, start);
> +       if (!att) {
> +               warn("saving included service to db failed - no such service");
> +               return -EIO;
> +       }
> +
> +       att = gatt_db_service_add_included(service, att);
> +       if (!att) {
> +               warn("saving included service to db failed");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int load_service(struct gatt_db *db, char *handle, char *value)
> +{
> +       struct gatt_db_attribute *att;
> +       uint16_t start, end;
> +       char type[MAX_LEN_UUID_STR], uuid_str[MAX_LEN_UUID_STR];
> +       bt_uuid_t uuid;
> +       bool primary;
> +
> +       if (sscanf(handle, "%04hx", &start) != 1)
> +               return -EIO;
> +
> +       if (sscanf(value, "%[^:]:%04hx:%s", type, &end, uuid_str) != 3)
> +               return -EIO;
> +
> +       if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR))
> +               primary = true;
> +       else if (g_str_equal(type, GATT_SND_SVC_UUID_STR))
> +               primary = false;
> +       else
> +               return -EIO;
> +
> +       bt_string_to_uuid(&uuid, uuid_str);
> +
> +       /* Log debug message. */
> +       DBG("loading service: 0x%04x, end: 0x%04x, uuid: %s",
> +                                                       start, end, uuid_str);
> +
> +       att = gatt_db_insert_service(db, start, &uuid, primary,
> +                                               end - start + 1);
> +
> +       if (!att) {
> +               DBG("ERROR saving service to db!");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int load_gatt_db_impl(GKeyFile *key_file, char **keys,
> +                                                       struct gatt_db *db)
> +{
> +       struct gatt_db_attribute *current_service;
> +       char **handle, *value, type[MAX_LEN_UUID_STR];
> +       int ret;
> +
> +       /* first load service definitions */
> +       for (handle = keys; *handle; handle++) {
> +               value = g_key_file_get_string(key_file, "GattDB", *handle,
> +                                                                       NULL);
> +
> +               if (sscanf(value, "%[^:]:", type) != 1) {
> +                       warn("Missing Type in attribute definition");
> +                       return -EIO;
> +               }
> +
> +               if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
> +                               g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
> +                       ret = load_service(db, *handle, value);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       current_service = NULL;
> +       /* then fill them with data*/
> +       for (handle = keys; *handle; handle++) {
> +               value = g_key_file_get_string(key_file, "GattDB", *handle,
> +                                                                       NULL);
> +
> +               if (sscanf(value, "%[^:]:", type) != 1) {
> +                       warn("Missing Type in attribute definition");
> +                       return -EIO;
> +               }
> +
> +               if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
> +                               g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
> +                       uint16_t tmp;
> +                       uint16_t start, end;
> +                       bool primary;
> +                       bt_uuid_t uuid;
> +                       char uuid_str[MAX_LEN_UUID_STR];
> +
> +                       if (sscanf(*handle, "%04hx", &tmp) != 1) {
> +                               warn("Unable to parse attribute handle");
> +                               return -EIO;
> +                       }
> +
> +                       if (current_service)
> +                               gatt_db_service_set_active(current_service,
> +                                                                       true);
> +
> +                       current_service = gatt_db_get_attribute(db, tmp);
> +
> +                       gatt_db_attribute_get_service_data(current_service,
> +                                                       &start, &end,
> +                                                       &primary, &uuid);
> +
> +                       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +                       DBG("currently loading details of service: 0x%04x, end:"
> +                               " 0x%04x, uuid: %s", start, end, uuid_str);
> +               } else if (g_str_equal(type, GATT_INCLUDE_UUID_STR)) {
> +                       ret = load_incl(db, *handle, value, current_service);
> +               } else if (g_str_equal(type, GATT_CHARAC_UUID_STR)) {
> +                       ret = load_chrc(*handle, value, current_service);
> +               } else {
> +                       ret = load_desc(*handle, value, current_service);
> +               }
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (current_service)
> +               gatt_db_service_set_active(current_service, true);
> +
> +       return 0;
> +}
> +
> +static void load_gatt_db(struct btd_device *device, const char *local,
> +                                                       const char *peer)
> +{
> +       char **keys, filename[PATH_MAX];
> +       GKeyFile *key_file;
> +
> +       DBG("Restoring %s gatt database from file", peer);
> +
> +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/attributes", local,
> +                       peer);

My suggestion was to use the cache directory instead of the device,
being in the cache means the data is subject to change can be
discarded if necessary. Btw, I think it would be better if we first
patch the settings documentation with these changes before starting
changing the behavior.

> +       key_file = g_key_file_new();
> +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> +       keys = g_key_file_get_keys(key_file, "GattDB", NULL, NULL);

I prefer the term Attributes.

> +       if (!keys) {
> +               warn("No cache for %s", peer);
> +               g_key_file_free(key_file);
> +               return;
> +       }
> +
> +       if (load_gatt_db_impl(key_file, keys, device->db))
> +               warn("Unable to load gatt db from file for %s", peer);
> +
> +       g_strfreev(keys);
> +       g_key_file_free(key_file);
> +
> +       g_slist_free_full(device->primaries, g_free);
> +       device->primaries = NULL;
> +       gatt_db_foreach_service(device->db, NULL, add_primary,
> +                                                       &device->primaries);
> +}
> +
>  static void device_add_uuids(struct btd_device *device, GSList *uuids)
>  {
>         GSList *l;
> @@ -3195,7 +3438,7 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
>         ba2str(src, srcaddr);
>
>         load_info(device, srcaddr, address, key_file);
> -       load_att_info(device, srcaddr, address);
> +       load_gatt_db(device, srcaddr, address);

One thing that we did for SDP records was to load them on demand,
perhaps we should the same with GATT Attributes so we only attempt to
load the cache once connected in case the db is empty, this can be in
a separate patch though.

>         return device;
>  }
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
