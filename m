Return-Path: <cyrus@holtmann.org>
Message-ID: <4C906430.90900@Atheros.com>
Date: Wed, 15 Sep 2010 11:44:08 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>	 <1284442946.2405.50.camel@localhost.localdomain>	 <4C8F160B.4010401@Atheros.com> <1284522264.2405.89.camel@localhost.localdomain>
In-Reply-To: <1284522264.2405.89.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 9/15/2010 9:14 AM, Marcel Holtmann wrote:
> Hi Suraj,
>
>>
>> I would really appreciate if you can give me any idea about working
>> around the above mentioned issues.
>
> if we talk about the SAP server role found in a mobile phone, then that
> support clearly needs to interact with the telephony stack. Since when
> SAP is active the telephony stack needs to be suspended and all SIM
> transaction being forwarded.
>
> Currently I would be thinking that the SAP implementation should be done
> inside oFono actually. Since then you have direct access to the
> hardware. The D-Bus approach just doesn't sound correct to me. I could
> be of course wrong, but I can't wrap my mind around on how you can make
> this work.
>
> Even with file descriptor passing this doesn't look like the right
> approach. If we need a hardware abstraction than we either use oFono or
> we have to create some SAP hardware access abstraction.

The advantage I thought d-bus has would be the generic interface it 
could provide. But, if we have a system with direct access to the Sim 
access hardware, D-bus could possibly become a bottleneck.

I would really appreciate if others who have worked with Sim Access and 
OFono can give their comments.

Also, please share some information on regarding the SIM reader 
implementation in linux based systems.

>
> The SAP client role found a carkit is obviously a different story.
>
> Regards
>
> Marcel
>
>
Regards
Suraj

