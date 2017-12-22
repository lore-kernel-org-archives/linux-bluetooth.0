Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4965681.kZWkZL0VDl@ix>
References: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20171221164720.20925-3-grzegorz.kolodziejczyk@codecoup.pl> <4965681.kZWkZL0VDl@ix>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Fri, 22 Dec 2017 14:50:32 +0100
Message-ID: <CALevQMZRxV8j=_3VXNZC4-kdiisTqGpeGHnDp_0eG4y_57x3Uw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/6] tools/btpclient: Add advertising proxy to adapter
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2017-12-22 11:48 GMT+01:00 Szymon Janc <szymon.janc@codecoup.pl>:
> Hi Grzegorz,
>
> On Thursday, 21 December 2017 17:47:17 CET Grzegorz Kolodziejczyk wrote:
>> Advertising manager proxy is required to handle advertise related
>> operations in adapter context.
>> ---
>>  tools/btpclient.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/tools/btpclient.c b/tools/btpclient.c
>> index 27e5a498e..095c5ea3e 100644
>> --- a/tools/btpclient.c
>> +++ b/tools/btpclient.c
>> @@ -36,6 +36,7 @@
>>
>>  struct btp_adapter {
>>       struct l_dbus_proxy *proxy;
>> +     struct l_dbus_proxy *ad_proxy;
>>       uint8_t index;
>>       uint32_t supported_settings;
>>       uint32_t current_settings;
>> @@ -659,6 +660,17 @@ static void proxy_added(struct l_dbus_proxy *proxy,
>> void *user_data) device->proxy =3D proxy;
>>
>>               l_queue_push_tail(adapter->devices, device);
>> +
>> +             return;
>> +     }
>> +
>> +     if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
>> +             struct btp_adapter *adapter;
>> +
>> +             adapter =3D find_adapter_by_path(path);
>
> This may return NULL if we failed to add proxy of adapter or due to inval=
id
> message. Please check that.
OK
>
>> +
>> +             adapter->ad_proxy =3D proxy;
>> +
>>               return;
>>       }
>>  }
>
>
> --
> pozdrawiam
> Szymon Janc

pozdrawiam
Grzegorz Ko=C5=82odziejczyk
