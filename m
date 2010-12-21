Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1292952355.14993.9.camel@sealablnx02.qualcomm.com>
References: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
	<1292952355.14993.9.camel@sealablnx02.qualcomm.com>
Date: Tue, 21 Dec 2010 16:25:44 -0300
Message-ID: <AANLkTin8BHWOhpnv36ncteMNRfXwU81r17owAAaixiD-@mail.gmail.com>
Subject: Re: [RFC 0/1] Implement Compound (Multi-step) GATT Procedure Support
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: vinicius.gomes@openbossa.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Tue, Dec 21, 2010 at 2:25 PM, Brian Gix <bgix@codeaurora.org> wrote:
> Hi Claudio & Vinicius,
>
>
> On Fri, 2010-12-17 at 14:48 -0800, Brian Gix wrote:
>> The following two proposed patches implement a method for correctly
>> staging GATT procedures that require multiple ATT req/resp exchanges.
>
> If you guys get a chance, could you consider this proposed change
> to gattrib.[ch] and the subsequent change to gatt.c? It differs from my
> initial proposed patch which subverted the gattrib queuing mechanism. It
> now lets each ATT command run to completion. It also fixes the memory
> leak potential that Vinicius spotted.  I think it is important that you
> give it at least a cursory look, because you guys know more about bluez
> GATT than anyone else here at this point.  Otherwise, I will resubmit
> this version as a patch request. -- thx
>

ok. We can review your patches.
Could you please send patches to change gatttool to support this new feature?
How are you testing it? Do you have a modified BlueZ attribute server
or another GATT server?

Claudio
