Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161227124039.10405-1-luiz.dentz@gmail.com>
References: <20161227124039.10405-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Dec 2016 15:23:53 +0200
Message-ID: <CABBYNZKtEeZSkPy2NN=4WChxawVYcTYydpu79+Djn2zU7EPc=w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] input/hog-lib: Add support to gatt-db
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 27, 2016 at 2:40 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This add support of passing a gatt-db to avoid having to discover the
> services again, this should also make it easier to port to bt_gatt_client
> once Android code support it.
> ---
>  android/hidhost.c        |   4 +
>  profiles/input/hog-lib.c | 247 +++++++++++++++++++++++++++++++++++++++++------
>  profiles/input/hog-lib.h |   4 +-
>  profiles/input/hog.c     |  61 ++++++------
>  unit/test-hog.c          |   6 ++
>  5 files changed, 255 insertions(+), 67 deletions(-)
>
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 591ca95..fe0ea2f 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -38,9 +38,13 @@
>  #include "lib/bluetooth.h"
>  #include "lib/sdp.h"
>  #include "lib/sdp_lib.h"
> +#include "lib/uuid.h"
>  #include "src/shared/mgmt.h"
>  #include "src/shared/util.h"
>  #include "src/shared/uhid.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
>  #include "src/sdp-client.h"
>  #include "src/uuid-helper.h"
>  #include "src/log.h"
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index e376c2b..ed38916 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -45,6 +45,8 @@
>  #include "src/shared/util.h"
>  #include "src/shared/uhid.h"
>  #include "src/shared/queue.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
>  #include "src/log.h"
>
>  #include "attrib/att.h"
> @@ -59,6 +61,7 @@
>  #include "profiles/input/hog-lib.h"
>
>  #define HOG_UUID               "00001812-0000-1000-8000-00805f9b34fb"
> +#define HOG_UUID16             0x1812
>
>  #define HOG_INFO_UUID          0x2A4A
>  #define HOG_REPORT_MAP_UUID    0x2A4B
> @@ -83,6 +86,7 @@ struct bt_hog {
>         uint16_t                vendor;
>         uint16_t                product;
>         uint16_t                version;
> +       struct gatt_db_attribute *attr;
>         struct gatt_primary     *primary;
>         GAttrib                 *attrib;
>         GSList                  *reports;
> @@ -110,9 +114,11 @@ struct report {
>         struct bt_hog           *hog;
>         uint8_t                 id;
>         uint8_t                 type;
> +       uint16_t                handle;
> +       uint16_t                value_handle;
> +       uint8_t                 properties;
>         uint16_t                ccc_handle;
>         guint                   notifyid;
> -       struct gatt_char        *decl;
>         uint16_t                len;
>         uint8_t                 *value;
>  };
> @@ -181,6 +187,10 @@ static void read_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
>         struct gatt_request *req;
>         unsigned int id;
>
> +       /* Ignore if not connected */
> +       if (!attrib)
> +               return;
> +
>         req = create_request(hog, user_data);
>         if (!req)
>                 return;
> @@ -334,7 +344,7 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
>
>         report->notifyid = g_attrib_register(hog->attrib,
>                                         ATT_OP_HANDLE_NOTIFY,
> -                                       report->decl->value_handle,
> +                                       report->value_handle,
>                                         report_value_cb, report, NULL);
>
>         DBG("Report characteristic descriptor written: notifications enabled");
> @@ -403,7 +413,7 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
>         report->id = pdu[1];
>         report->type = pdu[2];
>
> -       DBG("Report 0x%04x: id 0x%02x type %s", report->decl->value_handle,
> +       DBG("Report 0x%04x: id 0x%02x type %s", report->value_handle,
>                                 report->id, type_to_string(report->type));
>
>         /* Enable notifications only for Input Reports */
> @@ -516,7 +526,7 @@ static int report_chrc_cmp(const void *data, const void *user_data)
>         const struct report *report = data;
>         const struct gatt_char *decl = user_data;
>
> -       return report->decl->handle - decl->handle;
> +       return report->handle - decl->handle;
>  }
>
>  static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
> @@ -531,7 +541,9 @@ static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
>
>         report = g_new0(struct report, 1);
>         report->hog = hog;
> -       report->decl = g_memdup(chr, sizeof(*chr));
> +       report->handle = chr->handle;
> +       report->value_handle = chr->value_handle;
> +       report->properties = chr->properties;
>         hog->reports = g_slist_append(hog->reports, report);
>
>         read_char(hog, hog->attrib, chr->value_handle, report_read_cb, report);
> @@ -691,16 +703,16 @@ static void forward_report(struct uhid_event *ev, void *user_data)
>         }
>
>         DBG("Sending report type %d ID %d to handle 0x%X", report->type,
> -                               report->id, report->decl->value_handle);
> +                               report->id, report->value_handle);
>
>         if (hog->attrib == NULL)
>                 return;
>
> -       if (report->decl->properties & GATT_CHR_PROP_WRITE)
> -               write_char(hog, hog->attrib, report->decl->value_handle,
> +       if (report->properties & GATT_CHR_PROP_WRITE)
> +               write_char(hog, hog->attrib, report->value_handle,
>                                 data, size, output_written_cb, hog);
> -       else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
> -               gatt_write_cmd(hog->attrib, report->decl->value_handle,
> +       else if (report->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
> +               gatt_write_cmd(hog->attrib, report->value_handle,
>                                                 data, size, NULL, NULL);
>  }
>
> @@ -789,13 +801,13 @@ static void set_report(struct uhid_event *ev, void *user_data)
>         }
>
>         DBG("Sending report type %d ID %d to handle 0x%X", report->type,
> -                               report->id, report->decl->value_handle);
> +                               report->id, report->value_handle);
>
>         if (hog->attrib == NULL)
>                 return;
>
>         hog->setrep_att = gatt_write_char(hog->attrib,
> -                                               report->decl->value_handle,
> +                                               report->value_handle,
>                                                 data, size, set_report_cb,
>                                                 hog);
>         if (!hog->setrep_att) {
> @@ -878,7 +890,7 @@ static void get_report(struct uhid_event *ev, void *user_data)
>         }
>
>         hog->getrep_att = gatt_read_char(hog->attrib,
> -                                               report->decl->value_handle,
> +                                               report->value_handle,
>                                                 get_report_cb, hog);
>         if (!hog->getrep_att) {
>                 err = ENOMEM;
> @@ -1180,7 +1192,6 @@ static void report_free(void *data)
>         struct report *report = data;
>
>         g_free(report->value);
> -       g_free(report->decl);
>         g_free(report);
>  }
>
> @@ -1211,14 +1222,132 @@ static void hog_free(void *data)
>
>  struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
>                                         uint16_t product, uint16_t version,
> -                                       void *primary)
> +                                       struct gatt_db *db)
>  {
> -       return bt_hog_new(-1, name, vendor, product, version, primary);
> +       return bt_hog_new(-1, name, vendor, product, version, db);
>  }
>
> -struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
> +static void foreach_hog_report(struct gatt_db_attribute *attr, void *user_data)
> +{
> +       struct report *report = user_data;
> +       struct bt_hog *hog = report->hog;
> +       const bt_uuid_t *uuid;
> +       bt_uuid_t ref_uuid, ccc_uuid;
> +       uint16_t handle;
> +
> +       handle = gatt_db_attribute_get_handle(attr);
> +       uuid = gatt_db_attribute_get_type(attr);
> +
> +       bt_uuid16_create(&ref_uuid, GATT_REPORT_REFERENCE);
> +       if (!bt_uuid_cmp(&ref_uuid, uuid)) {
> +               read_char(hog, hog->attrib, handle, report_reference_cb,
> +                                                               report);
> +               return;
> +       }
> +
> +       bt_uuid16_create(&ccc_uuid, GATT_CLIENT_CHARAC_CFG_UUID);
> +       if (!bt_uuid_cmp(&ccc_uuid, uuid))
> +               report->ccc_handle = handle;
> +}
> +
> +static int report_attr_cmp(const void *data, const void *user_data)
> +{
> +       const struct report *report = data;
> +       const struct gatt_db_attribute *attr = user_data;
> +
> +       return report->handle - gatt_db_attribute_get_handle(attr);
> +}
> +
> +static struct report *report_add(struct bt_hog *hog,
> +                                       struct gatt_db_attribute *attr)
> +{
> +       struct report *report;
> +       GSList *l;
> +
> +       /* Skip if report already exists */
> +       l = g_slist_find_custom(hog->reports, attr, report_attr_cmp);
> +       if (l)
> +               return l->data;
> +
> +       report = g_new0(struct report, 1);
> +       report->hog = hog;
> +
> +       gatt_db_attribute_get_char_data(attr, &report->handle,
> +                                       &report->value_handle,
> +                                       &report->properties,
> +                                       NULL, NULL);
> +
> +       hog->reports = g_slist_append(hog->reports, report);
> +
> +       read_char(hog, hog->attrib, report->value_handle, report_read_cb,
> +                                                               report);
> +
> +       return report;
> +}
> +
> +static void foreach_hog_external(struct gatt_db_attribute *attr,
> +                                                       void *user_data)
> +{
> +       struct bt_hog *hog = user_data;
> +       const bt_uuid_t *uuid;
> +       bt_uuid_t ext_uuid;
> +       uint16_t handle;
> +
> +       handle = gatt_db_attribute_get_handle(attr);
> +       uuid = gatt_db_attribute_get_type(attr);
> +
> +       bt_uuid16_create(&ext_uuid, GATT_EXTERNAL_REPORT_REFERENCE);
> +       if (!bt_uuid_cmp(&ext_uuid, uuid))
> +               read_char(hog, hog->attrib, handle,
> +                                       external_report_reference_cb, hog);
> +}
> +
> +static void foreach_hog_chrc(struct gatt_db_attribute *attr, void *user_data)
> +{
> +       struct bt_hog *hog = user_data;
> +       bt_uuid_t uuid, report_uuid, report_map_uuid, info_uuid;
> +       bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
> +       uint16_t handle, value_handle;
> +
> +       gatt_db_attribute_get_char_data(attr, &handle, &value_handle, NULL,
> +                                       NULL, &uuid);
> +
> +       bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
> +       if (!bt_uuid_cmp(&report_uuid, &uuid)) {
> +               struct report *report = report_add(hog, attr);
> +               gatt_db_service_foreach_desc(attr, foreach_hog_report, report);
> +               return;
> +       }
> +
> +       bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
> +       if (!bt_uuid_cmp(&report_map_uuid, &uuid)) {
> +               read_char(hog, hog->attrib, value_handle, report_map_read_cb,
> +                                                                       hog);
> +               gatt_db_service_foreach_desc(attr, foreach_hog_external, hog);
> +               return;
> +       }
> +
> +       bt_uuid16_create(&info_uuid, HOG_INFO_UUID);
> +       if (!bt_uuid_cmp(&info_uuid, &uuid)) {
> +               read_char(hog, hog->attrib, value_handle, info_read_cb, hog);
> +               return;
> +       }
> +
> +       bt_uuid16_create(&proto_mode_uuid, HOG_PROTO_MODE_UUID);
> +       if (!bt_uuid_cmp(&proto_mode_uuid, &uuid)) {
> +               hog->proto_mode_handle = value_handle;
> +               read_char(hog, hog->attrib, value_handle, proto_mode_read_cb,
> +                                                                       hog);
> +       }
> +
> +       bt_uuid16_create(&ctrlpt_uuid, HOG_CONTROL_POINT_UUID);
> +       if (!bt_uuid_cmp(&ctrlpt_uuid, &uuid))
> +               hog->ctrlpt_handle = value_handle;
> +}
> +
> +static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
>                                         uint16_t product, uint16_t version,
> -                                       void *primary)
> +                                       struct gatt_db_attribute *attr)
>  {
>         struct bt_hog *hog;
>
> @@ -1245,9 +1374,58 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
>         hog->vendor = vendor;
>         hog->product = product;
>         hog->version = version;
> +       hog->attr = attr;
>
> -       if (primary)
> -               hog->primary = g_memdup(primary, sizeof(*hog->primary));
> +       return hog;
> +}
> +
> +static void hog_attach_instace(struct bt_hog *hog,
> +                               struct gatt_db_attribute *attr)
> +{
> +       struct bt_hog *instance;
> +
> +       if (!hog->attr) {
> +               hog->attr = attr;
> +               gatt_db_service_foreach_char(hog->attr, foreach_hog_chrc, hog);
> +               return;
> +       }
> +
> +       instance = hog_new(hog->uhid_fd, hog->name, hog->vendor,
> +                                       hog->product, hog->version, attr);
> +       if (!instance)
> +               return;
> +
> +       hog->instances = g_slist_append(hog->instances, instance);
> +}
> +
> +static void foreach_hog_service(struct gatt_db_attribute *attr, void *user_data)
> +{
> +       struct bt_hog *hog = user_data;
> +
> +       hog_attach_instace(hog, attr);
> +}
> +
> +struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
> +                                       uint16_t product, uint16_t version,
> +                                       struct gatt_db *db)
> +{
> +       struct bt_hog *hog;
> +
> +       hog = hog_new(fd, name, vendor, product, version, NULL);
> +       if (!hog)
> +               return NULL;
> +
> +       if (db) {
> +               bt_uuid_t uuid;
> +
> +               /* Handle the HID services */
> +               bt_uuid16_create(&uuid, HOG_UUID16);
> +               gatt_db_foreach_service(db, &uuid, foreach_hog_service, hog);
> +               if (!hog->attr) {
> +                       hog_free(hog);
> +                       return NULL;
> +               }
> +       }
>
>         return bt_hog_ref(hog);
>  }
> @@ -1357,10 +1535,11 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
>         }
>
>         instance = bt_hog_new(hog->uhid_fd, hog->name, hog->vendor,
> -                                       hog->product, hog->version, primary);
> +                                       hog->product, hog->version, NULL);
>         if (!instance)
>                 return;
>
> +       instance->primary = g_memdup(primary, sizeof(*primary));
>         find_included(instance, hog->attrib, primary->range.start,
>                         primary->range.end, find_included_cb, instance);
>
> @@ -1415,7 +1594,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
>
>  bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>  {
> -       struct gatt_primary *primary = hog->primary;
>         GSList *l;
>
>         if (hog->attrib)
> @@ -1423,7 +1601,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>
>         hog->attrib = g_attrib_ref(gatt);
>
> -       if (!primary) {
> +       if (!hog->attr && !hog->primary) {
>                 discover_primary(hog, hog->attrib, NULL, primary_cb, hog);
>                 return true;
>         }
> @@ -1444,9 +1622,14 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>
>         if (!hog->uhid_created) {
>                 DBG("HoG discovering characteristics");
> -               discover_char(hog, hog->attrib, primary->range.start,
> -                                               primary->range.end, NULL,
> -                                               char_discovered_cb, hog);
> +               if (hog->attr)
> +                       gatt_db_service_foreach_char(hog->attr,
> +                                                       foreach_hog_chrc, hog);
> +               else
> +                       discover_char(hog, hog->attrib,
> +                                       hog->primary->range.start,
> +                                       hog->primary->range.end, NULL,
> +                                       char_discovered_cb, hog);
>                 return true;
>         }
>
> @@ -1455,7 +1638,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>
>                 r->notifyid = g_attrib_register(hog->attrib,
>                                         ATT_OP_HANDLE_NOTIFY,
> -                                       r->decl->value_handle,
> +                                       r->value_handle,
>                                         report_value_cb, r, NULL);
>         }
>
> @@ -1528,14 +1711,14 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
>         if (!report)
>                 return -ENOTSUP;
>
> -       DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
> +       DBG("hog: Write report, handle 0x%X", report->value_handle);
>
> -       if (report->decl->properties & GATT_CHR_PROP_WRITE)
> -               write_char(hog, hog->attrib, report->decl->value_handle,
> +       if (report->properties & GATT_CHR_PROP_WRITE)
> +               write_char(hog, hog->attrib, report->value_handle,
>                                 data, size, output_written_cb, hog);
>
> -       if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
> -               gatt_write_cmd(hog->attrib, report->decl->value_handle,
> +       if (report->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
> +               gatt_write_cmd(hog->attrib, report->value_handle,
>                                                 data, size, NULL, NULL);
>
>         for (l = hog->instances; l; l = l->next) {
> diff --git a/profiles/input/hog-lib.h b/profiles/input/hog-lib.h
> index 2a9b899..415dc63 100644
> --- a/profiles/input/hog-lib.h
> +++ b/profiles/input/hog-lib.h
> @@ -25,11 +25,11 @@ struct bt_hog;
>
>  struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
>                                         uint16_t product, uint16_t version,
> -                                       void *primary);
> +                                       struct gatt_db *db);
>
>  struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
>                                         uint16_t product, uint16_t version,
> -                                       void *primary);
> +                                       struct gatt_db *db);
>
>  struct bt_hog *bt_hog_ref(struct bt_hog *hog);
>  void bt_hog_unref(struct bt_hog *hog);
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 7d318cd..23c9c15 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -67,32 +67,34 @@ struct hog_device {
>  static gboolean suspend_supported = FALSE;
>  static struct queue *devices = NULL;
>
> -static struct hog_device *hog_device_new(struct btd_device *device,
> -                                               struct gatt_primary *prim)
> +static void hog_device_accept(struct hog_device *dev, struct gatt_db *db)
>  {
> -       struct hog_device *dev;
>         char name[248];
>         uint16_t vendor, product, version;
>
> -       if (device_name_known(device))
> -               device_get_name(device, name, sizeof(name));
> +       if (dev->hog)
> +               return;
> +
> +       if (device_name_known(dev->device))
> +               device_get_name(dev->device, name, sizeof(name));
>         else
>                 strcpy(name, "bluez-hog-device");
>
> -       vendor = btd_device_get_vendor(device);
> -       product = btd_device_get_product(device);
> -       version = btd_device_get_version(device);
> +       vendor = btd_device_get_vendor(dev->device);
> +       product = btd_device_get_product(dev->device);
> +       version = btd_device_get_version(dev->device);
>
>         DBG("name=%s vendor=0x%X, product=0x%X, version=0x%X", name, vendor,
>                                                         product, version);
>
> -       dev = new0(struct hog_device, 1);
> -       dev->hog = bt_hog_new_default(name, vendor, product, version, prim);
> -       if (!dev->hog) {
> -               free(dev);
> -               return NULL;
> -       }
> +       dev->hog = bt_hog_new_default(name, vendor, product, version, db);
> +}
>
> +static struct hog_device *hog_device_new(struct btd_device *device)
> +{
> +       struct hog_device *dev;
> +
> +       dev = new0(struct hog_device, 1);
>         dev->device = btd_device_ref(device);
>
>         if (!devices)
> @@ -148,30 +150,16 @@ static int hog_probe(struct btd_service *service)
>  {
>         struct btd_device *device = btd_service_get_device(service);
>         const char *path = device_get_path(device);
> -       GSList *primaries, *l;
> +       struct hog_device *dev;
>
>         DBG("path %s", path);
>
> -       primaries = btd_device_get_primaries(device);
> -       if (primaries == NULL)
> +       dev = hog_device_new(device);
> +       if (!dev)
>                 return -EINVAL;
>
> -       for (l = primaries; l; l = g_slist_next(l)) {
> -               struct gatt_primary *prim = l->data;
> -               struct hog_device *dev;
> -
> -               if (strcmp(prim->uuid, HOG_UUID) != 0)
> -                       continue;
> -
> -               dev = hog_device_new(device, prim);
> -               if (!dev)
> -                       break;
> -
> -               btd_service_set_user_data(service, dev);
> -               return 0;
> -       }
> -
> -       return -EINVAL;
> +       btd_service_set_user_data(service, dev);
> +       return 0;
>  }
>
>  static void hog_remove(struct btd_service *service)
> @@ -189,8 +177,15 @@ static int hog_accept(struct btd_service *service)
>  {
>         struct hog_device *dev = btd_service_get_user_data(service);
>         struct btd_device *device = btd_service_get_device(service);
> +       struct gatt_db *db = btd_device_get_gatt_db(device);
>         GAttrib *attrib = btd_device_get_attrib(device);
>
> +       if (!dev->hog) {
> +               hog_device_accept(dev, db);
> +               if (!dev->hog)
> +                       return -EINVAL;
> +       }
> +
>         /* TODO: Replace GAttrib with bt_gatt_client */
>         bt_hog_attach(dev->hog, attrib);
>
> diff --git a/unit/test-hog.c b/unit/test-hog.c
> index 9f026e5..d117968 100644
> --- a/unit/test-hog.c
> +++ b/unit/test-hog.c
> @@ -32,8 +32,14 @@
>
>  #include <glib.h>
>
> +#include "lib/bluetooth.h"
> +#include "lib/uuid.h"
> +
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
>
>  #include "attrib/gattrib.h"
>
> --
> 2.9.3

Applied.


-- 
Luiz Augusto von Dentz
