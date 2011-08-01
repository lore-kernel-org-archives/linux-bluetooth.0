Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ_=cdTepd=gM9LfrfbAusd-g6wJ+ryDO4QEiqDsdO8Eg@mail.gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
 <1312188138-32265-2-git-send-email-luiz.dentz@gmail.com> <CAMOw1v6D65HgxLDDpmzg=TdnkBhBL0uGS7ikqiU3KkPOutWgcg@mail.gmail.com>
 <CABBYNZJ_=cdTepd=gM9LfrfbAusd-g6wJ+ryDO4QEiqDsdO8Eg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 1 Aug 2011 12:44:25 -0300
Message-ID: <CAMOw1v771o2aVOtxNf8UV4dSDzG1Jn-JNk85xZDijfbvt--Yow@mail.gmail.com>
Subject: Re: [PATCH hcidump 01/13] Don't parse response AVRCP pdu if ctype is NOT_IMPLETED
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 1, 2011 at 12:25 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Mon, Aug 1, 2011 at 5:11 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> On Mon, Aug 1, 2011 at 5:42 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> ---
>>>  parser/avrcp.c |    3 +++
>>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/parser/avrcp.c b/parser/avrcp.c
>>> index ff6862d..a1768e3 100644
>>> --- a/parser/avrcp.c
>>> +++ b/parser/avrcp.c
>>> @@ -347,6 +347,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
>>>                return;
>>>        }
>>>
>>> +       if (ctype == AVC_CTYPE_NOT_IMPLEMENTED)
>>> +               return;
>>> +
>>
>> From my reading of the spec, this check should be in avrcp_dump()
>> function -- like you did for skipping non-panel subunit packets. This
>> is because in the not-implemented case, only the avctp + avrcp headers
>> are sent, with no operands inside.
>> In AVRCP 1.3, section 4.3.4:
>>
>> "All of the operands are optional and are defined based on the values
>> of ctype, subunit_type, and opcode."
>>
>> In case ctype == NOT_IMPLEMENTED, there isn't any operand.
>
> But apparently the avrcp header indicates it length wrong (!= 0), also

You should not be reading this field because:

> avrcp_pdu_dump is called to print the avrcp header but perhaps the
> header itself is already considered an operand and in that should not
> even that should be present in the response.

And it's not in the response as far as I could check.


Lucas De Marchi
