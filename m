Return-Path: <cyrus@holtmann.org>
Message-ID: <5022012E.80303@ti.com>
Date: Wed, 8 Aug 2012 09:03:26 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] Battery: Add support for notifications
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com> <1343194947-13659-9-git-send-email-chen.ganir@ti.com> <CAAngNMaAeeUS4Os7xWvN4AAmpdYns2o4v3+9Fxjy3ZRrC72TGA@mail.gmail.com>
In-Reply-To: <CAAngNMaAeeUS4Os7xWvN4AAmpdYns2o4v3+9Fxjy3ZRrC72TGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Joao,

On 08/07/2012 07:29 PM, Joao Paulo Rechi Vita wrote:
> On Wed, Jul 25, 2012 at 2:42 AM, Chen Ganir <chen.ganir@ti.com> wrote:
>> Add support for emitting PropertyChanged when a battery level
>> characteristic notification is sent from the peer device.
>> ---
>>   doc/battery-api.txt                  |    5 ++
>>   profiles/batterystate/batterystate.c |  107 +++++++++++++++++++++++++++++++++-
>>   2 files changed, 111 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/battery-api.txt b/doc/battery-api.txt
>> index 5d7510d..f31e7e5 100644
>> --- a/doc/battery-api.txt
>> +++ b/doc/battery-api.txt
>> @@ -16,6 +16,11 @@ Methods      dict GetProperties()
>>                          Returns all properties for the interface. See the
>>                          Properties section for the available properties.
>>
>> +Signals                PropertyChanged(string name, variant value)
>> +
>> +               This signal indicates a changed value of the given
>> +               property.
>> +
>>   Properties     byte Namespace [readonly]
>>
>>                          Namespace value from the battery format characteristic
>> diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
>> index e5b68a9..718863b 100644
>> --- a/profiles/batterystate/batterystate.c
>> +++ b/profiles/batterystate/batterystate.c
>> @@ -50,6 +50,7 @@ struct battery {
>>          GAttrib                 *attrib;        /* GATT connection */
>>          guint                   attioid;        /* Att watcher id */
>>          struct att_range        *svc_range;     /* Battery range */
>> +       guint                   attnotid;       /* Att notifications id */
>>          GSList                  *chars;         /* Characteristics */
>>   };
>>
>> @@ -104,6 +105,14 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
>>          return -1;
>>   }
>>
>> +static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
>> +{
>> +       const struct characteristic *ch = a;
>> +       const uint16_t *handle = b;
>> +
>> +       return ch->attr.value_handle - *handle;
>> +}
>> +
>>   static void batterystate_free(gpointer user_data)
>>   {
>>          struct battery *batt = user_data;
>> @@ -117,6 +126,10 @@ static void batterystate_free(gpointer user_data)
>>          if (batt->attrib != NULL)
>>                  g_attrib_unref(batt->attrib);
>>
>> +       if (batt->attrib != NULL) {
>> +               g_attrib_unregister(batt->attrib, batt->attnotid);
>> +               g_attrib_unref(batt->attrib);
>> +       }
>>
>>          dbus_connection_unref(batt->conn);
>>          btd_device_unref(batt->dev);
>> @@ -158,6 +171,17 @@ static void process_batteryservice_char(struct characteristic *ch)
>>          }
>>   }
>>
>> +static void batterylevel_enable_notify_cb(guint8 status, const guint8 *pdu,
>> +                                               guint16 len, gpointer user_data)
>> +{
>> +       char *msg = user_data;
>> +
>> +       if (status != 0)
>> +               error("Could not enable battery level notification: %s", msg);
>> +
>> +       g_free(msg);
>> +}
>> +
>>   static void batterylevel_presentation_format_desc_cb(guint8 status,
>>                                                  const guint8 *pdu, guint16 len,
>>                                                  gpointer user_data)
>> @@ -194,6 +218,23 @@ static void process_batterylevel_desc(struct descriptor *desc)
>>          char uuidstr[MAX_LEN_UUID_STR];
>>          bt_uuid_t btuuid;
>>
>> +       bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
>> +
>> +       if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0 && g_strcmp0(ch->attr.uuid,
>> +                                               BATTERY_LEVEL_UUID) == 0) {
>> +               uint8_t atval[2];
>> +               uint16_t val;
>> +               char *msg;
>> +
>> +               val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
>> +               msg = g_strdup("Enable BatteryLevel notification");
>> +
>
> What's the point of passing "Enable BatteryLevel notification" as
> user_data for the batterylevel_enable_notify_cb() ?
>
No point. just a leftover i need to remove.

>> +               att_put_u16(val, atval);
>> +               gatt_write_char(ch->batt->attrib, desc->handle, atval, 2,
>> +                                       batterylevel_enable_notify_cb, msg);
>> +               return;
>> +       }
>> +
>>          bt_uuid16_create(&btuuid, GATT_CHARAC_FMT_UUID);
>>
>>          if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
>> @@ -277,6 +318,12 @@ static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
>>          return reply;
>>   }
>>
>> +static void emit_battery_level_changed(struct characteristic *c)
>> +{
>> +       emit_property_changed(c->batt->conn, c->path, BATTERY_INTERFACE,
>> +                                       "Level", DBUS_TYPE_BYTE, &c->level);
>> +}
>> +
>>   static GDBusMethodTable battery_methods[] = {
>>          { GDBUS_METHOD("GetProperties",
>>                                  NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
>> @@ -284,6 +331,11 @@ static GDBusMethodTable battery_methods[] = {
>>          { }
>>   };
>>
>> +static GDBusSignalTable battery_signals[] = {
>> +       { GDBUS_SIGNAL("PropertyChanged",
>> +               GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
>> +       { }
>> +};
>>
>>   static void configure_batterystate_cb(GSList *characteristics, guint8 status,
>>                                                          gpointer user_data)
>> @@ -318,7 +370,7 @@ static void configure_batterystate_cb(GSList *characteristics, guint8 status,
>>
>>                          if (!g_dbus_register_interface(batt->conn, ch->path,
>>                                                  BATTERY_INTERFACE,
>> -                                               battery_methods, NULL, NULL,
>> +                                               battery_methods, battery_signals, NULL,
>>                                                  ch, NULL)) {
>>                                  error("D-Bus register interface %s failed",
>>                                                          BATTERY_INTERFACE);
>> @@ -346,12 +398,63 @@ static void configure_batterystate_cb(GSList *characteristics, guint8 status,
>>          }
>>   }
>>
>> +static void proc_batterylevel(struct characteristic *c, const uint8_t *pdu,
>> +                                               uint16_t len, gboolean final)
>> +{
>> +       uint8_t new_batt_level = 0;
>> +       gboolean changed = FALSE;
>> +
>> +       if (!pdu) {
>> +               error("Battery level notification: Invalid pdu length");
>> +               goto done;
>> +       }
>> +
>
> If pdu can be NULL here, than bluetoothd would have broken when
> derreferencing it at "handle = att_get_u16(&pdu[1]);" in
> notif_handler(). If pdu can be NULL the check needs to be done there.
>
I will modify that.

>> +       new_batt_level = pdu[1];
>> +
>> +       if (new_batt_level != c->level)
>> +               changed = TRUE;
>> +
>> +       c->level = new_batt_level;
>> +
>> +done:
>
> There is no need for the done label, since 'changed' is always false
> when you 'goto' here. You could simply return instead of using goto,
> although the whole if statement is likely to be dropped from this
> function.
>
This is assuming notifications arrive only when battery level has 
changed. I agree, and i will change that.

>> +       if (changed)
>> +               emit_battery_level_changed(c);
>> +}
>> +
>> +static void notif_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
>> +{
>> +       struct battery *batt = user_data;
>> +       struct characteristic *ch;
>> +       uint16_t handle;
>> +       GSList *l;
>> +
>
> ch->attr.uuid == BATTERY_LEVEL_UUID should be tested before anything
> else, since other profiles may have enabled notifications for other
> characteristics (hog does that, for example). When testing with hog
> devices I got "notif_handler: Unexpected handle 0x0017" for every
> input report received.
>
ch->attr.uuid is only valid later in the code, after i get the handle 
out of the PDU (need to make sure the PDU is in the correct length) , 
find the characteristic in the list (make sure it is not NULL), and set 
ch to l->data. I believe removing the error code will remove the 
annoyance, but i see no better way to extract the characteristic without 
making sure everything is valid.

>> +       if (len < 3) {
>> +               error("notif_handler: Bad pdu received");
>> +               return;
>> +       }
>> +
>> +       handle = att_get_u16(&pdu[1]);
>> +       l = g_slist_find_custom(batt->chars, &handle, cmp_char_val_handle);
>> +       if (l == NULL) {
>> +               error("notif_handler: Unexpected handle 0x%04x", handle);
>> +               return;
>> +       }
>> +
>> +       ch = l->data;
>> +       if (g_strcmp0(ch->attr.uuid, BATTERY_LEVEL_UUID) == 0) {
>> +               proc_batterylevel(ch, pdu, len, FALSE);
>> +       }
>> +}
>> +
>>   static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>>   {
>>          struct battery *batt = user_data;
>>
>>          batt->attrib = g_attrib_ref(attrib);
>>
>> +       batt->attnotid = g_attrib_register(batt->attrib, ATT_OP_HANDLE_NOTIFY,
>> +                                               notif_handler, batt, NULL);
>> +
>>          if (batt->chars == NULL) {
>>                  gatt_discover_char(batt->attrib, batt->svc_range->start,
>>                                          batt->svc_range->end, NULL,
>> @@ -369,6 +472,8 @@ static void attio_disconnected_cb(gpointer user_data)
>>   {
>>          struct battery *batt = user_data;
>>
>> +       g_attrib_unregister(batt->attrib, batt->attnotid);
>> +       batt->attnotid = 0;
>>          g_attrib_unref(batt->attrib);
>>          batt->attrib = NULL;
>>   }
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

Thanks,
Chen Ganir.

