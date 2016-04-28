Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJGcppzwCEWWpoKxt2ci7UBOzTYY03cxGqzysVm1+BtNA@mail.gmail.com>
References: <1461744108-21366-1-git-send-email-beaufort.francois@gmail.com>
 <1461744108-21366-2-git-send-email-beaufort.francois@gmail.com> <CABBYNZJGcppzwCEWWpoKxt2ci7UBOzTYY03cxGqzysVm1+BtNA@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Thu, 28 Apr 2016 08:59:57 +0200
Message-ID: <CAEZxfGMZZu0yoCSKj9RnROoPjccDFKg0k4Ni+L6kuEK=20sM7g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Set RSSI_THRESHOLD to 2
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I believe Chromium team uses a RSSI threshold as low as possible (2)
for two reasons:
- They were experimenting with RSSI for proximity.
- So that they can surface accurate values to JavaScript since Bluez
notifies Chrome right away when the RSSI changes

On Wed, Apr 27, 2016 at 10:47 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Francois,
>
> On Wed, Apr 27, 2016 at 11:01 AM, Francois Beaufort
> <beaufort.francois@gmail.com> wrote:
>> ---
>>  src/device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 5269ee8..1caeee7 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -85,7 +85,7 @@
>>  #define MIN(a, b) ((a) < (b) ? (a) : (b))
>>  #endif
>>
>> -#define RSSI_THRESHOLD         8
>> +#define RSSI_THRESHOLD         2
>>
>>  #define GATT_PRIM_SVC_UUID_STR "2800"
>>  #define GATT_SND_SVC_UUID_STR  "2801"
>> --
>> 2.7.0
>
> Do you guys have any numbers here?  This will probably spam more the
> bus with the same device being notified more often, also some
> controllers may not sense that small variation on RSSI or employ some
> filter for duplicated values although HCI inquiry don't seem to
> support that.
>
> --
> Luiz Augusto von Dentz
