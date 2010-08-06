Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Aug 2010 18:30:42 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: ingas@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
 "Device Found" signal.
Message-ID: <20100806173042.GA28198@jh-x301>
References: <20100805102513.GA7221@jh-x301>
 <1281047801-4044-1-git-send-email-ingas@codeaurora.org>
 <20100806075552.GA22150@jh-x301>
 <1844054b1cfff4c91e67223013eb09ac.squirrel@www.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1844054b1cfff4c91e67223013eb09ac.squirrel@www.codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Fri, Aug 06, 2010, ingas@codeaurora.org wrote:
> > On Thu, Aug 05, 2010, Inga Stotland wrote:
> >> +	while (len < EIR_DATA_LENGTH - 1) {
> >> +		uint8_t type = eir_data[1];
> >> +		uint8_t field_len = eir_data[0];
> >> +
> >> +		/* Check for the end of EIR */
> >> +		if (field_len == 0)
> >> +			break;
> >
> > Shouldn't there also be another check here:
> >
> > 		/* Bail out if field_len claims to reach beyond the EIR
> > 		 * data end */
> > 		if (len + field_len + 1 >= EIR_DATA_LENGTH)
> > 			break;
> >
> 
> After reading in eir_data[0] & eir_data[1] (and those reads are valid due
> to passing the "while (len < EIR_DATA_LENGTH - 1)" check above) there are
> no more memory accesses in the loop. And if we do end up reading in field
> length that's bogus, we fail the "while" check on next iteration, exit the
> loop, fail the "(len > EIR_DATA_LENGTH)" and bail out of the routine with
> NULL return value.

Yep, you're right. What got me unnerved was that you still set pointers
to potentially out-of-bounds data in the switch statement, but as you
say the if check after the switch statement ensures that the pointers
don't get accessed if something went beyond the EIR data length.

There's still however one issue (I only now tried to compile the patch):

src/adapter.c: In function ‘get_eir_uuids’:
src/adapter.c:2810: error: comparison between signed and unsigned integer expressions
src/adapter.c:2820: error: comparison between signed and unsigned integer expressions
src/adapter.c:2833: error: comparison between signed and unsigned integer expressions
make[1]: *** [src/adapter.o] Error 1

Could you please fix it and always in the future ensure that the code
compiles cleanly when configured with ./bootstrap-configure. Also, could
you make the commit message more descriptive. The summary line should be
a very short summary of what the patch is about and the more detailed
description should be in the message body.

Johan
