Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs-hCShRT8GSNP0z8HDGOqMOd6xCaRc1JhXhReOf45rX+w@mail.gmail.com>
References: <37259a70-d8d0-0cff-5d59-460917c5010f@jp.fujitsu.com> <CALvjcs-hCShRT8GSNP0z8HDGOqMOd6xCaRc1JhXhReOf45rX+w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 31 Aug 2017 11:10:54 +0300
Message-ID: <CABBYNZLWwa3qEjg2D25jSwiJ+a5LzW94dATQgCKvJoZRUW-eDQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Fix default controller in interactive mode
To: Yunhan Wang <yunhanw@google.com>
Cc: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto, Yunhan,

On Thu, Aug 31, 2017 at 8:02 AM, Yunhan Wang <yunhanw@google.com> wrote:
> Hi, ERAMOTO
>
> With this change, when second adapter is enumerated.
> default_ctrl->ad_proxy would be assigned with advertising proxy from
> second adapter, but default_ctrl->proxy is still first adapter proxy.

Sounds like a bug if we cannot detect where the ad proxy should be added.

> Yes, when there are two adapters, the newest adapter is chosen as
> default one.  It is not good when you have adapter A in test, and
> later attach another adapter B. But if you make all adapters ready
> before your test is running, then you can use "select" to choose the
> default adapter.

This is bogus since we are not even printing anything when the default
changes. The user should have full control over what is the selected
adapter, the only exception is when the current default adapter is
removed it should automatically select a new default if there is at
least one available.

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

We might as well print the new add something to print_adapter to tell
if it is the default, also like I mentioned above if the default
adapter is removed we should select a new default and hint it to the
user.

>> +
>>         print_adapter(proxy, COLORED_NEW);
>>  }
>>
>> --
>> 2.7.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
