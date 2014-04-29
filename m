Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+fhCw4mHDBtSz2NBgxDGKxUXpQSZVV5WCUFc2Ji20xfA@mail.gmail.com>
References: <1398763780-16592-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1398763780-16592-2-git-send-email-andrzej.kaczmarek@tieto.com> <CABBYNZ+fhCw4mHDBtSz2NBgxDGKxUXpQSZVV5WCUFc2Ji20xfA@mail.gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Tue, 29 Apr 2014 17:31:58 +0200
Message-ID: <CAF3PWx2mQyBuwzv5ui07MC0tk+t2236CZ2ao2PfSPWDcFFDCOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hog: Improve report map debugging
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 29 April 2014 14:50, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Andrzej,
>
> On Tue, Apr 29, 2014 at 12:29 PM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:
>> Now that we can split report map into items it's convenient to have it
>> printed with items structure preserved which makes it more useful for
>> debugging.
>> ---
>>  profiles/input/hog.c | 64 +++++++++++++++++++++++++++++++---------------------
>>  1 file changed, 38 insertions(+), 26 deletions(-)
>>
>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>> index ab88414..c43ce6a 100644
>> --- a/profiles/input/hog.c
>> +++ b/profiles/input/hog.c
>> @@ -378,6 +378,28 @@ static bool parse_descriptor_item(uint8_t *buf, ssize_t blen, ssize_t *len,
>>         return *len <= blen;
>>  }
>>
>> +static void report_map_item(uint8_t *buf, uint8_t len)
>> +{
>> +       char str[51]; /* 16x3 (data) + 2 (continuation marker) + 1 (null) */
>> +       char *p = str;
>> +       int i;
>> +
>> +       i = 0;
>> +       while (i < len) {
>> +               p += sprintf(p, " %02x", buf[i]);
>> +
>> +               i++;
>> +
>> +               if (i % 16 == 0 && i < len) {
>> +                       sprintf(p, " \\");
>> +                       DBG("%s", str);
>> +                       p = str;
>> +               }
>> +       }
>> +
>> +       DBG("%s", str);
>> +}
>
> I would call it print_report, in future we might actually need to
> check if debug is enabled and bail out since otherwise it just run a
> useless loop that prints nothing.

I changed this to return string buffer so it can be used as DBG("%s",
item2string(...)) so it's not called without debug. I think 'item' is
better here than 'report' since Report Map is in fact Report
Descriptor consisting of items, as defined by HID spec.

>>  static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>                                                         gpointer user_data)
>>  {
>> @@ -388,7 +410,6 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>         uint16_t vendor_src, vendor, product, version;
>>         ssize_t vlen;
>>         int i;
>> -       int next_item = 0;
>>
>>         if (status != 0) {
>>                 error("Report Map read failed: %s", att_ecode2str(status));
>> @@ -402,35 +423,26 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>         }
>>
>>         DBG("Report MAP:");
>> -       for (i = 0; i < vlen; i++) {
>> +       for (i = 0; i < vlen;) {
>>                 ssize_t item_len = 0;
>>                 bool is_long_item = false;
>>
>> -               if (i == next_item) {
>> -                       if (parse_descriptor_item(&value[i], vlen - i,
>> -                                                       &item_len,
>> -                                                       &is_long_item)) {
>> -                               /* Report ID is short item with prefix
>> -                                * 100001xx (binary)
>> -                                */
>> -                               if (!is_long_item && (value[i] & 0xfc) == 0x84)
>> -                                       hogdev->has_report_id = TRUE;
>> -
>> -                               next_item += item_len;
>> -                       } else {
>> -                               error("Report Map parsing failed at %d", i);
>> -
>> -                               /* We do not increase next_item here so we won't
>> -                                * parse subsequent data - this is what we want.
>> -                                */
>> -                       }
>> -               }
>> +               if (parse_descriptor_item(&value[i], vlen - i,
>> +                                               &item_len,
>> +                                               &is_long_item)) {
>> +                       /* Report ID is short item with prefix 100001xx */
>> +                       if (!is_long_item && (value[i] & 0xfc) == 0x84)
>> +                               hogdev->has_report_id = TRUE;
>>
>> -               if (i % 2 == 0) {
>> -                       if (i + 1 == vlen)
>> -                               DBG("\t %02x", value[i]);
>> -                       else
>> -                               DBG("\t %02x %02x", value[i], value[i + 1]);
>> +                       report_map_item(&value[i], item_len);
>> +
>> +                       i += item_len;
>> +               } else {
>> +                       error("Report Map parsing failed at %d", i);
>> +
>> +                       /* Just print remaining items at once and break */
>> +                       report_map_item(&value[i], vlen - i);
>> +                       break;
>>                 }
>
> I would consider error on parse_descriptor so you can actually break
> on the if parse_descriptor fails.

This is how it works now: breaks parsing in case
parse_descriptor_item(). Or did I misunderstood?

BR,
Andrzej
