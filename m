Return-Path: <cyrus@holtmann.org>
Message-ID: <1325529836.1965.392.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Remove HCI_PRIO_MAX from ctrl cdm in
 RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 10:43:56 -0800
In-Reply-To: <CABBYNZ+CAnxi18+6wwWxpy61tdC0fyF1zi6PWz03q1+5NwtZFA@mail.gmail.com>
References: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
	 <1324408558-24653-2-git-send-email-padovan@profusion.mobi>
	 <1324414866.1965.133.camel@aeonflux>
	 <CABBYNZ+w0hqxHW2j4JrY_LQ8tG_aEy+Jk1TEXpixKo4aMbCQRA@mail.gmail.com>
	 <1325180758.1965.291.camel@aeonflux>
	 <CABBYNZ+CAnxi18+6wwWxpy61tdC0fyF1zi6PWz03q1+5NwtZFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> I guess you guys don't remember, but I tried to explain why the
> >> priority has to be set even for RFCOMM, any frame sent by the kernel
> >> with a timeout needs to be scheduled as soon as possible otherwise it
> >> may timeout due to quote being consumed by other channels with higher
> >> priority, so in this case if an A2DP stream in ongoing you will never
> >> be able to complete a RFCOMM connection because there wont be enough
> >> quote to schedule them before they timeout (usually 10 out 10 attempt
> >> end up like that in my setup).
> >>
> >> Perhaps if we assign a dedicated queue/hci_chan per RFCOMM socket that
> >> should get rid of this resetting sk_priority on every frame, but that
> >> means not depending on socket API at all to pass frames from RFCOMM to
> >> L2CAP, so we need an API to create L2CAP frames directly in RFCOMM
> >> modules and queue them in its hci_chan.
> >
> > yes, we need exactly this. Not using the L2CAP socket and interfacing
> > with L2CAP directly is a good idea. Same came up with A2MP as well.
> 
> Right, so I will work on this next, but in the meantime I think we
> should keep the current logic (it doesn't seems to cause any problem
> although the locking is pretty bad) until we got a proper solution and
> at least it is able to complete connections.

the locking is broken with the move to workqueues. So feel free to
figure out a locking that works, but right now it is screwed up.

Be my guest to set a MAX_PRIO - 1 by default for RFCOMM and see how that
works out.

Regards

Marcel


