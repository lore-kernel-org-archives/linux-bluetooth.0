Return-Path: <cyrus@holtmann.org>
Message-ID: <1343399863.1803.10.camel@aeonflux>
Subject: Re: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket
From: Marcel Holtmann <marcel@holtmann.org>
To: Manoj Sharma <ursmanoj@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Date: Fri, 27 Jul 2012 07:37:43 -0700
In-Reply-To: <CAHH5__6sQ2yyEpuDZYMd4mFmHJEJeRX4eKzVM47k9TQcSthywA@mail.gmail.com>
References: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
	 <1343138034.24426.55.camel@aeonflux>
	 <CAHH5__6sQ2yyEpuDZYMd4mFmHJEJeRX4eKzVM47k9TQcSthywA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manoj,

> >> These patches allows L2CAP socket user to reserve bandwidth in
> >> percentage. Underlying socket reserves calculated number of
> >> HCI credits for this L2CAP channel.
> >
> > this description is by far not enough. Explain why you are doing this.
> > And make it a detailed description. Preferable with hcidump traces
> > showing why this makes a difference at all.
> >
> This patch simply adds an additional L2CAP socket option for reserving
> bandwidth.
> The reserved bandwidth would result into reserving calculated number
> of ACL data credits. Thus the L2CAP channels without this option set
> would not be able to use all available ACL buffers in controller. This
> would ensure that whenever an L2CAP channel with this option set has
> data to send, it does not starve or wait because of other channels
> already using all controller buffers.
> 
> Above explanation is most suitable in case when simultaneous AVDTP
> streaming channels and other channels (e.g. OPP, PBAP etc) are in
> action. Such an arrangement for reserving credits would allow AVDTP
> stream to flow to controller without any obstacle from simultaneous
> traffic and help removing glitches in music streaming over Bluetooth.
> Please suggest if this description is sufficient and if I should push
> patch-set again.

and what is the problem with using SO_PRIORITY for this?

Regards

Marcel


