Return-Path: <cyrus@holtmann.org>
To: Hendrik Sattler <post@hendrik-sattler.de>,
	Jaganath Kanakkassery <jaganath.k@samsung.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd 2/2] gobex: Fix ABORT request not processing
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Fri, 13 Jan 2012 12:07:44 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <20120113105420.GA4490@x220>
References: <1326448613-8367-1-git-send-email-jaganath.k@samsung.com>
 <adc3f64ff0de3606125dfbdea3f6b2ac@mail.hendrik-sattler.de>
 <20120113105420.GA4490@x220>
Message-ID: <8d043367426e37a570df29ff2f4b298b@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 13.01.2012 11:54, schrieb Johan Hedberg:
> Hi,
>
> On Fri, Jan 13, 2012, Hendrik Sattler wrote:
>> Am 13.01.2012 10:56, schrieb Jaganath Kanakkassery:
>> >G_OBEX_OP_ABORT is defined as 0x7f but error checking of opcode is
>> >done for greater than 0x1f. So abort request is simply ignored.
>> >So corrected the error checking.
>> >---
>> > gobex/gobex.c |    2 +-
>> > 1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> >diff --git a/gobex/gobex.c b/gobex/gobex.c
>> >index 33b77fd..bfb9f37 100644
>> >--- a/gobex/gobex.c
>> >+++ b/gobex/gobex.c
>> >@@ -1150,7 +1150,7 @@ static gboolean incoming_data(GIOChannel *io,
>> >GIOCondition cond,
>> > 	} else {
>> > 		opcode = obex->rx_last_op;
>> > 		/* Unexpected response -- fail silently */
>> >-		if (opcode > 0x1f && opcode < 0xff) {
>> >+		if (opcode > G_OBEX_OP_ABORT && opcode < 0xff) {
>> > 			obex->rx_data = 0;
>> > 			return TRUE;
>> > 		}
>>
>> This one always evaluates to false because 0xff == G_OBEX_OP_ABORT |
>> FINAL_BIT.
>
> The value of obex->rx_last_op is stored with the final bit cleared, 
> so
> the < 0xff part could also be removed from the test. The value 0x1f 
> has
> been picked because the IrDA OBEX specification defines 0x10 - 0x1f 
> as a
> user-definable range, so anything between 0x1f and 0x7f isn't 
> actually
> valid. The correct test would then become:
>
> 	if (opcode > 0x1f && opcode != G_OBEX_OP_ABORT)
>
> Jaganath, with the above change the patch should be ok, but the more
> surprising thing to me here is that this implies we're missing one or
> more unit tests for Abort. Could you create a patch to add those too?
> (if we're really strict those tests should go in before this patch so
> that it's actually possible to see that the patch makes a 
> difference).

User-definable does not mean invalid. It only means that these can be 
used
for custom commands. These are still bound to the rules of the OBEX
protocol. I've never seen one using that, though.

Else you'd also have to filter 0x04 and the range 0x08-0x0f because 
these
are marked as "reserved".

HS



