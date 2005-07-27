Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42E799DA.70207@fbl.cz>
From: Tomas Vanek <Tomas.Vanek@fbl.cz>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] dfutool block size
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
Date: Wed, 27 Jul 2005 16:27:38 +0200

I tryied upgrade an old i-Tec BT dongle (CSR BlueCore2 ext + 4M flash, 
ID=0a12:0001, original version 272 - BT 1.1 HCI 14.3) by dfutool. 
Archiving old firmware was OK.

dfutool upgrade GenericCSR829.dfu

failed after time-out with message:

Can't upload next block: Broken pipe (32)

No change after upgrading to today's bluez cvs head.
I reduced written block size to 512 (why original length was 1023 and 
not 1024??)
and dongle got upgraded OK (tested with archived fw version 272). Then I 
tested sizes
in between:

1008 and 992: broken pipe
960: Can't get status: No such device after 9600 bytes
896: dfutool finished upgrade OK but dongle stays in DFU mode
768: upgrade worked

It's clear this is a problem in dfu loader in the dongle. I tested it again
with upgraded firmware and problem persists.
If there is more such dongles, it might be worth to add a block size 
parameter to dfutool.

Tom


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
