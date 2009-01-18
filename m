Return-Path: <cyrus@holtmann.org>
Message-ID: <49739C4F.10905@gmail.com>
Date: Mon, 19 Jan 2009 00:17:03 +0300
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: app doesn't recieve signal DeviceDisappeared
References: <49696D00.9030604@gmail.com> <1232292554.5095.26.camel@californication>
In-Reply-To: <1232292554.5095.26.camel@californication>
Content-Type: text/plain; charset=windows-1251; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann пишет:
> Hi Ilya,
>
>   
>> I need help with using Bluez and dbus. Here is my small program in Python:
>>
>> ------------
>>
>> import dbus
>> import dbus.glib
>> import gobject
>>
>> def device_found(addr, values):
>> 	print 'Found:', addr
>>
>> def device_disapp(addr):    
>> 	print 'Disappeared:', addr
>>
>> bus = dbus.SystemBus()
>> obj = bus.get_object('org.bluez', '/org/bluez/hci0')
>> adapter = dbus.Interface(obj, 'org.bluez.Adapter')
>> adapter.connect_to_signal('DeviceFound', device_found)
>> adapter.connect_to_signal('DeviceDisappeared', device_disapp)
>>
>> adapter.StartDiscovery()
>>
>> gobject.threads_init()
>> dbus.glib.init_threads()
>> main_loop = gobject.MainLoop()
>> main_loop.run()
>>
>>
>> -----------
>>
>> And I have problem with DeviceDisappeared signal. I run program, then it 
>> finds my bluetooth enabled phone and prints it's address every ~10 
>> seconds (periodical discovery). Than I turn off bluetooth in phone, but 
>> Bluez doesn't send signal 'DeviceDisappeared', so program doesn't print 
>> "Disappeared: ...". What's wrong in my program? Do I have 
>> misunderstanding of Bluez Adapter API?
>>     
>
> this might be a bug. Not many applications are actually making full use
> of the DeviceDisappeared signal. Please run dbus-monitor and check if it
> is really not present.
>   
I run 'dbus-monitor --system'. Now I'm sure there are no 
DeviceDisappeared signal.
Besides, I found that the adapter's Discovering property changes to True 
only _right before_ any device is found. If there are no devices in the 
field, this property will be False permanently.

I use BlueZ 4.12. I understand that before reporting any bug I should 
update my system with the lastest versions of packages, so if this bug 
was fixed between 4.12 an current 4.27 version - excuse me and sorry for 
disturbing.
> On another note, you can _NOT_ hardcode /org/bluez/hci0 path in your
> apps. Nowadays they are totally random. Use FindAdapter() instead.
>
>   
Now I use this method instead of hardcoding paths. Thanks!
