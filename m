Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <74327474-414D-420B-89A1-B4BCA957527B@holtmann.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org>
	<1403824457-22461-2-git-send-email-armansito@chromium.org>
	<3C1DD48A-E6D0-4F6C-BD38-3F8AB023663E@holtmann.org>
	<CAHrH25Q+dP_pFoBhdrL6MT31WdHma_URZVM38R0n=SDs_BircA@mail.gmail.com>
	<74327474-414D-420B-89A1-B4BCA957527B@holtmann.org>
Date: Mon, 7 Jul 2014 02:02:36 -0700
Message-ID: <CAHrH25SS=LtH5+LHg0rJRw0H-hDMHywfGYGqdNzqoU5EA3KA=A@mail.gmail.com>
Subject: Re: [PATCH 01/10] shared/att: Implement outgoing "Find Information" request/response.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>>  1. Change the bt_att_send signature: bt_att_send(struct bt_att *att,
>> void *pdu, uint16_t len, ...); No opcode is passed as it's contained
>> in the first byte of the PDU.
>
> Keep it as opcode + payload. I really want the opcode in the signature.
>

Sounds good to me. But we still expect the passed in pdu to contain
the opcode as the first byte right? Or are we saying to pass in the
opcode + the rest of the PDU separately?

>>  2. Change the misnamed bt_att_request_func_t to: typedef
>> (*bt_att_pdu_func_t)(const void *pdu, uint16_t len, void *user_data),
>> to be invoked upon a response to a request and for all incoming PDUs.
>
> Not sure why? I want the difference between bt_att_send and bt_att_regist=
er.
>

No difference in the callback signatures if that's what you're asking.
My original intention was to have the (same type of) callback passed
to bt_att_send and bt_att_register take in a void pointer to a param
structure. Now the callback will just accept the raw PDU (or opcode +
the rest of the PDU in separate args). bt_att_request_func_t is a bit
misnamed (since it doesn't only apply to ATT protocol requests), so
changing that to bt_att_pdu_func_t. Also removing
bt_att_notify_func_t.

> Such helpers seems to be at first glance a good idea, but the devil is in=
 the detail. Some helpers might be a really good idea. Others might end up =
just being too complex and you end up in spaghetti code.
>
> What I think might be useful that for simple and rather common ATT comman=
ds, we have a wrapper around bt_att_send. As mentioned earlier, bt_att_find=
_info might such a wrapper. It takes start and end parameters and calls a p=
roper callback with all information available.
>
> That said, it might be also better to have this all in GATT procedures. S=
o that we get bt_gatt_discover_primary_services as such function and intern=
ally it uses many bt_att_send.
>
> I am not a big fan of too many abstractions. They all look reasonable in =
the beginning, but later on they just make code more complicated for no app=
arent reason. I can name numerous examples where actually not having wrappe=
rs or extra abstraction created cleaner code for us.
>
> So my advice would be to take one step back now. Look at what we really n=
eed in terms of GATT procedures and start with adding bt_gatt (src/share/ga=
tt.c). Do all the encoding and decoding of ATT payloads in bt_gatt and then=
 figure out where the pain points are. If you find common code that justifi=
es a more generic bt_att helper, then move it to bt_att.
>

Sounds good to me.
