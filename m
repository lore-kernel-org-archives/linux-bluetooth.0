Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unresolved Symbols
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Beyer <florian.beyer@aei.mpg.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040520090502.GA4352@mcmabrruq.sirius.net>
References: <20040520090502.GA4352@mcmabrruq.sirius.net>
Content-Type: text/plain
Message-Id: <1085044940.4327.135.camel@pegasus>
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
Date: Thu, 20 May 2004 11:22:20 +0200

Hi Florian,

> I have problems compiling the bluez-kernel-2.3-package with kernel  
> 2.4.22 and the mh6-patch (with activated bluetooth support of course).  
> The same happens for kernel 2.4.26 and mh1-patch.
> 
> After a
> 
> ./configure --with-kernel=/usr/src/linux-2.4 --prefix=/usr
> make
> make install
> 
> I get
> 
> /sbin/depmod -a
> depmod: *** Unresolved symbols in /lib/modules/2.4.22-mh6/kernel/net/ 
> bluetooth/bnep/bnep.o
> depmod: *** Unresolved symbols in /lib/modules/2.4.22-mh6/kernel/net/ 
> bluetooth/rfcomm/rfcomm.o
> 
> Furthermore I have
> 
> /sbin/modprobe bnep
> /lib/modules/2.4.22-mh6/kernel/net/bluetooth/bnep/bnep.o: unresolved  
> symbol l2cap_load_Rfc31fe88
> /lib/modules/2.4.22-mh6/kernel/net/bluetooth/bnep/bnep.o: insmod /lib/ 
> modules/2.4.22-mh6/kernel/net/bluetooth/bnep/bnep.o failed
> 
> and
> 
> /sbin/modprobe rfcomm
> /lib/modules/2.4.22-mh6/kernel/net/bluetooth/rfcomm/rfcomm.o:  
> unresolved symbol
> l2cap_load_Rfc31fe88
> /lib/modules/2.4.22-mh6/kernel/net/bluetooth/rfcomm/rfcomm.o:  
> unresolved symbol
> bluez_sock_wait_state_R12a89245
> /lib/modules/2.4.22-mh6/kernel/net/bluetooth/rfcomm/rfcomm.o: insmod / 
> lib/modules/2.4.22-mh6/kernel/net/bluetooth/rfcomm/rfcomm.o failed
> 
> 
> What can I do?

don't use bluez-kernel-2.3 !!! This package is deprecated and no longer
needed. The only way to update the kernel drivers is via my -mh patch.

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
