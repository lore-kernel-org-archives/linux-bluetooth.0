Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Phil Blundell <pb@nexus.co.uk>
Cc: Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   bluez-devel@lists.sourceforge.net
In-Reply-To: <20040219164833.GI7979@nexus.co.uk>
References: <1076265358.2670.36.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <200402090015.24318.bluez-devel@schaettgen.de>
	 <20040216144615.GA318@nexus.co.uk>
	 <1077205947.20897.153.camel@kalkyl.roxen.com>
	 <20040219164833.GI7979@nexus.co.uk>
Content-Type: text/plain
Message-Id: <1077249840.6445.25.camel@akka.yeti.nocrew.org>
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
Date: Fri, 20 Feb 2004 05:04:00 +0100

Phil,

tor 2004-02-19 klockan 17.48 skrev Phil Blundell:
> I don't think this is really an issue: text-based tools are probably
> going to be using dbus-send, which can take care of converting to
> binary representation from some convenient textual format.  Or, for
> languages which have their own D-BUS bindings, it would be handled at
> that level. So we may as well use the D-BUS type system, rather than
> manually converting everything to and from text strings.

This would require applications to convert Bluetooth addresses to/from
an artificial byte array representation which in most cases doesn't have
any meaning nor usefulness for the applications anyway. This is not only
unneeded work, it's also harmful because it restricts the address format
at the application layer instead of the at proper protocol layer.

Consider the same address issue with ipv4: It's better for high-level
applications to use text addresses (e.g. "127.0.0.1") instead of four
byte arrays. It's not only more convenient, it also works when the
address format is extended with ipv6.

Fredrik




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
