Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Beyer <florian.beyer@aei.mpg.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040520090502.GA4352@mcmabrruq.sirius.net>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-15
Subject: [Bluez-users] Unresolved Symbols
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
Date: Thu, 20 May 2004 11:05:02 +0200

Hello,

I have problems compiling the bluez-kernel-2.3-package with kernel  
2.4.22 and the mh6-patch (with activated bluetooth support of course).  
The same happens for kernel 2.4.26 and mh1-patch.

After a

./configure --with-kernel=/usr/src/linux-2.4 --prefix=/usr
make
make install

I get

/sbin/depmod -a
depmod: *** Unresolved symbols in /lib/modules/2.4.22-mh6/kernel/net/ 
bluetooth/bnep/bnep.o
depmod: *** Unresolved symbols in /lib/modules/2.4.22-mh6/kernel/net/ 
bluetooth/rfcomm/rfcomm.o

Furthermore I have

/sbin/modprobe bnep
/lib/modules/2.4.22-mh6/kernel/net/bluetooth/bnep/bnep.o: unresolved  
symbol l2cap_load_Rfc31fe88
/lib/modules/2.4.22-mh6/kernel/net/bluetooth/bnep/bnep.o: insmod /lib/ 
modules/2.4.22-mh6/kernel/net/bluetooth/bnep/bnep.o failed

and

/sbin/modprobe rfcomm
/lib/modules/2.4.22-mh6/kernel/net/bluetooth/rfcomm/rfcomm.o:  
unresolved symbol
l2cap_load_Rfc31fe88
/lib/modules/2.4.22-mh6/kernel/net/bluetooth/rfcomm/rfcomm.o:  
unresolved symbol
bluez_sock_wait_state_R12a89245
/lib/modules/2.4.22-mh6/kernel/net/bluetooth/rfcomm/rfcomm.o: insmod / 
lib/modules/2.4.22-mh6/kernel/net/bluetooth/rfcomm/rfcomm.o failed


What can I do?

Thanks for your help,
Florian Beyer



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
