Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <01CD59B6-44C7-425A-8686-82C428F41C87@holtmann.org>
References: <1399666440-14078-1-git-send-email-armansito@chromium.org>
	<1399666440-14078-2-git-send-email-armansito@chromium.org>
	<01CD59B6-44C7-425A-8686-82C428F41C87@holtmann.org>
Date: Tue, 13 May 2014 11:44:08 -0700
Message-ID: <CAHrH25RubNJx89MabHvHQc8ZsymcdDB2VoNVxwEooHEDv2=ybA@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> +static bool match_request_opcode(const void *a, const void *b)
>> +{
>> +     const struct bt_att_request *request =3D a;
>> +     const uint8_t *opcode =3D b;
>
> I think what you are looking for here is PTR_TO_UINT and UINT_TO_PRT magi=
c. Please use that.

Will do.

>> +static bool handle_exchange_mtu_rsp(struct bt_att *att, const uint8_t *=
pdu,
>> +                                                     uint16_t pdu_lengt=
h)
>> +{
>> +     struct bt_att_exchange_mtu_rsp_param param;
>> +
>> +     if (pdu_length !=3D 3)
>> +             return false;
>> +
>> +     param.server_rx_mtu =3D get_le16(pdu + 1);
>> +
>> +     request_complete(att, ATT_OP_EXCHANGE_MTU_REQ, pdu[0],
>> +                                                     &param, sizeof(par=
am));
>> +
>> +     return true;
>> +}
>
> So I wonder if we want to do this internally in att.c or not. My current =
thinking is that we might just provide an bt_att_set_mtu function that allo=
ws changing of the MTU and then then the MTU exchange itself becomes a GATT=
 problem. This means we keep ATT inside att.c pretty stupid to just being a=
 transport.

This is exactly the idea. This function above simply propagates the
received Server Rx MTU to the upper layer through the callback. The
upper layer is then expected to appropriately set the MTU using
bt_att_set_mtu, which is already introduced in this patch (I realize
now that it doesn't properly resize the buffer; I'll fix this in v2).

> I like this part of mgmt.c actually. It has no logic of its own besides q=
ueuing. Of course I realize that ATT is a bit silly with its one transactio=
n at a time, but then still allow bi-directional transactions.
>
> Here is what I had initially:
>
> unsigned int att_send(struct att *att, uint8_t opcode,
>                                 const void *param, uint16_t length,
>                                 const uint8_t responses[],
>                                 att_callback_func_t callback,
>                                 void *user_data, att_destroy_func_t destr=
oy);
>
> The trick is the responses[] callback which would take an array of opcode=
s that are valid responses for a transaction that is currently in progress.=
 Everything else would be treated as notifications. So all the logic is the=
n in GATT as an user of ATT.
>
> We did a similar style of handling with our AT command parser inside oFon=
o ad that worked out pretty nicely. For commands without response, the arra=
y could be just empty. Might want to check if the error response should be =
included by default if the array is not empty.

Actually what I have in mind is even simpler than this. For outgoing
operations that don't solicit a response (such as commands and
outgoing notifications) we simply send them and invoke the callback
with a special opcode such as "BT_ATT_PDU_SENT". For those outgoing
operations that do solicit a response (e.g. requests and indications),
the request remains pending until the response is received. A
responses array is not really necessary, since there is already a 1:1
mapping between ATT requests and their responses, so we know exactly
which request the received response matches (even the error response
contains the request that caused it in its PDU).

For incoming requests, we treat these as events as you said. To
respond to them, the upper layer than just needs to call bt_att_send
with the corresponding response opcode and parameters.


>> +/* Error response */
>> +#define ATT_OP_ERROR_RESP            0x01
>> +struct bt_att_error_rsp_param {
>> +     uint8_t request_opcode;
>> +     uint16_t handle;
>> +     uint8_t error_code;
>> +};
>> +
>> +/* Exchange MTU */
>> +#define ATT_OP_EXCHANGE_MTU_REQ              0x02
>> +struct bt_att_exchange_mtu_req_param {
>> +     uint16_t client_rx_mtu;
>> +};
>> +
>> +#define ATT_OP_EXCHANGE_MTU_RESP     0x03
>> +struct bt_att_exchange_mtu_rsp_param {
>> +     uint16_t server_rx_mtu;
>> +};
>> +
>> +/* Error codes for Error response PDU */
>> +#define ATT_ERROR_INVALID_HANDLE                     0x01
>> +#define ATT_ERROR_READ_NOT_PERMITTED                 0x02
>> +#define ATT_ERROR_WRITE_NOT_PERMITTED                        0x03
>> +#define ATT_ERROR_INVALID_PDU                                0x04
>> +#define ATT_ERROR_AUTHENTICATION                     0x05
>> +#define ATT_ERROR_REQUEST_NOT_SUPPORTED                      0x06
>> +#define ATT_ERROR_INVALID_OFFSET                     0x07
>> +#define ATT_ERROR_AUTHORIZATION                              0x08
>> +#define ATT_ERROR_PREPARE_QUEUE_FULL                 0x09
>> +#define ATT_ERROR_ATTRIBUTE_NOT_FOUND                        0x0A
>> +#define ATT_ERROR_ATTRIBUTE_NOT_LONG                 0x0B
>> +#define ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE   0x0C
>> +#define ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN                0x0D
>> +#define ATT_ERROR_UNLIKELY                           0x0E
>> +#define ATT_ERROR_INSUFFICIENT_ENCRYPTION            0x0F
>> +#define ATT_ERROR_UNSUPPORTED_GROUP_TYPE             0x10
>> +#define ATT_ERROR_INSUFFICIENT_RESOURCES             0x11
>
> Please prefix these with BT_ATT. Not sure if we better stick them into mo=
nitor/bt.h here.

Will do. I say we keep them here for now. On that note: is there a
pattern to which structures get the bt_ prefix and which don't? e.g.
would struct att be a better name then struct bt_att here?

Cheers,
Arman
