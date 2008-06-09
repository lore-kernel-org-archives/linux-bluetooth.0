Return-Path: <cyrus@holtmann.org>
From: mog <mog@jawz.de>
To: bluez-users@lists.sourceforge.net
Date: Mon, 9 Jun 2008 08:11:50 +0200
MIME-Version: 1.0
Message-Id: <200806090811.50913.mog@jawz.de>
Subject: [Bluez-users] Using Bluetooth devices @initramfs
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hi,

i am trying to get a file from a blootooth device during system boot.
my root-filesystem is encrypted and i would like to be able to get the 
encryption key from my mobile phone.
i have written a script, that is getting the key-file with obexftp. it is 
working as expected as long as i am running it from a fully started linux.
no i am trying to get it running in the initramfs and i am stuck.
the modules are loaded, hciconfig is showing me the proper device.
so far, so good, but:

as far as i understand bluez, i am in need of hcid running to communicate to 
my mobile phone. but trying to start hcid in the initramfs is a pain.
it seems to be in need of dbus.
i believe it goes very far beyond the scope of an initramfs to have dbus 
runnnig there.
just to give a simple example, dbus has user and group policies and is usually 
started as another user than root. this is all out of the context of an 
initramfs.

i got the dbus-daemon running in the initramfs after some tries, but starting 
the hcid still fails with connection errors (hcid is not getting response 
from dbus for whatever reason)

now i am stuck.

is there a way to communicate via obexftp to my mobile-phone without hcid?

or is there a way to start the hcid without dbus?

best regards
mog

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
