Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <harbaum@beecon.de>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408261852.56641.harbaum@beecon.de>
Subject: [Bluez-devel] Fighting with SCO
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
Date: Thu, 26 Aug 2004 18:52:56 +0200

Hi,

i have a BlueTrek G2 bluetooth headset and i am just unable to get
it work with bluez.

I can connect to it with hstool and it even sends me the AT+VGS-Volume 
commands and AT+CKPD=200 whenever i press the button. And if i send RING to 
it, then it rings.

But it won't send me any sco data. I have tested this with several different 
usb dongles (d-link dbt-120, the microsoft dongle delivered with the 
bluetooth desktop (both csr) and a Allnet WBT-3021 (broadcom chip)).

If i make scotest send some funny patterns to the headset i get some very 
quiet hissing like some audio transmitter has been switched on, but no actual 
audio signal is being transmitted.

Any hints? 

Regards,
  Till

BTW: Marcel: The l2cap buffer management student thesis is out ...

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
