Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs-cDRCAGToaJbxSGjc0k3GVTU8v65ZDf3nZZt+A5VFC7w@mail.gmail.com>
References: <20170823211610.88789-1-yunhanw@google.com> <CALvjcs-cDRCAGToaJbxSGjc0k3GVTU8v65ZDf3nZZt+A5VFC7w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Aug 2017 10:20:13 +0300
Message-ID: <CABBYNZLHeFEEiUatHWJOAhqoU1xG96X_fmLzmzKiRo3+Gky1iA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gatt: Add indication confirm callback using Gatt
 Confirm method
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Tue, Aug 29, 2017 at 6:24 AM, Yunhan Wang <yunhanw@google.com> wrote:
> Hi Luiz
>
> Could you help to take a further review?
>
> Thanks
> Best wishes
> Yunhan
>
> On Wed, Aug 23, 2017 at 2:16 PM, Yunhan Wang <yunhanw@google.com> wrote:
>> ---
>>  src/gatt-database.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
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

This one should be use "Confirm".

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
>> 2.14.1.342.g6490525c54-goog
>>



-- 
Luiz Augusto von Dentz
