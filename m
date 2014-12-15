Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 3/5] shared/gatt: Add bt_send_att_with_id functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RNQADkTEnCEEkp3y0ZwyuBsTiFXk7qLVO4PHMKqXNuQg@mail.gmail.com>
Date: Mon, 15 Dec 2014 19:31:24 +0100
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5D8E7A8A-E773-4D9C-9F79-D18130FB46B1@holtmann.org>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com> <1418637547-20848-4-git-send-email-lukasz.rymanowski@tieto.com> <CABBYNZKWPJaeLgvpLzvYWggXtQpd84jS-u1mbHrpCww7ijpviw@mail.gmail.com> <BCF85539-54B4-40E0-A641-872EF8E660E8@holtmann.org> <CABBYNZ+TQNsvp-oY=gUgaNvr3sOPX2_p1WK47UL8gLz9JDWhew@mail.gmail.com> <CAMudyAuWjeTtX2hUWXEyoXcE6NPtannAO+XfKChXjg6wsK+siw@mail.gmail.com> <CAHrH25RNQADkTEnCEEkp3y0ZwyuBsTiFXk7qLVO4PHMKqXNuQg@mail.gmail.com>
To: Arman Uguray <armansito@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

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
>>>>>>       return op->id;
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

this is just for reference since I am not advocating to implement this until we really need to. And with bt_gatt_client being the primary interface, I highly doubt we ever need to. However we have solved these kind of user facing use cases before.

The problem is that you want to use bt_att_cancel_all(), but only have it cancel the requests that you made and not requests that a different profile might have made. Since the ATT channel is a shared resource you need to play nice with others. One obvious solution is of course to just track all bt_att_send() call and cancel them individually via bt_att_cancel().

The only way we can ever use bt_att_cancel_all() in multi user/profile scenarios would be if we introduce struct bt_att *bt_att_clone(struct bt_att *). What this means is that you would create your own private clone of an existing struct bt_att and that all bt_att_send() and bt_att_register() are bound to your clone. Let me try to give an example.

	master_att = bt_att_new();

	att1 = bt_att_clone(master_att);
	att2 = bt_att_clone(master_att);

	bt_att_send(att1, ..)
	bt_att_send(att1, ..)
	bt_att_send(att2, ..)
	bt_att_cancel_all(att1, ..)


So this would only cancel the two bt_att_send() from att1 and the one from att2 will be happily executed.

We have used this concept before in GAtChat of oFono. However it is some heavy lifting involved internally to get this done. We did it because it made the drivers simpler and one driver was no longer affect the other even if the run over the same physical line.

The only reason to do this in BlueZ would be that the caller code becomes so complicated when it has to track all the bt_att_send() ids that it is unreasonable. Since this is only GAttrib right now, I would not go this route. It overhead that is involved with supported clones.

Also us abstracting things behind bt_gatt_client should not bring us into the situation that we need to have to create bt_att_clone() support. Anyway, this is just reference in case someone has to look this up in the future.

Regards

Marcel

