Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Phil Blundell <pb@nexus.co.uk>
Cc: Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   bluez-devel@lists.sourceforge.net
In-Reply-To: <20040216144615.GA318@nexus.co.uk>
References: <1076265358.2670.36.camel@pegasus>
	<1076278554.14742.112.camel@akka.yeti.nocrew.org>
	<1076279508.6869.54.camel@pegasus>
	<200402090015.24318.bluez-devel@schaettgen.de>
	<20040216144615.GA318@nexus.co.uk>
Content-Type: text/plain
Message-Id: <1076945776.17824.6.camel@merlin>
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
Date: 16 Feb 2004 16:36:15 +0100

Hi Phil,

> > I can only speak from my experience with dcop, but I would try to use standard 
> > types whereever it's possible. In case that there exists a d-bus counterpart 
> > to the dcop command line utility (dbus-send maybe?), it would make the bluez 
> > interface more accessible for scripts.
> 
> Yes, agreed.  In my experiments with D-BUS and BlueZ so far, I've been
> using a simple byte array for the address.  Encoding it as an ASCII
> string would be another possibility, but this would generally make the
> marshalling/unmarshalling process more expensive, and doesn't really
> gain you anything.

btw I tried to integrate the D-Bus patch for the PIN-Helper, but got
compilation errors with the libraries from Debian Sid. Has anyone used
this patch on Debian Sid?

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
