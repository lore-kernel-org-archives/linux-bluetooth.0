Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Feb 2011 10:58:49 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Frequent SM test failure at UPF
Message-ID: <20110208135849.GA31237@piper>
References: <4D508DC2.60003@codeaurora.org>
 <4D509ABA.1010909@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D509ABA.1010909@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 17:22 Mon 07 Feb, Brian Gix wrote:
> On 2/7/2011 4:26 PM, Brian Gix wrote:
> >
> >Testing of Shorter than 16 octet keys.
> >
> >In smp_cmd_pairing_random() when the STK is generated, it needs to be
> >truncated to the MIN of conn->preq[4] and conn->pres[4].
> >
> >This Min value may need to be saved for later as well, because it needs
> >to also limit the LTK key exchange.
> >
> >This failure showed up with the PTS tool, and at least one other device
> >during the days testing. I have mocked up a fix, but have not had a
> >chance to test it yet.
> >
> >

First, thanks for the reports. This particular issue should be fixed soon.

> 
> PTS also did not like that we request No Bonding, but request to
> exchange keys.  I am not sure who is at fault there. At first
> glance, exchanging keys insinuates a bonded relationship, so I don't
> know what it means to request key exchange but not bond.  I think
> both sides need to agree to bond (bit 0x01 in offset 3 (4th octet)
> of the req and res) to remember the exchanged keys, but exchanging
> keys should still be OK for the duration of that session at least.
> They would then be discarded when the connection ended.
> 
> It also may not make sense to request Bonding, but not have keys to
> exchange, because I am not sure if you are really bonded if you have
> no keys exchanged with the remote device.  You could always just
> remember the remote device's BD Addr, I suppose and choose to accept
> or reject no-security connections based on that.
> 
> I am sorry, the above is mostly just me thinking out loud. I don't
> know for sure if any of that is actually correct.
> 

So, I will add something to the thinking out loud session ;-) seems to me that
the tests were written assuming that most of the limitations are in the slave,
when some of them find a limited (for now) SM implementation in the master 
side some things are not so clear.

> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

Cheers,
-- 
Vinicius
