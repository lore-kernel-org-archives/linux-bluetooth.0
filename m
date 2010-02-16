Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <508e92ca1002160358g1c6b599bo329f4f51cae18041@mail.gmail.com>
References: <508e92ca1002160236k34c18949jc7d7187645ef4aa0@mail.gmail.com>
	 <20100216113408.GA15436@vigoh>
	 <508e92ca1002160358g1c6b599bo329f4f51cae18041@mail.gmail.com>
Date: Tue, 16 Feb 2010 14:16:17 +0200
Message-ID: <508e92ca1002160416w5e116d2j678481e02e207c2f@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix kernel crash on BT stress tests.
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>> Are you using ERTM or Streaming mode? If yes, I have a guess about the
>> source of the problem. On l2cap_parse_conf_rsp we check for:
>>
>>        while (len >= L2CAP_CONF_OPT_SIZE) {
>>                len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
>>
>> But on case L2CAP_CONF_RFC olen is greater than L2CAP_CONF_OPT_SIZE we
>> can exceed the buffer size. So the right fix will be check if len >=
>> olen in that case.
>
> We use test tool which sends "Configure Response" packet with size 262
> bytes. So "req" buffer gets overwritten. But in the code nobody checks
> that "req" might be overwritten.

The packet we are sending is:

Bluetooth L2CAP Packet
    Length: 266
    CID: 0x0001
    Command: Configure Response
        Command Code: Configure Response (0x05)
        Command Identifier: 0x02
        Command Length: 262
        Source CID: 0x0040
        .... .... .... ...0 = Continuation Flag: False
        Result: Failure - unacceptable parameters (0x0001)
        Option: MTU
        Option: MTU
        Option: MTU
        Option: MTU
        Option: MTU
        Option: MTU
        Option: MTU
        Option: MTU
        Option: MTU
        Option: MTU
.............

We can check of course that parameter MTU is already exist. Still
there is possibility to overwrite 64 bytes of req buffer so some check
is needed.

-- Andrei
