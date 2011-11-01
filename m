Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 15:47:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Implementation of name-resolve procedures in mgmtops
Message-ID: <20111101134757.GA13263@fusion.localdomain>
References: <7769C83744F2C34A841232EF77AEA20C01DCC8D2B7@dnce01.ent.ti.com>
 <AC090B9732AB2B4DB7FF476E907FE660013BAEC903@dnce02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE660013BAEC903@dnce02.ent.ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

On Tue, Nov 01, 2011, Ilia, Kolominsky wrote:
> Maybe we should keep resolve_name() method, so the user will be able to
> perform name resolution for a specific device without
> triggering the whole discovery process? This will allow more flexibility
> for the user.

We haven't had that in the higher level (D-Bus API) so far and it's not
planned to be added for 5.x either. The name gets refreshed
automatically every time there's a connection to the device without the
need of an explicit API for it.

> > Each "unknown name" device that user-space tells the kernel about gets
> > added to a list and once the currently ongoing inquiry finishes the
> > kernel proceeds with trying to resolve the name for each device in the
> > list, one at a time. For efficiency, this list should be sorted by
> > strongest RSSI first so that devices which are with a higher likelihood
> > closer to us get their names resolved first. The kernel will also wait
> > a
> > few seconds (2 sounds like an ok value?) if user space hasn't yet
> 
> Do we really need to wait here? - if this is to allow human interaction
> then 2 sec will be not enough anyway, if this is to allow the ack for
> the last ( the assumption is that the user will decide whether to ack or
> not on more or less sequential way ) discovered device, then,
> 2 sec is an overkill, so 1 or even 0.5 I think may be enough.

It's for the later case (e.g. for inquiry results that come right before
the inquiry complete event). The question then is, for a system under
heavy load what is a reasonable expectation to schedule in bluetoothd,
let it respond to the event and send the command and then schedule the
part of the kernel that handles the command from from bluetoothd. Maybe
1 second is enough, but there really isn't any single right answer for
this.

Johan
