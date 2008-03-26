Return-Path: <cyrus@holtmann.org>
Message-ID: <47EA8056.8090500@idlum.be>
Date: Wed, 26 Mar 2008 17:56:54 +0100
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------070508060503090805070705"
Subject: [Bluez-devel] Cached friendly names never updated when changed
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070508060503090805070705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

It seems that once a friendly name has been cached to 
/var/lib/bluetooth/*/names, RemoteNameUpdated signals contain this 
cached name forever, and user is never informed of a name change unless 
those "names" files are deleted.

It can be easily tested using the small python program attached. Just 
start it and play around with your device's friendly name, and with 
/var/lib/bluetooth/*/names (for example simply delete it).

So is there a way to get notified when a device's name has actually 
changed? Maybe I didn't wait long enough? According to the signal's name 
("RemoteNameUpdated"), I would expect to be notified when the name 
actually change.

Best Regards,
Pierre-Yves

--------------070508060503090805070705
Content-Type: text/x-python;
 name="namesresolver.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="namesresolver.py"

#!/usr/bin/python

import dbus
import dbus.glib
import gobject

def rem_dev_name_signal(address, name):
        print 'Signal: RemoteNameUpdated(%s, %s)' % (address, name)

def disc_completed_signal():
        adapter.DiscoverDevices()

bus = dbus.SystemBus();

bus.add_signal_receiver(rem_dev_name_signal, 'RemoteNameUpdated', 'org.bluez.Adapter', 'org.bluez', '/org/bluez/hci0')
bus.add_signal_receiver(disc_completed_signal, 'DiscoveryCompleted', 'org.bluez.Adapter', 'org.bluez', '/org/bluez/hci0')

obj = bus.get_object('org.bluez', '/org/bluez/hci0')
adapter = dbus.Interface(obj, 'org.bluez.Adapter')

adapter.DiscoverDevices()

gobject.threads_init()
dbus.glib.init_threads()
main_loop = gobject.MainLoop()
main_loop.run()

--------------070508060503090805070705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--------------070508060503090805070705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070508060503090805070705--
