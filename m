Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimboYUW4v=tHmVKiCKELqbGfAxegg@mail.gmail.com>
References: <BANLkTim=DVTzgBXDp4Rsed8LNwfrY47ACg@mail.gmail.com>
	<BANLkTimboYUW4v=tHmVKiCKELqbGfAxegg@mail.gmail.com>
Date: Thu, 9 Jun 2011 11:48:00 +0200
Message-ID: <BANLkTi=qBBOkmcS4SD+QJ-BLu7is=ghLTg@mail.gmail.com>
Subject: Re: Read clock not implemented in management
From: Santiago Carot <sancane@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

2011/6/8 Santiago Carot <sancane@gmail.com>:
> Hello Claudio.
>
> 2011/6/8 Claudio Takahasi <claudio.takahasi@openbossa.org>:
>> Hi Santiago and Elvis,
>>
>> Read clock is not implemented in the management interface. Does it
>> break something important in the health plug-in?
>>

Coming back to this issue. I'm not caught up with this stuff and I
dont know if there are any special reason to not provide a read clock
functionality in the bluetooth API. although I think it's a pity  to
restrict MCAP features after the good work Elvis did in CSP.

Regards.

>
> Read clock is only required for Clock Shynchronization Protocol (CSP)
> in MCAP, but  CSP is not mandatory for HDP and although this feature
> was implemented in MCAP is not used in the Health Plugin so it won't
> break the API.
>
>> I am not aware when hciops will be dropped, but the fact is: if the
>> system uses mgmtops instead of hciops health will not work properly.
>>
>
> Well, as far as I know, only MCAP uses it for CSP and it's an optional
> part in the specification so it won't a severe problem for health
> applications.
>
>> BR,
>> Claudio.
>>
>
