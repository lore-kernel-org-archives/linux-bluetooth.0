Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: Fredrik Noring <noring@nocrew.org>
Cc: Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-Bus interfaces
Message-ID: <20040219164833.GI7979@nexus.co.uk>
References: <1076265358.2670.36.camel@pegasus> <1076278554.14742.112.camel@akka.yeti.nocrew.org> <1076279508.6869.54.camel@pegasus> <200402090015.24318.bluez-devel@schaettgen.de> <20040216144615.GA318@nexus.co.uk> <1077205947.20897.153.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1077205947.20897.153.camel@kalkyl.roxen.com>
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
Date: Thu, 19 Feb 2004 16:48:33 +0000

on Thu, Feb 19, 2004 at 04:52:27PM +0100, Fredrik Noring wrote:
> Marshalling of text addresses is probably negligible in a DBus context.
> It can potentially make the interface more accessible to text based
> tools such as Perl as configurarions, user input etc. are based on text
> addresses.

Hi Fredrik

I don't think this is really an issue: text-based tools are probably
going to be using dbus-send, which can take care of converting to
binary representation from some convenient textual format.  Or, for
languages which have their own D-BUS bindings, it would be handled at
that level.  So we may as well use the D-BUS type system, rather than
manually converting everything to and from text strings.

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
