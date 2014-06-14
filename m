Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v3 1/4] src/shared/att: Introduce struct bt_att.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25Q1=tAvg-aYRi1B2qNDAztaJK4m44C5P56tPnVJamYK8A@mail.gmail.com>
Date: Sat, 14 Jun 2014 15:45:17 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <F3482ECB-0CC7-4D53-88ED-D7A6BF72162F@holtmann.org>
References: <1402364040-11502-1-git-send-email-armansito@chromium.org> <1402364040-11502-2-git-send-email-armansito@chromium.org> <8304B43A-6644-4766-B089-DB71F34A63EF@holtmann.org> <CAHrH25QZfx1AJZvAaMDEzhkBawWeapCugSOkhkcVH3fbwpNAhg@mail.gmail.com> <FA65A4B0-E573-4557-831F-D1F96025C6EB@holtmann.org> <CAHrH25Q1=tAvg-aYRi1B2qNDAztaJK4m44C5P56tPnVJamYK8A@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> Hmm, according to the spec the "Optional authentication signature for
>>> the Attribute Opcode and Attribute Parameters" is 12 octets in length.
>>> See "Core v4.1, Vol 3, Part F, Section 3.3.1, Table 3: Format of
>>> Attribute PDU", and tell me what I'm missing. Or are you suggesting
>>> that we calculate the authentication signature in bt_att? My idea was
>>> that the calculation of the signature and resolving (for incoming
>>> signed requests) would be handled by an upper layer.
>> 
>> We have to calculate the signature brand new anyway since it is generated over the actual PDU. So yes, lets store the master + slave signature keys in bt_att and handle the signature generation and verification internally.
>> 
> 
> In that case, we need to access the remote and local sign counters as
> well, which change dynamically. Should bt_att store and internally
> manage that count then? Basically, the first time the CSRK is
> generated, the upper layer stores it by calling
> bt_att_set_signing_key() and that function internally initializes the
> local sign counter to 0? Similarly, bt_att would also keep track of
> the remote sign count?

so for the ATT channels you will get a new fd for each connection, either from connect() or from accept() and when you create the bt_att via bt_att_new(), then you also need to set they CSRK if you have them available.

But you have a point with the sign counters. I think that for the lifetime of the bt_att, the sign counter should be managed internally. However it might be a good idea to provide the current sign counter when setting the signature key. In addition if we want to make the sign counter persistent, we need a way to read the current one so we can store it.

Regards

Marcel

