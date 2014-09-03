Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK3ncG7-emSn=-k6caiZ-hq2obvTTrESkHudWy6tfvsxg@mail.gmail.com>
References: <1409727487-19074-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1409727487-19074-2-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZK3ncG7-emSn=-k6caiZ-hq2obvTTrESkHudWy6tfvsxg@mail.gmail.com>
Date: Wed, 3 Sep 2014 15:46:25 +0200
Message-ID: <CAMudyAtdxuQ2uoZa5PW6s-vJVPg2EbDW1W5QYN=g9TFk+mBKjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] android/gatt: Unsubscribe from autoconnect on unregister
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 3 September 2014 13:30, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, Sep 3, 2014 at 9:58 AM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> When application does unregister, lets make sure that BfA does not keep
>> any auto connect devices for this app.
>> ---
>>  android/gatt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index a3486ca..dea253e 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -370,6 +370,13 @@ static bool match_device_by_state(const void *data, const void *user_data)
>>         return true;
>>  }
>>
>> +static bool match_device_by_ac_id(const void *data, const void *user_data)
>> +{
>> +       const struct gatt_device *dev = data;
>> +
>> +       return queue_find(dev->autoconnect_apps, match_by_value, user_data);
>> +}
>> +
>>  static bool match_pending_device(const void *data, const void *user_data)
>>  {
>>         const struct gatt_device *dev = data;
>> @@ -442,6 +449,11 @@ static struct gatt_device *find_device_by_state(uint32_t state)
>>                                                         UINT_TO_PTR(state));
>>  }
>>
>> +static struct gatt_device *find_device_by_autoconnect_app_id(uint32_t id)
>> +{
>> +       return queue_find(gatt_devices, match_device_by_ac_id,
>> +                                                       UINT_TO_PTR(id));
>> +}
>>  static bool match_srvc_by_element_id(const void *data, const void *user_data)
>>  {
>>         const struct element_id *exp_id = user_data;
>> @@ -1865,10 +1877,41 @@ static bool trigger_connection(struct app_connection *connection)
>>         return ret;
>>  }
>>
>> +static void clear_autoconnect_devices(int app_id)
>> +{
>> +       struct gatt_device *dev;
>> +
>> +       /*
>> +        * Check if application was registered for any devices to
>> +        * reconnect
>> +        */
>> +       dev = find_device_by_autoconnect_app_id(app_id);
>> +       while (dev) {
>> +               queue_remove(dev->autoconnect_apps, INT_TO_PTR(app_id));
>> +
>> +               if (queue_isempty(dev->autoconnect_apps)) {
>> +                       bt_auto_connect_remove(&dev->bdaddr);
>> +
>> +                       if (dev->state == DEVICE_CONNECT_INIT)
>> +                               device_set_state(dev, DEVICE_DISCONNECTED);
>> +
>> +                       device_unref(dev);
>> +               }
>> +
>> +               dev = find_device_by_autoconnect_app_id(app_id);
>> +       };
>
> Looks like there is a ';; after the while statement, please fix that.

True.  I had do {} while; before sending it to ML and forgot to remove it.

> Also this looks very inefficient since it does
> find_device_by_autoconnect_app_id does a double lookup and we doing it
> in a while loop, I would suggest using queue_foreach(gatt_devices...
> then do queue_remove_if(dev->autoconnect_apps,  the result should be
> the same but with a single lookup in each queue.
>

OK, Will use queue_foreach. I did this ways, because I thought that
device_unref can destroy device and remove it from gatt_devices and
this is something we don't want to happen during
queue_foreach(gatt_device..). Anyway, I double check it and it should
not happen (unless there is a bug somewhere ;) )

\Lukasz

>> +}
>> +
>>  static uint8_t unregister_app(int client_if)
>>  {
>>         struct gatt_app *cl;
>>
>> +       /*
>> +        * Make sure that there is no devices in auto connect list for this
>> +        * application
>> +        */
>> +       clear_autoconnect_devices(client_if);
>> +
>>         cl = queue_remove_if(gatt_apps, match_app_by_id, INT_TO_PTR(client_if));
>>         if (!cl) {
>>                 error("gatt: client_if=%d not found", client_if);
>> --
>> 1.8.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
