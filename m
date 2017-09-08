Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+HSyR-FesC-Csuc14B-OF0Ffj7t9oWsnPrpiOy01CH1w@mail.gmail.com>
References: <CAFxSrVsWAbw4bRwk8En-O1sX3Afr2_N1Y=Snmdb3QTZeW8niUA@mail.gmail.com>
 <CABBYNZ+HSyR-FesC-Csuc14B-OF0Ffj7t9oWsnPrpiOy01CH1w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 8 Sep 2017 16:55:27 +0300
Message-ID: <CABBYNZ+QhwncFFSukBmmP1wriQM=+7FPH6PWq20+EBVy9CVv4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mesh: Remove StopNotify method to avoid reading data
 twice on some mesh nodes
To: Laczen JMS <laczenjms@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 8, 2017 at 4:47 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jehudi,
>
> On Fri, Sep 8, 2017 at 3:30 PM, Laczen JMS <laczenjms@gmail.com> wrote:
>> Some mesh nodes do not change (e.g. zephyr) the notification when
>> given the StopNotify. As a result the data from the notification
>> channel is processed twice. This patch removes the StopNotify.
>
> What do you mean the node do not change? Perhaps this is the result of
> bluetoothd remembering the subscriptions so you don't have to
> StopNotify while disconnected, though this should not cause the data
> to be processed twice otherwise we have a bug somewhere in the daemon.
>
>> Kind regards,
>>
>> Jehudi
>>
>>   diff --git a/mesh/gatt.c b/mesh/gatt.c
>> index f9615b3..7d3b869 100644
>> --- a/mesh/gatt.c
>> +++ b/mesh/gatt.c
>> @@ -589,15 +589,10 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool
>> enable, GDBusReturnFunction cb,
>>   cb = notify_reply;
>>   }
>>   } else {
>> - if (notify_io) {
>> - notify_io_destroy();
>> - if (cb)
>> - cb(NULL, user_data);
>> - return true;
>> - } else {
>> - method = "StopNotify";
>> - cb = notify_reply;
>> - }
>> + if (notify_io) notify_io_destroy();
>> + if (cb) cb(NULL, user_data);
>> +
>> + return true;
>>   }
>>
>>   if (g_dbus_proxy_method_call(proxy, method, NULL, cb,

Btw please have a look in our HACKING document on how to contribute patches:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING

-- 
Luiz Augusto von Dentz
