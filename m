Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1292539367.6740.13.camel@sealablnx02.qualcomm.com>
References: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
	<1292442852-26457-2-git-send-email-claudio.takahasi@openbossa.org>
	<1292539367.6740.13.camel@sealablnx02.qualcomm.com>
Date: Mon, 20 Dec 2010 11:03:40 -0300
Message-ID: <AANLkTimLuXaEEqx3ER2BxV8nyeYN0GCXke0_Hpy40_BV@mail.gmail.com>
Subject: Re: [PATCH 2/5] Change CreatePairedDevice to support LE devices
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org,
	Sheldon Demario <sheldon.demario@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Thu, Dec 16, 2010 at 7:42 PM, Brian Gix <bgix@codeaurora.org> wrote:
> Hi Claudio,
>
> On Wed, 2010-12-15 at 16:54 -0300, Claudio Takahasi wrote:
>> From: Sheldon Demario <sheldon.demario@openbossa.org>
>>
>> CreatePairedDevice implements now the same behaviour of CreateDevice,
>> triggering Discover All Primary Services when needed. SMP negotiation
>> starts when the link is established. LE capable kernel is required to
>> test this method properly.
>
> What is your plan for handling single mode LE (remote) devices which
> have privacy enabled (random addresses). This impacts connection
> establishment, and SM pairing, as the remote device's addr type must
> be known at that time, and handled differently.

At the moment, we don't have a clear picture how we will address
random address. For this first phase I was considering to support
public address only.

The kernel doesn't have persistent storage of the key, we will
implement it using the new kernel management interface.
We discussed the possibility of translate/resolve the address in the
kernel, but we didn't reach a conclusion yet.

Regards,
Claudio.
