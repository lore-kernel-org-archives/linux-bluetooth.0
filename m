Return-Path: <Johan.Hedberg@nokia.com>
Date: Wed, 16 Jun 2004 15:45:41 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-BUS fixes for hcid
Message-ID: <20040616124541.GA8629@kone>
References: <20040616112702.GA898@kone> <1087385828.4309.3.camel@pegasus> <20040616115718.GA8420@kone> <1087388298.4309.10.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087388298.4309.10.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

I must admit that I hadn't looked into how the bluez-pin program works
in D-BUS mode. It seems it should be running all the time to be able to
receive any D-BUS requests, correct?

The service activation feature of D-BUS which I have talked about is
designed to solve the problem where some D-BUS service should be
launched on-demand. I think the pin-helper falls exactly into this
category, and would be IMHO more elegant if it wouldn't have to be
running all the time but would be automatically launched by D-BUS daemon
when needed.

On Wed, Jun 16, 2004, ext Marcel Holtmann wrote:
> > The second part (dbus_message_set_auto_activation) enables service
> > activation if the PinAgent service isn't aquired by any process (i.e.
> > the D-BUS daemon will execute the pin-helper program if needed).
> 
> The hcid shouldn't execute the D-Bus PIN helper.

Not hcid, but the D-BUS daemon.

> From my local .xession I start "bluez-pin --dbus &" and everything works
> fine.

Ok. But by using D-BUS service activation, you wouldn't need to do this.

Johan
