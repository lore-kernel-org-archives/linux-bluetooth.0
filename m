Return-Path: <cyrus@holtmann.org>
Subject: Re: app doesn't recieve signal DeviceDisappeared
From: Marcel Holtmann <marcel@holtmann.org>
To: Ilya Rubtsov <lusyaru@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49696D00.9030604@gmail.com>
References: <49696D00.9030604@gmail.com>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:29:14 +0100
Message-Id: <1232292554.5095.26.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> I need help with using Bluez and dbus. Here is my small program in Python:
> 
> ------------
> 
> import dbus
> import dbus.glib
> import gobject
> 
> def device_found(addr, values):
> 	print 'Found:', addr
> 
> def device_disapp(addr):    
> 	print 'Disappeared:', addr
> 
> bus = dbus.SystemBus()
> obj = bus.get_object('org.bluez', '/org/bluez/hci0')
> adapter = dbus.Interface(obj, 'org.bluez.Adapter')
> adapter.connect_to_signal('DeviceFound', device_found)
> adapter.connect_to_signal('DeviceDisappeared', device_disapp)
> 
> adapter.StartDiscovery()
> 
> gobject.threads_init()
> dbus.glib.init_threads()
> main_loop = gobject.MainLoop()
> main_loop.run()
> 
> 
> -----------
> 
> And I have problem with DeviceDisappeared signal. I run program, then it 
> finds my bluetooth enabled phone and prints it's address every ~10 
> seconds (periodical discovery). Than I turn off bluetooth in phone, but 
> Bluez doesn't send signal 'DeviceDisappeared', so program doesn't print 
> "Disappeared: ...". What's wrong in my program? Do I have 
> misunderstanding of Bluez Adapter API?

this might be a bug. Not many applications are actually making full use
of the DeviceDisappeared signal. Please run dbus-monitor and check if it
is really not present.

On another note, you can _NOT_ hardcode /org/bluez/hci0 path in your
apps. Nowadays they are totally random. Use FindAdapter() instead.

Regards

Marcel


