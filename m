Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <0E67B9FA7DC6B24391C00208804C1E552C2D25@mchh9ena.mchh.siemens.de>
From: Bitterlich Jean-Yves ICM MP PD TI 10
	 <jean-yves.bitterlich@siemens.com>
To: "'bluez-devel@lists.sourceforge.net'"
	 <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-devel] dumping/debuging ttySX ...
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
Date: Fri, 27 Feb 2004 09:45:57 +0100

Hi,

I'm currently adapting bluez to run a bt chip via uart. it seems that
modifying hciattach initialization code might be enough. however i'm having
trouble after initialization whenever the driver take the socket over
(N_HCI). for some reason, the chip sends lots of "invalid packet events" and
"startup events".

before going further, i need to know what is sent over uart (i.e. every
single byte in each direction). hcidump seems to be a bit too high-level.
what would you recommend to spy transparently the ttyS0 ?

thanx for any help
--JYB


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
