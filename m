Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] browsing non-public services?
From: Marcel Holtmann <marcel@holtmann.org>
To: Simon Vogl <vogl@soft.uni-linz.ac.at>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <403B4565.1020201@soft.uni-linz.ac.at>
References: <403B1072.1020102@soft.uni-linz.ac.at>
	 <1077624474.2880.37.camel@pegasus>  <403B4565.1020201@soft.uni-linz.ac.at>
Content-Type: text/plain
Message-Id: <1077626377.2880.57.camel@pegasus>
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
Date: Tue, 24 Feb 2004 13:39:37 +0100

Hi Simon,

> tried that already, but with no luck. From hcidump, I see that this is a 128bit
> uuid - how can I specify this as an argument??

I think sdptool isn't capable of it. Write your own code or use sdptest
from libs2/test CVS repository.

	sdptest records <bdaddr>

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
