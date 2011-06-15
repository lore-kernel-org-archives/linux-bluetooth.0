Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/4] Add support for custom (e)SCO parameters
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Date: Wed, 15 Jun 2011 04:08:05 -0700
In-Reply-To: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308136088.2518.3.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> Following patches add possibility to specify custom parameters for
> outgoing (e)SCO link. This is implemented as SCO socket options.
> 
> This change allows to use reference parameters as defined in HFP 1.5
> specification as well as support for future enchancements as wideband
> speech as defined in HFP 1.6 draft (uses different air coding format).
> 
> Additional socket option (patch 3) allows to disable automatic retry
> in case of failure which fallbacks from eSCO to SCO connection in
> current implementation. Such fallback should not happen when using
> wideband speech which mandates using of eSCO transport.

I am not a big fan of just stupidly exposing all possible HCI value to
userspace and let userspace set them. Especially since in the end there
are no real variation here anyway. There are just a 2-3 use cases for
your SCO socket.

I would rather have simple mode to hand to the kernel and let it do the
right thing (including negotiation and downgrading to SCO) than having
userspace opening sockets over sockets again.

So what are the actual modes for HFP that need to be supported and what
is the range of possible SCO and eSCO options?

Regards

Marcel


