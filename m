Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <harbaum@beecon.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Moritz Gmelin <moritz.gmelin@avetana.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200502101112.09602.harbaum@beecon.de>
Subject: [Bluez-devel] Zero length L2CAP packets
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
Date: Thu, 10 Feb 2005 11:12:09 +0100

Hi,

while working on the avetana jsr82 implementation we discovered, that the bt 
spec as well as jsr82 allow to transmit zero length l2cap packets. IMHO the 
linux socket interface does not support zero length packets and a read 
returning zero indicates an end of file (in this case meaning that the 
connection has been closed).

What happens if the other side actually sends a zero length packet? Is this 
dropped inside the kernel? Or will read return zero which i'll misinterpret 
as the eof marker? How can i distinguish between eof and a zero length 
packet?

Regards,
  Till

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
