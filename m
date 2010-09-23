Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 23 Sep 2010 00:46:55 -0700
Message-ID: <AANLkTi=QaWXz2BEsUJPpXQjvGuGm8CtctJ_q-7WNC=VH@mail.gmail.com>
Subject: Bluez simple-agent vs agent
From: Viswanathan Sankararam <developervishwa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

I am new to bluetooth and bluez. I am having problems pairing my
bluetooth keyboard to my target that does not have python and so in
order to pair, I have compiled the agent application. My target has
Bluez 4.47. But I have not been able to get it to pair. After running

agent -a hci0 1234 00:1F:20:06:47:65

I get asked to enter the pin on the bt keyboard and then it says Agent
is released. When I list devices using

dbus-send --system --dest=org.bluez --print-reply $BTADAPTER
org.bluez.Adapter.ListDevices

I see it in the list and when I repeat the command, it disappears.

When I log on to my gentoo machine to pair the bt keyboard, I am able
to pair with the simple-agent python script but not the agent
application. The way the agent application behaves is the same as it
behaves when I use it on the target.My gentoo system uses Bluez 4.69.
Below is the log when I run bluetoothd with the -d option for the
simple-agent case and the agent C program case. As you can see, in the
simple-agent case, the device_probe_drivers gets called but in the
agent.c case, discover_services_req_exit gets called. This is the
place where they diverge. Also, I am not sure why the dbus system
daemon is rejecting a message from agent to org.bluez. I am nto sure
if its related. I am not able to proceed from here. Has any one faced
this kind of issue? Please advice me on how to proceed. I would really
appreciate it.

Thanks
Vishwa

simple-agent:

Sep 22 22:59:40 Zatoichi
bluetoothd[7042]:src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 22 22:59:40 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_create_device() 00:1F:20:06:47:65
Sep 22 22:59:40 Zatoichi bluetoothd[7042]:
src/device.c:device_create() Creating device
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65
Sep 22 22:59:40 Zatoichi bluetoothd[7042]:
src/device.c:btd_device_ref() 0xb899f6b8: ref=1
Sep 22 22:59:40 Zatoichi bluetoothd[7042]:
src/device.c:bonding_request_new()
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65: requesting bonding
Sep 22 22:59:40 Zatoichi bluetoothd[7042]:
src/device.c:bonding_request_new() Temporary agent registered for
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65 at :1.29:/test/agent
Sep 22 22:59:41 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 22 22:59:41 Zatoichi bluetoothd[7042]: Authentication requested
Sep 22 22:59:41 Zatoichi bluetoothd[7042]: link_key_request
(sba=40:61:86:A5:0E:E1, dba=00:1F:20:06:47:65)
Sep 22 22:59:41 Zatoichi bluetoothd[7042]:
src/security.c:link_key_request() kernel auth requirements = 0x03
Sep 22 22:59:41 Zatoichi bluetoothd[7042]: pin_code_request
(sba=40:61:86:A5:0E:E1, dba=00:1F:20:06:47:65)
Sep 22 22:59:41 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 22 22:59:41 Zatoichi bluetoothd[7042]:
src/device.c:device_request_authentication()
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65: requesting agent
authentication
Sep 22 22:59:47 Zatoichi bluetoothd[7042]: link_key_notify
(sba=40:61:86:A5:0E:E1, dba=00:1F:20:06:47:65, type=0)
Sep 22 22:59:47 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 22 22:59:47 Zatoichi bluetoothd[7042]:
src/dbus-hci.c:hcid_dbus_link_key_notify() key type 0x00 old key type
0xff new key type 0x00
Sep 22 22:59:47 Zatoichi bluetoothd[7042]:
src/dbus-hci.c:hcid_dbus_link_key_notify() local auth 0x03 and remote
auth 0xff
Sep 22 22:59:47 Zatoichi bluetoothd[7042]:
src/dbus-hci.c:hcid_dbus_link_key_notify() storing link key of type
0x00
Sep 22 22:59:47 Zatoichi bluetoothd[7042]:
src/dbus-hci.c:hcid_dbus_bonding_process_complete() status=00
Sep 22 22:59:47 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 22 22:59:47 Zatoichi bluetoothd[7042]:
src/device.c:btd_device_ref() 0xb899f6b8: ref=2
Sep 22 22:59:47 Zatoichi bluetoothd[7042]: src/agent.c:agent_release()
Releasing agent :1.29, /test/agent
Sep 22 22:59:47 Zatoichi dbus-daemon: [system] Rejected send message,
1 matched rules; type="method_return", sender=":1.29" (uid=0 pid=7790
comm="/usr/bin/python2.6) interface="(unset)" member="(unset)" error
name="(unset)" requested_reply=0 destination=":1.12" (uid=0 pid=7041
comm="/usr/sbin/bluetoothd))
Sep 22 22:59:48 Zatoichi bluetoothd[7042]:
src/device.c:device_probe_drivers() Probe drivers for
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65
Sep 22 22:59:48 Zatoichi bluetoothd[7042]:
input/manager.c:hid_device_probe() path
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65
Sep 22 22:59:48 Zatoichi bluetoothd[7042]:
src/device.c:btd_device_ref() 0xb899f6b8: ref=3
Sep 22 22:59:48 Zatoichi bluetoothd[7042]:
input/device.c:input_device_new() Registered interface org.bluez.Input
on path /org/bluez/7041/hci0/dev_00_1F_20_06_47_65
Sep 22 22:59:48 Zatoichi bluetoothd[7042]:
src/device.c:btd_device_unref() 0xb899f6b8: ref=2

agent.c:

Sep 23 00:14:34 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 23 00:14:34 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_create_device() 00:1F:20:06:47:65
Sep 23 00:14:34 Zatoichi bluetoothd[7042]:
src/device.c:device_create() Creating device
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65
Sep 23 00:14:34 Zatoichi bluetoothd[7042]:
src/device.c:btd_device_ref() 0xb899f6b8: ref=1
Sep 23 00:14:34 Zatoichi bluetoothd[7042]:
src/device.c:bonding_request_new()
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65: requesting bonding
Sep 23 00:14:34 Zatoichi bluetoothd[7042]:
src/device.c:bonding_request_new() Temporary agent registered for
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65 at
:1.35:/org/bluez/agent_8004
Sep 23 00:14:35 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 23 00:14:35 Zatoichi bluetoothd[7042]: Authentication requested
Sep 23 00:14:35 Zatoichi bluetoothd[7042]: link_key_request
(sba=40:61:86:A5:0E:E1, dba=00:1F:20:06:47:65)
Sep 23 00:14:35 Zatoichi bluetoothd[7042]:
src/security.c:link_key_request() kernel auth requirements = 0x03
Sep 23 00:14:35 Zatoichi bluetoothd[7042]: pin_code_request
(sba=40:61:86:A5:0E:E1, dba=00:1F:20:06:47:65)
Sep 23 00:14:35 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 23 00:14:35 Zatoichi bluetoothd[7042]:
src/device.c:device_request_authentication()
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65: requesting agent
authentication
Sep 23 00:14:38 Zatoichi bluetoothd[7042]: link_key_notify
(sba=40:61:86:A5:0E:E1, dba=00:1F:20:06:47:65, type=0)
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/dbus-hci.c:hcid_dbus_link_key_notify() key type 0x00 old key type
0xff new key type 0x00
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/dbus-hci.c:hcid_dbus_link_key_notify() local auth 0x03 and remote
auth 0xff
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/dbus-hci.c:hcid_dbus_link_key_notify() storing link key of type
0x00
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/dbus-hci.c:hcid_dbus_bonding_process_complete() status=00
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_get_device() 00:1F:20:06:47:65
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/device.c:btd_device_ref() 0xb899f6b8: ref=2
Sep 23 00:14:38 Zatoichi bluetoothd[7042]: src/agent.c:agent_release()
Releasing agent :1.35, /org/bluez/agent_8004
Sep 23 00:14:38 Zatoichi dbus-daemon: [system] Rejected send message,
1 matched rules; type="method_return", sender=":1.35" (uid=1000
pid=8004 comm="./agent) interface="(unset)" member="(unset)" error
name="(unset)" requested_reply=0 destination=":1.12" (uid=0 pid=7041
comm="/usr/sbin/bluetoothd))
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/device.c:discover_services_req_exit() DiscoverServices requestor
exited
Sep 23 00:14:38 Zatoichi bluetoothd[7042]:
src/device.c:btd_device_unref() 0xb899f6b8: ref=1
Sep 23 00:14:40 Zatoichi bluetoothd[7042]:
src/adapter.c:adapter_remove_connection() Removing temporary device
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65
Sep 23 00:14:40 Zatoichi bluetoothd[7042]:
src/device.c:device_remove() Removing device
/org/bluez/7041/hci0/dev_00_1F_20_06_47_65
Sep 23 00:14:40 Zatoichi bluetoothd[7042]:
src/device.c:btd_device_unref() 0xb899f6b8: ref=0
Sep 23 00:14:40 Zatoichi bluetoothd[7042]: src/device.c:device_free() 0xb899f6b8
