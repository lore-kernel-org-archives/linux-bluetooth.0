Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: "Ganir, Chen" <chen.ganir@ti.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 1 Nov 2011 16:04:29 +0100
Subject: RE: Implementation of name-resolve procedures in mgmtops
Message-ID: <AC090B9732AB2B4DB7FF476E907FE660013BAEC984@dnce02.ent.ti.com>
References: <7769C83744F2C34A841232EF77AEA20C01DCC8D2B7@dnce01.ent.ti.com>
 <AC090B9732AB2B4DB7FF476E907FE660013BAEC903@dnce02.ent.ti.com>
 <20111101134757.GA13263@fusion.localdomain>
 <20111101135225.GA13355@fusion.localdomain>
 <AC090B9732AB2B4DB7FF476E907FE660013BAEC932@dnce02.ent.ti.com>
 <7769C83744F2C34A841232EF77AEA20C01DCC8D380@dnce01.ent.ti.com>
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCC8D380@dnce01.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: Ganir, Chen
> Sent: Tuesday, November 01, 2011 5:01 PM
> To: Ilia, Kolominsky; Johan Hedberg; linux-bluetooth@vger.kernel.org
> Subject: RE: Implementation of name-resolve procedures in mgmtops
> 
> Ilia, Johan,
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Ilia, Kolominsky
> > Sent: Tuesday, November 01, 2011 3:58 PM
> > To: Johan Hedberg; linux-bluetooth@vger.kernel.org
> > Subject: RE: Implementation of name-resolve procedures in mgmtops
> >
> > > -----Original Message-----
> > > From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> > > Sent: Tuesday, November 01, 2011 3:52 PM
> > > To: Ilia, Kolominsky; linux-bluetooth@vger.kernel.org
> > > Subject: Re: Implementation of name-resolve procedures in mgmtops
> > >
> > > Hi,
> > >
> > > On Tue, Nov 01, 2011, Johan Hedberg wrote:
> > > > > > Each "unknown name" device that user-space tells the kernel
> > about
> > > gets
> > > > > > added to a list and once the currently ongoing inquiry
> finishes
> > > the
> > > > > > kernel proceeds with trying to resolve the name for each
> device
> > > in the
> > > > > > list, one at a time. For efficiency, this list should be
> sorted
> > > by
> > > > > > strongest RSSI first so that devices which are with a higher
> > > likelihood
> > > > > > closer to us get their names resolved first. The kernel will
> > also
> > > wait
> > > > > > a
> > > > > > few seconds (2 sounds like an ok value?) if user space hasn't
> > yet
> > > > >
> > > > > Do we really need to wait here? - if this is to allow human
> > > interaction
> > > > > then 2 sec will be not enough anyway, if this is to allow the
> ack
> > > for
> > > > > the last ( the assumption is that the user will decide whether
> to
> > > ack or
> > > > > not on more or less sequential way ) discovered device, then,
> > > > > 2 sec is an overkill, so 1 or even 0.5 I think may be enough.
> > > >
> > > > It's for the later case (e.g. for inquiry results that come right
> > > before
> > > > the inquiry complete event). The question then is, for a system
> > under
> > > > heavy load what is a reasonable expectation to schedule in
> > > bluetoothd,
> > > > let it respond to the event and send the command and then
> schedule
> > > the
> > > > part of the kernel that handles the command from from bluetoothd.
> > > Maybe
> > > > 1 second is enough, but there really isn't any single right
> answer
> > > for
> > > > this.
> > >
> > > Actually there are two more context switches involved which
> probably
> > > introduce the most latency into the whole procedure: each time
> > > bluetoothd gets a device_found event with confirm_name set to 1
> it'll
> > > need to access the file-system in /var/lib/bluetooth to check if
> the
> > > name is stored there.
> >
> > Alright then, to be on the safe, let's do it 2 sec, my idea was
> > to finish the whole process asap. But since io is involved, 2 sec
> > seems to be a reasonable balance.
> > >
> > > Johan
> >
> > Ilia
> 
> Please keep in mind that if you do it 2 seconds, that will cause a
> problem. In interleaved scanning, we need to scan for BR/EDR devices
> for ~5 seconds ( T_GAP_100/2), and then LE devices for 5 seconds. If we
> wait 2 seconds for timeout, this means 2 seconds in which we do
> nothing. This will mean that we need to scan for BR/EDR for 1 second,
> wait 2 seconds for ack, and then we will have about 2 more seconds for
> name requests for legacy devices. We need to think of a better solution
> here, which will coexist with interleaved device discovery.
> 
> What if we start name requests immediately after the inquiry is
> complete, according to what is already pending for name request (what
> the user has already confirmed for name request), and allow the user to
> confirm the name request for more devices up until we complete the name
> request process and return the SCAN_COMPLETE event ? The SCAN_COMPLETE
> event will be sent once the pending names list is clear, or any other
> limit we decide.
> 

Lets send the he name-resolving requests after the "General Discovery
Procedure" ( as in 13.2.1 of spec ) completes?

> Chen Ganir.

Regards, Ilia
