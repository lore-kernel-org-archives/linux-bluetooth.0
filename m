Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Zero length L2CAP packets
From: Marcel Holtmann <marcel@holtmann.org>
To: Moritz Gmelin <moritz.gmelin@avetana.de>
Cc: Till Harbaum <harbaum@beecon.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2def10fdd2a185bcddd4562929cd1417@avetana.de>
References: <200502101112.09602.harbaum@beecon.de>
	 <1108044288.15974.45.camel@pegasus>
	 <2def10fdd2a185bcddd4562929cd1417@avetana.de>
Content-Type: text/plain
Message-Id: <1109031428.7626.84.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 22 Feb 2005 01:17:08 +0100

Hi Moritz,

> I just tried writing a 0-length packet on my open L2CAP Connection and 
> I cannot see anything happening with hcidump. The remote end is a Mac. 
> But I guess that I should see anything regardless of the remote end. 
> 1-byte packets and more get transferred correctly but
> 
> write (fd, "foo", 0);
> 
> on my open L2CAP Descriptor fd does not give any reaction in hcidump.
> 
> my version of bluez is libbluetooth1 2.11-1

update the library and utils and also the kernel. Maybe you need to use
send() for sending 0 byte payload, because this is what is used in the
l2test program.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
