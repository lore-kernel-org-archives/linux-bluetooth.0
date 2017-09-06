Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
References: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com> <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Sep 2017 16:01:00 +0300
Message-ID: <CABBYNZLfbhXfEsb=DY-1mzQdiZVmJ9Ka3GjdGiGYgoaqKhkB+A@mail.gmail.com>
Subject: Re: [PATCH v2] gatt-server: Implement NegotiatedMTU property on Device1
To: Emil Lenngren <emil.lenngren@gmail.com>
Cc: Jonah Petri <jonah@sense.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Emil,

On Wed, Sep 6, 2017 at 3:17 PM, Emil Lenngren <emil.lenngren@gmail.com> wro=
te:
> Hi,
>
> 2017-09-06 13:20 GMT+02:00 Jonah Petri <jonah@sense.com>:
>> [Resending this patch, as I didn=E2=80=99t see any replies in the past m=
onth or so=E2=80=A6]
>>
>> It can be useful for programs using GATT to be aware of the maximum
>> transmittable attribute size, as negotiated by bluetoothd.  This change
>> exposes the negotiated size over D-Bus, if such a negotiation has
>> occurred.
>> ---
>> attrib/gattrib.c         |  6 +++++-
>> doc/device-api.txt       | 11 +++++++++++
>> src/device.c             | 41 +++++++++++++++++++++++++++++++++++++++++
>> src/shared/att.c         | 15 +++++++++++++++
>> src/shared/gatt-server.c |  1 +
>> src/shared/gatt-server.h |  3 +++
>> 6 files changed, 76 insertions(+), 1 deletion(-)
>>
>> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
>> index 2e1e39a..f080b6b 100644
>> --- a/attrib/gattrib.c
>> +++ b/attrib/gattrib.c
>> @@ -468,7 +468,11 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
>>
>>         attrib->buflen =3D mtu;
>>
>> -       return bt_att_set_mtu(attrib->att, mtu);
>> +       if (bt_att_set_mtu(attrib->att, mtu)) {
>> +               bt_att_set_mtu_negotiated(attrib->att, true);
>> +               return true;
>> +       } else
>> +               return false;
>> }
>>
>> gboolean g_attrib_unregister(GAttrib *attrib, guint id)
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index 13b2881..fc04011 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -234,3 +234,14 @@ Properties string Address [readonly]
>>                 array{byte} AdvertisingFlags [readonly, experimental]
>>
>>                         The Advertising Data Flags of the remote device.
>> +
>> +               int16 NegotiatedMaxAttributeSize [readonly,
>> +                                                 optional,
>> +                                                 experimental]
>> +
>> +                       The maximum supported byte size of attributes, a=
s
>> +                       negotiated between this host and the remote devi=
ce.
>> +                       This attribute is only available once the negoti=
ation
>> +                       is complete.  If the attribute is not available,
>> +                       clients should assume the default maximum size f=
or
>> +                       the underlying technology, e.g. 20 bytes for BTL=
E.
>> diff --git a/src/device.c b/src/device.c
>> index 8693eb8..cd3983b 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -92,6 +92,8 @@
>> #define GATT_INCLUDE_UUID_STR "2802"
>> #define GATT_CHARAC_UUID_STR "2803"
>>
>> +#define ATT_PACKET_HEADER_SIZE 3
>> +
>> static DBusConnection *dbus_conn =3D NULL;
>> static unsigned service_state_cb_id;
>>
>> @@ -930,6 +932,41 @@ static gboolean dev_property_exists_tx_power(const =
GDBusPropertyTable *property,
>>         return TRUE;
>> }
>>
>> +static gboolean dev_property_get_negotiated_max_att_payload(
>> +                                       const GDBusPropertyTable * prope=
rty,
>> +                                       DBusMessageIter *iter, void *dat=
a)
>> +{
>> +       const struct btd_device *dev =3D data;
>> +       dbus_int16_t val =3D 0;
>> +       int err;
>> +
>> +       /* The spec for this API requires a failure if
>> +        * MTU negotiation is incomplete.
>> +        */
>> +       if (!bt_att_is_mtu_negotiated(dev->att))
>> +               return FALSE;
>> +
>> +       val =3D bt_att_get_mtu(dev->att);
>> +       // subtract off the ATT header length to get the max payload
>> +       val -=3D ATT_PACKET_HEADER_SIZE;
>> +
>> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
>> +
>> +       return TRUE;
>> +}
>> +
>> +static gboolean dev_property_exists_negotiated_max_att_payload(
>> +                                       const GDBusPropertyTable * prope=
rty,
>> +                                       void *data)
>> +{
>> +       const struct btd_device *dev =3D data;
>> +
>> +       /* The spec for this API requires the property
>> +        * be absent until MTU negotiation is incomplete.
>> +        */
>> +       return bt_att_is_mtu_negotiated(dev->att);
>> +}
>> +
>> static gboolean
>> dev_property_get_svc_resolved(const GDBusPropertyTable *property,
>>                                         DBusMessageIter *iter, void *dat=
a)
>> @@ -2561,6 +2598,10 @@ static const GDBusPropertyTable device_properties=
[] =3D {
>>                                 NULL, dev_property_service_data_exist },
>>         { "TxPower", "n", dev_property_get_tx_power, NULL,
>>                                         dev_property_exists_tx_power },
>> +       { "NegotiatedMaxAttributeSize", "n",
>> +                                       dev_property_get_negotiated_max_=
att_payload,
>> +                                       NULL, dev_property_exists_negoti=
ated_max_att_payload,
>> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTA=
L },
>>         { "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, =
NULL },
>>         { "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
>>                                         dev_property_flags_exist,
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index ca2d051..bf20a01 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -70,6 +70,7 @@ struct bt_att {
>>
>>         uint8_t *buf;
>>         uint16_t mtu;
>> +       bool mtu_negotiated;
>>
>>         unsigned int next_send_id;      /* IDs for "send" ops */
>>         unsigned int next_reg_id;       /* IDs for registered callbacks =
*/
>> @@ -1100,6 +1101,20 @@ bool bt_att_set_debug(struct bt_att *att, bt_att_=
debug_func_t callback,
>>         return true;
>> }
>>
>> +bool bt_att_is_mtu_negotiated(struct bt_att *att)
>> +{
>> +       if (!att)
>> +               return false;
>> +
>> +       return att->mtu_negotiated;
>> +}
>> +
>> +void bt_att_set_mtu_negotiated(struct bt_att *att, bool negotiated)
>> +{
>> +       if (att && !att->mtu_negotiated)
>> +               att->mtu_negotiated =3D negotiated;

Over BR/EDR it shall be possible to change the MTU at any given time
as it doesn't use Exchange MTU procedure its rules don't apply to
L2CAP Config.

>> +}
>> +
>> uint16_t bt_att_get_mtu(struct bt_att *att)
>> {
>>         if (!att)
>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
>> index 79e01c8..c76ca23 100644
>> --- a/src/shared/gatt-server.c
>> +++ b/src/shared/gatt-server.c
>> @@ -1379,6 +1379,7 @@ static void exchange_mtu_cb(uint8_t opcode, const =
void *pdu,
>>         /* Set MTU to be the minimum */
>>         server->mtu =3D final_mtu;
>>         bt_att_set_mtu(server->att, final_mtu);
>> +       bt_att_set_mtu_negotiated(server->att, true);

This doesn't seem to even care about BR/EDR which doesn't use this callback=
.

>>         util_debug(server->debug_callback, server->debug_data,
>>                         "MTU exchange complete, with MTU: %u", final_mtu=
);
>> diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
>> index 0e480e1..0b99da5 100644
>> --- a/src/shared/gatt-server.h
>> +++ b/src/shared/gatt-server.h
>> @@ -31,6 +31,9 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_=
db *db,
>> struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server)=
;
>> void bt_gatt_server_unref(struct bt_gatt_server *server);
>>
>> +int bt_gatt_server_get_negotiated_mtu(const struct bt_gatt_server *serv=
er,
>> +                                       int16_t *mtu);
>> +

I think we better add a callback to att.h which gets called whenever
the MTU changes.

>> typedef void (*bt_gatt_server_destroy_func_t)(void *user_data);
>> typedef void (*bt_gatt_server_debug_func_t)(const char *str, void *user_=
data);
>> typedef void (*bt_gatt_server_conf_func_t)(void *user_data);
>> --
>> 2.10.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> I know there were some discussions regarding if it should be called
> max attribute size or mtu.
> Maybe I'm a bit late but in my opinion I think mtu is a better option.
>
> "The maximum supported byte size of attributes, as negotiated between
> this host and the remote device" is a bit misleading/wrong since the
> BLE spec allows up to 512 byte attribute values no matter of the MTU.

Note that the MTU can be in fact even bigger than 512 bytes since it
can be used by things like discover, etc, which is not bound to a
single attribute, though for practical reasons BlueZ will always
request 512 bytes since buffer size is usually not a concern in
systems running Linux.

> You can still perform a Long Write where the attribute value is larger
> than the MTU for example.
> Also, the max value size for transfer is different depending on
> method. Max value size for a notification/indication or normal write
> is ATT_MTU-3 while max value size for a normal read is ATT_MTU-1.

Yep, we can't really use the same value for read/write since the
actual payload changes depending on the opcode.

> With the current patch it's not clear (by only looking at the
> documentation) which value "max attribute size" really means. If it's
> called MTU it's on the other hand very clear what it is (like it is
> called in Android's implementation). Even if there is a difference
> between BD/EDR and LE MTU negotiation, the packet format for ATT and
> the meaning of MTU is still the same.

The fundamental part missing here is that over BR/EDR the MTU can be
asymmetric meaning we need the MTU value for input and output to be
separated.

>
> /Emil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
