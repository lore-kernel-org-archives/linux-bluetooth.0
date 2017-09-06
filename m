Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com>
References: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com>
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Wed, 6 Sep 2017 14:17:40 +0200
Message-ID: <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
Subject: Re: [PATCH v2] gatt-server: Implement NegotiatedMTU property on Device1
To: Jonah Petri <jonah@sense.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2017-09-06 13:20 GMT+02:00 Jonah Petri <jonah@sense.com>:
> [Resending this patch, as I didn=E2=80=99t see any replies in the past mo=
nth or so=E2=80=A6]
>
> It can be useful for programs using GATT to be aware of the maximum
> transmittable attribute size, as negotiated by bluetoothd.  This change
> exposes the negotiated size over D-Bus, if such a negotiation has
> occurred.
> ---
> attrib/gattrib.c         |  6 +++++-
> doc/device-api.txt       | 11 +++++++++++
> src/device.c             | 41 +++++++++++++++++++++++++++++++++++++++++
> src/shared/att.c         | 15 +++++++++++++++
> src/shared/gatt-server.c |  1 +
> src/shared/gatt-server.h |  3 +++
> 6 files changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> index 2e1e39a..f080b6b 100644
> --- a/attrib/gattrib.c
> +++ b/attrib/gattrib.c
> @@ -468,7 +468,11 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
>
>         attrib->buflen =3D mtu;
>
> -       return bt_att_set_mtu(attrib->att, mtu);
> +       if (bt_att_set_mtu(attrib->att, mtu)) {
> +               bt_att_set_mtu_negotiated(attrib->att, true);
> +               return true;
> +       } else
> +               return false;
> }
>
> gboolean g_attrib_unregister(GAttrib *attrib, guint id)
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 13b2881..fc04011 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -234,3 +234,14 @@ Properties string Address [readonly]
>                 array{byte} AdvertisingFlags [readonly, experimental]
>
>                         The Advertising Data Flags of the remote device.
> +
> +               int16 NegotiatedMaxAttributeSize [readonly,
> +                                                 optional,
> +                                                 experimental]
> +
> +                       The maximum supported byte size of attributes, as
> +                       negotiated between this host and the remote devic=
e.
> +                       This attribute is only available once the negotia=
tion
> +                       is complete.  If the attribute is not available,
> +                       clients should assume the default maximum size fo=
r
> +                       the underlying technology, e.g. 20 bytes for BTLE=
.
> diff --git a/src/device.c b/src/device.c
> index 8693eb8..cd3983b 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -92,6 +92,8 @@
> #define GATT_INCLUDE_UUID_STR "2802"
> #define GATT_CHARAC_UUID_STR "2803"
>
> +#define ATT_PACKET_HEADER_SIZE 3
> +
> static DBusConnection *dbus_conn =3D NULL;
> static unsigned service_state_cb_id;
>
> @@ -930,6 +932,41 @@ static gboolean dev_property_exists_tx_power(const G=
DBusPropertyTable *property,
>         return TRUE;
> }
>
> +static gboolean dev_property_get_negotiated_max_att_payload(
> +                                       const GDBusPropertyTable * proper=
ty,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       const struct btd_device *dev =3D data;
> +       dbus_int16_t val =3D 0;
> +       int err;
> +
> +       /* The spec for this API requires a failure if
> +        * MTU negotiation is incomplete.
> +        */
> +       if (!bt_att_is_mtu_negotiated(dev->att))
> +               return FALSE;
> +
> +       val =3D bt_att_get_mtu(dev->att);
> +       // subtract off the ATT header length to get the max payload
> +       val -=3D ATT_PACKET_HEADER_SIZE;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
> +
> +       return TRUE;
> +}
> +
> +static gboolean dev_property_exists_negotiated_max_att_payload(
> +                                       const GDBusPropertyTable * proper=
ty,
> +                                       void *data)
> +{
> +       const struct btd_device *dev =3D data;
> +
> +       /* The spec for this API requires the property
> +        * be absent until MTU negotiation is incomplete.
> +        */
> +       return bt_att_is_mtu_negotiated(dev->att);
> +}
> +
> static gboolean
> dev_property_get_svc_resolved(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data=
)
> @@ -2561,6 +2598,10 @@ static const GDBusPropertyTable device_properties[=
] =3D {
>                                 NULL, dev_property_service_data_exist },
>         { "TxPower", "n", dev_property_get_tx_power, NULL,
>                                         dev_property_exists_tx_power },
> +       { "NegotiatedMaxAttributeSize", "n",
> +                                       dev_property_get_negotiated_max_a=
tt_payload,
> +                                       NULL, dev_property_exists_negotia=
ted_max_att_payload,
> +                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL=
 },
>         { "ServicesResolved", "b", dev_property_get_svc_resolved, NULL, N=
ULL },
>         { "AdvertisingFlags", "ay", dev_property_get_flags, NULL,
>                                         dev_property_flags_exist,
> diff --git a/src/shared/att.c b/src/shared/att.c
> index ca2d051..bf20a01 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -70,6 +70,7 @@ struct bt_att {
>
>         uint8_t *buf;
>         uint16_t mtu;
> +       bool mtu_negotiated;
>
>         unsigned int next_send_id;      /* IDs for "send" ops */
>         unsigned int next_reg_id;       /* IDs for registered callbacks *=
/
> @@ -1100,6 +1101,20 @@ bool bt_att_set_debug(struct bt_att *att, bt_att_d=
ebug_func_t callback,
>         return true;
> }
>
> +bool bt_att_is_mtu_negotiated(struct bt_att *att)
> +{
> +       if (!att)
> +               return false;
> +
> +       return att->mtu_negotiated;
> +}
> +
> +void bt_att_set_mtu_negotiated(struct bt_att *att, bool negotiated)
> +{
> +       if (att && !att->mtu_negotiated)
> +               att->mtu_negotiated =3D negotiated;
> +}
> +
> uint16_t bt_att_get_mtu(struct bt_att *att)
> {
>         if (!att)
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 79e01c8..c76ca23 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1379,6 +1379,7 @@ static void exchange_mtu_cb(uint8_t opcode, const v=
oid *pdu,
>         /* Set MTU to be the minimum */
>         server->mtu =3D final_mtu;
>         bt_att_set_mtu(server->att, final_mtu);
> +       bt_att_set_mtu_negotiated(server->att, true);
>
>         util_debug(server->debug_callback, server->debug_data,
>                         "MTU exchange complete, with MTU: %u", final_mtu)=
;
> diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
> index 0e480e1..0b99da5 100644
> --- a/src/shared/gatt-server.h
> +++ b/src/shared/gatt-server.h
> @@ -31,6 +31,9 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_d=
b *db,
> struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server);
> void bt_gatt_server_unref(struct bt_gatt_server *server);
>
> +int bt_gatt_server_get_negotiated_mtu(const struct bt_gatt_server *serve=
r,
> +                                       int16_t *mtu);
> +
> typedef void (*bt_gatt_server_destroy_func_t)(void *user_data);
> typedef void (*bt_gatt_server_debug_func_t)(const char *str, void *user_d=
ata);
> typedef void (*bt_gatt_server_conf_func_t)(void *user_data);
> --
> 2.10.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


I know there were some discussions regarding if it should be called
max attribute size or mtu.
Maybe I'm a bit late but in my opinion I think mtu is a better option.

"The maximum supported byte size of attributes, as negotiated between
this host and the remote device" is a bit misleading/wrong since the
BLE spec allows up to 512 byte attribute values no matter of the MTU.
You can still perform a Long Write where the attribute value is larger
than the MTU for example.
Also, the max value size for transfer is different depending on
method. Max value size for a notification/indication or normal write
is ATT_MTU-3 while max value size for a normal read is ATT_MTU-1.

With the current patch it's not clear (by only looking at the
documentation) which value "max attribute size" really means. If it's
called MTU it's on the other hand very clear what it is (like it is
called in Android's implementation). Even if there is a difference
between BD/EDR and LE MTU negotiation, the packet format for ATT and
the meaning of MTU is still the same.

/Emil
