Return-Path: <cyrus@holtmann.org>
Message-ID: <52FD205F.7030704@convergeddevices.net>
Date: Thu, 13 Feb 2014 19:43:27 +0000
From: tony <tony.makkiel@convergeddevices.net>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Help in getting  BlueZ version - 5.14 running please
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
         I am trying to familiarize with blueZ commands. I can scan 
devices and see HCI commands and events using hcidump. But am having 
some problems which I have been trying to figure out the past two days. 
Any suggestions or pointers will be much appreciated.

1) I found a lot of forums talking about creating connection. But 
couldn't find any which says how to accept connection. I am trying to 
accept an A2DP connection. The peer device is sending an AVDTP Connect 
request but don't know how to make blueZ respond. Can somebody please help?

2) I tried to start bluetooth daemon by running
> ../src/bluetoothd -n -d
> bluetoothd[4440]: Bluetooth daemon 5.14
> bluetoothd[4440]: Failed to access management interface
> bluetoothd[4440]: Adapter handling initialization failed

The kernel modules I have are

> lsmod | grep blue
> bluetooth             158447  7 rfcomm,bnep,btusb

Should I be running any other command before bluetoothd?

3) I am get problem in getting the python scripts in the test folder.
For example when I try to run simple-agent it throws up dbus error as 
below. I tried googling from which I understand some people had the same 
error with 5.13 as well. The dbus version I have is 1.6.4 (I had to 
upgrade from 1.4 to build blueZ)


> ./simple-agent hci0 00:1B:DC:07:2E:95
> Traceback (most recent call last):
>   File "./simple-agent", line 158, in <module>
>     obj = bus.get_object(BUS_NAME, "/org/bluez");
>   File "/usr/lib/python2.7/dist-packages/dbus/bus.py", line 241, in get_object
>     follow_name_owner_changes=follow_name_owner_changes)
>   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 248, in __init__
>     self._named_service = conn.activate_name_owner(bus_name)
>   File "/usr/lib/python2.7/dist-packages/dbus/bus.py", line 180, in activate_name_owner
>     self.start_service_by_name(bus_name)
>   File "/usr/lib/python2.7/dist-packages/dbus/bus.py", line 278, in start_service_by_name
>     'su', (bus_name, flags)))
>   File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.Spawn.ChildExited: Launch helper exited with unknown return code 1

Thank you for any suggestions or pointers in advance.

Tony


