Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dm@chello.nl>
Date: Sun, 13 May 2007 11:59:46 +0000 (UTC)
Message-ID: <loom.20070513T135336-907@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] dbus.DBusException:
	org.bluez.input.Error.AlreadyExists: Input Already exists
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

Hi all,

I'm trying the new input service with my Logitech dinovo desktop but I can't get
it working. I've read http://wiki.bluez.org/wiki/HOWTO/InputDevices and
manufactured/stolen the following python script:

import dbus
bus = dbus.SystemBus()
bmgr = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
'org.bluez.Manager')
bus_id = bmgr.ActivateService('input')

# All input messages should be sent to this address
print bus_id

imgr = dbus.Interface(bus.get_object(bus_id, '/org/bluez/input'),
'org.bluez.input.Manager')

# device creation
#path = imgr.CreateDevice('00:07:61:69:27:XX')
path = imgr.CreateDevice('00:07:61:68:CA:XX')
idev = dbus.Interface (bus.get_object(bus_id, path), 'org.bluez.input.Device')

# host initiated connection
print idev.GetName()
idev.Connect()

This results in:

:1.30
Logitech Bluetooth Keyboard
Traceback (most recent call last):
  File "test.py", line 19, in ?
    idev.Connect()
  File "//usr/lib/python2.4/site-packages/dbus/proxies.py", line 169, in __call__
    reply_message = self._connection.send_message_with_reply_and_block(message,
timeout)
dbus.DBusException: org.bluez.input.Error.ConnectionAttemptFailed: Host is down

I've tried some fiddling with the connect button and rm-/insmod-ed hidp (from
linux-2.6.21).

Could someone please give me some hints?

Thanks,
Dick


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
