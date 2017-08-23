Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL9_VbMEm5ghwpq6OSpjEwm4U_RXc_ULGy==BK_RsuP7Q@mail.gmail.com>
References: <20170823085125.56361-1-yunhanw@google.com> <CABBYNZL9_VbMEm5ghwpq6OSpjEwm4U_RXc_ULGy==BK_RsuP7Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Aug 2017 12:20:25 +0300
Message-ID: <CABBYNZKSXXG4mwbSvLqbTP=bZurZGrGb2wnsX8BChgTY13H5tw@mail.gmail.com>
Subject: Re: [PATCH v2] gatt: Add implementation for Gatt method, Confirm
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Wed, Aug 23, 2017 at 12:18 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Yunhan,
>
> On Wed, Aug 23, 2017 at 11:51 AM, Yunhan Wang <yunhanw@google.com> wrote:
>> ---
>>  doc/gatt-api.txt    |  7 +++++++
>>  src/gatt-client.c   |  9 +++++++++
>>  src/gatt-database.c | 16 ++++++++++++----
>>  3 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
>> index c0ad1de25..42b1f55aa 100644
>> --- a/doc/gatt-api.txt
>> +++ b/doc/gatt-api.txt
>> @@ -162,6 +162,13 @@ Methods            array{byte} ReadValue(dict options)
>>
>>                         Possible Errors: org.bluez.Error.Failed
>>
>> +               void Confirm()
>> +
>> +                       This method doesn't expect a reply so it is just a
>> +                       confirmation that value was received.
>
> Documentation should go in a separate patch, make Confirm optional and
> server only.
>
>> +                       Possible Errors: org.bluez.Error.Failed
>> +
>>  Properties     string UUID [read-only]
>>
>>                         128-bit characteristic UUID.
>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>> index 1cd7fbcf5..808d3da1d 100644
>> --- a/src/gatt-client.c
>> +++ b/src/gatt-client.c
>> @@ -1598,6 +1598,13 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
>>         return dbus_message_new_method_return(msg);
>>  }
>>
>> +static DBusMessage *characteristic_indication_conf(DBusConnection *conn,
>> +                                       DBusMessage *msg, void *user_data)
>> +{
>> +       DBG("indication conf received");
>> +       return dbus_message_new_method_return(msg);
>> +}
>> +
>>  static const GDBusPropertyTable characteristic_properties[] = {
>>         { "UUID", "s", characteristic_get_uuid, NULL, NULL },
>>         { "Service", "o", characteristic_get_service, NULL, NULL },
>> @@ -1635,6 +1642,8 @@ static const GDBusMethodTable characteristic_methods[] = {
>>                                         characteristic_start_notify) },
>>         { GDBUS_METHOD("StopNotify", NULL, NULL,
>>                                         characteristic_stop_notify) },
>> +       { GDBUS_METHOD("Confirm", NULL, NULL,
>> +                                  characteristic_indication_conf) },
>
> Lets make this server only so we don't need to define a methods that
> does nothing.
>
>>         { }
>>  };
>>
>> diff --git a/src/gatt-database.c b/src/gatt-database.c
>> index 3b4bc7c8d..0969f8d1f 100644
>> --- a/src/gatt-database.c
>> +++ b/src/gatt-database.c
>> @@ -867,11 +867,18 @@ struct notify {
>>         const uint8_t *value;
>>         uint16_t len;
>>         bool indicate;
>> +       GDBusProxy *proxy;
>>  };
>>
>>  static void conf_cb(void *user_data)
>>  {
>> +       GDBusProxy *proxy = user_data;
>>         DBG("GATT server received confirmation");
>> +
>> +       if (proxy != NULL)
>> +       {
>> +               g_dbus_proxy_method_call(proxy, "IndicationConf", NULL, NULL, NULL, NULL);
>> +       }
>>  }
>>
>>  static void send_notification_to_device(void *data, void *user_data)
>> @@ -917,7 +924,7 @@ static void send_notification_to_device(void *data, void *user_data)
>>         DBG("GATT server sending indication");
>>         bt_gatt_server_send_indication(server, notify->handle, notify->value,
>>                                                         notify->len, conf_cb,
>> -                                                       NULL, NULL);
>> +                                                       notify->proxy, NULL);
>>
>>         return;
>>
>> @@ -930,7 +937,7 @@ remove:
>>  static void send_notification_to_devices(struct btd_gatt_database *database,
>>                                         uint16_t handle, const uint8_t *value,
>>                                         uint16_t len, uint16_t ccc_handle,
>> -                                       bool indicate)
>> +                                       bool indicate, GDBusProxy *proxy)
>>  {
>>         struct notify notify;
>>
>> @@ -942,6 +949,7 @@ static void send_notification_to_devices(struct btd_gatt_database *database,
>>         notify.value = value;
>>         notify.len = len;
>>         notify.indicate = indicate;
>> +       notify.proxy = proxy;
>>
>>         queue_foreach(database->device_states, send_notification_to_device,
>>                                                                 &notify);
>> @@ -972,7 +980,7 @@ static void send_service_changed(struct btd_gatt_database *database,
>>         put_le16(end, value + 2);
>>
>>         send_notification_to_devices(database, handle, value, sizeof(value),
>> -                                                       ccc_handle, true);
>> +                                                       ccc_handle, true, NULL);
>>  }
>>
>>  static void gatt_db_service_added(struct gatt_db_attribute *attrib,
>> @@ -1861,7 +1869,7 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
>>                                 gatt_db_attribute_get_handle(chrc->attrib),
>>                                 value, len,
>>                                 gatt_db_attribute_get_handle(chrc->ccc),
>> -                               chrc->props & BT_GATT_CHRC_PROP_INDICATE);
>> +                               chrc->props & BT_GATT_CHRC_PROP_INDICATE, proxy);
>>  }
>>
>>  static bool database_add_ccc(struct external_service *service,
>> --
>> 2.14.1.480.gb18f417b89-goog

Btw, please add a patch to bluetoothctl implementing the Confirm so we
are able to see the confirmations while using it.

-- 
Luiz Augusto von Dentz
