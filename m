Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2313734.dSmzyFu87i@ix>
References: <20180112141012.28113-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180112141012.28113-2-grzegorz.kolodziejczyk@codecoup.pl> <2313734.dSmzyFu87i@ix>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Tue, 16 Jan 2018 10:26:36 +0100
Message-ID: <CALevQMZdqKECu_MxEw2g+BPQ9P4tZMqyv+jaGpFgu1x2o4un7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/4] tools/btpclient: Add start, stop advertising commands
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

2018-01-15 14:21 GMT+01:00 Szymon Janc <szymon.janc@codecoup.pl>:
> Hi Grzegorz,
>
> On Friday, 12 January 2018 15:10:10 CET Grzegorz Kolodziejczyk wrote:
>> This patch adds start and stop advertising commands for btp client.
>> ---
>>  tools/btpclient.c | 651
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 6=
50
>> insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/btpclient.c b/tools/btpclient.c
>> index a8a65fd51..3fb94b7f9 100644
>> --- a/tools/btpclient.c
>> +++ b/tools/btpclient.c
>> @@ -34,6 +34,19 @@
>>
>>  #include "src/shared/btp.h"
>>
>> +#define AD_PATH "/org/bluez/advertising"
>> +#define AD_IFACE "org.bluez.LEAdvertisement1"
>> +
>> +/* List of assigned numbers for advetising data and scan response */
>> +#define AD_TYPE_FLAGS                                0x01
>> +#define AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST       0x02
>> +#define AD_TYPE_SHORT_NAME                   0x08
>> +#define AD_TYPE_SERVICE_DATA_UUID16          0x16
>> +#define AD_TYPE_APPEARANCE                   0x19
>> +#define AD_TYPE_MANUFACTURER_DATA            0xff
>> +
>> +static struct l_dbus *dbus;
>> +
>>  struct btp_adapter {
>>       struct l_dbus_proxy *proxy;
>>       struct l_dbus_proxy *ad_proxy;
>> @@ -53,12 +66,61 @@ static struct btp *btp;
>>
>>  static bool gap_service_registered;
>>
>> +struct ad_data {
>> +     uint8_t data[25];
>> +     uint8_t len;
>> +};
>> +
>> +struct service_data {
>> +     char *uuid;
>> +     struct ad_data data;
>> +};
>> +
>> +struct manufacturer_data {
>> +     uint16_t id;
>> +     struct ad_data data;
>> +};
>> +
>> +static struct ad {
>> +     bool registered;
>> +     char *type;
>> +     char *local_name;
>> +     uint16_t local_appearance;
>> +     uint16_t duration;
>> +     uint16_t timeout;
>> +     struct l_queue *uuids;
>> +     struct l_queue *services;
>> +     struct l_queue *manufacturers;
>> +     bool tx_power;
>> +     bool name;
>> +     bool appearance;
>> +} ad =3D {
>> +     .local_appearance =3D UINT16_MAX,
>> +};
>> +
>>  static bool str2addr(const char *str, uint8_t *addr)
>>  {
>>       return sscanf(str, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &addr[5], &add=
r[4],
>>                               &addr[3], &addr[2], &addr[1], &addr[0]) =
=3D=3D 6;
>>  }
>>
>> +static char *dupuuid2str(const uint8_t *uuid, uint8_t len)
>> +{
>> +     switch (len) {
>> +     case 16:
>> +             return l_strdup_printf("%hhx%hhx", uuid[0], uuid[1]);
>> +     case 128:
>> +             return l_strdup_printf("%hhx%hhx%hhx%hhx%hhx%hhx%hhx%hhx%h=
hx"
>> +                                     "%hhx%hhx%hhx%hhx%hhx%hhx%hhx", uu=
id[0],
>> +                                     uuid[1], uuid[2], uuid[3], uuid[4]=
,
>> +                                     uuid[5], uuid[6], uuid[6], uuid[8]=
,
>> +                                     uuid[7], uuid[10], uuid[11], uuid[=
12],
>> +                                     uuid[13], uuid[14], uuid[15]);
>> +     default:
>> +             return NULL;
>> +     }
>> +}
>> +
>>  static struct btp_adapter *find_adapter_by_proxy(struct l_dbus_proxy
>> *proxy) {
>>       const struct l_queue_entry *entry;
>> @@ -123,6 +185,8 @@ static void btp_gap_read_commands(uint8_t index, con=
st
>> void *param, commands |=3D (1 << BTP_OP_GAP_SET_CONNECTABLE);
>>       commands |=3D (1 << BTP_OP_GAP_SET_DISCOVERABLE);
>>       commands |=3D (1 << BTP_OP_GAP_SET_BONDABLE);
>> +     commands |=3D (1 << BTP_OP_GAP_START_ADVERTISING);
>> +     commands |=3D (1 << BTP_OP_GAP_STOP_ADVERTISING);
>>       commands |=3D (1 << BTP_OP_GAP_START_DISCOVERY);
>>       commands |=3D (1 << BTP_OP_GAP_STOP_DISCOVERY);
>>
>> @@ -234,6 +298,46 @@ static void remove_device_reply(struct l_dbus_proxy
>> *proxy, l_queue_remove(adapter->devices, device);
>>  }
>>
>> +static void unreg_advertising_setup(struct l_dbus_message *message,
>> +                                                             void *user=
_data)
>> +{
>> +     struct l_dbus_message_builder *builder;
>> +
>> +     builder =3D l_dbus_message_builder_new(message);
>> +     l_dbus_message_builder_append_basic(builder, 'o', AD_PATH);
>> +     l_dbus_message_builder_finalize(builder);
>> +     l_dbus_message_builder_destroy(builder);
>> +}
>> +
>> +static void unreg_advertising_reply(struct l_dbus_proxy *proxy,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     const char *path =3D l_dbus_proxy_get_path(proxy);
>> +     struct btp_adapter *adapter =3D find_adapter_by_path(path);
>> +
>> +     if (!adapter)
>> +             return;
>> +
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name;
>> +
>> +             l_dbus_message_get_error(result, &name, NULL);
>> +
>> +             l_error("Failed to stop advertising %s (%s)",
>> +                                     l_dbus_proxy_get_path(proxy), name=
);
>> +             return;
>> +     }
>> +
>> +     if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFACE))
>> +             l_info("Unable to remove ad instance");
>> +     if (!l_dbus_object_remove_interface(dbus, AD_PATH,
>> +                                             L_DBUS_INTERFACE_PROPERTIE=
S))
>> +             l_info("Unable to remove propety instance");
>> +     if (!l_dbus_unregister_interface(dbus, AD_IFACE))
>> +             l_info("Unable to unregister ad interface");
>> +}
>> +
>>  static void btp_gap_reset(uint8_t index, const void *param, uint16_t
>> length, void *user_data)
>>  {
>> @@ -264,6 +368,16 @@ static void btp_gap_reset(uint8_t index, const void
>> *param, uint16_t length, NULL);
>>       }
>>
>> +     if (adapter->ad_proxy)
>> +             if (!l_dbus_proxy_method_call(adapter->ad_proxy,
>> +                                             "UnregisterAdvertisement",
>> +                                             unreg_advertising_setup,
>> +                                             unreg_advertising_reply,
>> +                                             NULL, NULL)) {
>> +                     status =3D BTP_ERROR_FAIL;
>> +                     goto failed;
>> +             }
>> +
>>       /* TODO for we assume all went well */
>>       btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET, index, 0, NULL);
>>       return;
>> @@ -449,6 +563,529 @@ failed:
>>       btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>>  }
>>
>> +static void ad_cleanup_service(void *service)
>> +{
>> +     struct service_data *s =3D service;
>> +
>> +     l_free(s->uuid);
>> +     l_free(s);
>> +}
>> +
>> +static void ad_cleanup()
>
> (void) is missing
>
>> +{
>> +     l_free(ad.local_name);
>> +     l_queue_destroy(ad.uuids, l_free);
>> +     l_queue_destroy(ad.services, ad_cleanup_service);
>> +     l_queue_destroy(ad.manufacturers, l_free);
>
> type free is missing here, and I'd also memset ad here.
Right, I'll fix it.
>
>> +}
>> +
>> +static struct l_dbus_message *ad_release_call(struct l_dbus *dbus,
>> +                                             struct l_dbus_message *mes=
sage,
>> +                                             void *user_data)
>> +{
>> +     struct l_dbus_message *reply;
>> +
>> +     l_dbus_unregister_object(dbus, AD_PATH);
>> +     l_dbus_unregister_interface(dbus, AD_IFACE);
>> +
>> +     reply =3D l_dbus_message_new_method_return(message);
>> +     l_dbus_message_set_arguments(reply, "");
>> +
>> +     ad_cleanup();
>> +
>> +     return reply;
>> +}
>> +
>> +static bool ad_type_getter(struct l_dbus *dbus, struct l_dbus_message
>> *message, +                           struct l_dbus_message_builder *bui=
lder,
>> +                             void *user_data)
>> +{
>> +     l_dbus_message_builder_append_basic(builder, 's', ad.type);
>> +
>> +     return true;
>> +}
>> +
>> +static bool ad_serviceuuids_getter(struct l_dbus *dbus,
>> +                                     struct l_dbus_message *message,
>> +                                     struct l_dbus_message_builder *bui=
lder,
>> +                                     void *user_data)
>> +{
>> +     const struct l_queue_entry *entry;
>> +
>> +     if (l_queue_isempty(ad.uuids))
>> +             return false;
>> +
>> +     l_dbus_message_builder_enter_array(builder, "s");
>> +
>> +     for (entry =3D l_queue_get_entries(ad.uuids); entry; entry =3D ent=
ry->next)
>> +             l_dbus_message_builder_append_basic(builder, 's', entry->d=
ata);
>> +
>> +     l_dbus_message_builder_leave_array(builder);
>> +
>> +     return true;
>> +}
>> +
>> +static bool ad_servicedata_getter(struct l_dbus *dbus,
>> +                                     struct l_dbus_message *message,
>> +                                     struct l_dbus_message_builder *bui=
lder,
>> +                                     void *user_data)
>> +{
>> +     const struct l_queue_entry *entry;
>> +     size_t i;
>> +
>> +     if (l_queue_isempty(ad.services))
>> +             return false;
>> +
>> +     l_dbus_message_builder_enter_array(builder, "{sv}");
>> +
>> +     for (entry =3D l_queue_get_entries(ad.services); entry;
>> +                                                     entry =3D entry->n=
ext) {
>> +             struct service_data *sd =3D entry->data;
>> +
>> +             l_dbus_message_builder_enter_dict(builder, "sv");
>> +             l_dbus_message_builder_append_basic(builder, 's', sd->uuid=
);
>> +             l_dbus_message_builder_enter_variant(builder, "ay");
>> +             l_dbus_message_builder_enter_array(builder, "y");
>> +
>> +             for (i =3D 0; i < sd->data.len; i++)
>> +                     l_dbus_message_builder_append_basic(builder, 'y',
>> +                                                     &(sd->data.data[i]=
));
>> +
>> +             l_dbus_message_builder_leave_array(builder);
>> +             l_dbus_message_builder_leave_variant(builder);
>> +             l_dbus_message_builder_leave_dict(builder);
>> +     }
>> +     l_dbus_message_builder_leave_array(builder);
>> +
>> +     return true;
>> +}
>> +
>> +static bool ad_manufacturerdata_getter(struct l_dbus *dbus,
>> +                                     struct l_dbus_message *message,
>> +                                     struct l_dbus_message_builder *bui=
lder,
>> +                                     void *user_data)
>> +{
>> +     const struct l_queue_entry *entry;
>> +     size_t i;
>> +
>> +     if (l_queue_isempty(ad.manufacturers))
>> +             return false;
>> +
>> +     l_dbus_message_builder_enter_array(builder, "{qv}");
>> +
>> +     for (entry =3D l_queue_get_entries(ad.manufacturers); entry;
>> +                                                     entry =3D entry->n=
ext) {
>> +             struct manufacturer_data *md =3D entry->data;
>> +
>> +             l_dbus_message_builder_enter_dict(builder, "qv");
>> +             l_dbus_message_builder_append_basic(builder, 'q', &md->id)=
;
>> +             l_dbus_message_builder_enter_variant(builder, "ay");
>> +             l_dbus_message_builder_enter_array(builder, "y");
>> +
>> +             for (i =3D 0; i < md->data.len; i++)
>> +                     l_dbus_message_builder_append_basic(builder, 'y',
>> +                                                     &(md->data.data[i]=
));
>> +
>> +             l_dbus_message_builder_leave_array(builder);
>> +             l_dbus_message_builder_leave_variant(builder);
>> +             l_dbus_message_builder_leave_dict(builder);
>> +     }
>> +     l_dbus_message_builder_leave_array(builder);
>> +
>> +     return true;
>> +}
>> +
>> +static bool ad_includes_getter(struct l_dbus *dbus,
>> +                                     struct l_dbus_message *message,
>> +                                     struct l_dbus_message_builder *bui=
lder,
>> +                                     void *user_data)
>> +{
>> +     l_dbus_message_builder_enter_array(builder, "s");
>> +
>> +     if (!(ad.tx_power || ad.name || ad.appearance))
>> +             return false;
>> +
>> +     if (ad.tx_power) {
>> +             const char *str =3D "tx-power";
>> +
>> +             l_dbus_message_builder_append_basic(builder, 's', &str);
>> +     }
>> +
>> +     if (ad.name) {
>> +             const char *str =3D "local-name";
>> +
>> +             l_dbus_message_builder_append_basic(builder, 's', &str);
>> +     }
>> +
>> +     if (ad.appearance) {
>> +             const char *str =3D "appearance";
>> +
>> +             l_dbus_message_builder_append_basic(builder, 's', &str);
>> +     }
>> +
>> +     l_dbus_message_builder_leave_array(builder);
>> +
>> +     return true;
>> +}
>> +
>> +static bool ad_localname_getter(struct l_dbus *dbus,
>> +                                     struct l_dbus_message *message,
>> +                                     struct l_dbus_message_builder *bui=
lder,
>> +                                     void *user_data)
>> +{
>> +     if (!ad.local_name)
>> +             return false;
>> +
>> +     l_dbus_message_builder_append_basic(builder, 's', ad.local_name);
>> +
>> +     return true;
>> +}
>> +
>> +static bool ad_appearance_getter(struct l_dbus *dbus,
>> +                                     struct l_dbus_message *message,
>> +                                     struct l_dbus_message_builder *bui=
lder,
>> +                                     void *user_data)
>> +{
>> +     if (!ad.local_appearance)
>> +             return false;
>> +
>> +     l_dbus_message_builder_append_basic(builder, 'q', &ad.local_appear=
ance);
>> +
>> +     return true;
>> +}
>> +
>> +static bool ad_duration_getter(struct l_dbus *dbus,
>> +                                     struct l_dbus_message *message,
>> +                                     struct l_dbus_message_builder *bui=
lder,
>> +                                     void *user_data)
>> +{
>> +     if (!ad.duration)
>> +             return false;
>> +
>> +     l_dbus_message_builder_append_basic(builder, 'q', &ad.duration);
>> +
>> +     return true;
>> +}
>> +
>> +static bool ad_timeout_getter(struct l_dbus *dbus,
>> +                                     struct l_dbus_message *message,
>> +                                     struct l_dbus_message_builder *bui=
lder,
>> +                                     void *user_data)
>> +{
>> +     if (!ad.timeout)
>> +             return false;
>> +
>> +     l_dbus_message_builder_append_basic(builder, 'q', &ad.timeout);
>> +
>> +     return true;
>> +}
>> +
>> +static void setup_ad_interface(struct l_dbus_interface *interface)
>> +{
>> +     l_dbus_interface_method(interface, "Release",
>> +                                             L_DBUS_METHOD_FLAG_NOREPLY=
,
>> +                                             ad_release_call, "", "");
>> +     l_dbus_interface_property(interface, "Type", 0, "s", ad_type_gette=
r,
>> +                                                                     NU=
LL);
>> +     l_dbus_interface_property(interface, "ServiceUUIDs", 0, "as",
>> +                                             ad_serviceuuids_getter, NU=
LL);
>> +     l_dbus_interface_property(interface, "ServiceData", 0, "a{sv}",
>> +                                             ad_servicedata_getter, NUL=
L);
>> +     l_dbus_interface_property(interface, "ManufacturerServiceData", 0,
>> +                                     "a{qv}", ad_manufacturerdata_gette=
r,
>> +                                     NULL);
>> +     l_dbus_interface_property(interface, "Includes", 0, "as",
>> +                                             ad_includes_getter, NULL);
>> +     l_dbus_interface_property(interface, "LocalName", 0, "s",
>> +                                             ad_localname_getter, NULL)=
;
>> +     l_dbus_interface_property(interface, "Appearance", 0, "q",
>> +                                             ad_appearance_getter, NULL=
);
>> +     l_dbus_interface_property(interface, "Duration", 0, "q",
>> +                                             ad_duration_getter, NULL);
>> +     l_dbus_interface_property(interface, "Timeout", 0, "q",
>> +                                             ad_timeout_getter, NULL);
>> +}
>> +
>> +static void start_advertising_reply(struct l_dbus_proxy *proxy,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     const char *path =3D l_dbus_proxy_get_path(proxy);
>> +     struct btp_adapter *adapter =3D find_adapter_by_path(path);
>> +     uint32_t new_settings;
>> +
>> +     if (!adapter) {
>> +             btp_send_error(btp, BTP_GAP_SERVICE, BTP_INDEX_NON_CONTROL=
LER,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name, *desc;
>> +
>> +             l_dbus_message_get_error(result, &name, &desc);
>> +             l_error("Failed to start advertising (%s), %s", name, desc=
);
>> +
>> +             btp_send_error(btp, BTP_GAP_SERVICE, adapter->index,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     new_settings =3D adapter->current_settings;
>> +     new_settings |=3D BTP_GAP_SETTING_ADVERTISING;
>> +     update_current_settings(adapter, new_settings);
>> +
>> +     ad.registered =3D true;
>> +
>> +     btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_ADVERTISING,
>> +                                     adapter->index, sizeof(new_setting=
s),
>> +                                     &new_settings);
>> +}
>> +
>> +static void create_advertising_data(uint8_t adv_data_len, const uint8_t
>> *data) +{
>> +     const uint8_t *ad_data;
>> +     uint8_t ad_type, ad_len;
>> +     uint8_t remaining_data_len =3D adv_data_len;
>> +
>> +     while (remaining_data_len) {
>> +             ad_type =3D data[adv_data_len - remaining_data_len];
>> +             ad_len =3D data[adv_data_len - remaining_data_len + 1];
>> +             ad_data =3D &data[adv_data_len - remaining_data_len + 2];
>> +
>> +             switch (ad_type) {
>> +             case AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST:
>> +             {
>> +                     char *uuid =3D dupuuid2str(ad_data, 16);
>
> Empty line here.
Ok.
>
>> +                     l_queue_push_tail(ad.uuids, uuid);
>> +
>> +                     break;
>> +             }
>> +             case AD_TYPE_SHORT_NAME:
>> +                     ad.local_name =3D malloc(ad_len + 1);
>> +                     memcpy(ad.local_name, ad_data, ad_len);
>> +                     ad.local_name[ad_len] =3D '\0';
>> +
>> +                     break;
>> +             case AD_TYPE_SERVICE_DATA_UUID16:
>> +             {
>> +                     struct service_data *sd;
>> +
>> +                     sd =3D l_new(struct service_data, 1);
>> +                     sd->uuid =3D dupuuid2str(ad_data, 16);
>> +                     sd->data.len =3D ad_len - 2;
>> +                     memcpy(sd->data.data, ad_data + 2, sd->data.len);
>> +
>> +                     l_queue_push_tail(ad.services, sd);
>> +
>> +                     break;
>> +             }
>> +             case AD_TYPE_APPEARANCE:
>> +                     memcpy(&ad.local_appearance, ad_data, ad_len);
>> +
>> +                     break;
>> +             case AD_TYPE_MANUFACTURER_DATA:
>> +             {
>> +                     struct manufacturer_data *md;
>> +
>> +                     md =3D l_new(struct manufacturer_data, 1);
>> +                     /* The first 2 octets contain the Company Identifi=
er
>> +                      * Code followed by additional manufacturer specif=
ic
>> +                      * data.
>> +                      */
>> +                     memcpy(&md->id, ad_data, 2);
>> +                     md->data.len =3D ad_len - 2;
>> +                     memcpy(md->data.data, ad_data + 2, md->data.len);
>> +
>> +                     l_queue_push_tail(ad.manufacturers, md);
>> +
>> +                     break;
>> +             }
>> +             default:
>> +                     l_info("Unsupported advertising data type");
>> +
>> +                     break;
>> +             }
>> +             /* Advertising entity data len + advertising entity header
>> +              * (type, len)
>> +              */
>> +             remaining_data_len -=3D ad_len + 2;
>> +     }
>> +}
>> +
>> +static void create_scan_response(uint8_t scan_rsp_len, const uint8_t *d=
ata)
>> +{
>> +     /* TODO */
>> +}
>> +
>> +static void start_advertising_setup(struct l_dbus_message *message,
>> +                                                     void *user_data)
>> +{
>> +     struct l_dbus_message_builder *builder;
>> +
>> +     builder =3D l_dbus_message_builder_new(message);
>> +     l_dbus_message_builder_append_basic(builder, 'o', AD_PATH);
>> +     l_dbus_message_builder_enter_array(builder, "{sv}");
>> +     l_dbus_message_builder_enter_dict(builder, "sv");
>> +     l_dbus_message_builder_leave_dict(builder);
>> +     l_dbus_message_builder_leave_array(builder);
>> +     l_dbus_message_builder_finalize(builder);
>> +     l_dbus_message_builder_destroy(builder);
>> +}
>> +
>> +static void btp_gap_start_advertising(uint8_t index, const void *param,
>> +                                     uint16_t length, void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_index(index);
>> +     const struct btp_gap_start_adv_cp *cp =3D param;
>> +     uint8_t status =3D BTP_ERROR_FAIL;
>> +     bool prop;
>> +
>> +     if (!adapter) {
>> +             status =3D BTP_ERROR_INVALID_INDEX;
>> +             goto failed;
>> +     }
>> +
>> +     /* Adapter needs to be powered to be able to remove devices */
>> +     if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &pr=
op) ||
>> +                                                     !prop || ad.regist=
ered)
>> +             goto failed;
>> +
>> +     if (!l_dbus_register_interface(dbus, AD_IFACE, setup_ad_interface,=
 NULL,
>> +                                                                     fa=
lse)) {
>> +             l_info("Unable to register ad interface");
>> +             goto failed;
>> +     }
>> +
>> +     if (!l_dbus_object_add_interface(dbus, AD_PATH, AD_IFACE, NULL)) {
>> +             l_info("Unable to instantiate ad interface");
>> +
>> +             if (!l_dbus_unregister_interface(dbus, AD_IFACE))
>> +                     l_info("Unable to unregister ad interface");
>> +
>> +             goto failed;
>> +     }
>> +
>> +     if (!l_dbus_object_add_interface(dbus, AD_PATH,
>> +                                             L_DBUS_INTERFACE_PROPERTIE=
S,
>> +                                             NULL)) {
>> +             l_info("Unable to instantiate the properties interface");
>> +
>> +             if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFAC=
E))
>> +                     l_info("Unable to remove ad instance");
>> +             if (!l_dbus_unregister_interface(dbus, AD_IFACE))
>> +                     l_info("Unable to unregister ad interface");
>> +
>> +             goto failed;
>> +     }
>> +
>> +     ad.uuids =3D l_queue_new();
>> +     ad.services =3D l_queue_new();
>> +     ad.manufacturers =3D l_queue_new();
>
> Put this into helper eg ad_init(), also set appearance to default value.
Ok.
>
>> +
>> +     if (adapter->current_settings & BTP_GAP_SETTING_CONNECTABLE)
>> +             ad.type =3D l_strdup("peripheral");
>> +     else
>> +             ad.type =3D l_strdup("broadcast");
>
> No need to dup those string, just assing them with constants.
Right.
>
>> +
>> +     if (cp->adv_data_len > 0)
>> +             create_advertising_data(cp->adv_data_len, cp->data);
>> +     if (cp->scan_rsp_len > 0)
>> +             create_scan_response(cp->scan_rsp_len,
>> +                                             cp->data + cp->scan_rsp_le=
n);
>> +
>> +     if (!l_dbus_proxy_method_call(adapter->ad_proxy,
>> +                                                     "RegisterAdvertise=
ment",
>> +                                                     start_advertising_=
setup,
>> +                                                     start_advertising_=
reply,
>> +                                                     NULL, NULL)) {
>> +             if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFAC=
E))
>> +                     l_info("Unable to remove ad instance");
>> +             if (!l_dbus_unregister_interface(dbus, AD_IFACE))
>> +                     l_info("Unable to unregister ad interface");
>> +
>> +             goto failed;
>> +     }
>> +
>> +     return;
>> +
>> +failed:
>> +     btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>> +}
>> +
>> +static void stop_advertising_reply(struct l_dbus_proxy *proxy,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     const char *path =3D l_dbus_proxy_get_path(proxy);
>> +     struct btp_adapter *adapter =3D find_adapter_by_path(path);
>> +     uint32_t new_settings;
>> +
>> +     if (!adapter)
>> +             return;
>> +
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name;
>> +
>> +             l_dbus_message_get_error(result, &name, NULL);
>> +
>> +             l_error("Failed to stop advertising %s (%s)",
>> +                                     l_dbus_proxy_get_path(proxy), name=
);
>> +             return;
>> +     }
>> +
>> +     if (!l_dbus_object_remove_interface(dbus, AD_PATH, AD_IFACE))
>> +             l_info("Unable to remove ad instance");
>> +     if (!l_dbus_object_remove_interface(dbus, AD_PATH,
>> +                                             L_DBUS_INTERFACE_PROPERTIE=
S))
>> +             l_info("Unable to remove propety instance");
>> +     if (!l_dbus_unregister_interface(dbus, AD_IFACE))
>> +             l_info("Unable to unregister ad interface");
>> +
>> +     new_settings =3D adapter->current_settings;
>> +     new_settings &=3D ~BTP_GAP_SETTING_ADVERTISING;
>> +     update_current_settings(adapter, new_settings);
>> +
>> +     ad_cleanup();
>> +
>> +     btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_ADVERTISING,
>> +                                     adapter->index, sizeof(new_setting=
s),
>> +                                     &new_settings);
>> +}
>> +
>> +static void btp_gap_stop_advertising(uint8_t index, const void *param,
>> +                                     uint16_t length, void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_index(index);
>> +     uint8_t status =3D BTP_ERROR_FAIL;
>> +     bool prop;
>> +
>> +     if (!adapter) {
>> +             status =3D BTP_ERROR_INVALID_INDEX;
>> +             goto failed;
>> +     }
>> +
>> +     if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &pr=
op) ||
>> +                                                     !prop || !ad.regis=
tered)
>> +             goto failed;
>> +
>> +     if (adapter->ad_proxy) {
>> +             if (!l_dbus_proxy_method_call(adapter->ad_proxy,
>> +                                             "UnregisterAdvertisement",
>> +                                             unreg_advertising_setup,
>> +                                             stop_advertising_reply,
>> +                                             NULL, NULL)) {
>> +                     status =3D BTP_ERROR_FAIL;
>> +                     goto failed;
>> +             }
>> +     }
>> +
>> +     return;
>> +
>> +failed:
>> +     btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>> +}
>> +
>>  static void start_discovery_reply(struct l_dbus_proxy *proxy,
>>                                               struct l_dbus_message *res=
ult,
>>                                               void *user_data)
>> @@ -728,6 +1365,12 @@ static void register_gap_service(void)
>>       btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_BONDABLE,
>>                                       btp_gap_set_bondable, NULL, NULL);
>>
>> +     btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_ADVERTISING,
>> +                                     btp_gap_start_advertising, NULL, N=
ULL);
>> +
>> +     btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_STOP_ADVERTISING,
>> +                                     btp_gap_stop_advertising, NULL, NU=
LL);
>> +
>>       btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_START_DISCOVERY,
>>                                       btp_gap_start_discovery, NULL, NUL=
L);
>>
>> @@ -1124,6 +1767,12 @@ static void client_ready(struct l_dbus_client
>> *client, void *user_data) BTP_INDEX_NON_CONTROLLER, 0, NULL);
>>  }
>>
>> +static void ready_callback(void *user_data)
>> +{
>> +     if (!l_dbus_object_manager_enable(dbus))
>> +             l_info("Unable to register the ObjectManager");
>> +}
>> +
>>  static void usage(void)
>>  {
>>       l_info("btpclient - Bluetooth tester");
>> @@ -1148,7 +1797,6 @@ int main(int argc, char *argv[])
>>  {
>>       struct l_dbus_client *client;
>>       struct l_signal *signal;
>> -     struct l_dbus *dbus;
>>       sigset_t mask;
>>       int opt;
>>
>> @@ -1192,6 +1840,7 @@ int main(int argc, char *argv[])
>>       signal =3D l_signal_create(&mask, signal_handler, NULL, NULL);
>>
>>       dbus =3D l_dbus_new_default(L_DBUS_SYSTEM_BUS);
>> +     l_dbus_set_ready_handler(dbus, ready_callback, NULL, NULL);
>>       client =3D l_dbus_client_new(dbus, "org.bluez", "/org/bluez");
>>
>>       l_dbus_client_set_connect_handler(client, client_connected, NULL, =
NULL);
>
>
> --
> pozdrawiam
> Szymon Janc
>
>
pozdrawiam,
Grzegorz Ko=C5=82odziejczyk
