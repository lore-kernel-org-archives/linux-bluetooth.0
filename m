Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <003e01cffd98$675c9210$3615b630$@samsung.com>
References: <1415194959-18169-1-git-send-email-vikram.pal@samsung.com>
	<CABBYNZKXeLfm5dK6c-x=rRRuQSXgC2gYGUav0XGsv4sKQKzFFw@mail.gmail.com>
	<003e01cffd98$675c9210$3615b630$@samsung.com>
Date: Tue, 11 Nov 2014 13:08:49 +0200
Message-ID: <CABBYNZ+P-s0ya7K3p7HOmP=8KVVkceZrB9nLBQgpBwtwvxAAmA@mail.gmail.com>
Subject: Re: [PATCH] monitor: Fix AVRCP GetElementAttributes formatting issue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Tue, Nov 11, 2014 at 12:15 PM, Vikrampal <vikram.pal@samsung.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Tuesday, November 11, 2014 3:07 PM
>> To: Vikrampal Yadav
>> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; cpgs@samsung.com
>> Subject: Re: [PATCH] monitor: Fix AVRCP GetElementAttributes formatting
>> issue
>>
>> Hi Vikram,
>>
>> On Wed, Nov 5, 2014 at 3:42 PM, Vikrampal Yadav
>> <vikram.pal@samsung.com> wrote:
>> > AVRCP GetElementAttributes formatting issue for AttributeValue fixed.
>> >
>> >       AVCTP Control: Response: type 0x00 label 4 PID 0x110e
>> >         AV/C: Stable: address 0x48 opcode 0x00
>> >           Subunit: Panel
>> >           Opcode: Vendor Dependent
>> >           Company ID: 0x001958
>> >           AVRCP: GetElementAttributes pt Single len 0x0040
>> >             AttributeCount: 0x04
>> >             Attribute: 0x00000001 (Title)
>> >             CharsetID: 0x006a (UTF-8)
>> >             AttributeValueLength: 0x0008
>> >             AttributeValue: fernando
>> >             Attribute: 0x00000002 (Artist)
>> >             CharsetID: 0x006a (UTF-8)
>> >             AttributeValueLength: 0x0004
>> >             AttributeValue: abba
>> >             Attribute: 0x00000003 (Album)
>> >             CharsetID: 0x006a (UTF-8)
>> >             AttributeValueLength: 0x000d
>> >             AttributeValue: Greatest Hits
>> >             Attribute: 0x00000007 (Track duration)
>> >             CharsetID: 0x006a (UTF-8)
>> >             AttributeValueLength: 0x0006
>> >             AttributeValue: 150000
>>
>> I don't get it, you seem to be changing ContinuingAttributeValue yet the
>> frame above does not contain it?
>
> This fix is also for AttributeValue. While reviewing found issue with ContinuingAttributeValue
> as well so fixed both.

Ok, then please fix the buffer size.

>> > ---
>> >  monitor/avctp.c | 20 +++++++++++++-------
>> >  1 file changed, 13 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/monitor/avctp.c b/monitor/avctp.c index 4abd18f..11579ad
>> > 100644
>> > --- a/monitor/avctp.c
>> > +++ b/monitor/avctp.c
>> > @@ -1122,7 +1122,9 @@ response:
>> >                 num = avrcp_continuing.num;
>> >
>> >                 if (avrcp_continuing.size > 0) {
>> > +                       char attrval[1024];
>>
>> The buffer should be as big as size can be which is UINT8_MAX.
>>
>> >                         uint16_t size;
>> > +                       uint8_t idx;
>> >
>> >                         if (avrcp_continuing.size > len) {
>> >                                 size = len; @@ -1132,16 +1134,17 @@
>> > response:
>> >                                 avrcp_continuing.size = 0;
>> >                         }
>> >
>> > -                       printf("ContinuingAttributeValue: ");
>> > -                       for (; size > 0; size--) {
>> > +                       for (idx = 0; size > 0; idx++, size--) {
>> >                                 uint8_t c;
>> >
>> >                                 if (!l2cap_frame_get_u8(frame, &c))
>> >                                         goto failed;
>> >
>> > -                               printf("%1c", isprint(c) ? c : '.');
>> > +                               sprintf(&attrval[idx], "%1c",
>> > +                                                       isprint(c) ? c
>> > + : '.');
>> >                         }
>> > -                       printf("\n");
>> > +                       print_field("%*cContinuingAttributeValue: %s",
>> > +                                               (indent - 8), ' ',
>> > + attrval);
>> >
>> >                         len -= size;
>> >                 }
>> > @@ -1153,6 +1156,8 @@ response:
>> >         while (num > 0 && len > 0) {
>> >                 uint32_t attr;
>> >                 uint16_t charset, attrlen;
>> > +               uint8_t idx;
>> > +               char attrval[1024];
>>
>> Same here, use UINT8_MAX.
>>
>> >                 if (!l2cap_frame_get_be32(frame, &attr))
>> >                         goto failed;
>> > @@ -1175,15 +1180,16 @@ response:
>> >                 len -= sizeof(attr) + sizeof(charset) + sizeof(attrlen);
>> >                 num--;
>> >
>> > -               print_field("%*cAttributeValue: ", (indent - 8), ' ');
>> > -               for (; attrlen > 0 && len > 0; attrlen--, len--) {
>> > +               for (idx = 0; attrlen > 0 && len > 0; idx++,
>> > + attrlen--, len--) {
>> >                         uint8_t c;
>> >
>> >                         if (!l2cap_frame_get_u8(frame, &c))
>> >                                 goto failed;
>> >
>> > -                       printf("%1c", isprint(c) ? c : '.');
>> > +                       sprintf(&attrval[idx], "%1c", isprint(c) ? c :
>> > + '.');
>> >                 }
>> > +               print_field("%*cAttributeValue: %s", (indent - 8),
>> > +                                                               ' ',
>> > + attrval);
>> >
>> >                 if (attrlen > 0)
>> >                         avrcp_continuing.size = attrlen;
>> > --
>> > 1.9.1
>> >
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> Regards,
> Vikram
>



-- 
Luiz Augusto von Dentz
