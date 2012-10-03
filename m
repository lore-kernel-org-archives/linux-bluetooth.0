Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Oct 2012 11:04:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal.Labedzki@tieto.com
Cc: linux-bluetooth@vger.kernel.org, andrei.emeltchenko.news@gmail.com
Subject: Re: Wireshark
Message-ID: <20121003080438.GA11960@x220>
References: <E50901D4F2CF69428D43141B7C8586792CFACCF505@EXMB03.eu.tieto.com>
 <20120928135747.GD8184@aemeltch-MOBL1>
 <E50901D4F2CF69428D43141B7C8586792CFACCF507@EXMB03.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E50901D4F2CF69428D43141B7C8586792CFACCF507@EXMB03.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Oct 03, 2012, Michal.Labedzki@tieto.com wrote:
> > but it can't do any kind of high-level decoding (e.g. profiles).
> > It'd be interesting to know if it could be easily supported in
> > wireshark since right now there doesn't seem to be a viable way of
> > porting decoders from hcidump to btmon due to their very different
> > ways of handling buffers etc.
> 
> Johan, I guess Wireshark support decoding what do you need (expect
> ongoing tasks). If you have another idea how do decoding, please share
> it. Power of Wireshark is:

I think you must have misunderstood what I was trying to say. Did you
actually look into what the monitor socket we talked about is? I wasn't
trying to say wireshark shouldn't be used (so no point in iterating it's
benefits - you've already convinced me) but that its Bluetooth decoding
support be ported from traditional HCI sockets to use monitor sockets
instead. This wouldn't give us any new decoders to wireshark but it
would allow early HCI traffic decoding (e.g. on plugged in USB dongles)
which isn't possible with current wireshark or hcidump and context
discovery when tracing is started after there already exists
connections.

Considering these benefits monitor sockets compared to HCI ones is it
something you might be interested in implementing?

Johan
