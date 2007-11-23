Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: "thHog" <bluez@t3i.nl>
Mime-Version: 1.0
Message-Id: <E1IvOBq-0005p1-0g@daffy.sipo.nl>
Date: Fri, 23 Nov 2007 03:22:46 +0100
Subject: [Bluez-devel] python / dbus issue
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I tried my first python script for accessing bluez through dbus. The bluez
setup is complete and I can scan and connect bluetooth devices using hcitool
and rfcomm tools. The dbus setup is working as well, the "dbus-monitor
--system" shows bluez messages when starting bluez.

But, I tried to run the following python script (and several other examples
from the internet):


import dbus
bus = dbus.SystemBus();
obj = bus.get_object('org.bluez', '/org/bluez')
manager = dbus.Interface(obj, 'org.bluez.Manager')
print manager.ListAdapters()


The output from this script is:

Traceback (most recent call last):
  File "./mydbus.py", line 27, in ?
    print manager.ListAdapters()
  File "/usr/lib/python2.4/site-packages/dbus/proxies.py", line 85, in
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.4/site-packages/dbus/proxies.py", line 169, in
__call__
    reply_message =
self._connection.send_message_with_reply_and_block(message, timeout)
dbus.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Method
"ListAdapters" with signature "" on interface "org.bluez.Manager" doesn't
exist

On starting /etc/init.d/bluetooth, dbus-monitor --system shows:

$ dbus-monitor --system
signal sender=org.freedesktop.DBus -> dest=:1.5 path=/org/freedesktop/DBus;
interface=org.freedesktop.DBus; member=NameAcquired
   string ":1.5"
signal sender=org.freedesktop.DBus -> dest=(null destination)
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged
   string ":1.6"
   string ""
   string ":1.6"
signal sender=org.freedesktop.DBus -> dest=(null destination)
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged
   string "org.bluez"
   string ""
   string ":1.6"
signal sender=:1.6 -> dest=(null destination) path=/org/bluez/Manager;
interface=org.bluez.Manager; member=DeviceAdded
   string "/org/bluez/Device/hci0"
signal sender=:1.6 -> dest=(null destination) path=/org/bluez/Device/hci0;
interface=org.bluez.Device; member=Up
signal sender=:1.6 -> dest=(null destination) path=/org/bluez/Device/hci0;
interface=org.bluez.Device; member=PropertyChanged
   string "name"
   string ""

What is wrong here?

Thanks,
--theHog



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
