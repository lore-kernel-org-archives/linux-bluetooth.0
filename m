Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
To: bluez-users@lists.sourceforge.net
Message-id: <13c0fd76e.d76e13c0f@estudiants.urv.es>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Bluez-users] problem on make install
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
Date: Fri, 05 Mar 2004 10:54:10 +0100

Hello all

I'm working in a Red Hat with kernel 2.4.18, so I've
downloaded bluez-kernel-2.3 , untared it, and
./configure. Until there there is no problem, but
when I do make, I need to comment line 461 on core.c
to skip the error:

core.c: In function `bnep_session':
core.c:461: structure has no member named `nice'
make[2]: *** [core.o] Error 1
make[1]: *** [bnep.o] Error 2

when I comment that line there is no problem on
doing the 'make', but on make install I get the next
messages:

make[1]: Leaving directory
`/root/testings/bluez-kernel-2.3/doc'
/sbin/depmod -a
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/drivers/bluetooth/bluecard_cs.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/drivers/bluetooth/bt3c_cs.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/drivers/bluetooth/btuart_cs.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/drivers/bluetooth/dtl1_cs.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/drivers/bluetooth/hci_uart.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/drivers/bluetooth/hci_usb.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/drivers/bluetooth/hci_vhci.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/misc/ksock_multi.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/misc/ksock_single.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/net/bluetooth/bluez.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/net/bluetooth/bnep.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/net/bluetooth/l2cap.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/net/bluetooth/rfcomm.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-4custom/kernel/net/bluetooth/sco.o
make: *** [install] Error 1


can anybody help me on this? I'm new on BlueZ so
please be gentle!! ;)


Thanks


Albert



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
