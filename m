Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Reply-To: <halam.rose@7layers-uk.com>
From: "Halam Rose" <halam.rose@7layers-uk.com>
Cc: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] CF cards capable of 1Mbps?
Message-ID: <MGEGKHCLDAFHMAIHGKNCAEPGGBAA.halam.rose@7layers-uk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1063111685.32473.425.camel@hades.cambridge.redhat.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 9 Sep 2003 14:47:52 +0100

1 Mbps is the bulk data rate but there are overheads so only 723Kbps is
possible with any Bluetooth link.

Halam

-----Original Message-----
From: David Woodhouse [mailto:dwmw2@infradead.org]
Sent: 09 September 2003 13:48
To: Nils Faerber
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] CF cards capable of 1Mbps?


On Tue, 2003-09-09 at 14:20 +0200, Nils Faerber wrote:
> The fact that the UART of the CF card sais it would run at 115kbps does
> not at all mean that the actual data throughput is only 115kbps.
> For example we have a Brainboxes CF card which you set to 115kbps but
> actually uses 1Mbps between the UART and the CSR chipset then. The UART
> clock is simply higher so that a devider for 115kbps results in 1Mbps.
> Only if your OS tries to setup something based on the baudrate you would
> be in trouble here. Linux has no problems with the extra bitrate.

This is true. Which is why I confirmed with BNEP bandwidth tests that I
only get about 9-10Kbps transfer rate, and checked what speed the CSR
chip thinks it's talking at too...

 # pskey -d /dev/tts/0 -b
Physical device :/dev/tts/0
Speed           :115200
Use BCSP        :YES
Initiating read thread
BT SYS: Initializing BCSP
BT SYS: BCSP initialized and syncronized
Synchronized
Successfully read firmware info.
 Firmware version: 272
pskey>191
Key 0191 length 10
01d8 0006 00fa 0014 0004 0000 0004 001e 0064 000a

The information about the Brainboxes card is appreciated -- thanks.
http://www.brainboxes.com/products/bluetooth/product.asp?id=BL-565
says only 721Kbps, but that'll do me fine; I'll see if I can find one of
those for slightly less than the insane amount of money they seem to
claim is the recommended price.

I had a Cyberblue BLUE-CF01 which had a baud_base of 1152000, but the
first one went back due to radio-side reliability problems -- only about
1 in 5 times would it detect and correctly get name from my phone which
was sitting right next to it. The second one was better for a while, but
then started to lose RX characters, until last week it finally gave up
completely and I don't receive _anything_ from the CSR chip. I don't
think I want another of those :)

--
dwmw2



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
