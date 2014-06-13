Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v3 4/4] src/shared/att: Handle incoming response PDUs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QrY8n28qa8uCi5CiYYU1h0z7yhszWmPcOeR2hX=wE1dw@mail.gmail.com>
Date: Fri, 13 Jun 2014 11:16:41 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <391CBE6C-CFFE-4754-AC60-683EDFE89B2C@holtmann.org>
References: <1402364040-11502-1-git-send-email-armansito@chromium.org> <1402364040-11502-5-git-send-email-armansito@chromium.org> <7FD20345-0246-4986-991C-DA9C24E6BFD1@holtmann.org> <CAHrH25QrY8n28qa8uCi5CiYYU1h0z7yhszWmPcOeR2hX=wE1dw@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>>> +     if (!op) {
>>> +             /* There is no pending request so the response is unexpected.
>>> +              * TODO: In such a case, the connection should be dropped
>>> +              * entirely. For now, simply ignore the PDU.
>>> +              */
>> 
>> is this what the specification say?
> 
> Actually, I can't seem to find the section in the spec that says this,
> so I might be remembering it wrong. What it does say is that if a
> request times out (after 30 seconds) then the ATT bearer should be
> terminated. Once I add way to notify the upper layers of a request
> time out (perhaps as a ATT Error OP with a special BlueZ specific
> error code) we will technically be handling this case. I already added
> a TODO for implementing timeouts.

we need to be able to provide a callback that triggers if we do not receive a response within the 30 seconds and in this case be able to terminate the link. And I think this should be a specific callback indicating to terminate the link and free the bt_att object. Internally we also have to mark the bt_att as invalid now and return false on all future bt_att_send.

>>        if (att->destroyed)
>>                return true;
>> 
>>        wakeup_writer(att);
>> 
>> I prefer it this way since it is easier to read when you go through the function. Especially with the att->destroyed cases for the reentrant support. We want to make it clear that we expect that object to be gone.
> 
> I got rid of att->destroyed for now.
> 
>>> +static bool handle_error_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>>> +                                                             ssize_t pdu_len)
>>> +{
>>> +     struct bt_att_error_rsp_param p;
>>> +     bool result;
>>> +
>>> +     if (pdu_len != 5)
>>> +             return false;
>>> +
>>> +     memset(&p, 0, sizeof(p));
>>> +     p.request_opcode = pdu[1];
>>> +     p.handle = get_le16(pdu + 2);
>>> +     p.error_code = pdu[4];
>>> +
>>> +     /* Note: avoid a tail call */
>> 
>> I do not get this comment. Explain please.
>> 
>>> +     result = request_complete(att, p.request_opcode, opcode, &p, sizeof(p));
>>> +     return result;
>> 
>>        return request_complete(..
>> 
> 
> Ah yes, if you do a tail call here (i.e. return request_complete(... )
> the "struct bt_att_error_rsp_param p" will go out of scope before
> request_complete executes, due to tail call optimization, so the
> pointer to to "p" that I'm passing down to request_complete will be
> invalid. Hence the workaround of calling before returning.

The compiler is really this stupid? I can not see how the stack variable (or a pointer to it) can go out of scope here. If this is really a problem, then I would imagine we have a few more of these lingering in the overall code of BlueZ.

Regards

Marcel

