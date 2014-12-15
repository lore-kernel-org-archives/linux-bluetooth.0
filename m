Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 3/5] shared/gatt: Add bt_send_att_with_id functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKWPJaeLgvpLzvYWggXtQpd84jS-u1mbHrpCww7ijpviw@mail.gmail.com>
Date: Mon, 15 Dec 2014 11:53:46 +0100
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BCF85539-54B4-40E0-A641-872EF8E660E8@holtmann.org>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com> <1418637547-20848-4-git-send-email-lukasz.rymanowski@tieto.com> <CABBYNZKWPJaeLgvpLzvYWggXtQpd84jS-u1mbHrpCww7ijpviw@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


>> With this patch it is possible to send ATT request with a given id
>> request. It might be useful for ATT user for example to keep track of
>> the GATT request which requires more then one ATT request e.g. search
>> services
>> ---
>> src/shared/att.c | 26 ++++++++++++++++++++++++++
>> src/shared/att.h |  6 ++++++
>> 2 files changed, 32 insertions(+)
>> 
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index 2a131e0..f51f893 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -1083,6 +1083,32 @@ static unsigned int send_att(struct bt_att *att, struct att_send_op *op)
>>        return op->id;
>> }
>> 
>> +unsigned int bt_att_send_with_id(struct bt_att *att, unsigned int id,
>> +                                       uint8_t opcode, const void *pdu,
>> +                                       uint16_t length,
>> +                                       bt_att_response_func_t callback,
>> +                                       void *user_data,
>> +                                       bt_att_destroy_func_t destroy)
>> +{
>> +       struct att_send_op *op;
>> +
>> +       if (!att || !att->io)
>> +               return 0;
> 
> I guess we need to check for invalid id here, or we can do the
> opposite and let 0 id be used for self assign an id so bt_att_send
> could just bt_att_send_with_id so we reuse more code.
> 
>> +       op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
>> +                                                       user_data, destroy);
>> +       if (!op)
>> +               return 0;
>> 
>> +       /*
>> +        * TODO: Some verification might be needed here. For now we
>> +        * believe that user know what he is doing.
>> +        */
>> +       op->id = id;
> 
> I think we should prevent multiple entries using the same id and Im
> also not sure why this is not being queue like the rest of operations?

or we are not doing this at all since this sounds like a crazy API.

If the caller wants to keep track of something, then it can keep track of it, but we are not allowing the caller to mess with internals.

Regards

Marcel

