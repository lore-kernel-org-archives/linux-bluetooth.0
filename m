Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jonathan McDowell <noodles@earth.li>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050317151924.GY2054@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Billionton(?) CF card - success
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Mar 2005 15:19:24 +0000

Hi.

I bought a CF Bluetooth card from a UK supplier's (ebuyer) budget range.
It said it was based on the CSR chipset, which seems to be reasonably
well supported. Should have done more research first really. :)

Anyway. It idents as:

Socket 0:
  product info: "Compact Flash", "Bluetooth Card", "", ""
  manfid: 0x0279, 0x950b
  function: 2 (serial)

There's no manufacturer listed on it. The front says "CF CompactFlash
BluetoothTM". The back says "BluetoothTM CompactFlash Card" and "P/N:
CFBT02-N2".

Plugging the card into my Zaurus with the BlueZ packages installed led
to no luck. The card got detected, serial_cs was loaded, hciattach
wasn't happy. So I switched to my laptop, which already had a working
BlueZ setup with a USB device (Debian testing/2.6.11 kernel). Not much
better.

ttyS0: detected caps 00000700 should be 00000100
ttyS0 at I/O 0x3f8 (irq = 5) is a 16C950/954

and then hciattach wouldn't work, no matter what speed I tried.

Much Googling didn't seem to turn up much. And then I found a link to:

http://www.summet.com/x31/8250_patch_CFcard.txt

I thought this would be the answer, but it turned out not to be.
However, with the addition of a:

setserial /dev/ttyS0 baud_base 912600

I can then do:

hciattach -s 912600 /dev/ttyS0 bcsp

And I have working Bluetooth. hciscan works locally and on a remote box
finds the laptop ok and I can make an rfcomm connection to my mobile
phone.

I get a:

bcsp_recv: Out-of-order packet arrived, got 1 expected 0

message, but only the once.

Hopefully this might help someone else battling with a similar card; I
couldn't find any success stories about similar ones. Now all I need to
do is try it again with the Zaurus, which it was actually bought for. :)

J.

-- 
] http://www.earth.li/~noodles/ [] Who said that itemised phone bills  [
]  PGP/GPG Key @ the.earth.li   []          were a good idea?          [
] via keyserver, web or email.  []                                     [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
