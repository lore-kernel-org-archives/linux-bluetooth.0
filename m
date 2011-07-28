Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jul 2011 11:49:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: can adapters have a say in automatic setup procedure?
Message-ID: <20110728084948.GA13243@dell>
References: <CABUK1ahn-HxWWwaqO=eeYUvLoJcBRLeg1Z+sPikRTbg=zimYWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABUK1ahn-HxWWwaqO=eeYUvLoJcBRLeg1Z+sPikRTbg=zimYWQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Wed, Jul 27, 2011, Pavan Savoy wrote:
> The patch mentioned below seem to power on the adapters for before
> they are being actually used and the user-space bluetoothd exists.
> I am not sure in what situations or what sort of adapters would
> require such information to be available before-hand, even before the
> adapter is intended to be used.

The reason why this behavior was implemented is that there's absolutely
nothing user-space can do with an adapter for which we don't even know
the Bluetooth address. Since adapter-specific configuration is stored in
/var/lib/bluetooth/<address>/config user-space doesn't even know if the
adapter should be kept switched off or not without switching it on at
least once (to read the address).

With the new management interface the existence of adapters isn't even
reported to user space (MGMT_EV_INDEX_ADDED) before they've been
switched on and had the basic information fetched about them.

*If* there's no user-space available the kernel has a timer to switch
the adapter back off, but I guess this isn't helpful for you since you
just want to postpone hdev->open() to the last possible moment.

> However, what I would really like is the adapters to have say in this.
> I do-not want my bluetooth device to be accessed before the bluetooth
> user-space exists, Because I would require to do a bunch of
> initialization upon hdev->open of my interface, which I don't want to
> go thru' just to provide information.
> 
> So please suggest on this....

Maybe a module parameter to disable this "auto-on" feature? The problem
with that would be that it wouldn't really work with the management
interface (like I pointed out above). Another option would be to make
the kernel wait until it gets some indication that user-space is
available and only after that proceed with doing this auto-on for all
available adapters (after which they'd all be reported to user-space
through ev_index_added).

I'd also like to get some comment from Marcel about this since the
feature was originally his idea.

Johan
