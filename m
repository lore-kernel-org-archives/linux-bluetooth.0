Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Date: Mon, 09 Sep 2013 07:08:48 -0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Can't initialize a Bluetooth antenna.
MIME-Version: 1.0
From: atar <atar.yosef@gmail.com>
Message-ID: <op.w24t4yu9e4gg2u@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there!!

When I try to use the hciconfig command to initialized my Bluetooth  
antenna like the command:

hciconfig hci0 up OR hciconfig hci0 reset

it emits an error message saying:

Can't init device hci0: Connection timed out (110).

dmesg reports the following errors messages:

[   15.084017] Bluetooth: hci0 command tx timeout
[   17.611516] input: ACPI Virtual Keyboard Device as  
/devices/virtual/input/input5
[   32.826814] Bluetooth: RFCOMM TTY layer initialized
[   32.828142] Bluetooth: RFCOMM socket layer initialized
[   32.829376] Bluetooth: RFCOMM ver 1.11
[   32.869417] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   32.870701] Bluetooth: BNEP filters: protocol multicast
[   33.422622] lp0: using parport0 (interrupt-driven).
[   33.433318] ppdev: user-space parallel port driver
[   33.982250] atl2 0000:01:00.0: irq 43 for MSI/MSI-X
[   33.982474] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   38.136034] usb 2-1: reset full-speed USB device number 2 using uhci_hcd
[   38.286042] btusb 2-1:1.0: no reset_resume for driver btusb?
[   38.286048] btusb 2-1:1.1: no reset_resume for driver btusb?
[   66.706329] fuse init (API version 7.17)

and the 'bluez-simple-agent' command emits the following error messages:

Traceback (most recent call last):
  File "/usr/bin/bluez-simple-agent", line 104, in <module>
    path = manager.DefaultAdapter()
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in  
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in  
__call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in  
call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.NoSuchAdapter: No such  
adapter

Has anyone here an idea what's going on?

NOTE: the system is a Wheezy Debian system.

Thanks in advance!!

atar.
