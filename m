Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: Fred Sch??ttgen <bluez-devel@schaettgen.de>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-Bus interfaces
Message-ID: <20040216144615.GA318@nexus.co.uk>
References: <1076265358.2670.36.camel@pegasus> <1076278554.14742.112.camel@akka.yeti.nocrew.org> <1076279508.6869.54.camel@pegasus> <200402090015.24318.bluez-devel@schaettgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402090015.24318.bluez-devel@schaettgen.de>
From: Phil Blundell <pb@nexus.co.uk>
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
Date: Mon, 16 Feb 2004 14:46:15 +0000

on Mon, Feb 09, 2004 at 12:15:24AM +0100, Fred Sch??ttgen wrote:
> On Sunday 08 February 2004 23:31, Marcel Holtmann wrote:
> > Do we need a special datatype for the BD_ADDR or is string the best?
> 
> I can only speak from my experience with dcop, but I would try to use standard 
> types whereever it's possible. In case that there exists a d-bus counterpart 
> to the dcop command line utility (dbus-send maybe?), it would make the bluez 
> interface more accessible for scripts.

Yes, agreed.  In my experiments with D-BUS and BlueZ so far, I've been
using a simple byte array for the address.  Encoding it as an ASCII
string would be another possibility, but this would generally make the
marshalling/unmarshalling process more expensive, and doesn't really
gain you anything.

p.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
