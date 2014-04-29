Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL=gidP7m89NACUPBnL87+JDO3kG8zHLHCbz7_+3-WCXw@mail.gmail.com>
References: <1398763780-16592-1-git-send-email-andrzej.kaczmarek@tieto.com> <CABBYNZL=gidP7m89NACUPBnL87+JDO3kG8zHLHCbz7_+3-WCXw@mail.gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Tue, 29 Apr 2014 15:56:14 +0200
Message-ID: <CAF3PWx3xm0RH8DYR=w4PcC_ZDVKeQOhiMZuL8b27U=79+-nw2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] hog: Fix checking for Report ID item
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 29 April 2014 14:37, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Andrzej,
>
> On Tue, Apr 29, 2014 at 12:29 PM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:
>> Report ID item is detected by just looking for possible item prefixes
>> anywhere in report map. This could lead to false-positive detection if
>> value we look for is inside item data.
>>
>> This patch adds simple parser which can split report map into proper
>> items and check for Report ID item in reliable way.
>
> Well it looks like the format of each descriptor can be different so I
> would add this to the patch description and probably quote from spec
> what is those formats.

Sure, I can add better description why parsing is done this way.

>> ---
>>  profiles/input/hog.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 55 insertions(+), 5 deletions(-)
>>
>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>> index a11e04e..ab88414 100644
>> --- a/profiles/input/hog.c
>> +++ b/profiles/input/hog.c
>> @@ -345,6 +345,39 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
>>                                         external_service_char_cb, hogdev);
>>  }
>>
>> +static bool parse_descriptor_item(uint8_t *buf, ssize_t blen, ssize_t *len,
>> +                                                               bool *is_long)
>> +{
>> +       if (!blen)
>> +               return false;
>> +
>> +       if (buf[0] == 0xFE) {
>> +               if (blen < 3)
>> +                       return false;
>> +               /* long item:
>> +                * byte 0 -> 0xFE
>> +                * byte 1 -> data size
>> +                * byte 2 -> tag
>> +                * + data
>> +                */
>> +               *len = buf[1] + 3;
>> +               *is_long = true;
>> +       } else {
>> +               uint8_t b_size;
>> +               /* short item:
>> +                * byte 0[1..0] -> data size (=0, 1, 2, 4)
>> +                * byte 0[3..2] -> type
>> +                * byte 0[7..4] -> tag
>> +                * + data
>> +                */
>> +               b_size = buf[0] & 0x03;
>> +               *len = (b_size ? 1 << (b_size - 1) : 0) + 1;
>> +               *is_long = false;
>> +       }
>
> Perhaps split this into 2 functions one to parse sort descriptors and
> one for long descriptors, also you can probably drop the item suffix
> e.g.: parse_short_descriptor, parse_long_descriptor.

I'll need to check 1st byte of item anyway in order to differentiate
between short and long item before calling proper handler so we'll end
up with code which calls one-liner functions.
Perhaps name of this function is misleading since we don't really
parse items here since this is something uhid will do. We just need to
figure out item length co we can skip to next one.

>> +       return *len <= blen;
>> +}
>> +
>>  static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>                                                         gpointer user_data)
>>  {
>> @@ -355,6 +388,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>         uint16_t vendor_src, vendor, product, version;
>>         ssize_t vlen;
>>         int i;
>> +       int next_item = 0;
>>
>>         if (status != 0) {
>>                 error("Report Map read failed: %s", att_ecode2str(status));
>> @@ -369,11 +403,27 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>
>>         DBG("Report MAP:");
>>         for (i = 0; i < vlen; i++) {
>> -               switch (value[i]) {
>> -               case 0x85:
>> -               case 0x86:
>> -               case 0x87:
>> -                       hogdev->has_report_id = TRUE;
>> +               ssize_t item_len = 0;
>> +               bool is_long_item = false;
>> +
>> +               if (i == next_item) {
>> +                       if (parse_descriptor_item(&value[i], vlen - i,
>> +                                                       &item_len,
>> +                                                       &is_long_item)) {
>> +                               /* Report ID is short item with prefix
>> +                                * 100001xx (binary)
>> +                                */
>> +                               if (!is_long_item && (value[i] & 0xfc) == 0x84)
>
> Hmm, so long descriptors are ignored? Is that really what we want?

Yes, long items do not matter here. We only need to know whether there
is at least one Report ID item inside descriptor (don't even care
about its contents) which is defined as short item by HID spec.

I'll try to make better description and function names for v2 so it's
clear what precisely we do here.

BR,
Andrzej
