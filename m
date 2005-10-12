Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mitja Pufic <raveer@section-one.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth 2.0 dongle
In-Reply-To: <1129052600.7583.13.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0510121358240.1705@cherokee.spacecom.si>
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
 <1128784148.5212.17.camel@blade>  <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com>
  <1128896442.19569.26.camel@blade>  <20051010195850.GA23080@localhost.localdomain>
  <1128977357.7352.1.camel@blade>  <20051011100057.GA29401@localhost.localdomain>
  <1129025702.7352.17.camel@blade> <434BAD41.5020503@csr.com>
 <20051011144946.GA31437@localhost.localdomain>
 <Pine.LNX.4.61.0510111902440.7462@cherokee.spacecom.si>
 <1129052600.7583.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 12 Oct 2005 14:37:27 +0200 (CEST)

Hello Marcel,

Well today I got hands on Level-1 MDU-0025USB, it is BlueCore04-external 
and comes with Toshiba Windows stack, it has only 56bit encryption, even
though package says 128bit, :( The german homepage is www.level-one.de

Here are the hciconfig outputs:
-- revision:

hci0:	Type: USB
	BD Address: 00:09:DD:50:01:C8 ACL MTU: 384:8 SCO MTU: 64:8
	HCI 19.2
	Chip version: BlueCore4-External
	Max key size: 56 bit
	SCO mapping:  HCI

-- hciconfig -a:

hci0:	Type: USB
	BD Address: 00:09:DD:50:01:C8 ACL MTU: 384:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
	RX bytes:1525 acl:0 sco:0 events:51 errors:0
	TX bytes:950 acl:0 sco:0 commands:50 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'Raindrop-3B'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 2.0 (0x3) HCI Rev: 0x77b LMP Ver: 2.0 (0x3) LMP Subver: 0x77b
	Manufacturer: Cambridge Silicon Radio (10)

-- features:

hci0:	Type: USB
	BD Address: 00:09:DD:50:01:C8 ACL MTU: 384:8 SCO MTU: 64:8
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
		<timing accuracy> <role switch> <hold mode> <sniff mode> 
		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
		<power control> <transparent SCO> <broadcast encrypt> 
		<EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan> 
		<interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
		<extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave> 
		<AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
		<AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
		<EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>


And here is the little table of 2.0 dongles I found:

MANUF   MODEL	              CHIP		WINSTCK	HOMEPAGE
Tecom   BT3034EDR       (EDR) Broadcom          Widcomm http://www.tecomproduct.com/BT3034.htm
Cellink BTA-6030        (EDR) CSR BlueCore04    ???	http://www.cellink.com.tw/pro-bta-6030.htm
Planex  BT-01UDE        (EDR) CSR BlueCore04    Toshiba	http://www.planex.net/product/bluetooth/bt-01ude.htm
Level1  MDU-0025USB     (EDR) CSR BlueCore04    Toshiba http://www.levelone.si/products3.php?sklop=24&id=590025

Planex one I've never seen either, one of my friends is an exchenge 
student in Malmo Sweden, and he saw this one in shop there, maybe I can 
persuade him to get me one for christmas. For Tecom dongle I am harassing .si 
distributor to order them for about 2 monoths now, and they keep saying the 
can not get it. And .si Cellink distrubitor only sells headsets. :( 
Where can you buy them in Germany I would not know, I found cellink one on 
blueunplugged and tecom on ebay.

Best regards,
Mitja


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
