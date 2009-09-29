Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/7] Bluetooth: Initialize variables and timers for
 both channel's sides
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6b53b1990909282215l6a823048sf3e684cc8ceeb047@mail.gmail.com>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254200130.2659.72.camel@localhost.localdomain>
	 <6b53b1990909282215l6a823048sf3e684cc8ceeb047@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 22:18:42 -0700
Message-Id: <1254201522.2659.85.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> >> ERTM entity need to handle state vars, timers and counters to send and
> >> receive I-frames. We initialize all of them to the default values here.
> >
> > while this is a good idea. Where is the justification for pushing this
> > after the merge window?
> 
> These patches are bug fixes and implementations of missing parts of ERTM spec.
> For instance, they enable ERTM to transmit in a full duplex among other things.
> Also, ERTM isn't enabled on L2CAP, so we aren't introducing any regressions and
> ASAP we put this code on mainline more feedback we can get from
> possible testers.
> 
> Should I put this on the commit message?

if it fixes a bug in the current implementation, then that is fine. If
it adds another feature, then it is not acceptable. However if that
feature is mandatory by the specification, then that is a different
story. Make it perfectly clear what you are fixing or adding.

L2CAP has been in the kernel before and so the not introducing a
regression is not a real valid argument. You normally only get that for
new drivers or subsystems.

And forget about the idea with the more testers. After the merge window
that comment is void.

Regards

Marcel


