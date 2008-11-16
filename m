Return-Path: <cyrus@holtmann.org>
Message-ID: <49208DED.8040303@powercraft.nl>
Date: Sun, 16 Nov 2008 22:17:33 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [Bluez-devel] dell bluetooth mouse and keyboard do not work	after
 "successful" pairing with simple-agent.py
References: <49105E9C.8000605@powercraft.nl> <loom.20081116T200553-19@post.gmane.org>
In-Reply-To: <loom.20081116T200553-19@post.gmane.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dick wrote:
> Hi Jelle,
> 
> Have you tried using hidd --search or hidd --connect?
> If you don't have hidd try the following hidtool.py python script.
> 
> Succes er mee!
> 
> #!/usr/bin/python
> import sys
> import getopt
> import dbus
> 
> bus = dbus.SystemBus()
> 
> bmgr = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
> 'org.bluez.Manager')
> bus_id = bmgr.ActivateService('input')
> 
> imgr = dbus.Interface(bus.get_object(bus_id, '/org/bluez/input'),
> 'org.bluez.input.Manager')
> 
> optlist, args = getopt.getopt(sys.argv[1:], '',
> ['list','connect=','disconnect=','help'])
> 
> for opt,val in optlist:
> 	if opt == '--list':
> 		for path in imgr.ListDevices():
> 			idev = dbus.Interface (bus.get_object(bus_id, path), 'org.bluez.input.Device')
> 			print "%s Name: \"%s\" ID: %04x:%04x Connected: %i" % (path, idev.GetName(),
> idev.GetProductId(), idev.GetVendorId(), idev.IsConnected())
> 	elif opt == '--connect':
> 		path = ''
> 		if (val[0] == '/'):
> 			path = val
> 		else:
> 			path = imgr.CreateDevice(val)
> 		idev = dbus.Interface (bus.get_object(bus_id, path), 'org.bluez.input.Device')
> 		idev.Connect()
> 	elif opt == '--disconnect':
> 		imgr.RemoveDevice(val)
> 	else:
> 		print 'usage: ', sys.argv[0], '[ --list, --connect=[XX:XX:XX:XX:XX,
> /org/bluez/input/device0], --disconnect=/org/bluez/input/device0, --help ]'
> 		break
> 

Thank you Dick for taking the time to response. Two small comments, the
developers list is moving to linux-bluetooth@vger.kernel.org and the
hidd program is being replaced/depreciated.

I will try your python script, where can i find the upstream source
place? is it somewhere in the testing directory of the bluez git?

Thanks in advance,

Jelle
