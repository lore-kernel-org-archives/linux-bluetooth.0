Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 22 Aug 2011 12:36:37 -0500
Message-ID: <CABUK1aiEJCCpmxMvob4PDtMS1PX8KA=rCxD+JZ2DGxuWavp18A@mail.gmail.com>
Subject: using test-health and test-health-sink
From: Pavan Savoy <pavan_savoy@sify.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to make my desktop running latest BlueZ (4.96) as a hdp
source, and want to use test-health to communicate with a sink that I
know off.
However, when I try to use the test-health service  - I see that the
hdp_device hasn't been probed and then the dbus service
"org.bluez.HealthDevice" isn't running and hence getting this
error....

org.bluez.HealthManager seems to be running fine...
How do I make org.bluez.HealthDevice to be registered ?

[]:~/misc/bluez$ sudo ./test/test-health
Select 1. source or 2. sink: 1
 Select a data type: 1
 Select a preferred data channel type 1. reliable 2. streaming: 1
bluetoothd[13771]: health/mcap.c:mcap_instance_ref()
mcap_instance_ref(0x7fc216d8b500): ref=1
bluetoothd[13771]: health/hdp.c:update_adapter() 1. done update_adapter
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10005
bluetoothd[13771]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[13771]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[13771]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000001e-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000001f-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001400-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001401-0000-1000-8000-00805f9
bluetoothd[13771]: health/hdp.c:manager_create_application() Health
application created with id /org/bluez/health_app_5
 New application created: /org/bluez/health_app_5
Connect to a remote device (y/n)? y
 1. /org/bluez/13771/hci0
Select an adapter: 1
 1. /org/bluez/13771/hci0/dev_08_00_28_0E_23_C3
Select a device: 1
 Perform an echo (y/n)? y

Traceback (most recent call last):
  File "./test/test-health", line 200, in <module>
    if device.Echo():
  File "/usr/lib/pymodules/python2.7/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/pymodules/python2.7/dbus/proxies.py", line 140, in __call__
    **keywords)
  File "/usr/lib/pymodules/python2.7/dbus/connection.py", line 630, in
call_blocking
    message, timeout)
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "Echo" with signature
"" on interface "org.bluez.HealthDevice" doesn't exist

bluetoothd[13771]: health/hdp.c:client_disconnected() Client
disconnected from the bus, deleting hdp application
bluetoothd[13771]: health/hdp.c:remove_application() Application
/org/bluez/health_app_5 deleted
bluetoothd[13771]: health/hdp_util.c:hdp_application_unref()
health_application_unref(0x7fc216da2f90): ref=0
bluetoothd[13771]: health/mcap.c:mcap_instance_unref()
mcap_instance_unref(0x7fc216d8b500): ref=0
bluetoothd[13771]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10005
bluetoothd[13771]: plugins/hciops.c:hciops_remove_uuid() hci0
bluetoothd[13771]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[13771]: plugins/hciops.c:update_ext_inquiry_response() hci0



with test-health-sink something similar...
sudo ./test/test-health-sink
bluetoothd[13771]: health/mcap.c:mcap_instance_ref()
mcap_instance_ref(0x7fc216d96fe0): ref=1
bluetoothd[13771]: health/hdp.c:update_adapter() 1. done update_adapter
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10005
bluetoothd[13771]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[13771]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[13771]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000001e-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000001f-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001400-0000-1000-8000-00805f9
bluetoothd[13771]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001402-0000-1000-8000-00805f9
bluetoothd[13771]: health/hdp.c:manager_create_application() Health
application created with id /org/bluez/health_app_7
/org/bluez/health_app_7
1. /org/bluez/13771/hci0
Select an adapter: 1
 1. /org/bluez/13771/hci0/dev_08_00_28_0E_23_C3
Select a device: 1
 Connecting to /org/bluez/13771/hci0/dev_08_00_28_0E_23_C3
Traceback (most recent call last):
  File "./test/test-health-sink", line 76, in <module>
    chan = device.CreateChannel(app_path, "Any")
  File "/usr/lib/pymodules/python2.7/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/pymodules/python2.7/dbus/proxies.py", line 140, in __call__
    **keywords)
  File "/usr/lib/pymodules/python2.7/dbus/connection.py", line 630, in
call_blocking
    message, timeout)
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "CreateChannel" with
signature "os" on interface "org.bluez.HealthDevice" doesn't exist

bluetoothd[13771]: health/hdp.c:client_disconnected() Client
disconnected from the bus, deleting hdp application
bluetoothd[13771]: health/hdp.c:remove_application() Application
/org/bluez/health_app_7 deleted
bluetoothd[13771]: health/hdp_util.c:hdp_application_unref()
health_application_unref(0x7fc216da2f90): ref=0
bluetoothd[13771]: health/mcap.c:mcap_instance_unref()
mcap_instance_unref(0x7fc216d96fe0): ref=0
bluetoothd[13771]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10005
bluetoothd[13771]: plugins/hciops.c:hciops_remove_uuid() hci0
bluetoothd[13771]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[13771]: plugins/hciops.c:update_ext_inquiry_response() hci0
