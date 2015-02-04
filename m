Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLDAFdotoZMEr5AiBds3rJ_5KNM6WPS7VbtXmA7iT0rsQ@mail.gmail.com>
References: <1423022302-27124-1-git-send-email-armansito@chromium.org>
	<CABBYNZLDAFdotoZMEr5AiBds3rJ_5KNM6WPS7VbtXmA7iT0rsQ@mail.gmail.com>
Date: Wed, 4 Feb 2015 14:05:59 -0800
Message-ID: <CAHrH25TOLzhdP_3BocdSdTK27j69AzpLGdT5Eci9n7=QWV6Ntg@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt: Allow register_notify without CCC
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Wed, Feb 4, 2015 at 6:26 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Wed, Feb 4, 2015 at 5:58 AM, Arman Uguray <armansito@chromium.org> wrote:
>> Certain peripherals can expose a GATT characteristic with the
>> notify/indicate property but with no Client Characteristic Configuration
>> descriptor. Since bt_gatt_client_register_notify enforces a CCC as a
>> requirement, it returns an error for such characteristics.
>
> Do you have some evidence of this? I don't mind not being too strict
> while receiving but we need to document why we are doing these
> changes,...

I came across this while testing with a Nexus 6 device running Android
L. The application exposes a "Service Changed" characteristic with no
CCC, which is causing bt_gatt_client's initialization sequence to fail
(since it assumes that there will be a CCC and treats the absence as
an error). This seemed strange to me, so I did some digging, and the
Bluetooth developer page actually lists "None" for "Descriptors"
(https://developer.bluetooth.org/gatt/services/Pages/ServiceViewer.aspx?u=org.bluetooth.service.generic_attribute.xml)
of this characteristic.

However, this seemed incorrect to me, so I checked the Core Spec v4.2,
Vol 3, Part G, Section 7.1 "Service Changed", which states: "This
[Service Changed] Characteristic Value shall be configured to be
indicated, using the Client Characteristic Configuration descriptor by
a client. Indications caused by changes to the Service Changed
Characteristic Value shall be considered lost if the client has not
enabled indications in the Client Configuration Characteristic
Descriptor." Which means that the CCC is certainly mandatory, so this
must be an error in the developer page.

Regardless, though, even if this is an error in the BlueDroid stack,
it means that some devices may have incorrectly implemented the spec
here, so we should probably tolerate this. BlueZ's server
implementation SHOULD regardless expose this descriptor, but the
client IMO shouldn't fail if the CCC generally doesn't exist.

> ...and btw this perhaps makes my argument of enabling
> notification by default even stronger since if such devices really
> exists they might be notifying us since the beginning.
>

Hmm, I don't know how this makes that argument any stronger.
bt_gatt_client already automatically registers for Service Changed,
and for external applications we still want to only notify if an app
is interested (which they can do now across connections).

Generally, I want to treat this as a corner-case, since it's not
really spec compliant behavior. Either way, it's probably not that bad
to have this fix so that we don't bork out immediately with devices
that behave incorrectly. Actually, it might be even more spec
compliant for us to simply ignore the Service Changed characteristic
if it's discovered but doesn't have a CCC, since the spec says
"changes to the Service Changed Characteristic Value shall be
considered lost if the client has not enabled indications in the
Client Configuration Characteristic Descriptor", which would end up
being a simpler fix on our end.

Either way, I'll wait for your response to determine what the right
behavior is here.

> The other problem I now see is that there is probably no way to rate
> limit the notification, because they are profile specific, so if you
> had a problem with too much traffic on D-Bus this may already happen
> even if we register the notification on demand.
>

Right, though I guess this is a separate issue that can be dealt with
at the D-Bus API level. shared/gatt-client has to still send all
notifications up, otherwise things like HoG wouldn't work well with a
rate limit. Anyway, we can do this at a D-Bus API level separately.
I'll add this to the general TODO list.

>> This patch fixes this behavior so that bt_gatt_client_register_notify
>> immediately registers the callback and returns success for
>> characteristics with no CCC.
>> ---
>>  src/shared/gatt-client.c | 43 +++++++++++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index 5edb991..d0fc054 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -88,6 +88,7 @@ struct bt_gatt_client {
>>          * the remote peripheral.
>>          */
>>         unsigned int svc_chngd_ind_id;
>> +       bool svc_chngd_registered;
>>         struct queue *svc_chngd_queue;  /* Queued service changed events */
>>         bool in_svc_chngd;
>>
>> @@ -234,12 +235,6 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
>>                                                         &properties, NULL))
>>                         return NULL;
>>
>> -       /* Find the CCC characteristic */
>> -       ccc = NULL;
>> -       gatt_db_service_foreach_desc(attr, find_ccc, &ccc);
>> -       if (!ccc)
>> -               return NULL;
>> -
>>         chrc = new0(struct notify_chrc, 1);
>>         if (!chrc)
>>                 return NULL;
>> @@ -250,8 +245,17 @@ static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
>>                 return NULL;
>>         }
>>
>> +       /*
>> +        * Find the CCC characteristic. Some characteristics that allow
>> +        * notifications may not have a CCC descriptor. We treat these as
>> +        * automatically successful.
>> +        */
>> +       ccc = NULL;
>> +       gatt_db_service_foreach_desc(attr, find_ccc, &ccc);
>> +       if (ccc)
>> +               chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
>> +
>>         chrc->value_handle = value_handle;
>> -       chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
>>         chrc->properties = properties;
>>
>>         queue_push_tail(client->notify_chrcs, chrc);
>> @@ -1020,6 +1024,7 @@ static void service_changed_reregister_cb(uint16_t att_ecode, void *user_data)
>>                 util_debug(client->debug_callback, client->debug_data,
>>                         "Re-registered handler for \"Service Changed\" after "
>>                         "change in GATT service");
>> +               client->svc_chngd_registered = true;
>>                 return;
>>         }
>>
>> @@ -1089,6 +1094,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
>>         /* The GATT service was modified. Re-register the handler for
>>          * indications from the "Service Changed" characteristic.
>>          */
>> +       client->svc_chngd_registered = false;
>>         client->svc_chngd_ind_id = bt_gatt_client_register_notify(client,
>>                                         gatt_db_attribute_get_handle(attr),
>>                                         service_changed_reregister_cb,
>> @@ -1197,6 +1203,7 @@ static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
>>                 goto done;
>>         }
>>
>> +       client->svc_chngd_registered = true;
>>         client->ready = true;
>>         success = true;
>>         util_debug(client->debug_callback, client->debug_data,
>> @@ -1239,13 +1246,16 @@ static void init_complete(struct discovery_op *op, bool success,
>>                                         service_changed_register_cb,
>>                                         service_changed_cb,
>>                                         client, NULL);
>> -       client->ready = false;
>> +
>> +       if (!client->svc_chngd_registered)
>> +               client->ready = false;
>>
>>         if (client->svc_chngd_ind_id)
>>                 return;
>>
>>         util_debug(client->debug_callback, client->debug_data,
>>                         "Failed to register handler for \"Service Changed\"");
>> +       success = false;
>>
>>  fail:
>>         util_debug(client->debug_callback, client->debug_data,
>> @@ -1423,18 +1433,17 @@ static void complete_unregister_notify(void *data)
>>          */
>>         if (notify_data->att_id) {
>>                 bt_att_cancel(notify_data->client->att, notify_data->att_id);
>> -               notify_data_unref(notify_data);
>> -               return;
>> +               goto done;
>>         }
>>
>> -       if (__sync_sub_and_fetch(&notify_data->chrc->notify_count, 1)) {
>> -               notify_data_unref(notify_data);
>> -               return;
>> -       }
>> +       if (__sync_sub_and_fetch(&notify_data->chrc->notify_count, 1) ||
>> +                                               !notify_data->chrc->ccc_handle)
>> +               goto done;
>>
>>         if (notify_data_write_ccc(notify_data, false, disable_ccc_callback))
>>                 return;
>>
>> +done:
>>         notify_data_unref(notify_data);
>>  }
>>
>> @@ -2571,9 +2580,7 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>         /* Add the handler to the bt_gatt_client's general list */
>>         queue_push_tail(client->notify_list, notify_data);
>>
>> -       /* Assign an ID to the handler and notify the caller that it was
>> -        * successfully registered.
>> -        */
>> +       /* Assign an ID to the handler. */
>>         if (client->next_reg_id < 1)
>>                 client->next_reg_id = 1;
>>
>> @@ -2591,7 +2598,7 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>         /*
>>          * If the ref count is not zero, then notifications are already enabled.
>>          */
>> -       if (chrc->notify_count > 0) {
>> +       if (chrc->notify_count > 0 || !chrc->ccc_handle) {
>>                 complete_notify_request(notify_data);
>>                 return notify_data->id;
>>         }
>> --
>> 2.2.0.rc0.207.ga3a616c
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

Thanks,
Arman
