Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] lmx9814
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Blundell <pb@nexus.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076865675.23437.73.camel@dixie.nexus.co.uk>
References: <1076864335.23437.70.camel@dixie.nexus.co.uk>
	 <1076865499.2840.8.camel@pegasus>
	 <1076865675.23437.73.camel@dixie.nexus.co.uk>
Content-Type: text/plain
Message-Id: <1076866147.2840.11.camel@pegasus>
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
Date: Sun, 15 Feb 2004 18:29:07 +0100

Hi Philip,

> The older 3000 series does use an ALPS module with a CSR chip, but I'm
> fairly certain that the 5000 is using the National part.

if you have a 5500 that runs Windows, check is with "hcitool info ..."
from another Linux machine. If it is a CSR chip, simply try to use the
BCSP method of hciattach.

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
