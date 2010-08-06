Return-Path: <cyrus@holtmann.org>
Message-ID: <1844054b1cfff4c91e67223013eb09ac.squirrel@www.codeaurora.org>
In-Reply-To: <20100806075552.GA22150@jh-x301>
References: <20100805102513.GA7221@jh-x301>
    <1281047801-4044-1-git-send-email-ingas@codeaurora.org>
    <20100806075552.GA22150@jh-x301>
Date: Fri, 6 Aug 2010 09:16:22 -0700 (PDT)
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
     "Device Found" signal.
From: ingas@codeaurora.org
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Hi Inga,
>
> On Thu, Aug 05, 2010, Inga Stotland wrote:
>> +	while (len < EIR_DATA_LENGTH - 1) {
>> +		uint8_t type = eir_data[1];
>> +		uint8_t field_len = eir_data[0];
>> +
>> +		/* Check for the end of EIR */
>> +		if (field_len == 0)
>> +			break;
>
> Shouldn't there also be another check here:
>
> 		/* Bail out if field_len claims to reach beyond the EIR
> 		 * data end */
> 		if (len + field_len + 1 >= EIR_DATA_LENGTH)
> 			break;
>

After reading in eir_data[0] & eir_data[1] (and those reads are valid due
to passing the "while (len < EIR_DATA_LENGTH - 1)" check above) there are
no more memory accesses in the loop. And if we do end up reading in field
length that's bogus, we fail the "while" check on next iteration, exit the
loop, fail the "(len > EIR_DATA_LENGTH)" and bail out of the routine with
NULL return value.

Actually, I originally had the check for field length inside the loop, but
then moved it outside for efficiency reasons.

Thanks,

Inga


--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


>


