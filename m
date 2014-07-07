Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 01/10] shared/att: Implement outgoing "Find Information" request/response.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25SS=LtH5+LHg0rJRw0H-hDMHywfGYGqdNzqoU5EA3KA=A@mail.gmail.com>
Date: Mon, 7 Jul 2014 11:48:52 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <500222D2-02C4-4F62-B3A7-0B7FD73DBDCA@holtmann.org>
References: <1403824457-22461-1-git-send-email-armansito@chromium.org> <1403824457-22461-2-git-send-email-armansito@chromium.org> <3C1DD48A-E6D0-4F6C-BD38-3F8AB023663E@holtmann.org> <CAHrH25Q+dP_pFoBhdrL6MT31WdHma_URZVM38R0n=SDs_BircA@mail.gmail.com> <74327474-414D-420B-89A1-B4BCA957527B@holtmann.org> <CAHrH25SS=LtH5+LHg0rJRw0H-hDMHywfGYGqdNzqoU5EA3KA=A@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> 1. Change the bt_att_send signature: bt_att_send(struct bt_att *att,
>>> void *pdu, uint16_t len, ...); No opcode is passed as it's contained
>>> in the first byte of the PDU.
>> 
>> Keep it as opcode + payload. I really want the opcode in the signature.
>> 
> 
> Sounds good to me. But we still expect the passed in pdu to contain
> the opcode as the first byte right? Or are we saying to pass in the
> opcode + the rest of the PDU separately?

I want opcode + payload. So the opcode is not part of the PDU we pass in.

>>> 2. Change the misnamed bt_att_request_func_t to: typedef
>>> (*bt_att_pdu_func_t)(const void *pdu, uint16_t len, void *user_data),
>>> to be invoked upon a response to a request and for all incoming PDUs.
>> 
>> Not sure why? I want the difference between bt_att_send and bt_att_register.
>> 
> 
> No difference in the callback signatures if that's what you're asking.
> My original intention was to have the (same type of) callback passed
> to bt_att_send and bt_att_register take in a void pointer to a param
> structure. Now the callback will just accept the raw PDU (or opcode +
> the rest of the PDU in separate args). bt_att_request_func_t is a bit
> misnamed (since it doesn't only apply to ATT protocol requests), so
> changing that to bt_att_pdu_func_t. Also removing
> bt_att_notify_func_t.

Keep them separate for now. Even if they have the same signature. We can fix that later on if we see that it makes more sense.

Regards

Marcel

