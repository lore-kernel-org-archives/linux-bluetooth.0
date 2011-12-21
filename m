Return-Path: <cyrus@holtmann.org>
Message-ID: <4EF27216.4030905@codeaurora.org>
Date: Wed, 21 Dec 2011 15:56:06 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v8 1/2] Bluetooth: Add MITM mechanism to LE-SMP
References: <1324505319-3881-1-git-send-email-bgix@codeaurora.org>	 <1324505319-3881-2-git-send-email-bgix@codeaurora.org> <1324511576.1965.186.camel@aeonflux>
In-Reply-To: <1324511576.1965.186.camel@aeonflux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 12/21/2011 3:52 PM, Marcel Holtmann wrote:
> Hi Brian,
>
>> +static const u8	gen_method[5][5] = {
>
> can the tab between u8 and gen_method please go away.
>
>> +	{ JUST_WORKS, JUST_CFM, REQ_PASSKEY, JUST_WORKS, REQ_PASSKEY     },
>> +	{ JUST_WORKS, JUST_CFM, REQ_PASSKEY, JUST_WORKS, REQ_PASSKEY     },
>> +	{ CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, CFM_PASSKEY },
>> +	{ JUST_WORKS, JUST_CFM, JUST_WORKS, JUST_WORKS, JUST_CFM         },
>> +	{ CFM_PASSKEY, CFM_PASSKEY, REQ_PASSKEY, JUST_WORKS, OVERLAP     },
>> +};
>
> Can you make sure all elements are aligned like you had it before. So
> the table becomes readable. If you go over 80 chars here then that is
> fine. So be it.
>

Sure.  Sorry, I misunderstood which tab you were referring to last time.


> For the rest I am happy with it.
>
> Acked-by: Marcel Holtmann<marcel@holtmann.org>
>

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
