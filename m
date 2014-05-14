Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CABBYNZLmDazb+0=-sph80yXsVYY4CcP0EVgBiJt00spE-=YhTw@mail.gmail.com>
References: <1399666440-14078-1-git-send-email-armansito@chromium.org>
	<1399666440-14078-2-git-send-email-armansito@chromium.org>
	<01CD59B6-44C7-425A-8686-82C428F41C87@holtmann.org>
	<CAHrH25RubNJx89MabHvHQc8ZsymcdDB2VoNVxwEooHEDv2=ybA@mail.gmail.com>
	<CABBYNZLmDazb+0=-sph80yXsVYY4CcP0EVgBiJt00spE-=YhTw@mail.gmail.com>
Date: Wed, 14 May 2014 07:54:03 -0700
Message-ID: <CAHrH25TYbP7mkwJeJO3vcECetbTCx_TguUDuE1k02XC=a6pOmQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> Actually what I have in mind is even simpler than this. For outgoing
>> operations that don't solicit a response (such as commands and
>> outgoing notifications) we simply send them and invoke the callback
>> with a special opcode such as "BT_ATT_PDU_SENT". For those outgoing
>> operations that do solicit a response (e.g. requests and indications),
>> the request remains pending until the response is received. A
>> responses array is not really necessary, since there is already a 1:1
>> mapping between ATT requests and their responses, so we know exactly
>> which request the received response matches (even the error response
>> contains the request that caused it in its PDU).
>
> I don't think we need an special opcode when the PDU is sent, the
> caller might actually not set any callback and I don't think there is
> any special action that can be triggered by having such a thing,
> specially because it is in no way an acknowledgment it just mean it
> has been dispatched it may still not reach the remote side. In other
> words if ATT does not have acknowledgment we should not invent one
> either.

Makes sense. The idea I had was that if the caller passes NULL to
bt_att_send for the callback, then no acknowledgement would happen but
if they do, we would confirm with a special PDU, but this will no
longer be necessary if we have a separate function as you suggest
below.

>> For incoming requests, we treat these as events as you said. To
>> respond to them, the upper layer than just needs to call bt_att_send
>> with the corresponding response opcode and parameters.
>
> I would not reuse the same function for both requests and responses,
> responses should not have any callback and custom data attached for
> the same reasons stated above, so I would have att_send_rsp for
> responses alone.

Maybe it would make sense to have one function to send operations that
solicit a response (requests/indications), e.g.
bt_att_send_op_with_rsp and one function for those that don't (for
responses/commands/notifications) like bt_att_send_op_no_rsp. Or do
you think we should have separate functions such as bt_att_send_req,
bt_att_send_rsp, bt_att_send_not, bt_att_send_ind, etc?
