Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <F61B4D04CD1C194FA7CDCAF0858DC65C01A046EF57@SDCEXMBX2.ARRS.ARRISI.com>
References: <20170901035615.95402-1-yunhanw@google.com> <a4eb008e-5c19-c13c-bb35-ac840f80be42@jp.fujitsu.com>
 <CALvjcs-3W8skPEH0TyHgwX=TSzrKcMy5ptjeHPbR+kY7x8hVvw@mail.gmail.com> <F61B4D04CD1C194FA7CDCAF0858DC65C01A046EF57@SDCEXMBX2.ARRS.ARRISI.com>
From: Yunhan Wang <yunhanw@google.com>
Date: Tue, 5 Sep 2017 22:42:45 -0700
Message-ID: <CALvjcs9jEHwj5CC7tQ95ub8Q4rNan_SYCFxY15JTtM1-bJRXdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Fix default_ctrl change when new adapter is found
To: "Zhang, Ming" <Ming.Zhang@arris.com>
Cc: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Ming

Could you post your command from your peripheral and central? Usually
when you set the attribute with read,write permission in peripheral,
then in central, you can select-attribute the characteristic path, and
read/write.

thanks
best wishes
yunhan

On Fri, Sep 1, 2017 at 2:06 PM, Zhang, Ming <Ming.Zhang@arris.com> wrote:
> Hello,
>
> Can anybody give a help with BlueZ utility bluetoothctl?
> - "read" and "write" commands seem not working? always report "no attribu=
te selected", using "select-attribute" first doesn't help.
>
> Thanks,
> Ming
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner=
@vger.kernel.org] On Behalf Of Yunhan Wang
> Sent: Friday, September 01, 2017 12:43 AM
> To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH BlueZ] client: Fix default_ctrl change when new adapt=
er is found
>
> Hi, ERAMOTO
>
> cache_ctrl is not advertising manager, cache_ctrl is temporary adapter th=
at store newest adapter info(see the below structure info). When you use se=
lect, find_ctrl_by_address would filter your preferred adapter by your addr=
ess, then if it is default, return, otherwise, it would update default_ctrl=
.
>
> struct adapter {
> GDBusProxy *proxy;
> GDBusProxy *ad_proxy;
> GList *devices;
> };
>
> when new adapter is found, the proxy handler would add adapter proxy, pro=
file proxy, advertising proxy sequentially, in this procedure, cache_ctrl w=
ould update advertising manager.
>
> thanks
> best wishes
> yunhan
>
> On Fri, Sep 1, 2017 at 12:28 AM, ERAMOTO Masaya <eramoto.masaya@jp.fujits=
u.com> wrote:
>> Hi Yunhan,
>>
>> Your patch have a regression, since select command can not update the
>> current advertising manager (cache_ctrl) when it chooses another adapter=
.
>>
>> I think that it is better to use proxy->obj_path below:
>>
>> ---
>>  client/main.c | 57
>> +++++++++++++++++++++++++++++++++++++++------------------
>>  1 file changed, 39 insertions(+), 18 deletions(-)
>>
>> diff --git a/client/main.c b/client/main.c index 825647d..c6cb995
>> 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -525,17 +525,52 @@ static void device_added(GDBusProxy *proxy)
>>         }
>>  }
>>
>> +static struct adapter *find_ctrl(GList *source, const char *path) {
>> +       GList *list;
>> +
>> +       for (list =3D g_list_first(source); list; list =3D g_list_next(l=
ist)) {
>> +               struct adapter *adapter =3D list->data;
>> +
>> +               if (!strcasecmp(g_dbus_proxy_get_path(adapter->proxy), p=
ath))
>> +                       return adapter;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static struct adapter *adapter_new(GDBusProxy *proxy) {
>> +       struct adapter *adapter =3D g_malloc0(sizeof(struct adapter));
>> +
>> +       ctrl_list =3D g_list_append(ctrl_list, adapter);
>> +
>> +       if (!default_ctrl)
>> +               default_ctrl =3D adapter;
>> +
>> +       return adapter;
>> +}
>> +
>>  static void adapter_added(GDBusProxy *proxy)  {
>> -       default_ctrl =3D g_malloc0(sizeof(struct adapter));
>> -       default_ctrl->proxy =3D proxy;
>> -       ctrl_list =3D g_list_append(ctrl_list, default_ctrl);
>> +       struct adapter *ctrl;
>> +       ctrl =3D find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
>> +       if (!ctrl)
>> +               ctrl =3D adapter_new(proxy);
>> +
>> +       ctrl->proxy =3D proxy;
>> +
>>         print_adapter(proxy, COLORED_NEW);  }
>>
>>  static void ad_manager_added(GDBusProxy *proxy)  {
>> -       default_ctrl->ad_proxy =3D proxy;
>> +       struct adapter *ctrl;
>> +       ctrl =3D find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
>> +       if (!ctrl)
>> +               ctrl =3D adapter_new(proxy);
>> +
>> +       ctrl->ad_proxy =3D proxy;
>>  }
>>
>>  static void proxy_added(GDBusProxy *proxy, void *user_data) @@
>> -661,20 +696,6 @@ static void proxy_removed(GDBusProxy *proxy, void *use=
r_data)
>>         }
>>  }
>>
>> -static struct adapter *find_ctrl(GList *source, const char *path) -{
>> -       GList *list;
>> -
>> -       for (list =3D g_list_first(source); list; list =3D g_list_next(l=
ist)) {
>> -               struct adapter *adapter =3D list->data;
>> -
>> -               if (!strcasecmp(g_dbus_proxy_get_path(adapter->proxy), p=
ath))
>> -                       return adapter;
>> -       }
>> -
>> -       return NULL;
>> -}
>> -
>>  static void property_changed(GDBusProxy *proxy, const char *name,
>>                                         DBusMessageIter *iter, void
>> *user_data)  {
>> --
>> 2.7.4
>>
>>
>> Regards,
>> Eramoto
>>
>> On 09/01/2017 12:56 PM, Yunhan Wang wrote:
>>> When another adapter is found, the default adapter would be changed,
>>> which is not expected. Default adapter can only be changed by select
>>> command.
>>> ---
>>>  client/main.c | 18 ++++++++++++------
>>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/client/main.c b/client/main.c index 75696c2c1..29b3978e1
>>> 100644
>>> --- a/client/main.c
>>> +++ b/client/main.c
>>> @@ -67,6 +67,7 @@ struct adapter {
>>>  };
>>>
>>>  static struct adapter *default_ctrl;
>>> +static struct adapter *cache_ctrl;
>>>  static GDBusProxy *default_dev;
>>>  static GDBusProxy *default_attr;
>>>  static GList *ctrl_list;
>>> @@ -151,7 +152,7 @@ static void disconnect_handler(DBusConnection
>>> *connection, void *user_data)
>>>
>>>       g_list_free_full(ctrl_list, proxy_leak);
>>>       ctrl_list =3D NULL;
>>> -
>>> +     cache_ctrl =3D NULL;
>>>       default_ctrl =3D NULL;
>>>  }
>>>
>>> @@ -521,15 +522,21 @@ static void device_added(GDBusProxy *proxy)
>>>
>>>  static void adapter_added(GDBusProxy *proxy)  {
>>> -     default_ctrl =3D g_malloc0(sizeof(struct adapter));
>>> -     default_ctrl->proxy =3D proxy;
>>> -     ctrl_list =3D g_list_append(ctrl_list, default_ctrl);
>>> +     struct adapter *adapter =3D g_malloc0(sizeof(struct adapter));
>>> +
>>> +     adapter->proxy =3D proxy;
>>> +     cache_ctrl =3D adapter;
>>> +     ctrl_list =3D g_list_append(ctrl_list, adapter);
>>> +
>>> +     if (!default_ctrl)
>>> +             default_ctrl =3D adapter;
>>> +
>>>       print_adapter(proxy, COLORED_NEW);  }
>>>
>>>  static void ad_manager_added(GDBusProxy *proxy)  {
>>> -     default_ctrl->ad_proxy =3D proxy;
>>> +     cache_ctrl->ad_proxy =3D proxy;
>>>  }
>>>
>>>  static void proxy_added(GDBusProxy *proxy, void *user_data) @@
>>> -602,7 +609,6 @@ static void adapter_removed(GDBusProxy *proxy)
>>>                       print_adapter(proxy, COLORED_DEL);
>>>
>>>                       if (default_ctrl && default_ctrl->proxy =3D=3D pr=
oxy) {
>>> -                             default_ctrl =3D NULL;
>>>                               set_default_device(NULL, NULL);
>>>                       }
>>>
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in the body of a message to majordomo@vger.kernel.org More majordomo info=
 at  https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fvger=
.kernel.org%2Fmajordomo-info.html&data=3D01%7C01%7CMing.Zhang%40arris.com%7=
Cd0163e6bd854446caf6d08d4f10d0444%7Cf27929ade5544d55837ac561519c3091%7C1&sd=
ata=3DjIiRTYhnB4kdGAnIPR2dPtm8i6ialLQFfyGfUS1BxEo%3D&reserved=3D0
