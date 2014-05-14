Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RubNJx89MabHvHQc8ZsymcdDB2VoNVxwEooHEDv2=ybA@mail.gmail.com>
References: <1399666440-14078-1-git-send-email-armansito@chromium.org>
	<1399666440-14078-2-git-send-email-armansito@chromium.org>
	<01CD59B6-44C7-425A-8686-82C428F41C87@holtmann.org>
	<CAHrH25RubNJx89MabHvHQc8ZsymcdDB2VoNVxwEooHEDv2=ybA@mail.gmail.com>
Date: Wed, 14 May 2014 11:17:08 +0300
Message-ID: <CABBYNZLmDazb+0=-sph80yXsVYY4CcP0EVgBiJt00spE-=YhTw@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] src/shared/att: Introduce struct bt_att.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, May 13, 2014 at 9:44 PM, Arman Uguray <armansito@chromium.org> wrot=
e:
> Hi Marcel,
>
>>> +static bool match_request_opcode(const void *a, const void *b)
>>> +{
>>> +     const struct bt_att_request *request =3D a;
>>> +     const uint8_t *opcode =3D b;
>>
>> I think what you are looking for here is PTR_TO_UINT and UINT_TO_PRT mag=
ic. Please use that.
>
> Will do.
>
>>> +static bool handle_exchange_mtu_rsp(struct bt_att *att, const uint8_t =
*pdu,
>>> +                                                     uint16_t pdu_leng=
th)
>>> +{
>>> +     struct bt_att_exchange_mtu_rsp_param param;
>>> +
>>> +     if (pdu_length !=3D 3)
>>> +             return false;
>>> +
>>> +     param.server_rx_mtu =3D get_le16(pdu + 1);
>>> +
>>> +     request_complete(att, ATT_OP_EXCHANGE_MTU_REQ, pdu[0],
>>> +                                                     &param, sizeof(pa=
ram));
>>> +
>>> +     return true;
>>> +}
>>
>> So I wonder if we want to do this internally in att.c or not. My current=
 thinking is that we might just provide an bt_att_set_mtu function that all=
ows changing of the MTU and then then the MTU exchange itself becomes a GAT=
T problem. This means we keep ATT inside att.c pretty stupid to just being =
a transport.
>
> This is exactly the idea. This function above simply propagates the
> received Server Rx MTU to the upper layer through the callback. The
> upper layer is then expected to appropriately set the MTU using
> bt_att_set_mtu, which is already introduced in this patch (I realize
> now that it doesn't properly resize the buffer; I'll fix this in v2).
>
>> I like this part of mgmt.c actually. It has no logic of its own besides =
queuing. Of course I realize that ATT is a bit silly with its one transacti=
on at a time, but then still allow bi-directional transactions.
>>
>> Here is what I had initially:
>>
>> unsigned int att_send(struct att *att, uint8_t opcode,
>>                                 const void *param, uint16_t length,
>>                                 const uint8_t responses[],
>>                                 att_callback_func_t callback,
>>                                 void *user_data, att_destroy_func_t dest=
roy);
>>
>> The trick is the responses[] callback which would take an array of opcod=
es that are valid responses for a transaction that is currently in progress=
. Everything else would be treated as notifications. So all the logic is th=
en in GATT as an user of ATT.
>>
>> We did a similar style of handling with our AT command parser inside oFo=
no ad that worked out pretty nicely. For commands without response, the arr=
ay could be just empty. Might want to check if the error response should be=
 included by default if the array is not empty.
>
> Actually what I have in mind is even simpler than this. For outgoing
> operations that don't solicit a response (such as commands and
> outgoing notifications) we simply send them and invoke the callback
> with a special opcode such as "BT_ATT_PDU_SENT". For those outgoing
> operations that do solicit a response (e.g. requests and indications),
> the request remains pending until the response is received. A
> responses array is not really necessary, since there is already a 1:1
> mapping between ATT requests and their responses, so we know exactly
> which request the received response matches (even the error response
> contains the request that caused it in its PDU).

I don't think we need an special opcode when the PDU is sent, the
caller might actually not set any callback and I don't think there is
any special action that can be triggered by having such a thing,
specially because it is in no way an acknowledgment it just mean it
has been dispatched it may still not reach the remote side. In other
words if ATT does not have acknowledgment we should not invent one
either.

> For incoming requests, we treat these as events as you said. To
> respond to them, the upper layer than just needs to call bt_att_send
> with the corresponding response opcode and parameters.

I would not reuse the same function for both requests and responses,
responses should not have any callback and custom data attached for
the same reasons stated above, so I would have att_send_rsp for
responses alone.
