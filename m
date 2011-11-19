Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC7D77F.7060505@codeaurora.org>
Date: Sat, 19 Nov 2011 08:21:19 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Chen Ganir <chen.ganir@gmail.com>
CC: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] LE based Remote Name Request
References: <4EC6B482.1070106@codeaurora.org>	<20111118220848.GA17225@samus.indt.org>	<CAKT1EBf8cE8=09rqHZR+8xzC3HhsGvWv_BJBBWVKE-=fHB9-Uw@mail.gmail.com>	<4EC6ECAE.3010403@codeaurora.org> <CAP2aRG+Wfvs-gEAjR5aKYx1FfMF69LmfMaHgRZnoxEbqUaYDGg@mail.gmail.com>
In-Reply-To: <CAP2aRG+Wfvs-gEAjR5aKYx1FfMF69LmfMaHgRZnoxEbqUaYDGg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On 11/18/2011 9:28 PM, Chen Ganir wrote:
> On Sat, Nov 19, 2011 at 01:39, Brian Gix<bgix@codeaurora.org>  wrote:
>> Those are otherwise good points (not all devices will automatically start
>> advertising again) however ServiceChanged should never be attempted to be
>> read.  We should only obtain this via an Indication from the remote device,
>> and at any rate it is only shared with Trusted devices, so we would have to
>> be Bonded.
>>
>> However, I would definitely NOT try to re-read Name/Appearance at every
>> connection.  Those should definitely be cached, and not re-read unless we
>> get the ServiceChanged Indication.
>>
> ServiceChanged is irrelevant here. ServiceChanged will only notify you
> if the handles changed, not if the value changed. Name and appearance
> can and should be read, since we may get only the short name in the
> advertising data, and we wil need the full name. In addition, a device
> may change its name, and we will not be notified of this (GAP name
> characteristic does not notify/indicate). Name may change just like it
> does in BR/EDR.

I don't think we should do anything automatically on start-up.

If we know that we do not have the full name (if the Adv data has it 
flagged as "Partial") then we should of course fetch the full name from 
the characteristic.  However, if we get in the habit of re-reading data 
just because it *may* have changed, then we lose track of what LE is all 
about, which is minimization of over-the-air traffic.

If a particular high level app wants refresh the Name and/or Appearance, 
then of course which should provide that ability, but I might consider 
that App to be poorly written barring a compelling need, like perhaps an 
indication that it needs to be re-paired.  Single mode LE devices will 
generally be single mode because they want to limit these unneeded 
transactions.  LE Profiles are designed to not require Polling type 
activities, which a Name or Appearance refresh would be.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
