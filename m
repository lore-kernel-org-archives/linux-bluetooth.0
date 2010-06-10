Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100610202023.GC16611@botech.co.uk>
References: <20100610125848.GA28631@botech.co.uk>
	<AANLkTinlsskks35CHsSlDueAGCi4HeicWjHLUTQcfzYC@mail.gmail.com>
	<20100610202023.GC16611@botech.co.uk>
Date: Fri, 11 Jun 2010 01:19:38 +0300
Message-ID: <AANLkTinQ_Tr5fwNquGwW9o5LIuqpAGCqHveGuAA1Av3O@mail.gmail.com>
Subject: Re: bug and possible patch for dbus DiscoverServices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tim Renouf <tpr.vger@botech.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 10, 2010 at 11:20 PM, Tim Renouf <tpr.vger@botech.co.uk> wrote:
> On Thu, Jun 10, 2010 at 04:48:58PM +0300, Luiz Augusto von Dentz wrote:
>> I would just rework it a bit to make the tmp_records to always store
>> the last search, something like the following:
>>
>> -       if (device->tmp_records && req->records) {
>> +       if (device->tmp_records)
>>                 sdp_list_free(device->tmp_records,
>>                                         (sdp_free_func_t) sdp_record_free);
>> -               device->tmp_records = req->records;
>> -               req->records = NULL;
>> -       }
>> +
>> +       device->tmp_records = req->records;
>> +       req->records = NULL;
>>
>>         if (!req->profiles_added && !req->profiles_removed) {
>>                 DBG("%s: No service update", device->path);
>> @@ -1522,7 +1522,7 @@ send_reply:
>>
>>         if (dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
>>                                         "DiscoverServices"))
>> -               discover_services_reply(req, err, req->records);
>> +               discover_services_reply(req, err, device->tmp_records);
>>         else if (dbus_message_is_method_call(req->msg, ADAPTER_INTERFACE,
>>                                                 "CreatePairedDevice"))
>>                 create_device_reply(device, req);
>>
>> What do you think?
>
> Thanks, that looks good, I'll use that.
>
> What is the procedure to get it included in future versions of BlueZ ?
> Does someone sweep this list for patches to review and possibly
> include ?

Similar to kernel. git format-patch or git pull request, be sure that
it applies and compiles cleanly against git master.

-- 
Luiz Augusto von Dentz
Computer Engineer
