Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358460154.2089.14.camel@aeonflux>
References: <1358460154.2089.14.camel@aeonflux>
Date: Tue, 22 Jan 2013 22:12:13 -0300
Message-ID: <CACJA=fV+KiKNyHcAfy98JANFqhcJgGcWOUUeGJzOfdDiqXf2kw@mail.gmail.com>
Subject: Re: Thoughts about LE scanning
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 17, 2013 at 7:02 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hello,
>
> so I have been looking into how we handle LE scanning in central role a
> little bit. And I am not really happy with what we do right now. Instead
> of just adding new profiles, we need to take one step back and get the
> basics right.
>
> The one thing that I stumbled about is that we are trying to use the
> Start Discovery management command to scan for connectable device that
> we are paired with. And it is all triggered by bluetoothd. It tries to
> get this done right, but fails badly at it. Trying to do this ends up in
> a convoluted solution that will just break down eventually.
>
> So Start Discovery and Stop Discovery management commands are for
> finding new devices. They are for finding devices that we want to pair
> with. They are not for checking if a paired device is in range or
> signals connection requests to us. It is called discovery for a reason.
>
> It might have looked like a good idea to just re-use these two commands,
> but what I am seeing when working with multiple paired LE devices is
> just a big mess. The amount of code that is needed to keep track of
> states between running D-Bus commands for discovery, discovery triggered
> management commands, scanning triggered management commands etc. is not
> a good idea.
>
> I am failing to understand why we tried to solve this inside bluetoothd
> and not just let the kernel take full control here. We are loading the
> list of paired LE devices at controller power on anyway. So the kernel
> does know about our paired devices. It can control sensible scan
> intervals and also sync a device discovery with scanning for connection
> triggers from know remote devices. It also can sensible disconnect on
> idle and scan for other devices that requests connections.

We are working on moving this connection management into kernel space
and we should start sending RFCs soon.

> What I think we should have is a management command that allows us to
> load device specific scan parameter configuration into the kernel. And
> then the kernel will execute this on our behalf. We need to decouple the
> commands for device discovery from the commands that scan for known
> devices.

Once we have the connection management working properly we can working
on this new management command to setup the scan parameters.

Regards,

Andre
