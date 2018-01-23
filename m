Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2648945.RnxBAffNI9@ix>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180119164133.16767-3-grzegorz.kolodziejczyk@codecoup.pl> <2648945.RnxBAffNI9@ix>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Tue, 23 Jan 2018 16:06:45 +0100
Message-ID: <CALevQMY6_3pia+RamVRg5fcadcEbBG8gE19uOwFJWsmQBfh39w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/8] tools/btpclient: Add set io capabilities command
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

2018-01-23 14:48 GMT+01:00 Szymon Janc <szymon.janc@codecoup.pl>:
> Hi Grzegorz,
>
> On Friday, 19 January 2018 17:41:28 CET Grzegorz Kolodziejczyk wrote:
>> This patch adds support for set io capabilities command.
>> ---
>>  tools/btpclient.c | 361
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 3=
61
>> insertions(+)
>>
>> diff --git a/tools/btpclient.c b/tools/btpclient.c
>> index f2c79b3a3..708092937 100644
>> --- a/tools/btpclient.c
>> +++ b/tools/btpclient.c
>> @@ -36,7 +36,9 @@
>>  #include "src/shared/btp.h"
>>
>>  #define AD_PATH "/org/bluez/advertising"
>> +#define AG_PATH "/org/bluez/agent"
>>  #define AD_IFACE "org.bluez.LEAdvertisement1"
>> +#define AG_IFACE "org.bluez.Agent1"
>>
>>  /* List of assigned numbers for advetising data and scan response */
>>  #define AD_TYPE_FLAGS                                0x01
>> @@ -97,6 +99,12 @@ static struct ad {
>>       bool appearance;
>>  } ad;
>>
>> +static struct btp_agent {
>> +     bool registered;
>> +     struct l_dbus_proxy *proxy;
>> +     struct l_dbus_message *pending_req;
>> +} ag;
>> +
>>  static char *dupuuid2str(const uint8_t *uuid, uint8_t len)
>>  {
>>       switch (len) {
>> @@ -198,6 +206,31 @@ static struct btp_device *find_device_by_address(st=
ruct
>> btp_adapter *adapter, return NULL;
>>  }
>>
>> +static bool match_device_paths(const void *device, const void *path)
>> +{
>> +     const struct btp_device *dev =3D device;
>> +
>> +     return !strcmp(l_dbus_proxy_get_path(dev->proxy), path);
>> +}
>> +
>> +static struct btp_device *find_device_by_path(const char *path)
>> +{
>> +     const struct l_queue_entry *entry;
>> +     struct btp_device *device;
>> +
>> +     for (entry =3D l_queue_get_entries(adapters); entry;
>> +                                                     entry =3D entry->n=
ext) {
>> +             struct btp_adapter *adapter =3D entry->data;
>> +
>> +             device =3D l_queue_find(adapter->devices, match_device_pat=
hs,
>> +                                                                     pa=
th);
>> +             if (device)
>> +                     return device;
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>>  static bool match_adapter_dev_proxy(const void *device, const void *pro=
xy)
>>  {
>>       const struct btp_device *d =3D device;
>> @@ -269,6 +302,7 @@ static void btp_gap_read_commands(uint8_t index, con=
st
>> void *param, commands |=3D (1 << BTP_OP_GAP_STOP_DISCOVERY);
>>       commands |=3D (1 << BTP_OP_GAP_CONNECT);
>>       commands |=3D (1 << BTP_OP_GAP_DISCONNECT);
>> +     commands |=3D (1 << BTP_OP_GAP_SET_IO_CAPA);
>>
>>       commands =3D L_CPU_TO_LE16(commands);
>>
>> @@ -418,6 +452,43 @@ static void unreg_advertising_reply(struct l_dbus_p=
roxy
>> *proxy, l_info("Unable to unregister ad interface");
>>  }
>>
>> +static void unreg_agent_setup(struct l_dbus_message *message, void
>> *user_data) +{
>> +     struct l_dbus_message_builder *builder;
>> +
>> +     builder =3D l_dbus_message_builder_new(message);
>> +
>> +     l_dbus_message_builder_append_basic(builder, 'o', AG_PATH);
>> +
>> +     l_dbus_message_builder_finalize(builder);
>> +     l_dbus_message_builder_destroy(builder);
>> +}
>> +
>> +static void unreg_agent_reply(struct l_dbus_proxy *proxy,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     if (l_dbus_message_is_error(result)) {
>> +             const char *name;
>> +
>> +             l_dbus_message_get_error(result, &name, NULL);
>> +
>> +             l_error("Failed to unregister agent %s (%s)",
>> +                                     l_dbus_proxy_get_path(proxy), name=
);
>> +             return;
>> +     }
>> +
>> +     if (!l_dbus_object_remove_interface(dbus, AG_PATH,
>> +                                             L_DBUS_INTERFACE_PROPERTIE=
S))
>> +             l_info("Unable to remove propety instance");
>> +     if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFACE))
>> +             l_info("Unable to remove agent instance");
>> +     if (!l_dbus_unregister_interface(dbus, AG_IFACE))
>> +             l_info("Unable to unregister agent interface");
>> +
>> +     ag.registered =3D false;
>> +}
>> +
>>  static void btp_gap_reset(uint8_t index, const void *param, uint16_t
>> length, void *user_data)
>>  {
>> @@ -458,6 +529,15 @@ static void btp_gap_reset(uint8_t index, const void
>> *param, uint16_t length, goto failed;
>>               }
>>
>> +     if (ag.registered)
>> +             if (!l_dbus_proxy_method_call(ag.proxy, "UnregisterAgent",
>> +                                                     unreg_agent_setup,
>> +                                                     unreg_agent_reply,
>> +                                                     NULL, NULL)) {
>> +                     status =3D BTP_ERROR_FAIL;
>> +                     goto failed;
>> +             }
>> +
>>       /* TODO for we assume all went well */
>>       btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET, index, 0, NULL);
>>       return;
>> @@ -1513,6 +1593,278 @@ failed:
>>       btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>>  }
>>
>> +static struct l_dbus_message *ag_release_call(struct l_dbus *dbus,
>> +                                             struct l_dbus_message *mes=
sage,
>> +                                             void *user_data)
>> +{
>> +     struct l_dbus_message *reply;
>> +
>> +     reply =3D l_dbus_message_new_method_return(message);
>> +     l_dbus_message_set_arguments(reply, "");
>> +
>> +     return reply;
>> +}
>> +
>> +static struct l_dbus_message *ag_request_passkey_call(struct l_dbus *db=
us,
>> +                                             struct l_dbus_message *mes=
sage,
>> +                                             void *user_data)
>> +{
>> +     struct btp_gap_passkey_req_ev ev;
>> +     struct btp_device *device;
>> +     struct btp_adapter *adapter;
>> +     const char *path, *str_addr, *str_addr_type;
>> +
>> +     l_dbus_message_get_arguments(message, "o", &path);
>> +
>> +     device =3D find_device_by_path(path);
>> +
>> +     if (!l_dbus_proxy_get_property(device->proxy, "Address", "s", &str=
_addr)
>> +             || !l_dbus_proxy_get_property(device->proxy, "AddressType"=
, "s",
>> +             &str_addr_type)) {
>> +             l_info("Cannot get device properties");
>> +
>> +             return NULL;
>> +     }
>> +
>> +     ev.address_type =3D strcmp(str_addr_type, "public") ?
>> +                                                     BTP_GAP_ADDR_RANDO=
M :
>> +                                                     BTP_GAP_ADDR_PUBLI=
C;
>> +     if (!str2ba(str_addr, &ev.address))
>> +             return NULL;
>> +
>> +     adapter =3D find_adapter_by_device(device);
>> +
>> +     ag.pending_req =3D l_dbus_message_ref(message);
>> +
>> +     btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_PASSKEY_REQUEST,
>> +                                     adapter->index, sizeof(ev), &ev);
>> +
>> +     return NULL;
>> +}
>> +
>> +static struct l_dbus_message *ag_display_passkey_call(struct l_dbus *db=
us,
>> +                                             struct l_dbus_message *mes=
sage,
>> +                                             void *user_data)
>> +{
>> +     struct l_dbus_message *reply;
>> +
>> +     reply =3D l_dbus_message_new_method_return(message);
>> +     l_dbus_message_set_arguments(reply, "");
>> +
>> +     return reply;
>> +}
>> +
>> +static struct l_dbus_message *ag_request_confirmation_call(struct l_dbu=
s
>> *dbus, +                                              struct l_dbus_mess=
age *message,
>> +                                             void *user_data)
>> +{
>> +     struct l_dbus_message *reply;
>> +
>> +     reply =3D l_dbus_message_new_method_return(message);
>> +     l_dbus_message_set_arguments(reply, "");
>> +
>> +     return reply;
>> +}
>> +
>> +static struct l_dbus_message *ag_authorize_service_call(struct l_dbus
>> *dbus, +                                              struct l_dbus_mess=
age *message,
>> +                                             void *user_data)
>> +{
>> +     struct l_dbus_message *reply;
>> +
>> +     reply =3D l_dbus_message_new_method_return(message);
>> +     l_dbus_message_set_arguments(reply, "");
>> +
>> +     return reply;
>> +}
>> +
>> +static struct l_dbus_message *ag_cancel_call(struct l_dbus *dbus,
>> +                                             struct l_dbus_message *mes=
sage,
>> +                                             void *user_data)
>> +{
>> +     struct l_dbus_message *reply;
>> +
>> +     reply =3D l_dbus_message_new_method_return(message);
>> +     l_dbus_message_set_arguments(reply, "");
>> +
>> +     return reply;
>> +}
>> +
>> +static void setup_ag_interface(struct l_dbus_interface *iface)
>> +{
>> +     l_dbus_interface_method(iface, "Release", 0, ag_release_call, "", =
"");
>> +     l_dbus_interface_method(iface, "RequestPasskey", 0,
>> +                                     ag_request_passkey_call, "u", "o",
>> +                                     "passkey", "device");
>> +     l_dbus_interface_method(iface, "DisplayPasskey", 0,
>> +                                     ag_display_passkey_call, "", "ouq"=
,
>> +                                     "device", "passkey", "entered");
>> +     l_dbus_interface_method(iface, "RequestConfirmation", 0,
>> +                                     ag_request_confirmation_call, "", =
"ou",
>> +                                     "device", "passkey");
>> +     l_dbus_interface_method(iface, "RequestAuthorization", 0,
>> +                                     ag_request_confirmation_call, "", =
"o",
>> +                                     "device");
>> +     l_dbus_interface_method(iface, "AuthorizeService", 0,
>> +                                     ag_authorize_service_call, "", "os=
",
>> +                                     "device", "uuid");
>> +     l_dbus_interface_method(iface, "Cancel", 0, ag_cancel_call, "", ""=
);
>> +}
>> +
>> +struct set_io_capabilities_data {
>> +     uint8_t capa;
>> +     struct btp_adapter *adapter;
>> +};
>> +
>> +static void set_io_capabilities_setup(struct l_dbus_message *message,
>> +                                                             void *user=
_data)
>> +{
>> +     struct set_io_capabilities_data *sicd =3D user_data;
>> +     struct l_dbus_message_builder *builder;
>> +     char *capa_str;
>> +
>> +     builder =3D l_dbus_message_builder_new(message);
>> +
>> +     l_dbus_message_builder_append_basic(builder, 'o', AG_PATH);
>> +
>> +     switch (sicd->capa) {
>> +     case BTP_GAP_IOCAPA_DISPLAY_ONLY:
>> +             capa_str =3D "DisplayOnly";
>> +             break;
>> +     case BTP_GAP_IOCAPA_DISPLAY_YESNO:
>> +             capa_str =3D "DisplayYesNo";
>> +             break;
>> +     case BTP_GAP_IOCAPA_KEYBOARD_ONLY:
>> +             capa_str =3D "KeyboardOnly";
>> +             break;
>> +     case BTP_GAP_IOCAPA_NO_INPUT_NO_OUTPUT:
>> +             capa_str =3D "NoInputNoOutput";
>> +             break;
>> +     case BTP_GAP_IOCAPA_KEYBOARD_DISPLAY:
>> +             capa_str =3D "KeyboardDisplay";
>> +             break;
>> +     default:
>> +             l_error("Wrong iocapa given!");
>> +             l_dbus_message_builder_finalize(builder);
>> +             l_dbus_message_builder_destroy(builder);
>> +
>> +             return;
>> +     }
>
> setup callback should only build message, not verify parameters as it ret=
urns
> void. Please check those in btp_gap_set_io_capabilities().
Ok.
>
>> +
>> +     l_dbus_message_builder_append_basic(builder, 's', capa_str);
>> +
>> +     l_dbus_message_builder_finalize(builder);
>> +     l_dbus_message_builder_destroy(builder);
>> +}
>> +
>> +static void set_io_capabilities_reply(struct l_dbus_proxy *proxy,
>> +                                             struct l_dbus_message *res=
ult,
>> +                                             void *user_data)
>> +{
>> +     struct set_io_capabilities_data *sicd =3D user_data;
>> +
>> +     if (!sicd->adapter) {
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
>> +             if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFAC=
E))
>> +                     l_info("Unable to remove agent instance");
>> +             if (!l_dbus_unregister_interface(dbus, AG_IFACE))
>> +                     l_info("Unable to unregister agent interface");
>> +
>> +             l_dbus_message_get_error(result, &name, &desc);
>> +             l_error("Failed to set io capabilities (%s), %s", name, de=
sc);
>> +
>> +             btp_send_error(btp, BTP_GAP_SERVICE, sicd->adapter->index,
>> +                                                             BTP_ERROR_=
FAIL);
>> +             return;
>> +     }
>> +
>> +     ag.registered =3D true;
>> +
>> +     btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_IO_CAPA,
>> +                                             sicd->adapter->index, 0, N=
ULL);
>> +}
>> +
>> +static void set_io_capabilities_destroy(void *user_data)
>> +{
>> +     l_free(user_data);
>> +}
>> +
>> +static void btp_gap_set_io_capabilities(uint8_t index, const void *para=
m,
>> +                                     uint16_t length, void *user_data)
>> +{
>> +     struct btp_adapter *adapter =3D find_adapter_by_index(index);
>> +     const struct btp_gap_set_io_capa_cp *cp =3D param;
>> +     uint8_t status =3D BTP_ERROR_FAIL;
>> +     struct set_io_capabilities_data *data;
>> +     bool prop;
>> +
>> +     if (!adapter) {
>> +             status =3D BTP_ERROR_INVALID_INDEX;
>> +             goto failed;
>> +     }
>> +
>> +     /* Adapter needs to be powered to be able to set io cap */
>> +     if (!l_dbus_proxy_get_property(adapter->proxy, "Powered", "b", &pr=
op) ||
>> +                                                     !prop || ag.regist=
ered)
>> +             goto failed;
>> +
>> +     if (!l_dbus_register_interface(dbus, AG_IFACE, setup_ag_interface,=
 NULL,
>> +                                                             false)) {
>> +             l_info("Unable to register agent interface");
>> +             goto failed;
>> +     }
>> +
>> +     if (!l_dbus_object_add_interface(dbus, AG_PATH, AG_IFACE, NULL)) {
>> +             l_info("Unable to instantiate agent interface");
>> +
>> +             if (!l_dbus_unregister_interface(dbus, AD_IFACE))
>> +                     l_info("Unable to unregister agent interface");
>> +
>> +             goto failed;
>> +     }
>> +
>> +     if (!l_dbus_object_add_interface(dbus, AG_PATH,
>> +                                             L_DBUS_INTERFACE_PROPERTIE=
S,
>> +                                             NULL)) {
>> +             l_info("Unable to instantiate the ag properties interface"=
);
>> +
>> +             if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFAC=
E))
>> +                     l_info("Unable to remove agent instance");
>> +             if (!l_dbus_unregister_interface(dbus, AG_IFACE))
>> +                     l_info("Unable to unregister agent interface");
>> +
>> +             goto failed;
>> +     }
>> +
>> +     data =3D l_new(struct set_io_capabilities_data, 1);
>> +     data->adapter =3D adapter;
>> +     data->capa =3D cp->capa;
>> +
>> +     if (!l_dbus_proxy_method_call(ag.proxy, "RegisterAgent",
>> +                                             set_io_capabilities_setup,
>> +                                             set_io_capabilities_reply,=
 data,
>> +                                             set_io_capabilities_destro=
y)) {
>> +             if (!l_dbus_object_remove_interface(dbus, AG_PATH, AG_IFAC=
E))
>> +                     l_info("Unable to remove agent instance");
>> +             if (!l_dbus_unregister_interface(dbus, AG_IFACE))
>> +                     l_info("Unable to unregister agent interface");
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
>>  static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
>>  {
>>       struct btp_device_found_ev ev;
>> @@ -1634,6 +1986,9 @@ static void register_gap_service(void)
>>
>>       btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_DISCONNECT,
>>                                               btp_gap_disconnect, NULL, =
NULL);
>> +
>> +     btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_IO_CAPA,
>> +                             btp_gap_set_io_capabilities, NULL, NULL);
>>  }
>>
>>  static void btp_core_read_commands(uint8_t index, const void *param,
>> @@ -1889,6 +2244,12 @@ static void proxy_added(struct l_dbus_proxy *prox=
y,
>> void *user_data)
>>
>>               return;
>>       }
>> +
>> +     if (!strcmp(interface, "org.bluez.AgentManager1")) {
>> +             ag.proxy =3D proxy;
>> +
>> +             return;
>> +     }
>>  }
>>
>>  static bool device_match_by_proxy(const void *a, const void *b)
>
> More general comment. We should register default agent on startup so that
> system agent is never used when btpclient is running. When this command i=
s
> called and iocapa is differrent than currently used we should unregister
> current agent and register new default.
Agree
>
>
> --
> pozdrawiam
> Szymon Janc
>
>

pozdrawiam,
Grzegorz Ko=C5=82odziejczyk
