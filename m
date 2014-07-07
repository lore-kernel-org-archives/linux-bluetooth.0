Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <3C1DD48A-E6D0-4F6C-BD38-3F8AB023663E@holtmann.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
	<1403824457-22461-2-git-send-email-armansito@chromium.org>
	<3C1DD48A-E6D0-4F6C-BD38-3F8AB023663E@holtmann.org>
Date: Mon, 7 Jul 2014 01:18:40 -0700
Message-ID: <CAHrH25Q+dP_pFoBhdrL6MT31WdHma_URZVM38R0n=SDs_BircA@mail.gmail.com>
Subject: Re: [PATCH 01/10] shared/att: Implement outgoing "Find Information" request/response.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I am not really convinced that doing all the encoding and decoding in suc=
h a way is a good idea. The low-level bt_att_send should not really care ab=
out the PDU payload or anything. It should just now what are the expected r=
esult PDUs and nothing else. I think we should stick to the ATT low-level p=
rotocol.
>

I thought the whole point of having opcodes + param structures was so
that they could be passed down to bt_att_send? Somebody needs to
encode them into the PDU and if bt_att_send will accept structures as
they are currently defined in src/shared/att-types.h, then this needs
to be done here. I'm fine with not doing it that way, so then
bt_att_send will accept the raw PDU as is and we do away with the
parameters structures? Let's decide this now.

> If you want to add extra helpers for using the ATT procedures like Find I=
nformation, then we better add actually proper helpers on top of bt_att_sen=
d (compared to internally hacked into it). I am thinking along the lines of=
 bt_add_find_info() and then have parameters that make sense.
>
> However I am also fine in just making this part (the ATT procedures) part=
 of our new GATT implementation.
>

I wanted to at least create an abstraction so that these low-level ATT
protocol operations are not hidden inside an upper layer and can be
used elsewhere (e.g. by unit tests or command-line tools) and to make
debugging easier. So then this is what I propose:

  1. Change the bt_att_send signature: bt_att_send(struct bt_att *att,
void *pdu, uint16_t len, ...); No opcode is passed as it's contained
in the first byte of the PDU.
  2. Change the misnamed bt_att_request_func_t to: typedef
(*bt_att_pdu_func_t)(const void *pdu, uint16_t len, void *user_data),
to be invoked upon a response to a request and for all incoming PDUs.
  3. Get rid of all the parameters structures in
src/shared/att-types.h. Replace them with PDU encode/decode helpers a
la attrib/att.h.

So then one would do something like:

    uint8_t pdu[5];
    uint16_t start =3D ...;
    uint16_t end =3D ...;
    bt_att_encode_find_info_req(start, end, pdu);
    bt_att_send(att, pdu, sizeof(pdu), find_info_cb, NULL, NULL);

And then for incoming PDUs you would have a bt_att_decode_... helper
for each operation.

-Arman
