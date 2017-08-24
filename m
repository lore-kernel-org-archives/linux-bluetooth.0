Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLddrYozPCdfRDMDM3fD26BqxCd6MiBUpwpK6jgoYYD6Q@mail.gmail.com>
References: <20170823235550.45934-1-mcchou@chromium.org> <CABBYNZLddrYozPCdfRDMDM3fD26BqxCd6MiBUpwpK6jgoYYD6Q@mail.gmail.com>
From: Sonny Sasaka <sonnysasaka@chromium.org>
Date: Thu, 24 Aug 2017 12:11:27 -0700
Message-ID: <CAOxioNmNRsjgEu0-_wLK6-bREDE46w+JUh2NObSJH6-qDFGUNw@mail.gmail.com>
Subject: Re: [PATCH] adapter: Guard StartDiscovery and StopDiscovery with
 discovering check
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Miao-chen Chou <mcchou@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Aug 24, 2017 at 1:30 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Aug 24, 2017 at 2:55 AM,  <mcchou@chromium.org> wrote:
>> From: Miao-chen Chou <mcchou@chromium.org>
>>
>> There is a race condition where a start/stop discovery is requested before the
>> previous stop/start discovery finish, and checking the adapter->discovery_list
>> is insufficient to guard to race condition. For example, if start_discovery is
>> called right after stop discovery, the callback, stop_discovery_complete, may
>> not be called before calling start_discovery. Then start_discovery will
>> proceed and fail.
>>
>> Test steps:
>> Add delay in kernel for the stop discovery callback.
>> Check if the start discovery can happen before the completion of the previous
>> stop discovery, and the other way around.
>>
>> Please refer to https://bugs.chromium.org/p/chromium/issues/detail?id=738237
>> for more details.
>
> It is giving me:
>
> You do not have permission to view the requested page.
>
> Reason: User is not allowed to view this issue
>
>> ---
>>  src/adapter.c | 26 +++++++++++++++++++++++---
>>  1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 83f38ddbe..395b430d2 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -2119,20 +2119,30 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>>         struct btd_adapter *adapter = user_data;
>>         const char *sender = dbus_message_get_sender(msg);
>>         struct watch_client *client;
>> -       bool is_discovering;
>> +       bool discovery_client_exists;
>
> Don't really see why to change the name here.

It's to prevent confusion between is_discovering and
adapter->discovering. But we can modify to follow your preference.

>
>>         DBG("sender %s", sender);
>>
>>         if (!(adapter->current_settings & MGMT_SETTING_POWERED))
>>                 return btd_error_not_ready(msg);
>>
>> -       is_discovering = get_discovery_client(adapter, sender, &client);
>> +       discovery_client_exists = get_discovery_client(
>> +                       adapter, sender, &client);
>>
>>         /*
>>          * Every client can only start one discovery, if the client
>>          * already started a discovery then return an error.
>>          */
>> -       if (is_discovering)
>> +       if (discovery_client_exists)
>> +               return btd_error_busy(msg);
>> +
>> +       /*
>> +        * adapter->discovery_list being empty but adapter->discovering being
>> +        * true indicates that there is a stop discovery operation in progress.
>> +        * Prevent a new start discovery request when the previous
>> +        * stop discovery is in progress.
>> +        */
>> +       if (!adapter->discovery_list && adapter->discovering)
>
> Perhaps we should delay the removal of a client if it is the last in
> the list, or actually both start and stop discovery need to wait their
> respective commands to complete before replying, that way the client
> can actually be sure it has started or stopped the discovery and we
> don't have to reply busy.

I agree that we can wait to reply after the command is completed. But I think
we still need the busy error in case the client doesn't honor the
"wait until dbus reply"
protocol, otherwise bluetoothd will enter into a strange internal
state if it's not guarded.
What do you think?

>
>>                 return btd_error_busy(msg);
>>
>>         /*
>> @@ -2420,6 +2430,16 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
>>         if (!list)
>>                 return btd_error_failed(msg, "No discovery started");
>>
>> +       /*
>> +        * adapter->discovery_list being not empty but adapter->discovering
>> +        * being false indicates that there is a start discovery operation in
>> +        * progress.
>> +        * Prevent a new stop discovery request when the previous start
>> +        * discovery is in progress.
>> +        */
>> +       if (!adapter->discovering)
>> +               return btd_error_busy(msg);
>
> Ditto.
>
>>         client = list->data;
>>
>>         cp.type = adapter->discovery_type;
>> --
>> 2.14.1.342.g6490525c54-goog
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
