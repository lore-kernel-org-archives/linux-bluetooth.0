Return-Path: <cyrus@holtmann.org>
Message-ID: <1386452389.32408.23.camel@nuvo>
Subject: Re: Missing properties during pairing, refcounting bug?
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 07 Dec 2013 22:39:49 +0100
In-Reply-To: <20131207180028.GC29280@x220.p-661hnu-f1>
References: <1386420104.32408.9.camel@nuvo>
	 <20131207180028.GC29280@x220.p-661hnu-f1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2013-12-07 at 22:00 +0400, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Sat, Dec 07, 2013, Bastien Nocera wrote:
> > Johan was blaming my "slow" Bluetooth adapter for the missing Class
> > property when pairing was remote initiated,
> 
> I don't recall blaming your Bluetooth adapter, but simply concluding
> that it seems either the local or remote side is slow in doing the name
> discovery, based on the HCI log you produced. Your discovery of the
> issue going away by adding delay before replying to the PIN request
> seemed to support this conclusion.

Right. This isn't the TomTom Remote anymore, but a Sony Ericsson phone.
I'm pretty certain that I'd be able to reproduce the problem with
another adapter.

<snip>
> Yep. Device which have dev->temporary = TRUE get removed when the
> connection to them is lost.

But why is the connection lost? It seems to me that the loss is only
temporary, and part of the pairing process. Is it the reverse SDP
finishing? We shouldn't unref the device yet certainly.

>  The temporary flag in turn gets cleared upon
> successful pairing or when we've initiated some procedure through
> Device1.Connect() or Device1.Pair().
> 
> That said, I think it would make sense to apply the same policy on
> remotely initiated connections as we do for devices we've discovered but
> not yet connected to. In other words, I think we should have the same 3
> minute timer for this kind of device objects and only remove them if
> pairing didn't happen by that time. Does it sound like it might solve
> the issue?

I think 3 minutes is far too high. In this particular case, I think that
the device is getting unref'ed too early during the pairing process.

Could you walk me through the pairing process, remote initiated, for a
pre-2.1 device? I don't understand why I'm seeing a complete
disconnection from the remote device.

Cheers

