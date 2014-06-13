Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <FA65A4B0-E573-4557-831F-D1F96025C6EB@holtmann.org>
References: <1402364040-11502-1-git-send-email-armansito@chromium.org>
	<1402364040-11502-2-git-send-email-armansito@chromium.org>
	<8304B43A-6644-4766-B089-DB71F34A63EF@holtmann.org>
	<CAHrH25QZfx1AJZvAaMDEzhkBawWeapCugSOkhkcVH3fbwpNAhg@mail.gmail.com>
	<FA65A4B0-E573-4557-831F-D1F96025C6EB@holtmann.org>
Date: Fri, 13 Jun 2014 14:14:56 -0700
Message-ID: <CAHrH25Q1=tAvg-aYRi1B2qNDAztaJK4m44C5P56tPnVJamYK8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> Hmm, according to the spec the "Optional authentication signature for
>> the Attribute Opcode and Attribute Parameters" is 12 octets in length.
>> See "Core v4.1, Vol 3, Part F, Section 3.3.1, Table 3: Format of
>> Attribute PDU", and tell me what I'm missing. Or are you suggesting
>> that we calculate the authentication signature in bt_att? My idea was
>> that the calculation of the signature and resolving (for incoming
>> signed requests) would be handled by an upper layer.
>
> We have to calculate the signature brand new anyway since it is generated over the actual PDU. So yes, lets store the master + slave signature keys in bt_att and handle the signature generation and verification internally.
>

In that case, we need to access the remote and local sign counters as
well, which change dynamically. Should bt_att store and internally
manage that count then? Basically, the first time the CSRK is
generated, the upper layer stores it by calling
bt_att_set_signing_key() and that function internally initializes the
local sign counter to 0? Similarly, bt_att would also keep track of
the remote sign count?

-Arman
