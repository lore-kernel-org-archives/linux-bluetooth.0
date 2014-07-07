Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 01/10] shared/att: Implement outgoing "Find Information" request/response.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25Q+dP_pFoBhdrL6MT31WdHma_URZVM38R0n=SDs_BircA@mail.gmail.com>
Date: Mon, 7 Jul 2014 10:42:40 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <74327474-414D-420B-89A1-B4BCA957527B@holtmann.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org> <1403824457-22461-2-git-send-email-armansito@chromium.org> <3C1DD48A-E6D0-4F6C-BD38-3F8AB023663E@holtmann.org> <CAHrH25Q+dP_pFoBhdrL6MT31WdHma_URZVM38R0n=SDs_BircA@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> I am not really convinced that doing all the encoding and decoding in such a way is a good idea. The low-level bt_att_send should not really care about the PDU payload or anything. It should just now what are the expected result PDUs and nothing else. I think we should stick to the ATT low-level protocol.
>> 
> 
> I thought the whole point of having opcodes + param structures was so
> that they could be passed down to bt_att_send? Somebody needs to
> encode them into the PDU and if bt_att_send will accept structures as
> they are currently defined in src/shared/att-types.h, then this needs
> to be done here. I'm fine with not doing it that way, so then
> bt_att_send will accept the raw PDU as is and we do away with the
> parameters structures? Let's decide this now.

lets use raw PDU for bt_att_send. The only thing it really needs to handle are the responses and errors that match to the opcode. And for bt_att_register handle the mapping confirmations correctly.

>> If you want to add extra helpers for using the ATT procedures like Find Information, then we better add actually proper helpers on top of bt_att_send (compared to internally hacked into it). I am thinking along the lines of bt_add_find_info() and then have parameters that make sense.
>> 
>> However I am also fine in just making this part (the ATT procedures) part of our new GATT implementation.
>> 
> 
> I wanted to at least create an abstraction so that these low-level ATT
> protocol operations are not hidden inside an upper layer and can be
> used elsewhere (e.g. by unit tests or command-line tools) and to make
> debugging easier. So then this is what I propose:
> 
>  1. Change the bt_att_send signature: bt_att_send(struct bt_att *att,
> void *pdu, uint16_t len, ...); No opcode is passed as it's contained
> in the first byte of the PDU.

Keep it as opcode + payload. I really want the opcode in the signature.

>  2. Change the misnamed bt_att_request_func_t to: typedef
> (*bt_att_pdu_func_t)(const void *pdu, uint16_t len, void *user_data),
> to be invoked upon a response to a request and for all incoming PDUs.

Not sure why? I want the difference between bt_att_send and bt_att_register.

>  3. Get rid of all the parameters structures in
> src/shared/att-types.h. Replace them with PDU encode/decode helpers a
> la attrib/att.h.
> 
> So then one would do something like:
> 
>    uint8_t pdu[5];
>    uint16_t start = ...;
>    uint16_t end = ...;
>    bt_att_encode_find_info_req(start, end, pdu);
>    bt_att_send(att, pdu, sizeof(pdu), find_info_cb, NULL, NULL);
> 
> And then for incoming PDUs you would have a bt_att_decode_... helper
> for each operation.

Such helpers seems to be at first glance a good idea, but the devil is in the detail. Some helpers might be a really good idea. Others might end up just being too complex and you end up in spaghetti code.

What I think might be useful that for simple and rather common ATT commands, we have a wrapper around bt_att_send. As mentioned earlier, bt_att_find_info might such a wrapper. It takes start and end parameters and calls a proper callback with all information available.

That said, it might be also better to have this all in GATT procedures. So that we get bt_gatt_discover_primary_services as such function and internally it uses many bt_att_send.

I am not a big fan of too many abstractions. They all look reasonable in the beginning, but later on they just make code more complicated for no apparent reason. I can name numerous examples where actually not having wrappers or extra abstraction created cleaner code for us.

So my advice would be to take one step back now. Look at what we really need in terms of GATT procedures and start with adding bt_gatt (src/share/gatt.c). Do all the encoding and decoding of ATT payloads in bt_gatt and then figure out where the pain points are. If you find common code that justifies a more generic bt_att helper, then move it to bt_att.

Regards

Marcel

