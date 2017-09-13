Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLgHhTk-xKm4wUmPdc+YzYu69a2g64wEKAcSJEKNCBEjQ@mail.gmail.com>
References: <20170906052743.6821-1-yunhanw@google.com> <CABBYNZLgHhTk-xKm4wUmPdc+YzYu69a2g64wEKAcSJEKNCBEjQ@mail.gmail.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Wed, 13 Sep 2017 00:37:59 -0700
Message-ID: <CALvjcs_+o5z8-cX7QKBjCFwXwSv3X1MS2yoCfmByA83o9xUqYQ@mail.gmail.com>
Subject: Re: [PATCH v2] client: Fix default_ctrl change when new adapter is found
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

Thank you. Just submit the fix. Sorry for the delay fix.

Best wishes
Yunhan

On Wed, Sep 6, 2017 at 1:33 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Yunhan,
>
> On Wed, Sep 6, 2017 at 8:27 AM, Yunhan Wang <yunhanw@google.com> wrote:
>> When another adapter is found, the default adapter would be changed,
>> which is not expected. Default adapter can only be changed by select
>> command.
>> ---
>>  client/main.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/client/main.c b/client/main.c
>> index 75696c2c1..e76b6fc25 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -67,6 +67,7 @@ struct adapter {
>>  };
>>
>>  static struct adapter *default_ctrl;
>> +static struct adapter *cache_ctrl;
>>  static GDBusProxy *default_dev;
>>  static GDBusProxy *default_attr;
>>  static GList *ctrl_list;
>> @@ -151,7 +152,7 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
>>
>>         g_list_free_full(ctrl_list, proxy_leak);
>>         ctrl_list = NULL;
>> -
>> +       cache_ctrl = NULL;
>>         default_ctrl = NULL;
>>  }
>>
>> @@ -521,15 +522,21 @@ static void device_added(GDBusProxy *proxy)
>>
>>  static void adapter_added(GDBusProxy *proxy)
>>  {
>> -       default_ctrl = g_malloc0(sizeof(struct adapter));
>> -       default_ctrl->proxy = proxy;
>> -       ctrl_list = g_list_append(ctrl_list, default_ctrl);
>> +       struct adapter *adapter = g_malloc0(sizeof(struct adapter));
>> +
>> +       adapter->proxy = proxy;
>> +       cache_ctrl = adapter;
>
> Lets not do this, we should never assume any specific order in which
> the proxies are discovered.
>
>> +       ctrl_list = g_list_append(ctrl_list, adapter);
>> +
>> +       if (!default_ctrl)
>> +               default_ctrl = adapter;
>> +
>>         print_adapter(proxy, COLORED_NEW);
>>  }
>>
>>  static void ad_manager_added(GDBusProxy *proxy)
>>  {
>> -       default_ctrl->ad_proxy = proxy;
>> +       cache_ctrl->ad_proxy = proxy;
>
> So instead of caching the last controller found this should lookup the
> adapter pointer from the ctrl_list and then update its ad_proxy.
>
>>  }
>>
>>  static void proxy_added(GDBusProxy *proxy, void *user_data)
>> --
>> 2.14.1.581.gf28d330327-goog
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
