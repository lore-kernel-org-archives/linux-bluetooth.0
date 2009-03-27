Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090327204954.GA2306@jh-x301>
References: <35c90d960903271323w6f206741ya366a11464461235@mail.gmail.com>
	<20090327204820.GA2222@jh-x301> <20090327204954.GA2306@jh-x301>
Date: Fri, 27 Mar 2009 14:13:57 -0700
Message-ID: <35c90d960903271413v45025dbexd6967cac51c1b10d@mail.gmail.com>
Subject: Re: [PATCH] AVDTP Qualification: Use GENERAL_REJECT instead of REJECT
	for unknown command.
From: Nick Pelly <npelly@google.com>
To: Nick Pelly <npelly@google.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 27, 2009 at 1:49 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Fri, Mar 27, 2009, Johan Hedberg wrote:
>> > From: Nick Pelly <npelly@google.com>
>> > Date: Fri, 27 Mar 2009 12:57:45 -0700
>> > Subject: [PATCH 1/2] AVCTP qualification: Handle more error codes.
>>
>> This one has been pushed upstream. Thanks.
>
> Sorry, that was supposed to refer to the other patch. The general reject one
> doesn't look right. There's no message type of 0x01 according to AVDTP 1.2. The
> way I interpret it is that general reject should use the normal reject message
> type.

Here is the information we received from a partner for this patch:

TP-SIG-SMG-BI-28-C

Test Condition
Fields of AVDTP_CMD:
- Transaction_label = TransactionLowerTester = Any value
- Packet_type = 00 (single packet)
- Reserved = 00
- Message_type = 00 (command)
- Signal_Id = 0x3F (Undefined signal id)

Pass verdict
The lower tester receives the AVDTP signaling message with the fields:
Transaction_label = TransactionLowerTester
Packet_type = 00 (single packet)
Message type = 01 (general reject)
Bits 6 and 7 of Octet 1 are both set to ‘0’
Other 6 bits = Set to the invalid signal identifier being rejected (0x3F)


However I can't find this same information in the current version of
the AVDTP test specification. Maybe it was from an older version of
the test spec? I couldn't work out where on bluetooth.org to get older
versions of test specs so I cannot confirm this.

In any case, we were told this change is recommended by the BQE, but
not required. So probably fine to skip this one.

Nick
