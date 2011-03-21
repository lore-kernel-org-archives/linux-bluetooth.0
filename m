Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Mar 2011 19:28:29 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: SMP data within struct l2cap_conn  -vs-  single threading SMP
Message-ID: <20110321222829.GA2910@piper>
References: <4D8286A4.4000706@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D8286A4.4000706@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

Sorry for the delay,

On 15:09 Thu 17 Mar, Brian Gix wrote:
> 
> Hi Vinicius,
> 
> As you probably know, I am working on adding mgmt.c plumbing into
> SMP, to enable user level input (Confirmation, passkeys, perhaps
> OOB).
>

I didn't know. Cool.

> One issue I am running into is matching up the return of user
> confirmation with the (struct l2cap_conn *).  There is nothing
> within the user confirmation aside from the bdaddr that identifies
> who it is intended for, and there is no one-to-one relationship
> between bdaddrs and L2CAP channels.
> 

Yeah, I can see why this is a problem.

> What would you think about enforcing a "one at a time" SMP process?
> 

Short answer: seems easier to get right, but a little ugly. Long answer
below, opinions welcome.

> The SMP pairing data within the l2cap_conn structure is certainly a
> handy place for it, however it is bulky for the times (most of the
> time) where SMP is *not* taking place, and as in the obvious case I
> mention above, there is not a handy way to track the L2CAP
> connection back to the user input.

I agree that this information needs to be grouped and moved somewhere
else. Something similar to l2cap_pinfo? smp_pinfo perhaps?

> 
> I would like to suggest that all of the SMP data be pulled out of
> the l2cap_conn structure, and put into a private structure within
> smp.c. It can be malloc'd when the pairing process starts, free'd
> when it completes, and any traffic (from either the User or the
> Baseband) that takes place when another device is in the midst of
> pairing gets rejected.

This sounds very tempting, but I don't think that imposing this 
restriction from kernel side is the right aproach, the only hard
limitation that I can imagine is user interaction. And if we use
Just Works even that limitation is droped.

One question: what were your plans for dealing with multiple adapters?

Btw, it would be great if we could maintain a similar behaviour to
Basic Rate.

> 
> This structure local to smp.c would store both the bdaddr (to match
> up with user input) and the l2cap_conn * to match up with BB
> traffic, and provide the outbound path for the user confirmation
> which would otherwise be difficult to track down.

It would be a little harder but we could do something similar to l2cap
when it's needed to find a socket associated with a connection.

> 
> Your Thoughts?
> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


Cheers,
-- 
Vinicius

