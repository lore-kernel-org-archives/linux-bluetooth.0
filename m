Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Paul Hedderly <bulkpaul@mjr.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-ID: <20040915090305.GL26469@wacka.mjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Unidentified Bluetooth CF card
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
Date: Wed, 15 Sep 2004 10:03:05 +0100

Ok I got a cheap CF Bluetooth card from ebay. I got it a while ago and
keep trying to make it work... but can't (all the others I have no
problem with...)

I think it's a 'Mavin' - there are pictures of the front and back at:
	http://mjr.org/bt/front.jpg
	http://mjr.org/bt/back.jpg
	http://mjr.org/bt/inside.jpg
	http://mjr.org/bt/closeup.jpg

The main chips inside (to save you needing to to the pics :O) are:
	OXCF950
	BC212
	29LV800BA-90

And the markings are:
	Model No.:MCF-M2.1
	60m
	S/N:MCF 0001773
	Made in Taiwan

I've tried various conf definitions and drivers but get nothing.

weeblu:/etc/bluetooth# cardctl ident 1
  product info: "CF CARD", "GENERIC", "", ""
  manfid: 0x0279, 0x950b
  function: 2 (serial)

I've tried stuff like:
	
card "Noname... Compact Flash Card"
  manfid 0x0279, 0x950b
  bind "btuart_cs"
and
  bind "bt950_cs"

Also tried the bt950 driver and tried to compile the bt2000e driver
(Since this card seems to have the Oxford Semi CS950 chip in it)

All I get are lines like:

Sep 15 09:36:11 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x70 received.
Sep 15 09:36:11 weeblu kernel: bt950_cs: Unknown HCI packet with type 0xFD received.
Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x60 received.
Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0xFD received.
Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x70 received.
Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0xFD received.
Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x60 received.
Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0xFD received.
Sep 15 09:36:12 weeblu kernel: bt950_cs: Unknown HCI packet with type 0x00 received.

and:

Sep 15 09:42:30 weeblu kernel: btuart_cs: RLSI
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0xc0 received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0x00 received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0x41 received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0x00 received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0xbe received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0xda received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0xdc received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0xed received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0xed received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0x00 received.
Sep 15 09:42:30 weeblu kernel: btuart_cs: Unknown HCI packet with type 0xff received.


Any ideas?

--
Cheers
Paul


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
