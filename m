Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOxioNnbY=0TkYj6UGhKKFNdXcBR5Bz9cfR8KG_DQXNkPvFT5g@mail.gmail.com>
References: <20170823235550.45934-1-mcchou@chromium.org> <CABBYNZLddrYozPCdfRDMDM3fD26BqxCd6MiBUpwpK6jgoYYD6Q@mail.gmail.com>
 <CAOxioNmNRsjgEu0-_wLK6-bREDE46w+JUh2NObSJH6-qDFGUNw@mail.gmail.com>
 <CAOxioN=2S=tP5DMeWXS6Gh=RKfntD_PKjV0oyauzdL1p1K3zuQ@mail.gmail.com>
 <CABBYNZKUHgBEi0x8DG34V7PXwF6dF1U7kR51ubCzyZy5-Hk+1w@mail.gmail.com> <CAOxioNnbY=0TkYj6UGhKKFNdXcBR5Bz9cfR8KG_DQXNkPvFT5g@mail.gmail.com>
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date: Fri, 25 Aug 2017 20:24:13 +0300
Message-ID: <CACumGOJUyv0+8CtZ8AJBAzoi+H8Lb2t6n6uRCoY+8j2qzTUr+g@mail.gmail.com>
Subject: Re: [PATCH] adapter: Guard StartDiscovery and StopDiscovery with
 discovering check
To: Sonny Sasaka <sonnysasaka@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Shyh-In Hwang <josephsih@chromium.org>,
        Rahul Chaturvedi <rkc@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sonny,

On Fri, Aug 25, 2017 at 7:54 PM, Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> Hi Luiz,
>
> On Fri, Aug 25, 2017 at 12:33 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Sonny,
>>
>> On Fri, Aug 25, 2017 at 2:14 AM, Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>>> Hi Luiz,
>>>
>>> I am about to implement the async reply for StartDiscovery, then I
>>> realize that there is a case where this may cause dbus timeout if this
>>> happens several times:
>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n1456.
>>> Now I am not sure if async reply is suitable for this operation. What
>>> do you think? Thanks.
>>
>> This is a timeout to restart, nothing to do with D-Bus timeout. D-Bus
>> timeout is actually client side, default is 25 seconds, but management
>> command timeout should kick in much faster than that.
>
> Yes, management command timeout is fast. But this particular code path
> actually re-send the management command delayed after 10 seconds if
> the previous management command failed, so if there are more than 2
> retries it will timeout the dbus. Maybe I illustrate the scenario
> below:
> 1. Client calls StartDiscovery, so bluetoothd send MGMT_OP_START_DISCOVERY
> 2. Quickly (< 1 second) the reply from kernel is received.
> 3. The reply status is non-success, so it does not reply back to
> client via dbus, but re-schedule the mgmt 10 seconds later
> (https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n1456).
> 4. 10 seconds later bluetoothd sends MGMT_OP_START_DISCOVERY again
> (like step 2), and quickly it receives the reply from kernel (like
> step 3).
> 5. The reply status is non-success, so it does not reply back to
> client via dbus, but re-schedule the mgmt 10 seconds later
> (https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n1456).
> 6. 10 seconds later bluetoothd sends MGMT_OP_START_DISCOVERY again
> (like step 2), and quickly it receives the reply from kernel (like
> step 3).
> 7. The reply status is non-success, so it does not reply back to
> client via dbus, but re-schedule the mgmt 10 seconds later
> (https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n1456).
> 8. 10 seconds later bluetoothd sends MGMT_OP_START_DISCOVERY again
> (like step 2), and quickly it receives the reply from kernel (like
> step 3).
> 9. Now the reply status is success, so it's going to reply success to
> client via dbus, but this time the dbus already timed out because it's
> already more than 25 seconds.

The default is 25 seconds anything lower than 5 seconds would pretty
much always trigger this error on the client side if the command
fails, though I think the client can actually handle this since the
timeout will trigger a specific error so it can attempt again. But Id
said the current logic is flawed since it seems to retry forever, Id
retry it just once or twice, or perhaps don't retry if this is the
first attempt since the continuous discovery has not started yet it is
still possible for the application to handle the error, once it has
started it should continue until the application call StopDiscovery in
that case perhaps it is justified to retry as make times as it is
required to restart otherwise the discovery just stall.

> So, I am worried about this scenario because client cannot reliably
> "wait until dbus reply to make sure command is not in progress".
>
>> What I would do is to keep the existing logic adding the client to the
>> list as soon as it attempt to start a discovery, but we store the msg
>> into watch_client which will be used to reply once the request is
>> complete and also can be used to checked if the client has an
>> operation pending and in that case return busy.
>
> I understand this part, but it doesn't address the scenario above.
>
>>
>>> On Thu, Aug 24, 2017 at 12:11 PM, Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>>>> Hi Luiz,
>>>>
>>>> On Thu, Aug 24, 2017 at 1:30 AM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Aug 24, 2017 at 2:55 AM,  <mcchou@chromium.org> wrote:
>>>>>> From: Miao-chen Chou <mcchou@chromium.org>
>>>>>>
>>>>>> There is a race condition where a start/stop discovery is requested before the
>>>>>> previous stop/start discovery finish, and checking the adapter->discovery_list
>>>>>> is insufficient to guard to race condition. For example, if start_discovery is
>>>>>> called right after stop discovery, the callback, stop_discovery_complete, may
>>>>>> not be called before calling start_discovery. Then start_discovery will
>>>>>> proceed and fail.
>>>>>>
>>>>>> Test steps:
>>>>>> Add delay in kernel for the stop discovery callback.
>>>>>> Check if the start discovery can happen before the completion of the previous
>>>>>> stop discovery, and the other way around.
>>>>>>
>>>>>> Please refer to https://bugs.chromium.org/p/chromium/issues/detail?id=738237
>>>>>> for more details.
>>>>>
>>>>> It is giving me:
>>>>>
>>>>> You do not have permission to view the requested page.
>>>>>
>>>>> Reason: User is not allowed to view this issue
>>>>>
>>>>>> ---
>>>>>>  src/adapter.c | 26 +++++++++++++++++++++++---
>>>>>>  1 file changed, 23 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/src/adapter.c b/src/adapter.c
>>>>>> index 83f38ddbe..395b430d2 100644
>>>>>> --- a/src/adapter.c
>>>>>> +++ b/src/adapter.c
>>>>>> @@ -2119,20 +2119,30 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>>>>>>         struct btd_adapter *adapter = user_data;
>>>>>>         const char *sender = dbus_message_get_sender(msg);
>>>>>>         struct watch_client *client;
>>>>>> -       bool is_discovering;
>>>>>> +       bool discovery_client_exists;
>>>>>
>>>>> Don't really see why to change the name here.
>>>>
>>>> It's to prevent confusion between is_discovering and
>>>> adapter->discovering. But we can modify to follow your preference.
>>>>
>>>>>
>>>>>>         DBG("sender %s", sender);
>>>>>>
>>>>>>         if (!(adapter->current_settings & MGMT_SETTING_POWERED))
>>>>>>                 return btd_error_not_ready(msg);
>>>>>>
>>>>>> -       is_discovering = get_discovery_client(adapter, sender, &client);
>>>>>> +       discovery_client_exists = get_discovery_client(
>>>>>> +                       adapter, sender, &client);
>>>>>>
>>>>>>         /*
>>>>>>          * Every client can only start one discovery, if the client
>>>>>>          * already started a discovery then return an error.
>>>>>>          */
>>>>>> -       if (is_discovering)
>>>>>> +       if (discovery_client_exists)
>>>>>> +               return btd_error_busy(msg);
>>>>>> +
>>>>>> +       /*
>>>>>> +        * adapter->discovery_list being empty but adapter->discovering being
>>>>>> +        * true indicates that there is a stop discovery operation in progress.
>>>>>> +        * Prevent a new start discovery request when the previous
>>>>>> +        * stop discovery is in progress.
>>>>>> +        */
>>>>>> +       if (!adapter->discovery_list && adapter->discovering)
>>>>>
>>>>> Perhaps we should delay the removal of a client if it is the last in
>>>>> the list, or actually both start and stop discovery need to wait their
>>>>> respective commands to complete before replying, that way the client
>>>>> can actually be sure it has started or stopped the discovery and we
>>>>> don't have to reply busy.
>>>>
>>>> I agree that we can wait to reply after the command is completed. But I think
>>>> we still need the busy error in case the client doesn't honor the
>>>> "wait until dbus reply"
>>>> protocol, otherwise bluetoothd will enter into a strange internal
>>>> state if it's not guarded.
>>>> What do you think?
>>>>
>>>>>
>>>>>>                 return btd_error_busy(msg);
>>>>>>
>>>>>>         /*
>>>>>> @@ -2420,6 +2430,16 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
>>>>>>         if (!list)
>>>>>>                 return btd_error_failed(msg, "No discovery started");
>>>>>>
>>>>>> +       /*
>>>>>> +        * adapter->discovery_list being not empty but adapter->discovering
>>>>>> +        * being false indicates that there is a start discovery operation in
>>>>>> +        * progress.
>>>>>> +        * Prevent a new stop discovery request when the previous start
>>>>>> +        * discovery is in progress.
>>>>>> +        */
>>>>>> +       if (!adapter->discovering)
>>>>>> +               return btd_error_busy(msg);
>>>>>
>>>>> Ditto.
>>>>>
>>>>>>         client = list->data;
>>>>>>
>>>>>>         cp.type = adapter->discovery_type;
>>>>>> --
>>>>>> 2.14.1.342.g6490525c54-goog
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
