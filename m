Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7A6BFC.4040704@codeaurora.org>
Date: Fri, 11 Mar 2011 10:37:48 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
CC: Johan Hedberg <johan.hedberg@nokia.com>,
	linux-bluetooth@vger.kernel.org,
	=?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: [PATCH 1/5 v2] Add new UUID utility functions
References: <1299853813-15753-1-git-send-email-epx@signove.com> <AANLkTims=7dS56VhVQXgSgwkLQsjcu=rYL3cvrsZCfFq@mail.gmail.com>
In-Reply-To: <AANLkTims=7dS56VhVQXgSgwkLQsjcu=rYL3cvrsZCfFq@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 3/11/2011 10:02 AM, Claudio Takahasi wrote:
> Hi Johan/Brian,
>
> On Fri, Mar 11, 2011 at 2:30 PM, Elvis Pfützenreuter<epx@signove.com>  wrote:
>> From: Claudio Takahasi<claudio.takahasi@openbossa.org>
>>
>> New UUID functions will store the UUIDs values on host order. Added
>> functions to create, compare and convert UUIDs.

[...]

>> +
>> +       memcpy(&uuid128->value.u128.data[BASE_UUID16_OFFSET],
>> +&uuid16->value.u16, sizeof(uuid16->value.u16));
>
> Are you fine with memcpy or it is better to use assignments(as
> proposed by Brian)?

Well, the memcpy does have the added advantage of being more immune to 
memory alignment issues.  These structures are all multiple of 4 bytes, 
so it probably doesn't matter, but the memcpy will place the data in the 
correct place for all supported architectures, without any danger of 
misalignment exceptions.  I'd now keep it as a memcpy.


Regards,

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
