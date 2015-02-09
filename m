Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <002f01d0445d$73759f40$5a60ddc0$@samsung.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
	<1423220624-18861-13-git-send-email-luiz.dentz@gmail.com>
	<002f01d0445d$73759f40$5a60ddc0$@samsung.com>
Date: Mon, 9 Feb 2015 15:14:01 +0200
Message-ID: <CABBYNZJ_Op_8SiiVHDY57j4juo6cok-73O_sCyaZBiciZFhQXA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 12/12] client: Handle attribute notifications
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Feb 9, 2015 at 1:41 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>> Sent: Friday, February 06, 2015 4:34 PM
>> To: linux-bluetooth@vger.kernel.org
>> Subject: [PATCH BlueZ 12/12] client: Handle attribute notifications
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This enable printing properties changes to the current selected attribute.
>> ---
>>  client/main.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/client/main.c b/client/main.c index 57b1201..fbfd8c8 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -158,6 +158,7 @@ static void print_iter(const char *label, const char
>> *name,
>>       dbus_uint32_t valu32;
>>       dbus_uint16_t valu16;
>>       dbus_int16_t vals16;
>> +     unsigned char byte;
>>       const char *valstr;
>>       DBusMessageIter subiter;
>>
>> @@ -192,6 +193,10 @@ static void print_iter(const char *label, const char
>> *name,
>>               dbus_message_iter_get_basic(iter, &vals16);
>>               rl_printf("%s%s: %d\n", label, name, vals16);
>>               break;
>> +     case DBUS_TYPE_BYTE:
>> +             dbus_message_iter_get_basic(iter, &byte);
>> +             rl_printf("%s%s: 0x%02x\n", label, name, byte);
>> +             break;
>>       case DBUS_TYPE_VARIANT:
>>               dbus_message_iter_recurse(iter, &subiter);
>>               print_iter(label, name, &subiter);
>> @@ -494,6 +499,14 @@ static void property_changed(GDBusProxy *proxy,
>> const char *name,
>>
>>               print_iter(str, name, iter);
>>               g_free(str);
>> +     } else if (proxy == default_attr) {
>> +             char *str;
>> +
>> +             str = g_strdup_printf("[" COLORED_CHG "] Attribute %s ",
>> +
>>       g_dbus_proxy_get_path(proxy));
>> +
>> +             print_iter(str, name, iter);
>
> Here I suppose, g_free(str) should come. Because the returned string (str)
> should be freed when no longer needed.
> And str = g_strdup(""); seems like Dead assignment. Other than that
> everything applied cleanly with no warnings/errors.
>
> Regards,
> Gowtham Anandha Babu
>
>> +             str = g_strdup("");

Indeed this is a dead assignment, not sure why it did not catch during
the build, perhaps that should be g_free not g_strdup.


-- 
Luiz Augusto von Dentz
