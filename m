Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3054242.MalPW5PRBD@ix>
References: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20171221164720.20925-2-grzegorz.kolodziejczyk@codecoup.pl> <3054242.MalPW5PRBD@ix>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Fri, 22 Dec 2017 14:49:59 +0100
Message-ID: <CALevQMbjoAFdcTJsUfPfisCS2m1po2btrHxPwkMKHoqPfQXFSQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/6] tools/btpclient: Move string to address
 conversion to helper
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2017-12-22 11:48 GMT+01:00 Szymon Janc <szymon.janc@codecoup.pl>:
> Hi Grzegorz,
>
> On Thursday, 21 December 2017 17:47:16 CET Grzegorz Kolodziejczyk wrote:
>> This patch makes local helper with string to address conversion.
>> ---
>>  tools/btpclient.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/btpclient.c b/tools/btpclient.c
>> index 9ea624995..27e5a498e 100644
>> --- a/tools/btpclient.c
>> +++ b/tools/btpclient.c
>> @@ -52,6 +52,12 @@ static struct btp *btp;
>>
>>  static bool gap_service_registered;
>>
>> +static inline uint8_t str2addr(const char *str, uint8_t *addr)
>
> Just static, no need for inline in .c file.
> Also make this return bool and verify sscanf return value in helper.
OK
>
>> +{
>> +     return sscanf(str,"%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &addr[5], &addr=
[4],
>> +                                     &addr[3], &addr[2], &addr[1], &add=
r[0]);
>> +}
>> +
>>  static struct btp_adapter *find_adapter_by_proxy(struct l_dbus_proxy
>> *proxy) {
>>       const struct l_queue_entry *entry;
>> @@ -171,9 +177,7 @@ static void btp_gap_read_info(uint8_t index, const v=
oid
>> *param, uint16_t length, if (!l_dbus_proxy_get_property(adapter->proxy,
>> "Address", "s", &str)) goto failed;
>>
>> -     if (sscanf(str,"%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
>> -                     &rp.address[5], &rp.address[4], &rp.address[3],
>> -                     &rp.address[2], &rp.address[1], &rp.address[0]) !=
=3D 6)
>> +     if (str2addr(str, rp.address) !=3D 6)
>>               goto failed;
>>
>>       if (!l_dbus_proxy_get_property(adapter->proxy, "Name", "s", &str))=
 {
>
>
> --
> pozdrawiam
> Szymon Janc

pozdrawiam,
Grzegorz Ko=C5=82odziejczyk
