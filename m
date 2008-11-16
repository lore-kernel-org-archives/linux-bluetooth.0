Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Dick <dick@mrns.nl>
Date: Sun, 16 Nov 2008 20:08:49 +0000 (UTC)
Message-ID: <loom.20081116T200553-19@post.gmane.org>
References: <49105E9C.8000605@powercraft.nl>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] dell bluetooth mouse and keyboard do not work
	after "successful" pairing with simple-agent.py
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jelle,

Have you tried using hidd --search or hidd --connect?
If you don't have hidd try the following hidtool.py python script.

Succes er mee!

#!/usr/bin/python
import sys
import getopt
import dbus

bus = dbus.SystemBus()

bmgr = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
'org.bluez.Manager')
bus_id = bmgr.ActivateService('input')

imgr = dbus.Interface(bus.get_object(bus_id, '/org/bluez/input'),
'org.bluez.input.Manager')

optlist, args = getopt.getopt(sys.argv[1:], '',
['list','connect=','disconnect=','help'])

for opt,val in optlist:
	if opt == '--list':
		for path in imgr.ListDevices():
			idev = dbus.Interface (bus.get_object(bus_id, path), 'org.bluez.input.Device')
			print "%s Name: \"%s\" ID: %04x:%04x Connected: %i" % (path, idev.GetName(),
idev.GetProductId(), idev.GetVendorId(), idev.IsConnected())
	elif opt == '--connect':
		path = ''
		if (val[0] == '/'):
			path = val
		else:
			path = imgr.CreateDevice(val)
		idev = dbus.Interface (bus.get_object(bus_id, path), 'org.bluez.input.Device')
		idev.Connect()
	elif opt == '--disconnect':
		imgr.RemoveDevice(val)
	else:
		print 'usage: ', sys.argv[0], '[ --list, --connect=[XX:XX:XX:XX:XX,
/org/bluez/input/device0], --disconnect=/org/bluez/input/device0, --help ]'
		break


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
