Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0408132340500.22327@shofar.kom.e-technik.tu-darmstadt.de>
References: 
	 <Pine.LNX.4.58.0408132340500.22327@shofar.kom.e-technik.tu-darmstadt.de>
Content-Type: text/plain
Message-Id: <1092434684.4501.56.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: FrogPad Bluetooth keyboard - arrived+working well with BlueZ
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 14 Aug 2004 00:04:45 +0200

Hi Ralf,

> since we had the discussion about its actual availability a few months ago 
> - my Bluetooth FrogPad 
> 	http://www.frogpad.com/
> arrived today and works perfectly with the BlueZ 
> stack (hidp module + hidd).

you are a lucky man, because my promised FrogPad for testing still
hasn't arrived :(

> I've tested on an x86 system so far but will later also try on several ARM 
> machines (ipaq with either PCMCIA/CF or integrated BT module).

May you do me a favour and request some information from your FrogPad. I
like to get "hcitool info ..." and the full SDP record. For this you can
use sdptest from libs2 CVS repository:

	sdptest records 00:aa:bb:cc:dd:ee > frogpad.txt

Then send me that file.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
