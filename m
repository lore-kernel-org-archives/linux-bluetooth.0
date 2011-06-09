Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jun 2011 21:28:06 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: Santiago Carot <sancane@gmail.com>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Read clock not implemented in management
Message-ID: <20110609122805.GA8875@dell.ccr.corp.intel.com>
References: <BANLkTim=DVTzgBXDp4Rsed8LNwfrY47ACg@mail.gmail.com>
 <BANLkTimboYUW4v=tHmVKiCKELqbGfAxegg@mail.gmail.com>
 <BANLkTi=qBBOkmcS4SD+QJ-BLu7is=ghLTg@mail.gmail.com>
 <A4DF21E7-112D-4AA7-9043-90C744A33CE0@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A4DF21E7-112D-4AA7-9043-90C744A33CE0@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 09, 2011, Elvis Pfutzenreuter wrote:
> > Coming back to this issue. I'm not caught up with this stuff and I
> > dont know if there are any special reason to not provide a read clock
> > functionality in the bluetooth API. although I think it's a pity  to
> > restrict MCAP features after the good work Elvis did in CSP.
> 
> More to the point, could we implement HCI read clock for mgmt interface? Or
> it simply won't have read clock by design?

There's no obvious reason why it couldn't have it. However other means
should be considered too, e.g. would it be cleaner to get the info
directly through the socket (using a socket option or something
similar)? Or was this already considered when the HCI socket solution
was implemented?

Johan
