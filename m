Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Andrey Batyiev <batyiev@gmail.com>
Date: Fri, 20 Apr 2018 18:31:46 +0300
Message-ID: <CAEQQxWwn=QDTLOj_wdFDVx8H3K=nOGMnHOG_qQxqq+qdzhENeg@mail.gmail.com>
Subject: Crash at queue_remove in src/shared/queue.c:256
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

I've got crash in bluez daemon (git master version) while trying to
use AcquireNotify DBus method.

My steps are:
0. I have two separate linux devices (laptop and raspberry pi 3)
1. GATT server (rpi3) running example-advertisement and
example-gatt-server (both are test scripts from bluez package itself)
2. GATT client (laptop) is running custom script (see at the end of the message)
3. I do CTRL+C on example-gatt-server to shutdown GATT server
4. bluetoothd on GATT client gets SIGSERV

I added gdb stacktrace and my script to the of this email. Should I
look and add anything else?

Thanks,
   Andrey

Stacktrace:
---------------------

bluetoothd[11407]: src/device.c:gatt_debug() service disappeared:
start 0x0026 end 0x0035
bluetoothd[11407]: src/device.c:gatt_service_removed() start: 0x0026,
end: 0x0035
bluetoothd[11407]: src/gatt-client.c:btd_gatt_client_service_removed()
GATT Services Removed - start: 0x0026, end: 0x0035
bluetoothd[11407]: src/gatt-client.c:unregister_service() Removing
GATT service: /org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026
bluetoothd[11407]: src/gatt-client.c:unregister_characteristic()
Removing GATT characteristic:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char0027
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char0027/desc0029
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char0027/desc002a
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char0027/desc002b
bluetoothd[11407]: src/gatt-client.c:unregister_characteristic()
Removing GATT characteristic:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char002c
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char002c/desc002e
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char002c/desc002f
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char002c/desc0030
bluetoothd[11407]: src/gatt-client.c:unregister_characteristic()
Removing GATT characteristic:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char0031
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char0031/desc0033
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char0031/desc0034
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0026/char0031/desc0035
bluetoothd[11407]: src/device.c:gatt_client_service_changed() start
0x0026, end: 0x0035
bluetoothd[11407]: src/device.c:gatt_debug() service disappeared:
start 0x0036 end 0x003d
bluetoothd[11407]: src/device.c:gatt_service_removed() start: 0x0036,
end: 0x003d
bluetoothd[11407]: src/gatt-client.c:btd_gatt_client_service_removed()
GATT Services Removed - start: 0x0036, end: 0x003d
bluetoothd[11407]: src/gatt-client.c:unregister_service() Removing
GATT service: /org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0036
bluetoothd[11407]: src/gatt-client.c:unregister_characteristic()
Removing GATT characteristic:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0036/char0037
bluetoothd[11407]: src/gatt-client.c:unregister_characteristic()
Removing GATT characteristic:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0036/char0039
bluetoothd[11407]: src/gatt-client.c:unregister_characteristic()
Removing GATT characteristic:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0036/char003b
bluetoothd[11407]: src/gatt-client.c:notify_client_unref() owner :1.159
bluetoothd[11407]: src/gatt-client.c:notify_client_free() owner :1.159
bluetoothd[11407]: src/gatt-client.c:unregister_descriptor() Removing
GATT descriptor:
/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0036/char003b/desc003d

Program received signal SIGSEGV, Segmentation fault.
0x080eeca3 in queue_remove (queue=0x696c6275, data=0x8178be8) at
src/shared/queue.c:256
256             for (entry = queue->head, prev = NULL; entry;
(gdb) bt
#0  0x080eeca3 in queue_remove (queue=0x696c6275, data=0x8178be8) at
src/shared/queue.c:256
#1  0x080c1138 in notify_io_destroy (data=0x8178be8) at src/gatt-client.c:1461
#2  0x080c0480 in pipe_io_destroy (io=0x817aac8) at src/gatt-client.c:1082
#3  0x080c16f0 in characteristic_free (data=0x817b870) at src/gatt-client.c:1663
#4  0x080e8cc4 in remove_interface (data=0x817de00, name=0x811e609
"org.bluez.GattCharacteristic1") at gdbus/object.c:667
#5  0x080ea489 in g_dbus_unregister_interface (connection=0x8161140,
path=0x817df48 "/org/bluez/hci1/dev_B8_27_EB_E7_50_36/service0036/char003b",
    name=0x811e609 "org.bluez.GattCharacteristic1") at gdbus/object.c:1391
#6  0x080c1a32 in unregister_characteristic (data=0x817b870) at
src/gatt-client.c:1744
#7  0x080eeee0 in queue_remove_all (queue=0x817b280, function=0x0,
user_data=0x0, destroy=0x80c1958 <unregister_characteristic>) at
src/shared/queue.c:354
#8  0x080c1ef9 in unregister_service (data=0x817b1f0) at src/gatt-client.c:1893
#9  0x080eee8e in queue_remove_all (queue=0x8173928,
function=0x80c2188 <match_service_handle>, user_data=0x36,
destroy=0x80c1e9d <unregister_service>) at src/shared/queue.c:339
#10 0x080c286b in btd_gatt_client_service_removed (client=0x8173fa8,
attrib=0x817bbf8) at src/gatt-client.c:2199
#11 0x080ca00e in gatt_service_removed (attr=0x817bbf8,
user_data=0x8173dc0) at src/device.c:3682
#12 0x08100266 in handle_notify (data=0x8174248, user_data=0xbffff1a4)
at src/shared/gatt-db.c:263
#13 0x080eebc2 in queue_foreach (queue=0x8173c18, function=0x810020a
<handle_notify>, user_data=0xbffff1a4) at src/shared/queue.c:220
#14 0x081002eb in notify_service_changed (db=0x8173b00,
service=0x8174238, added=false) at src/shared/gatt-db.c:280
#15 0x0810034b in gatt_db_service_destroy (data=0x8174238) at
src/shared/gatt-db.c:291
#16 0x081007d3 in gatt_db_remove_service (db=0x8173b00,
attrib=0x817bbf8) at src/shared/gatt-db.c:420
#17 0x080f6f2a in discovery_op_complete (op=0x817ba70, success=true,
err=10 '\n') at src/shared/gatt-client.c:376
#18 0x080f8171 in discover_chrcs_cb (success=true, att_ecode=10 '\n',
result=0x0, user_data=0x817ba70) at src/shared/gatt-client.c:940
#19 0x081049dd in discovery_op_complete (op=0x81747b0, success=false,
ecode=10 '\n') at src/shared/gatt-helpers.c:628
#20 0x08105ca7 in discover_chrcs_cb (opcode=1 '\001', pdu=0x817be09,
length=4, user_data=0x81747b0) at src/shared/gatt-helpers.c:1250
#21 0x080f4ff2 in handle_rsp (att=0x8170200, opcode=1 '\001',
pdu=0x817be09 "\b6", pdu_len=4) at src/shared/att.c:714
#22 0x080f54f1 in can_read_data (io=0x81689c8, user_data=0x8170200) at
src/shared/att.c:886
#23 0x0810347a in watch_callback (channel=0x816b0a0, cond=G_IO_IN,
user_data=0x816d658) at src/shared/io-glib.c:170
#24 0xb7f068ee in g_io_unix_dispatch () from /usr/lib/libglib-2.0.so.0
#25 0xb7ebfffb in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
#26 0xb7ec03f9 in g_main_context_iterate.isra () from /usr/lib/libglib-2.0.so.0
#27 0xb7ec07a9 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
#28 0x0808e9f7 in main (argc=1, argv=0xbffff654) at src/main.c:781

-----------------


GATT client script:
-----------------

#!/usr/bin/env python3

import dbus
try:
  from gi.repository import GObject
except ImportError:
  import gobject as GObject
import sys
import io

from dbus.mainloop.glib import DBusGMainLoop

bus = None
mainloop = None

BLUEZ_SERVICE_NAME = 'org.bluez'
DBUS_OM_IFACE =      'org.freedesktop.DBus.ObjectManager'
DBUS_PROP_IFACE =    'org.freedesktop.DBus.Properties'

GATT_SERVICE_IFACE = 'org.bluez.GattService1'
GATT_CHRC_IFACE =    'org.bluez.GattCharacteristic1'

HR_SVC_UUID =        '0000180d-0000-1000-8000-00805f9b34fb'
HR_MSRMT_UUID =      '00002a37-0000-1000-8000-00805f9b34fb'
BODY_SNSR_LOC_UUID = '00002a38-0000-1000-8000-00805f9b34fb'
HR_CTRL_PT_UUID =    '00002a39-0000-1000-8000-00805f9b34fb'

# The objects that we interact with.
hr_service = None
hr_msrmt_chrc = None
body_snsr_loc_chrc = None
hr_ctrl_pt_chrc = None


def generic_error_cb(error):
    print('D-Bus call failed: ' + str(error))
    mainloop.quit()


def start_client():
    while True:
        notifications = hr_msrmt_chrc[0].AcquireNotify({},
dbus_interface=GATT_CHRC_IFACE)
        f = io.FileIO(notifications[0].take())
        f.read()
        f.close()
        del f


def process_chrc(chrc_path):
    chrc = bus.get_object(BLUEZ_SERVICE_NAME, chrc_path)
    chrc_props = chrc.GetAll(GATT_CHRC_IFACE,
                             dbus_interface=DBUS_PROP_IFACE)

    uuid = chrc_props['UUID']

    if uuid == HR_MSRMT_UUID:
        global hr_msrmt_chrc
        hr_msrmt_chrc = (chrc, chrc_props)

    return True


def process_hr_service(service_path, chrc_paths):
    service = bus.get_object(BLUEZ_SERVICE_NAME, service_path)
    service_props = service.GetAll(GATT_SERVICE_IFACE,
                                   dbus_interface=DBUS_PROP_IFACE)

    uuid = service_props['UUID']

    if uuid != HR_SVC_UUID:
        return False

    print('Heart Rate Service found: ' + service_path)

    # Process the characteristics.
    for chrc_path in chrc_paths:
        process_chrc(chrc_path)

    global hr_service
    hr_service = (service, service_props, service_path)

    return True


def interfaces_removed_cb(object_path, interfaces):
    if not hr_service:
        return

    if object_path == hr_service[2]:
        print('Service was removed')
        mainloop.quit()


def main():
    # Set up the main loop.
    DBusGMainLoop(set_as_default=True)
    global bus
    bus = dbus.SystemBus()
    global mainloop
    mainloop = GObject.MainLoop()

    om = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, '/'), DBUS_OM_IFACE)
    om.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)

    print('Getting objects...')
    objects = om.GetManagedObjects()
    chrcs = []

    # List characteristics found
    for path, interfaces in objects.items():
        if GATT_CHRC_IFACE not in interfaces.keys():
            continue
        chrcs.append(path)

    # List sevices found
    for path, interfaces in objects.items():
        if GATT_SERVICE_IFACE not in interfaces.keys():
            continue

        chrc_paths = [d for d in chrcs if d.startswith(path + "/")]

        if process_hr_service(path, chrc_paths):
            break

    if not hr_service:
        print('No Heart Rate Service found')
        sys.exit(1)

    start_client()

    mainloop.run()


if __name__ == '__main__':
    main()

------------
