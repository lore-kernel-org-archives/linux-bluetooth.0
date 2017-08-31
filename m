Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] client: Fix default controller in interactive mode
To: Yunhan Wang <yunhanw@google.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <37259a70-d8d0-0cff-5d59-460917c5010f@jp.fujitsu.com>
 <CALvjcs-hCShRT8GSNP0z8HDGOqMOd6xCaRc1JhXhReOf45rX+w@mail.gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <a12789e7-54c1-2469-e12e-4235a2327432@jp.fujitsu.com>
Date: Thu, 31 Aug 2017 17:06:50 +0900
MIME-Version: 1.0
In-Reply-To: <CALvjcs-hCShRT8GSNP0z8HDGOqMOd6xCaRc1JhXhReOf45rX+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

Thanks for your reply.

On 08/31/2017 02:02 PM, Yunhan Wang wrote:
> Hi, ERAMOTO
> 
> With this change, when second adapter is enumerated.
> default_ctrl->ad_proxy would be assigned with advertising proxy from
> second adapter, but default_ctrl->proxy is still first adapter proxy.

I understood your commit 4e111f3448.

> Yes, when there are two adapters, the newest adapter is chosen as
> default one.  It is not good when you have adapter A in test, and
> later attach another adapter B. But if you make all adapters ready
> before your test is running, then you can use "select" to choose the
> default adapter.

I worry about the case that bluetootctl is not run on test phase
but on operation phase (end-users may attach adapters freely). In
addition, now bluetoothctl seems to be inconsistent when adapters
without advertising (e.g. with only BR/EDR) are used.

Do you have any ideas how to fix this behavior? Or do not we need
to worry about above?


Regards,
Eramoto

> Thanks
> Best wishes
> Yunhan
> 
> On Wed, Aug 30, 2017 at 9:23 PM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> Since 4e111f3448a126786f3620be1b5ce969456edc65, when a attached adapter
>> is tried to operate in the interactive mode and another adapter is
>> attached newly, the default controller is changed to the another adapter.
>>
>> In the interactive mode, because the default controller should change by
>> select command, this patch fixes to not change the default controller
>> when another adapter is attached.
>> ---
>>  client/main.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/client/main.c b/client/main.c
>> index 825647d..7ab95dc 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -527,9 +527,14 @@ static void device_added(GDBusProxy *proxy)
>>
>>  static void adapter_added(GDBusProxy *proxy)
>>  {
>> -       default_ctrl = g_malloc0(sizeof(struct adapter));
>> -       default_ctrl->proxy = proxy;
>> -       ctrl_list = g_list_append(ctrl_list, default_ctrl);
>> +       struct adapter *adapter = g_malloc0(sizeof(struct adapter));
>> +
>> +       adapter->proxy = proxy;
>> +       ctrl_list = g_list_append(ctrl_list, adapter);
>> +
>> +       if (!default_ctrl)
>> +               default_ctrl = adapter;
>> +
>>         print_adapter(proxy, COLORED_NEW);
>>  }
>>
>> --
>> 2.7.4
>>
> 
> 

