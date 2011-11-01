Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 17:20:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "Ilia, Kolominsky" <iliak@ti.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Implementation of name-resolve procedures in mgmtops
Message-ID: <20111101152002.GA2047@fusion.localdomain>
References: <7769C83744F2C34A841232EF77AEA20C01DCC8D2B7@dnce01.ent.ti.com>
 <AC090B9732AB2B4DB7FF476E907FE660013BAEC903@dnce02.ent.ti.com>
 <20111101134757.GA13263@fusion.localdomain>
 <20111101135225.GA13355@fusion.localdomain>
 <AC090B9732AB2B4DB7FF476E907FE660013BAEC932@dnce02.ent.ti.com>
 <7769C83744F2C34A841232EF77AEA20C01DCC8D347@dnce01.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCC8D347@dnce01.ent.ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Tue, Nov 01, 2011, Ganir, Chen wrote:
> Please keep in mind that if you do it 2 seconds, that will cause a
> problem. In interleaved scanning, we need to scan for BR/EDR devices
> for ~5 seconds ( T_GAP_100/2), and then LE devices for 5 seconds. If
> we wait 2 seconds for timeout, this means 2 seconds in which we do
> nothing. This will mean that we need to scan for BR/EDR for 1 second,
> wait 2 seconds for ack, and then we will have about 2 more seconds for
> name requests for legacy devices. We need to think of a better
> solution here, which will coexist with interleaved device discovery.

There must be something wrong with the spec or your understanding of it
since this doesn't make any sense to me. The only thing that would make
sense to me is if this 5 seconds only includes the inquiry phase but not
the name resolving phase. Typically BR/EDR devices have their page
timeout configured anywhere between 5 and 20 seconds. This means that
for a single BR/EDR device that happens to be out of range when the time
for name resolving comes, you could end up waiting quite long after the
inquiry phase. Even for devices within range 1 second isn't an unusual
time for name resolving, so you'd already go over 5 seconds with just 5
pre-2.1 devices around you.

> What if we start name requests immediately after the inquiry is
> complete, according to what is already pending for name request (what
> the user has already confirmed for name request), and allow the user
> to confirm the name request for more devices up until we complete the
> name request process and return the SCAN_COMPLETE event?

I don't know what you mean by "SCAN_COMPLETE" event, but this is what we
can and should certainly do. However if there was a single device found
for which we do not know the name, then the "pending" list will be empty
and in the worst case we'll end up waiting for whatever we decide to use
as a timeout. Note that this is not something that will always or even
frequently happen. In most cases inquiry results come well before the
inquiry complete and if the system isn't under really heavy load the
kernel will receive its ack in much shorter time.

Johan
