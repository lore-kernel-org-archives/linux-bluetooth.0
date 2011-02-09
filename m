Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110209142118.GD1995@joana>
References: <1297260110-10515-1-git-send-email-andre.dieb@signove.com>
	<1297260110-10515-6-git-send-email-andre.dieb@signove.com>
	<20110209142118.GD1995@joana>
Date: Wed, 9 Feb 2011 12:28:50 -0200
Message-ID: <AANLkTimeyZ+45d+nQjHU+JumELzvYEgZYf8zx-ZgCe1a@mail.gmail.com>
Subject: Re: [PATCH 6/7] Add ATT dump for read req/resp
From: =?UTF-8?Q?Andr=C3=A9_Dieb?= <andre.dieb@signove.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Besides its opcode (which was already parsed), read response contains
only the attribute value octets.

To further parse it, I think we'd need to store the handle of the read
request, match it against a UUID table and maybe parse the read
response format, if any. Maybe too much work?

I must note I liked raw_dump() for this because it also prints out
chars, which make attribs. like device name have a nice dump.

On Wed, Feb 9, 2011 at 12:21 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Andre,
>
> * Andre Dieb Martins <andre.dieb@signove.com> [2011-02-09 11:01:49 -0300]:
>
>> ---
>>  parser/att.c |   14 ++++++++++++++
>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/parser/att.c b/parser/att.c
>> index b172f95..2a9da30 100644
>> --- a/parser/att.c
>> +++ b/parser/att.c
>> @@ -331,6 +331,14 @@ static void att_find_info_resp_dump(int level, struct frame *frm)
>>       }
>>  }
>>
>> +static void att_read_req_dump(int level, struct frame *frm)
>> +{
>> +     uint16_t handle = btohs(htons(get_u16(frm)));
>> +
>> +     p_indent(level, frm);
>> +     printf("handle 0x%2.2x\n", handle);
>> +}
>> +
>>  static void att_handle_notify_dump(int level, struct frame *frm)
>>  {
>>       uint16_t handle = btohs(htons(get_u16(frm)));
>> @@ -371,6 +379,12 @@ void att_dump(int level, struct frame *frm)
>>               case ATT_OP_FIND_INFO_RESP:
>>                       att_find_info_resp_dump(level + 1, frm);
>>                       break;
>> +             case ATT_OP_READ_REQ:
>> +                     att_read_req_dump(level + 1, frm);
>> +                     break;
>> +             case ATT_OP_READ_RESP:
>> +                     raw_dump(level + 1, frm);
>
> raw_dump?
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>
