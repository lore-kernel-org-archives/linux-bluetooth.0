Return-Path: <pb@nexus.co.uk>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Philip Blundell <pb@nexus.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1077063432.2665.165.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <200402090015.24318.bluez-devel@schaettgen.de>
	 <20040216144615.GA318@nexus.co.uk> <1076945776.17824.6.camel@merlin>
	 <20040216154155.GB32285@nexus.co.uk>  <1077058771.2665.134.camel@pegasus>
	 <1077061102.685.0.camel@dixie.nexus.co.uk>
	 <1077061494.2665.148.camel@pegasus>
	 <1077061750.685.3.camel@dixie.nexus.co.uk>
	 <1077062239.2665.153.camel@pegasus>
	 <1077062886.685.8.camel@dixie.nexus.co.uk>
	 <1077063432.2665.165.camel@pegasus>
Content-Type: text/plain
Message-Id: <1077064144.685.16.camel@dixie.nexus.co.uk>
Mime-Version: 1.0
Date: Wed, 18 Feb 2004 00:29:04 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-02-18 at 00:17, Marcel Holtmann wrote:
> > Right, but BlueZ is the group defining the interface.  Linux and FreeBSD
> > are not the only Bluetooth vendors, so I don't think it is appropriate
> > to use the bluetooth.org namespace.
> 
> for me this is only a name and the technology behind it is Bluetooth, so
> I prefer to use org.bluetooth. That's it.

I agree that it's just a name, but I don't think it's necessarily
appropriate for us to use the Bluetooth name just because that's the
underlying technology.  The reason for having the domain identifier is
to ensure unique naming, not to indicate the provenance of the
interface.  Any other group that wanted to invent D-BUS bindings for
Bluetooth would be just as entitled as us to use the "org.bluetooth"
namespace.  Not that I think this is especially likely to happen, but it
still seems like bad form to usurp those identifiers.

> I don't know, but I like to have a pseudo standard interface that can be
> used across free unix operating systems.

We can still have that within the org.bluez namespace.

p.
