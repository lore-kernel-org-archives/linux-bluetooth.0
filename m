Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RNQADkTEnCEEkp3y0ZwyuBsTiFXk7qLVO4PHMKqXNuQg@mail.gmail.com>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1418637547-20848-4-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZKWPJaeLgvpLzvYWggXtQpd84jS-u1mbHrpCww7ijpviw@mail.gmail.com>
	<BCF85539-54B4-40E0-A641-872EF8E660E8@holtmann.org>
	<CABBYNZ+TQNsvp-oY=gUgaNvr3sOPX2_p1WK47UL8gLz9JDWhew@mail.gmail.com>
	<CAMudyAuWjeTtX2hUWXEyoXcE6NPtannAO+XfKChXjg6wsK+siw@mail.gmail.com>
	<CAHrH25RNQADkTEnCEEkp3y0ZwyuBsTiFXk7qLVO4PHMKqXNuQg@mail.gmail.com>
Date: Mon, 15 Dec 2014 17:28:44 +0100
Message-ID: <CAMudyAtRufOJJ4_m639OeW6CxduPOHZce5JKMdGddzkZczpH6w@mail.gmail.com>
Subject: Re: [PATCH 3/5] shared/gatt: Add bt_send_att_with_id functions
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Arman Uguray <armansito@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On 15 December 2014 at 16:56, Arman Uguray <armansito@google.com> wrote:
> Hi Lukasz,
>
>> On Mon, Dec 15, 2014 at 3:05 AM, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
>> Hi Marcel, Luiz,
>>
>> On 15 December 2014 at 12:00, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Marcel,
>>>
>>> On Mon, Dec 15, 2014 at 12:53 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>>> Hi Luiz,
>>>>
>>>>
>>>>>> With this patch it is possible to send ATT request with a given id
>>>>>> request. It might be useful for ATT user for example to keep track of
>>>>>> the GATT request which requires more then one ATT request e.g. search
>>>>>> services
>>>>>> ---
>>>>>> src/shared/att.c | 26 ++++++++++++++++++++++++++
>>>>>> src/shared/att.h |  6 ++++++
>>>>>> 2 files changed, 32 insertions(+)
>>>>>>
>>>>>> diff --git a/src/shared/att.c b/src/shared/att.c
>>>>>> index 2a131e0..f51f893 100644
>>>>>> --- a/src/shared/att.c
>>>>>> +++ b/src/shared/att.c
>>>>>> @@ -1083,6 +1083,32 @@ static unsigned int send_att(struct bt_att *att, struct att_send_op *op)
>>>>>>        return op->id;
>>>>>> }
>>>>>>
>>>>>> +unsigned int bt_att_send_with_id(struct bt_att *att, unsigned int id,
>>>>>> +                                       uint8_t opcode, const void *pdu,
>>>>>> +                                       uint16_t length,
>>>>>> +                                       bt_att_response_func_t callback,
>>>>>> +                                       void *user_data,
>>>>>> +                                       bt_att_destroy_func_t destroy)
>>>>>> +{
>>>>>> +       struct att_send_op *op;
>>>>>> +
>>>>>> +       if (!att || !att->io)
>>>>>> +               return 0;
>>>>>
>>>>> I guess we need to check for invalid id here, or we can do the
>>>>> opposite and let 0 id be used for self assign an id so bt_att_send
>>>>> could just bt_att_send_with_id so we reuse more code.
>>>>>
>>>>>> +       op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
>>>>>> +                                                       user_data, destroy);
>>>>>> +       if (!op)
>>>>>> +               return 0;
>>>>>>
>>>>>> +       /*
>>>>>> +        * TODO: Some verification might be needed here. For now we
>>>>>> +        * believe that user know what he is doing.
>>>>>> +        */
>>>>>> +       op->id = id;
>>>>>
>>>>> I think we should prevent multiple entries using the same id and Im
>>>>> also not sure why this is not being queue like the rest of operations?
>>>>
>>>> or we are not doing this at all since this sounds like a crazy API.
>>>>
>>>> If the caller wants to keep track of something, then it can keep track of it, but we are not allowing the caller to mess with internals.
>>>
>>> Well this is done internally so the caller can cancel operations such
>>> as discovery, we could add another id but the caller would have no
>>> idea the id has changed perhaps we could add an id mapping between
>>> gatt and att so the id on gatt won't change but the att id would, but
>>> with that we would need to change gattrib to do the same.
>>
>> ...and attrib/gatt.c is state less so it's not that easy to add that
>> tracking there ...
>
> I agree with Marcel here, in that it's probably better for the upper
> layer to keep track of which ATT request id maps to the overall
> operation at a given time. This is something that shared/gatt-helpers
> should be doing also but isn't, then again this hasn't hurt things
> that much so far, and all of those functions just return bool anyway.
> Generally you need this id to cancel an on-going operation in the case
> of a protocol error, and this is generally better served by something
> like bt_att_cancel_all already, where you just want to stop
> everything.
>
> Eitherway, maybe keep track of the operation states in GAttrib? It
> seems like your patch set is mainly addressing the fact that the id
> returned by g_attrib_* becomes invalid, so it sounds like the fix
> generally belongs in attrib/gatt?

Yes, fix belongs to attrib/gatt, but to solve it you need to cover two things.
One thing is to have request id tracked by attrib/gatt and second thing
is to let user of gattrib information about ongoing request id.
Without that problem is still there
because user of gatrrib is out of control of ongoing att request
because of outdated request id.
Unless we reuse existing req_id what is done in this set but is not welcome

Anyway, after discussion on IRC we decide to remove gattrib from
Android GATT and HOG and start use gatt-client.
We need to do it anyway so instead of fixing gattrib we move to gatt/client.

\Łukasz



>
>>
>> \Lukasz
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Cheers,
> Arman
