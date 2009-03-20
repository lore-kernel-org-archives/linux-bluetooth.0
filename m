Return-Path: <cyrus@holtmann.org>
Message-ID: <49C2E3E7.30503@gmail.com>
Date: Fri, 20 Mar 2009 03:31:35 +0300
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Exit from software scheduled periodic inquiry on program termination
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I need fast and frequent inquiry, so I set DiscoverSchedulerInterval=1 
in /etc/bluetooth/main.conf. Software scheduler works fine. But I have 
problems when I interrupt my program by Ctrl-C. Scheduler doesn't see 
that program was terminated and continues to send Inquiry command every 
11 seconds (in my case), but when I used normal periodic inquiry 
(hardware scheduled) chip automatically exited inquiry mode on program 
termination. So now if I rerun my program and try use adapter I catch 
execution 'Adapter is not ready'.

There is one more problem. If program was terminated and scheduled 
inquiry continues then the Manager.ListAdapters method returns 
duplicated list of adapters:
dbus.Array([dbus.ObjectPath('/org/bluez/7868/hci0'), 
dbus.ObjectPath('/org/bluez/7868/hci1'), 
dbus.ObjectPath('/org/bluez/7868/hci0'), 
dbus.ObjectPath('/org/bluez/7868/hci1')], signature=dbus.Signature('o'))

Then I unplug one dongle and get:
dbus.Array([dbus.ObjectPath('/org/bluez/7868/hci0'), 
dbus.ObjectPath('/org/bluez/7868/hci0')], signature=dbus.Signature('o'))

Then plug that dongle again and get:
dbus.Array([dbus.ObjectPath('/org/bluez/7868/hci0'), 
dbus.ObjectPath('/org/bluez/7868/hci0'), 
dbus.ObjectPath('/org/bluez/7868/hci1')], signature=dbus.Signature('o'))

I asked Vudentz at #bluez about it and he gave me patch - 
http://fpaste.org/paste/6518 . I used it. Now list is not duplicated - 
one bug fixed. But DefaultAdapter() now causes exception 'No such 
adapter' - +1 bug :)

Any ideas?
