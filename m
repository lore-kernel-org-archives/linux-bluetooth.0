Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOxioNk3U2-R067_KsxKRh6MQ-ANS_hnbWt++dGC=aTFxoU1Wg@mail.gmail.com>
References: <20170907115940.30459-1-luiz.dentz@gmail.com> <CABBYNZJSfDM9keDQHzn8OT_1yOM46erjHyB9zED8vsSbikDZYQ@mail.gmail.com>
 <CAOxioNmte6Vk7HjUND05Zni8zS+=cZyjGnk60p19q7zSm5eS8g@mail.gmail.com>
 <CABBYNZL-uJb7SmPPONWuC_Gk8fawKEoY7UGM11WVKVdE-e4QLg@mail.gmail.com>
 <CAOxioNnfn5Y5RmvSp=DT7-DfuiLUvr_wtpZGhJ8zG+nwVPNvxQ@mail.gmail.com> <CAOxioNk3U2-R067_KsxKRh6MQ-ANS_hnbWt++dGC=aTFxoU1Wg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Sep 2017 11:38:47 +0300
Message-ID: <CABBYNZ+Xnb7=4-dv8Z8k3WuMenmTrsaZ8_oP+0Kp+G1TRrwOAg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Fix not waiting for start discovery result
To: Sonny Sasaka <sonnysasaka@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sonny,

On Fri, Sep 15, 2017 at 12:40 AM, Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> Hi Luiz,
>
> We have just encountered a similar race condition: stop_discovery
> happens during start_discovery_timeout, but this time
> start_discovery_timeout wasn't initiated by start_discovery but by
> resume_discovery. I think this case is not yet handled by your patch
> and maybe you want to add it to the patch to handle this case.

Will address this in the next version, when this happens the client is
actually removed before start_discovery_complete but it should never
really had called stop_discovery_complete since
adapter->discovery_type has not been updated.

> On Wed, Sep 13, 2017 at 10:30 AM, Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>> Hi Luiz,
>>
>>
>> On Wed, Sep 13, 2017 at 5:11 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Sonny,
>>>
>>> On Wed, Sep 13, 2017 at 12:54 AM, Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>>>> Hi Luiz,
>>>>
>>>> Thank you for the patch. However I see that the patch doesn't address
>>>> the case where start discovery happens during stop discovery (after
>>>> stop_discovery but before stop_discovery_complete).
>>>
>>> I would considered this a different problem, but yes either multiple
>>> starts or start/stop in a sequence may cause the states to be out of
>>> sync so it needs fixing.
>>
>> It could be considered another problem, but it is the only problem we
>> are having. So this patch doesn't address any of our issue, but this
>> may fix issues other people are having.
>>
>>>
>>>> On Sun, Sep 10, 2017 at 12:24 PM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Sep 7, 2017 at 2:59 PM, Luiz Augusto von Dentz
>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>>
>>>>>> We should not reply until the start discovery completes otherwise
>>>>>> clients may attempt to stop the discovery before it even has started.
>>>>>>
>>>>>> On top of this it will now block clients so they so not be able to
>>>>>> queue more requests.
>>>>>> ---
>>>>>>  src/adapter.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
>>>>>>  1 file changed, 47 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/src/adapter.c b/src/adapter.c
>>>>>> index a571b1870..4b9f5a1cd 100644
>>>>>> --- a/src/adapter.c
>>>>>> +++ b/src/adapter.c
>>>>>> @@ -160,6 +160,7 @@ struct discovery_filter {
>>>>>>
>>>>>>  struct watch_client {
>>>>>>         struct btd_adapter *adapter;
>>>>>> +       DBusMessage *msg;
>>>>>>         char *owner;
>>>>>>         guint watch;
>>>>>>         struct discovery_filter *discovery_filter;
>>>>>> @@ -1421,13 +1422,17 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>>>>>>                                         const void *param, void *user_data)
>>>>>>  {
>>>>>>         struct btd_adapter *adapter = user_data;
>>>>>> +       struct watch_client *client = adapter->discovery_list->data;
>>>>>>         const struct mgmt_cp_start_discovery *rp = param;
>>>>>> +       DBusMessage *reply;
>>>>>>
>>>>>>         DBG("status 0x%02x", status);
>>>>>>
>>>>>>         if (length < sizeof(*rp)) {
>>>>>>                 btd_error(adapter->dev_id,
>>>>>>                         "Wrong size of start discovery return parameters");
>>>>>> +               if (client->msg)
>>>>>> +                       goto fail;
>>>>>>                 return;
>>>>>>         }
>>>>>>
>>>>>> @@ -1440,6 +1445,14 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>>>>>>                 else
>>>>>>                         adapter->filtered_discovery = false;
>>>>>>
>>>>>> +               if (client->msg) {
>>>>>> +                       reply = g_dbus_create_reply(client->msg,
>>>>>> +                                                       DBUS_TYPE_INVALID);
>>>>>> +                       g_dbus_send_message(dbus_conn, reply);
>>>>>> +                       dbus_message_unref(client->msg);
>>>>>> +                       client->msg = NULL;
>>>>>> +               }
>>>>>> +
>>>>>>                 if (adapter->discovering)
>>>>>>                         return;
>>>>>>
>>>>>> @@ -1449,6 +1462,15 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>>>>>>                 return;
>>>>>>         }
>>>>>>
>>>>>> +fail:
>>>>>> +       /* Reply with an error if the first discovery has failed */
>>>>>> +       if (client->msg) {
>>>>>> +               reply = btd_error_busy(client->msg);
>>>>>> +               g_dbus_send_message(dbus_conn, reply);
>>>>>> +               g_dbus_remove_watch(dbus_conn, client->watch);
>>>>>> +               return;
>>>>>> +       }
>>>>>> +
>>>>>>         /*
>>>>>>          * In case the restart of the discovery failed, then just trigger
>>>>>>          * it for the next idle timeout again.
>>>>>> @@ -1933,7 +1955,7 @@ static bool filters_equal(struct mgmt_cp_start_service_discovery *a,
>>>>>>         return true;
>>>>>>  }
>>>>>>
>>>>>> -static void update_discovery_filter(struct btd_adapter *adapter)
>>>>>> +static int update_discovery_filter(struct btd_adapter *adapter)
>>>>>>  {
>>>>>>         struct mgmt_cp_start_service_discovery *sd_cp;
>>>>>>
>>>>>> @@ -1942,7 +1964,7 @@ static void update_discovery_filter(struct btd_adapter *adapter)
>>>>>>         if (discovery_filter_to_mgmt_cp(adapter, &sd_cp)) {
>>>>>>                 btd_error(adapter->dev_id,
>>>>>>                                 "discovery_filter_to_mgmt_cp returned error");
>>>>>> -               return;
>>>>>> +               return -ENOMEM;
>>>>>>         }
>>>>>>
>>>>>>         /*
>>>>>> @@ -1953,13 +1975,15 @@ static void update_discovery_filter(struct btd_adapter *adapter)
>>>>>>             adapter->discovering != 0) {
>>>>>>                 DBG("filters were equal, deciding to not restart the scan.");
>>>>>>                 g_free(sd_cp);
>>>>>> -               return;
>>>>>> +               return 0;
>>>>>>         }
>>>>>>
>>>>>>         g_free(adapter->current_discovery_filter);
>>>>>>         adapter->current_discovery_filter = sd_cp;
>>>>>>
>>>>>>         trigger_start_discovery(adapter, 0);
>>>>>> +
>>>>>> +       return -EINPROGRESS;
>>>>>>  }
>>>>>>
>>>>>>  static void discovery_destroy(void *user_data)
>>>>>> @@ -1980,6 +2004,9 @@ static void discovery_destroy(void *user_data)
>>>>>>                 client->discovery_filter = NULL;
>>>>>>         }
>>>>>>
>>>>>> +       if (client->msg)
>>>>>> +               dbus_message_unref(client->msg);
>>>>>> +
>>>>>>         g_free(client->owner);
>>>>>>         g_free(client);
>>>>>>
>>>>>> @@ -2087,6 +2114,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>>>>>>         const char *sender = dbus_message_get_sender(msg);
>>>>>>         struct watch_client *client;
>>>>>>         bool is_discovering;
>>>>>> +       int err;
>>>>>>
>>>>>>         DBG("sender %s", sender);
>>>>>>
>>>>>> @@ -2107,12 +2135,14 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>>>>>>          * and trigger scan.
>>>>>>          */
>>>>>>         if (client) {
>>>>>> +               if (client->msg)
>>>>>> +                       return btd_error_busy(msg);
>>>>>> +
>>>>>>                 adapter->set_filter_list = g_slist_remove(
>>>>>>                                              adapter->set_filter_list, client);
>>>>>>                 adapter->discovery_list = g_slist_prepend(
>>>>>>                                               adapter->discovery_list, client);
>>>>>> -               update_discovery_filter(adapter);
>>>>>> -               return dbus_message_new_method_return(msg);
>>>>>> +               goto done;
>>>>>>         }
>>>>>>
>>>>>>         client = g_new0(struct watch_client, 1);
>>>>>> @@ -2126,14 +2156,23 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>>>>>>         adapter->discovery_list = g_slist_prepend(adapter->discovery_list,
>>>>>>                                                                 client);
>>>>>>
>>>>>> +done:
>>>>>>         /*
>>>>>>          * Just trigger the discovery here. In case an already running
>>>>>>          * discovery in idle phase exists, it will be restarted right
>>>>>>          * away.
>>>>>>          */
>>>>>> -       update_discovery_filter(adapter);
>>>>>> +       err = update_discovery_filter(adapter);
>>>>>> +       if (!err)
>>>>>> +               return dbus_message_new_method_return(msg);
>>>>>>
>>>>>> -       return dbus_message_new_method_return(msg);
>>>>>> +       /* If the discovery has to be started wait it complete to reply */
>>>>>> +       if (err == -EINPROGRESS) {
>>>>>> +               client->msg = dbus_message_ref(msg);
>>>>>> +               return NULL;
>>>>>> +       }
>>>>>> +
>>>>>> +       return btd_error_failed(msg, strerror(-err));
>>>>>>  }
>>>>>>
>>>>>>  static bool parse_uuids(DBusMessageIter *value, struct discovery_filter *filter)
>>>>>> @@ -2984,7 +3023,7 @@ static DBusMessage *get_discovery_filters(DBusConnection *conn,
>>>>>>  }
>>>>>>
>>>>>>  static const GDBusMethodTable adapter_methods[] = {
>>>>>> -       { GDBUS_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
>>>>>> +       { GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
>>>>>>         { GDBUS_METHOD("SetDiscoveryFilter",
>>>>>>                                 GDBUS_ARGS({ "properties", "a{sv}" }), NULL,
>>>>>>                                 set_discovery_filter) },
>>>>>> --
>>>>>> 2.13.5
>>>>>
>>>>> Could you guys please check if this does address the problem you are having?
>>>>>
>>>>>
>>>>> --
>>>>> Luiz Augusto von Dentz
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
