Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.6-mh2 freeze
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405272139.08194.cijoml@volny.cz>
References: <200405271934.52883.cijoml@volny.cz>
	 <1085686044.8896.43.camel@pegasus>  <200405272139.08194.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1085687506.8896.53.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 27 May 2004 21:51:46 +0200

Hi Michal,

> > this can't be my fault, because I've only touched the Bluetooth
> > subsystem with the -mh patch.
> 
> Hmm...but I installed only -mh2 and with -mh1 or clean 2.6.6 works

there must be something other different. Check the patch by yourself.

# diffstat patch-2.6.6-mh2.gz 
 Makefile                          |    2 
 drivers/bluetooth/bcm203x.c       |    2 
 drivers/bluetooth/bfusb.c         |    6 
 drivers/bluetooth/bt3c_cs.c       |    3 
 drivers/bluetooth/hci_bcsp.c      |    1 
 drivers/bluetooth/hci_ldisc.c     |    1 
 drivers/bluetooth/hci_usb.c       |  165 +--
 include/net/bluetooth/bluetooth.h |    1 
 net/bluetooth/Kconfig             |   17 
 net/bluetooth/Makefile            |    1 
 net/bluetooth/af_bluetooth.c      |    2 
 net/bluetooth/hidp/Kconfig        |   11 
 net/bluetooth/hidp/Makefile       |    7 
 net/bluetooth/hidp/core.c         |  531 ++++++++++++
 net/bluetooth/hidp/hid.c          | 1671 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hidp/hid.h          |  350 +++++++
 net/bluetooth/hidp/hidp.h         |  117 ++
 net/bluetooth/hidp/sock.c         |  209 ++++
 net/bluetooth/rfcomm/core.c       |   32 
 19 files changed, 3014 insertions(+), 115 deletions(-)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
