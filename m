Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Blundell <pb@nexus.co.uk>
Cc: Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1077062886.685.8.camel@dixie.nexus.co.uk>
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
Content-Type: text/plain
Message-Id: <1077063432.2665.165.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 18 Feb 2004 01:17:12 +0100

Hi Philip,

> > actually I don't care about the Bluetooth SIG. This interface is not
> > really BlueZ and Linux specific, because the FreeBSD stack can also make
> > use of it.
> 
> Right, but BlueZ is the group defining the interface.  Linux and FreeBSD
> are not the only Bluetooth vendors, so I don't think it is appropriate
> to use the bluetooth.org namespace.

for me this is only a name and the technology behind it is Bluetooth, so
I prefer to use org.bluetooth. That's it.

Personally I don't like this reversed domain stuff I have seen first
with the introduction of Java.

> Do you think that the FreeBSD people will have a problem using an
> interface that has "bluez" in the name?

I don't know, but I like to have a pseudo standard interface that can be
used across free unix operating systems.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
