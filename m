Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <harbaum@beecon.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411291226.52638.harbaum@beecon.de>
Subject: [Bluez-devel] Port parameter negotiation?
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
Date: Mon, 29 Nov 2004 12:26:52 +0100

Hi list,

does BlueZ implement rfcomm port paramater negotiation? This is required to 
allow a bluetooth->rs232 converter so set the baud rate etc according to the 
settings on the hosts virtual serial port. E.g. changing the baudrate on a 
windows bluetooth com port changes the rs232 bit rate on the bt device as 
well (ok, at least my widcomm/win98 notebook does this only for 57600 and 
115200 correctly).

So using something like 
  stty -F /dev/rfcomm0 speed 9600 

should IMHO cause a rfcomm port negotiation packet to be sent on client side. 
But i don't see this happen ...

Am i doing something wrong? I am using rfcomm 1.3 on a 2.6.8 kernel.

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
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
