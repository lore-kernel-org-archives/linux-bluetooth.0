Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKWFAZG4wHVimtKrXQ-BR2ZMjbXjgBOTXBfOH=6TH4BSg@mail.gmail.com>
References: <1440708538-3596-1-git-send-email-jpawlowski@google.com>
	<1440708538-3596-2-git-send-email-jpawlowski@google.com>
	<CABBYNZKWFAZG4wHVimtKrXQ-BR2ZMjbXjgBOTXBfOH=6TH4BSg@mail.gmail.com>
Date: Thu, 3 Sep 2015 09:34:58 -0700
Message-ID: <CAD0=r8xmOmA=6QEjy3UaAnOiHvxSKO9iEB+f8pu7AAOW1MVKGA@mail.gmail.com>
Subject: Re: [BlueZ v3 2/2] src/device: gatt database persistence
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Sep 3, 2015 at 6:58 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Thu, Aug 27, 2015 at 11:48 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> This patch adds whole gatt database persistence for paired LE devices.
>>
>> Storing whole database can have big impact on reconnection time for paired
>> devices, because full discovery can take up to 10 seconds.
>>
>> Sample how stored database looks in cache file:
>>
>> [Attributes]
>> 0001=2800:0005:1801
>> 0002=2803:0003:20:2a05
>> 0014=2800:001c:1800
>> 0015=2803:0016:02:2a00
>> 0017=2803:0018:02:2a01
>> 0019=2803:001a:02:2aa6
>> 0028=2800:ffff:0000180d-0000-1000-8000-00805f9b34fb
>> 0029=2803:002a:10:00002a37-0000-1000-8000-00805f9b34fb
>> 002b=2803:002c:02:00002a38-0000-1000-8000-00805f9b34fb
>> 002d=2803:002e:08:00002a39-0000-1000-8000-00805f9b34fb
>> ---
>>  src/device.c | 417 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 416 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 3dde8b8..09cd816 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -87,6 +87,11 @@
>>
>>  #define RSSI_THRESHOLD         8
>>
>> +#define GATT_PRIM_SVC_UUID_STR "2800"
>> +#define GATT_SND_SVC_UUID_STR  "2801"
>> +#define GATT_INCLUDE_UUID_STR "2802"
>> +#define GATT_CHARAC_UUID_STR "2803"
>> +
>>  static DBusConnection *dbus_conn = NULL;
>>  static unsigned service_state_cb_id;
>>
>> @@ -1962,6 +1967,154 @@ static void store_services(struct btd_device *device)
>>         g_key_file_free(key_file);
>>  }
>>
>> +struct gatt_saver {
>> +       struct btd_device *device;
>> +       GKeyFile *key_file;
>> +};
>> +
>> +static void store_desc(struct gatt_db_attribute *attr, void *user_data)
>> +{
>> +       struct gatt_saver *saver = user_data;
>> +       GKeyFile *key_file = saver->key_file;
>> +       char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
>> +       const bt_uuid_t *uuid;
>> +       uint16_t handle_num;
>> +
>> +       handle_num = gatt_db_attribute_get_handle(attr);
>> +       sprintf(handle, "%04hx", handle_num);
>> +
>> +       uuid = gatt_db_attribute_get_type(attr);
>> +       bt_uuid_to_string(uuid, uuid_str, sizeof(uuid_str));
>> +       sprintf(value, "%s", uuid_str);
>> +       g_key_file_set_string(key_file, "Attributes", handle, value);
>> +}
>> +
>> +static void store_chrc(struct gatt_db_attribute *attr, void *user_data)
>> +{
>> +       struct gatt_saver *saver = user_data;
>> +       GKeyFile *key_file = saver->key_file;
>> +       char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
>> +       uint16_t handle_num, value_handle;
>> +       uint8_t properties;
>> +       bt_uuid_t uuid;
>> +
>> +       if (!gatt_db_attribute_get_char_data(attr, &handle_num, &value_handle,
>> +                                                       &properties, &uuid)) {
>> +               warn("Error storing characteristic - can't get data");
>> +               return;
>> +       }
>> +
>> +       sprintf(handle, "%04hx", handle_num);
>> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
>> +       sprintf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s", value_handle,
>> +                                                       properties, uuid_str);
>> +       g_key_file_set_string(key_file, "Attributes", handle, value);
>> +
>> +       gatt_db_service_foreach_desc(attr, store_desc, saver);
>> +}
>> +
>> +static void store_incl(struct gatt_db_attribute *attr, void *user_data)
>> +{
>> +       struct gatt_saver *saver = user_data;
>> +       GKeyFile *key_file = saver->key_file;
>> +       struct gatt_db_attribute *service;
>> +       char handle[6], value[100], uuid_str[MAX_LEN_UUID_STR];
>> +       uint16_t handle_num, start, end;
>> +       bt_uuid_t uuid;
>> +
>> +       if (!gatt_db_attribute_get_incl_data(attr, &handle_num, &start, &end)) {
>> +               warn("Error storing included service - can't get data");
>> +               return;
>> +       }
>> +
>> +       service = gatt_db_get_attribute(saver->device->db, start);
>> +       if (!service) {
>> +               warn("Error storing included service - can't find it");
>> +               return;
>> +       }
>> +
>> +       sprintf(handle, "%04hx", handle_num);
>> +
>> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
>> +       sprintf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%s", start,
>> +                                                               end, uuid_str);
>> +
>> +       g_key_file_set_string(key_file, "Attributes", handle, value);
>> +}
>> +
>> +static void store_service(struct gatt_db_attribute *attr, void *user_data)
>> +{
>> +       struct gatt_saver *saver = user_data;
>> +       GKeyFile *key_file = saver->key_file;
>> +       char uuid_str[MAX_LEN_UUID_STR], handle[4], value[256];
>> +       uint16_t start, end;
>> +       bt_uuid_t uuid;
>> +       bool primary;
>> +       char *type;
>> +
>> +       if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
>> +                                                               &uuid)) {
>> +               warn("Error storing service - can't get data");
>> +               return;
>> +       }
>> +
>> +       sprintf(handle, "%04hx", start);
>> +
>> +       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
>> +
>> +       if (primary)
>> +               type = GATT_PRIM_SVC_UUID_STR;
>> +       else
>> +               type = GATT_SND_SVC_UUID_STR;
>> +
>> +       sprintf(value, "%s:%04hx:%s", type, end, uuid_str);
>> +
>> +       g_key_file_set_string(key_file, "Attributes", handle, value);
>> +
>> +       gatt_db_service_foreach_incl(attr, store_incl, saver);
>> +       gatt_db_service_foreach_char(attr, store_chrc, saver);
>> +}
>> +
>> +static void store_gatt_db(struct btd_device *device)
>> +{
>> +       struct btd_adapter *adapter = device->adapter;
>> +       char filename[PATH_MAX];
>> +       char src_addr[18], dst_addr[18];
>> +       GKeyFile *key_file;
>> +       GSList *l;
>> +       char *data;
>> +       gsize length = 0;
>> +       struct gatt_saver saver;
>> +
>> +       if (device_address_is_private(device)) {
>> +               warn("Can't store GATT db for private addressed device %s",
>> +                                                               device->path);
>> +               return;
>> +       }
>> +
>> +       ba2str(btd_adapter_get_address(adapter), src_addr);
>> +       ba2str(&device->bdaddr, dst_addr);
>> +
>> +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", src_addr,
>> +                                                               dst_addr);
>> +       create_file(filename, S_IRUSR | S_IWUSR);
>> +
>> +       key_file = g_key_file_new();
>> +       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> +
>> +       saver.key_file = key_file;
>> +       saver.device = device;
>> +
>> +       gatt_db_foreach_service(device->db, NULL, store_service, &saver);
>> +
>> +       data = g_key_file_to_data(key_file, &length, NULL);
>> +       g_file_set_contents(filename, data, length, NULL);
>> +
>> +       g_free(data);
>> +       g_key_file_free(key_file);
>> +}
>> +
>> +
>>  static void browse_request_complete(struct browse_req *req, uint8_t bdaddr_type,
>>                                                                         int err)
>>  {
>> @@ -2050,8 +2203,10 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
>>         if (!dev->temporary)
>>                 store_device_info(dev);
>>
>> -       if (bdaddr_type != BDADDR_BREDR && err == 0)
>> +       if (bdaddr_type != BDADDR_BREDR && err == 0) {
>>                 store_services(dev);
>> +               store_gatt_db(dev);
>> +       }
>>
>>         if (!req)
>>                 return;
>> @@ -2792,6 +2947,256 @@ static void add_primary(struct gatt_db_attribute *attr, void *user_data)
>>         *new_services = g_slist_append(*new_services, prim);
>>  }
>>
>> +static int load_desc(char *handle, char *value,
>> +                                       struct gatt_db_attribute *service)
>> +{
>> +       char uuid_str[MAX_LEN_UUID_STR];
>> +       struct gatt_db_attribute *att;
>> +       uint16_t handle_int;
>> +       bt_uuid_t uuid;
>> +
>> +       if (sscanf(handle, "%04hx", &handle_int) != 1)
>> +               return -EIO;
>> +
>> +       if (sscanf(value, "%s", uuid_str) != 1)
>> +               return -EIO;
>> +
>> +       bt_string_to_uuid(&uuid, uuid_str);
>> +
>> +       DBG("loading descriptor handle: 0x%04x, uuid: %s", handle_int,
>> +                                                               uuid_str);
>> +
>> +       att = gatt_db_service_insert_descriptor(service, handle_int, &uuid, 0,
>> +                                                       NULL, NULL, NULL);
>> +
>> +       if (!att || gatt_db_attribute_get_handle(att) != handle_int) {
>> +               warn("loading descriptor to db failed");
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int load_chrc(char *handle, char *value,
>> +                                       struct gatt_db_attribute *service)
>> +{
>> +       uint16_t properties, value_handle, handle_int;
>> +       char uuid_str[MAX_LEN_UUID_STR];
>> +       struct gatt_db_attribute *att;
>> +       bt_uuid_t uuid;
>> +
>> +       if (sscanf(handle, "%04hx", &handle_int) != 1)
>> +               return -EIO;
>> +
>> +       if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%s", &value_handle,
>> +                                               &properties, uuid_str) != 3)
>> +               return -EIO;
>> +
>> +       bt_string_to_uuid(&uuid, uuid_str);
>> +
>> +       /* Log debug message. */
>> +       DBG("loading characteristic handle: 0x%04x, value handle: 0x%04x,"
>> +                               " properties 0x%04x uuid: %s", handle_int,
>> +                               value_handle, properties, uuid_str);
>> +
>> +       att = gatt_db_service_insert_characteristic(service, value_handle,
>> +                                                       &uuid, 0, properties,
>> +                                                       NULL, NULL, NULL);
>> +
>> +       if (!att || gatt_db_attribute_get_handle(att) != value_handle) {
>> +               warn("saving characteristic to db failed");
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int load_incl(struct gatt_db *db, char *handle, char *value,
>> +                                       struct gatt_db_attribute *service)
>> +{
>> +       char uuid_str[MAX_LEN_UUID_STR];
>> +       struct gatt_db_attribute *att;
>> +       uint16_t start, end;
>> +       bt_uuid_t uuid;
>> +
>> +       if (sscanf(handle, "%04hx", &start) != 1)
>> +               return -EIO;
>> +
>> +       if (sscanf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%s", &start, &end,
>> +                                                               uuid_str) != 3)
>> +               return -EIO;
>> +
>> +       bt_string_to_uuid(&uuid, uuid_str);
>> +
>> +       /* Log debug message. */
>> +       DBG("loading included service: 0x%04x, end: 0x%04x, uuid: %s", start,
>> +                                                               end, uuid_str);
>> +
>> +       att = gatt_db_get_attribute(db, start);
>> +       if (!att) {
>> +               warn("saving included service to db failed - no such service");
>> +               return -EIO;
>> +       }
>> +
>> +       att = gatt_db_service_add_included(service, att);
>> +       if (!att) {
>> +               warn("saving included service to db failed");
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int load_service(struct gatt_db *db, char *handle, char *value)
>> +{
>> +       struct gatt_db_attribute *att;
>> +       uint16_t start, end;
>> +       char type[MAX_LEN_UUID_STR], uuid_str[MAX_LEN_UUID_STR];
>> +       bt_uuid_t uuid;
>> +       bool primary;
>> +
>> +       if (sscanf(handle, "%04hx", &start) != 1)
>> +               return -EIO;
>> +
>> +       if (sscanf(value, "%[^:]:%04hx:%s", type, &end, uuid_str) != 3)
>> +               return -EIO;
>> +
>> +       if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR))
>> +               primary = true;
>> +       else if (g_str_equal(type, GATT_SND_SVC_UUID_STR))
>> +               primary = false;
>> +       else
>> +               return -EIO;
>> +
>> +       bt_string_to_uuid(&uuid, uuid_str);
>> +
>> +       /* Log debug message. */
>> +       DBG("loading service: 0x%04x, end: 0x%04x, uuid: %s",
>> +                                                       start, end, uuid_str);
>> +
>> +       att = gatt_db_insert_service(db, start, &uuid, primary,
>> +                                               end - start + 1);
>> +
>> +       if (!att) {
>> +               DBG("ERROR saving service to db!");
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int load_gatt_db_impl(GKeyFile *key_file, char **keys,
>> +                                                       struct gatt_db *db)
>> +{
>> +       struct gatt_db_attribute *current_service;
>> +       char **handle, *value, type[MAX_LEN_UUID_STR];
>> +       int ret;
>> +
>> +       /* first load service definitions */
>> +       for (handle = keys; *handle; handle++) {
>> +               value = g_key_file_get_string(key_file, "Attributes", *handle,
>> +                                                                       NULL);
>> +
>> +               if (sscanf(value, "%[^:]:", type) != 1) {
>> +                       warn("Missing Type in attribute definition");
>> +                       return -EIO;
>> +               }
>> +
>> +               if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
>> +                               g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
>> +                       ret = load_service(db, *handle, value);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +       }
>> +
>> +       current_service = NULL;
>> +       /* then fill them with data*/
>> +       for (handle = keys; *handle; handle++) {
>> +               value = g_key_file_get_string(key_file, "Attributes", *handle,
>> +                                                                       NULL);
>> +
>> +               if (sscanf(value, "%[^:]:", type) != 1) {
>> +                       warn("Missing Type in attribute definition");
>> +                       return -EIO;
>> +               }
>> +
>> +               if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR) ||
>> +                               g_str_equal(type, GATT_SND_SVC_UUID_STR)) {
>> +                       uint16_t tmp;
>> +                       uint16_t start, end;
>> +                       bool primary;
>> +                       bt_uuid_t uuid;
>> +                       char uuid_str[MAX_LEN_UUID_STR];
>> +
>> +                       if (sscanf(*handle, "%04hx", &tmp) != 1) {
>> +                               warn("Unable to parse attribute handle");
>> +                               return -EIO;
>> +                       }
>> +
>> +                       if (current_service)
>> +                               gatt_db_service_set_active(current_service,
>> +                                                                       true);
>> +
>> +                       current_service = gatt_db_get_attribute(db, tmp);
>> +
>> +                       gatt_db_attribute_get_service_data(current_service,
>> +                                                       &start, &end,
>> +                                                       &primary, &uuid);
>> +
>> +                       bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
>> +                       DBG("currently loading details of service: 0x%04x, end:"
>> +                               " 0x%04x, uuid: %s", start, end, uuid_str);
>> +               } else if (g_str_equal(type, GATT_INCLUDE_UUID_STR)) {
>> +                       ret = load_incl(db, *handle, value, current_service);
>> +               } else if (g_str_equal(type, GATT_CHARAC_UUID_STR)) {
>> +                       ret = load_chrc(*handle, value, current_service);
>> +               } else {
>> +                       ret = load_desc(*handle, value, current_service);
>> +               }
>> +
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       if (current_service)
>> +               gatt_db_service_set_active(current_service, true);
>> +
>> +       return 0;
>> +}
>> +
>> +static void load_gatt_db(struct btd_device *device, const char *local,
>> +                                                       const char *peer)
>> +{
>> +       char **keys, filename[PATH_MAX];
>> +       GKeyFile *key_file;
>> +
>> +       DBG("Restoring %s gatt database from file", peer);
>> +
>> +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
>> +
>> +       key_file = g_key_file_new();
>> +       g_key_file_load_from_file(key_file, filename, 0, NULL);
>> +       keys = g_key_file_get_keys(key_file, "Attributes", NULL, NULL);
>> +
>> +       if (!keys) {
>> +               warn("No cache for %s", peer);
>> +               g_key_file_free(key_file);
>> +               return;
>> +       }
>> +
>> +       if (load_gatt_db_impl(key_file, keys, device->db))
>> +               warn("Unable to load gatt db from file for %s", peer);
>> +
>> +       g_strfreev(keys);
>> +       g_key_file_free(key_file);
>> +
>> +       g_slist_free_full(device->primaries, g_free);
>> +       device->primaries = NULL;
>> +       gatt_db_foreach_service(device->db, NULL, add_primary,
>> +                                                       &device->primaries);
>> +}
>> +
>>  static void device_add_uuids(struct btd_device *device, GSList *uuids)
>>  {
>>         GSList *l;
>> @@ -4311,6 +4716,8 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
>>         uint16_t mtu;
>>         uint16_t cid;
>>         struct btd_gatt_database *database;
>> +       const bdaddr_t *src, *dst;
>> +       char srcaddr[18], dstaddr[18];
>>
>>         bt_io_get(io, &gerr, BT_IO_OPT_SEC_LEVEL, &sec_level,
>>                                                 BT_IO_OPT_IMTU, &mtu,
>> @@ -4362,6 +4769,14 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
>>
>>         database = btd_adapter_get_database(dev->adapter);
>>
>> +       src = btd_adapter_get_address(dev->adapter);
>> +       ba2str(src, srcaddr);
>> +
>> +       dst = device_get_address(dev);
>> +       ba2str(dst, dstaddr);
>> +
>> +       load_gatt_db(dev, srcaddr, dstaddr);
>> +
>>         gatt_client_init(dev);
>>         gatt_server_init(dev, btd_gatt_database_get_db(database));
>>
>> --
>> 2.1.4
>
> First this does not compile, there is an unused variable in
> store_gatt_db, once I fixed that it works fine but there seems to be
> leaks to be resolved before we apply:

I had --enable-maintainer-mode set, and it still don't show this
error, something must be wrong with my setup, sorry for that

>
> ==22564== 1,080 bytes in 23 blocks are definitely lost in loss record 230 of 238
> ==22564==    at 0x4C28C50: malloc (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==22564==    by 0x4E84679: g_malloc (in /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4E761BA: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4E77867: g_key_file_get_string (in
> /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4A82B2: load_gatt_db_impl (device.c:3096)
> ==22564==    by 0x4A82B2: load_gatt_db (device.c:3187)
> ==22564==    by 0x4ACB7D: device_attach_att (device.c:4718)
> ==22564==    by 0x47EB60: connect_cb (gatt-database.c:496)
> ==22564==    by 0x46CE03: server_cb (btio.c:264)
> ==22564==    by 0x4E7EA89: g_main_context_dispatch (in
> /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4E7EE1F: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4E7F141: g_main_loop_run (in
> /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x40BAA7: main (main.c:661)
> ==22564==
> ==22564== 1,080 bytes in 23 blocks are definitely lost in loss record 231 of 238
> ==22564==    at 0x4C28C50: malloc (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==22564==    by 0x4E84679: g_malloc (in /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4E761BA: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4E77867: g_key_file_get_string (in
> /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4A84E6: load_gatt_db_impl (device.c:3115)
> ==22564==    by 0x4A84E6: load_gatt_db (device.c:3187)
> ==22564==    by 0x4ACB7D: device_attach_att (device.c:4718)
> ==22564==    by 0x47EB60: connect_cb (gatt-database.c:496)
> ==22564==    by 0x46CE03: server_cb (btio.c:264)
> ==22564==    by 0x4E7EA89: g_main_context_dispatch (in
> /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4E7EE1F: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x4E7F141: g_main_loop_run (in
> /usr/lib64/libglib-2.0.so.0.4400.1)
> ==22564==    by 0x40BAA7: main (main.c:661)
>

fixed

> Also there seems to be too much being printed when loading the
> attributes, we should probably drop load_gatt_db_impl DBG line. In the
> future I would like to move the GATT parts out from device.c since it
> is starting to become a little messy with so many things in the same
> file.

DBG dropped.

So I fought about creating separate file, gatt_db_persistence.c for
that in src/ or src/shared . If that's fine for you I'll later add a
patch to move whole persistence to separate file.

>
> --
> Luiz Augusto von Dentz
