Return-Path: <cyrus@holtmann.org>
Message-ID: <4CB69D35.2010802@Atheros.com>
Date: Thu, 14 Oct 2010 11:33:33 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: steven bluez <steven.bluez@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <gustavo@padovan.org>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Query regarding Virtual simulators
References: <AANLkTincuwLZnBhjj=vrmghDEcmZhL=dy1VP=SH6vK_Y@mail.gmail.com>
In-Reply-To: <AANLkTincuwLZnBhjj=vrmghDEcmZhL=dy1VP=SH6vK_Y@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

On 10/14/2010 10:57 AM, steven bluez wrote:
> HI MARCEL,GUSTAVO,Suraj
>
>                   If I am developing a profile thats not yet been
> implemented in bluez and if i dont have a Hardware that supports the
> profile.How can i validate it to fix a situation that this profile
> really works.Is there any virutal dummy simulators?
> Do help me out by giving certain ideas on how to perform the same? .
>
> Thanks,
> Steven

I am not sure about any virtual dummy simulator.
But, you should be able to write a dummy agent and test the profile 
against PTS if the profile is supported by it.

PTS would be able to give you a fair idea of what is missing.

It would be great if you can send a mail to the community regarding the 
profile and how you intent to implement it. There would be people with 
access to the hardware and they would be able to guide you accordingly.

Regards
Suraj

