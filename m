Return-Path: <pb@nexus.co.uk>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Philip Blundell <pb@nexus.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1077062239.2665.153.camel@pegasus>
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
Content-Type: text/plain
Message-Id: <1077062886.685.8.camel@dixie.nexus.co.uk>
Mime-Version: 1.0
Date: Wed, 18 Feb 2004 00:08:06 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2004-02-17 at 23:57, Marcel Holtmann wrote:
> actually I don't care about the Bluetooth SIG. This interface is not
> really BlueZ and Linux specific, because the FreeBSD stack can also make
> use of it.

Right, but BlueZ is the group defining the interface.  Linux and FreeBSD
are not the only Bluetooth vendors, so I don't think it is appropriate
to use the bluetooth.org namespace.

Do you think that the FreeBSD people will have a problem using an
interface that has "bluez" in the name?

p.
