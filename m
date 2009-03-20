Return-Path: <cyrus@holtmann.org>
Message-ID: <49C3D035.8080001@gmail.com>
Date: Fri, 20 Mar 2009 20:19:49 +0300
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Exit from software scheduled periodic inquiry on program termination
References: <49C2E3E7.30503@gmail.com>
In-Reply-To: <49C2E3E7.30503@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, I was wrong. The bug was caused NOT by software scheduler. I 
returned to using hardware scheduler, but bug is here. But
So, my program searches for nearby devices and tries to fetch SDP info. 
You can see it at http://pastebin.com/f31769cb
I handle KeyboardInterrupt and call StopDiscovery method. So the program 
cleans discovery session before it dies.

So, I run it first time:


ilya@ilya-laptop:~$ python workspace/btbroad/src/btbroad/sdp.py
dbus.Array([dbus.ObjectPath('/org/bluez/15682/hci0'), 
dbus.ObjectPath('/org/bluez/15682/hci1')], signature=dbus.Signature('o'))
Found adapter with path: /org/bluez/15682/hci0
Found adapter with path: /org/bluez/15682/hci1
Will use adapter /org/bluez/15682/hci1 for _services_ discovery
Found: 00:16:B8:53:5F:17
Remote device 00:16:B8:53:5F:17 kkk -63 - is new for me
------------begin info--------
Name = kkk
LegacyPairing = 1
Alias = kkk
Address = 00:16:B8:53:5F:17
RSSI = -63
Class = 5374468
Icon = phone
(I already have object for 00:16:B8:53:5F:17 (maybe you have run this 
app before?)
Will try discover services
I've got first SDP record!
------------end info---------
^CDieing


After program termination the dongle DOES exit from periodic inquiry mode.
Then I run it second time:


ilya@ilya-laptop:~$ python workspace/btbroad/src/btbroad/sdp.py
dbus.Array([dbus.ObjectPath('/org/bluez/15682/hci0'), 
dbus.ObjectPath('/org/bluez/15682/hci1')], signature=dbus.Signature('o'))
Found adapter with path: /org/bluez/15682/hci0
Found adapter with path: /org/bluez/15682/hci1
Will use adapter /org/bluez/15682/hci1 for _services_ discovery
Found: 00:16:B8:53:5F:17
Remote device 00:16:B8:53:5F:17 kkk -63 - is new for me
------------begin info--------
Name = kkk
LegacyPairing = 1
Alias = kkk
Address = 00:16:B8:53:5F:17
RSSI = -63
Class = 5374468
Icon = phone
(I already have object for 00:16:B8:53:5F:17 (maybe you have run this 
app before?)
Will try discover services
Cant fetch SDP list: org.freedesktop.DBus.Error.NoReply: Message did not 
receive a reply (timeout by message bus)
------------end info---------
^CDieing
Traceback (most recent call last):
  File "workspace/btbroad/src/btbroad/sdp.py", line 99, in <module>
    tester = MyBlue()
  File "workspace/btbroad/src/btbroad/sdp.py", line 95, in __init__
    self.clean()       
  File "workspace/btbroad/src/btbroad/sdp.py", line 60, in clean
    self.adapterone.StopDiscovery()
  File "/var/lib/python-support/python2.6/dbus/proxies.py", line 140, in 
__call__
    **keywords)
  File "/var/lib/python-support/python2.6/dbus/connection.py", line 622, 
in call_blocking
    message, timeout)
dbus.exceptions.DBusException: 
org.freedesktop.DBus.Error.ServiceUnknown: The name :1.176 was not 
provided by any .service files


And now the dongle is still in inquiry mode.
Then I run it third time. Before I applied Vudentz's patch I got 
'Adapter is busy' exception. Now I get:


ilya@ilya-laptop:~$ python workspace/btbroad/src/btbroad/sdp.py
Traceback (most recent call last):
  File "workspace/btbroad/src/btbroad/sdp.py", line 99, in <module>
    tester = MyBlue()
  File "workspace/btbroad/src/btbroad/sdp.py", line 71, in __init__
    self.adapterone = dbus.Interface(self.bus.get_object('org.bluez', 
self.manager.DefaultAdapter()), 'org.bluez.Adapter')
  File "/var/lib/python-support/python2.6/dbus/proxies.py", line 68, in 
__call__
    return self._proxy_method(*args, **keywords)
  File "/var/lib/python-support/python2.6/dbus/proxies.py", line 140, in 
__call__
    **keywords)
  File "/var/lib/python-support/python2.6/dbus/connection.py", line 622, 
in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.NoSuchAdapter: No such 
adapter


I think my program does correct termination itself, so problem not in 
it. Maybe something between D-Bus and bluetoothd (I just guess) is broken?



Ilya Rubtsov пишет:
> Hi!
>
> I need fast and frequent inquiry, so I set DiscoverSchedulerInterval=1 
> in /etc/bluetooth/main.conf. Software scheduler works fine. But I have 
> problems when I interrupt my program by Ctrl-C. Scheduler doesn't see 
> that program was terminated and continues to send Inquiry command 
> every 11 seconds (in my case), but when I used normal periodic inquiry 
> (hardware scheduled) chip automatically exited inquiry mode on program 
> termination. So now if I rerun my program and try use adapter I catch 
> execution 'Adapter is not ready'.
>
> There is one more problem. If program was terminated and scheduled 
> inquiry continues then the Manager.ListAdapters method returns 
> duplicated list of adapters:
> dbus.Array([dbus.ObjectPath('/org/bluez/7868/hci0'), 
> dbus.ObjectPath('/org/bluez/7868/hci1'), 
> dbus.ObjectPath('/org/bluez/7868/hci0'), 
> dbus.ObjectPath('/org/bluez/7868/hci1')], signature=dbus.Signature('o'))
>
> Then I unplug one dongle and get:
> dbus.Array([dbus.ObjectPath('/org/bluez/7868/hci0'), 
> dbus.ObjectPath('/org/bluez/7868/hci0')], signature=dbus.Signature('o'))
>
> Then plug that dongle again and get:
> dbus.Array([dbus.ObjectPath('/org/bluez/7868/hci0'), 
> dbus.ObjectPath('/org/bluez/7868/hci0'), 
> dbus.ObjectPath('/org/bluez/7868/hci1')], signature=dbus.Signature('o'))
>
> I asked Vudentz at #bluez about it and he gave me patch - 
> http://fpaste.org/paste/6518 . I used it. Now list is not duplicated - 
> one bug fixed. But DefaultAdapter() now causes exception 'No such 
> adapter' - +1 bug :)
>
> Any ideas?

