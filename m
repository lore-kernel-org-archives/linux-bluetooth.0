Return-Path: <SRS0+16d66c160553e32a8683+270+infradead.org+dwmw2@pentafluge-102826.srs.infradead.org>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085044833.4327.132.camel@pegasus>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
	 <1084382445.25099.77.camel@pegasus>
	 <1084382743.4426.351.camel@hades.cambridge.redhat.com>
	 <1084382951.25099.89.camel@pegasus>
	 <1084383201.4426.374.camel@hades.cambridge.redhat.com>
	 <1084383929.25099.94.camel@pegasus>
	 <1085044520.28151.1256.camel@hades.cambridge.redhat.com>
	 <1085044833.4327.132.camel@pegasus>
Content-Type: text/plain
Message-Id: <1085045305.28151.1269.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 20 May 2004 10:28:25 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-05-20 at 11:20 +0200, Marcel Holtmann wrote:
> many thanks for that.
> 
> Besides these, have you checked the Bluetooth CUPS backend, which is
> also included in bluez-utils-2.7?

It's in the bluez-utils-cups RPM. I haven't tried it as I have no
suitable hardware. We only have the client side implemented, don't we --
I can't emulate it by using another Linux/BlueZ box as the 'printer'?

I note it doesn't actually try very hard to find printers :)

> > In fact, I suspect that the right answer for pand is to tie it into the
> > initscripts and system-config-network, so you add an interface of type
> > 'PAN slave' or 'PAN master' and the network scripts handle starting and
> > stopping the daemon like they do ipppd, rather than doing it from a SysV
> > init script. I haven't used dund so I'm less sure about that but it
> > might also be the right approach there.
> 
> I am not a Fedora Core user, so I can't answer this question, but in
> general it is up to you to decide.

That's not really distro-specific. Well, the precise details of the
implementation might be -- but the idea that it's done in network
configuration and started like pppd on 'ifup', rather than by init like
a system daemon, isn't. 

-- 
dwmw2
