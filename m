Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Feb 2014 08:44:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Background scanning and white list usage
Message-ID: <20140228064422.GA28466@localhost.P-661HNU-F1>
References: <BFAEE1C5-E74F-40F0-A1A4-8F4907FBDCF4@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BFAEE1C5-E74F-40F0-A1A4-8F4907FBDCF4@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 27, 2014, Marcel Holtmann wrote:
> The complicated part comes into play when we have devices with LE
> Privacy enabled and when they are using resolvable private addresses.
> Meaning when our IRK list is populated with identity addresses and
> their IRKs. The only way to make this work with the current available
> controller features is if we program the RPA into the white list.
> Since that RPA is going to change over time, we need to stop scanning
> with the white list filter every now and then, scan for all devices
> and resolve the RPA. If we see a new RPA for a know IRK, we have to
> replace the old RPA in the white list with the new RPA. And then we go
> back to scanning with the white list filter policy.
> 
> Now the important question is what are good enough intervals to make
> this work smoothly. Devices using LE Privacy will take a hit in their
> re-connection time, but that is what we have to trade in for compared
> to waking up the host for every single advertising packet.
> 
> My initial idea is to scan 5 minutes using the white list, then scan
> 10 seconds without the white list, then back to 5 minutes using the
> white list and so on.
> 
> The default value for the PRA lifetime according to the specification
> is 15 minutes. I timed recent iOS devices which seem to be using 9
> minutes intervals. So we have to play a little bit with this and see
> what are good values.
> 
> Maybe 3 minutes white list scan and 5 seconds without white list is
> better. Things to try out.

I don't think this is a good idea at all. With LE starting advertising
is typically seen as the initiating action of connection creation
(unlike with BR/EDR where HCI_Create_Connection is the initiating
action). Typically peripherals mean "connect to me now!" when they start
connectable advertising.

Let's stay you switch on your peripheral device, or it comes into range
you haven't used it for some time (hours or even days). If it's using
RPAs it's pretty much guaranteed to have a different one than what we
know of and even if we're using 3 minutes white list scanning the user
is on average going to have to wait for 1.5 minutes for the device to
get connected which is not acceptable behavior (the extreme example
would be if this is a keyboard or a mouse which you start using for the
first time in the morning - moving the mouse or pressing a key on the
keyboard should certainly get you a connection in less than 1 second).

I fully understand the desire to use the white list as it's a very nice
power saving feature, but I don't think we can win here as long as we
don't have a way to have the controller do the resolving for us.

One thing we could potentially try to do (but which I doubt is really
worth it in the end) is to track the age of resolved RPAs. If we have an
RPA which was resolved say less than 5 minutes ago we consider it
appropriate to place into the white list. Otherwise we skip using the
white list.

Johan
