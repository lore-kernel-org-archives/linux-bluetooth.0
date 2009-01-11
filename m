Return-Path: <cyrus@holtmann.org>
Message-ID: <49696D00.9030604@gmail.com>
Date: Sun, 11 Jan 2009 06:52:32 +0300
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: app doesn't recieve signal DeviceDisappeared
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

Excuse me for my English.

I need help with using Bluez and dbus. Here is my small program in Python:

------------

import dbus
import dbus.glib
import gobject

def device_found(addr, values):
	print 'Found:', addr

def device_disapp(addr):    
	print 'Disappeared:', addr

bus = dbus.SystemBus()
obj = bus.get_object('org.bluez', '/org/bluez/hci0')
adapter = dbus.Interface(obj, 'org.bluez.Adapter')
adapter.connect_to_signal('DeviceFound', device_found)
adapter.connect_to_signal('DeviceDisappeared', device_disapp)

adapter.StartDiscovery()

gobject.threads_init()
dbus.glib.init_threads()
main_loop = gobject.MainLoop()
main_loop.run()


-----------

And I have problem with DeviceDisappeared signal. I run program, then it 
finds my bluetooth enabled phone and prints it's address every ~10 
seconds (periodical discovery). Than I turn off bluetooth in phone, but 
Bluez doesn't send signal 'DeviceDisappeared', so program doesn't print 
"Disappeared: ...". What's wrong in my program? Do I have 
misunderstanding of Bluez Adapter API?
