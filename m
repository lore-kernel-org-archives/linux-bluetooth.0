Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 Apr 2016 20:20:09 +0900
Message-ID: <CAArnnE4WkLUfS5J1A3PCHJjR886rOiGe=rEhn_qfTY2B6Dw46A@mail.gmail.com>
Subject: Not shown registered gatt services on an android 5.1.1
From: Hyuntak Lee <pphdev12@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dears,

I am testing a gatt server with iphone and android.
iPhone is working nicely, but unfortunately andorid cannot retrive
registered GATT services.
I tested with a bluez-5.39/test/example-gatt-server file.
Can you advice me?

My step is below:

* Peripheral env
** Bluez 5.39
** Linux Kernel 3.18
** BT Dongle: NEXT-204BT(CSR 4.0)

* Central env
** Android 5.1.1 and iOS 9.3.1
** Test app: nRF MCP

* Build configure
./configure --prefix=/usr     \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --enable-library      \
            --enable-experimental \
            --disable-systemd

* STEP
1. Executes a bluetooth daemon:
$ bluetoothd -ndE

2. Register gatt services
$ python bluez-5.39/test/example-gatt-server
For register service(Heart Rate, Battery Service)

3. To advertising and pairing:
$ hciconfig hci0 reset
$ hciconfig hci0 pscan;   # PSCAN need to pair with android
$ hcitool -i hci0 cmd 0x08 0x000a 00;
$ hcitool -i hci0 cmd 0x08 0x0008 03 02 0a 0a 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00;
$ hcitool -i hci0 cmd 0x08 0x000a 01;

4. connect to gatt server
4.1 with iOS 9.3.1
Retrieved list
- Heart Rate (UUID: 0x180D)
- Battery Service (UUID: 0x180F)

4.2 with android 5.1.1
Retrieved list
- Generic Attribute(UUID: 0x1801)
- Generic Access(UUID: 0x1800)



Only android don't get registerted services.
I founded different part of bluetoothd log in the case of iphone and
android. I hope these are helpful to you.

Logs of iOS case:

bluetoothd[2976]: src/gatt-database.c:connect_cb() New incoming LE ATT
connection
bluetoothd[2976]: attrib/gattrib.c:g_attrib_ref() 0x1e53230: g_attrib_ref=1
bluetoothd[2976]: src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[2976]: src/device.c:load_gatt_db() Restoring
57:92:97:B5:A8:C4 gatt database from file
bluetoothd[2976]: No cache for 57:92:97:B5:A8:C4
bluetoothd[2976]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 158
bluetoothd[2976]: src/device.c:gatt_debug() Read By Grp Type - start:
0x0001 end: 0xffff
bluetoothd[2976]: src/device.c:gatt_debug() Read By Grp Type - start:
0x0021 end: 0xffff
bluetoothd[2976]: src/device.c:gatt_debug() Read By Type - start:
0x0006 end: 0x0009
bluetoothd[2976]: src/device.c:gatt_debug() Find Info - start: 0x0009
end: 0x0009
bluetoothd[2976]: src/device.c:gatt_debug() Write Req - handle: 0x0009
bluetoothd[2976]: src/gatt-database.c:gatt_ccc_write_cb() CCC write
called for handle: 0x0009
bluetoothd[2976]: src/device.c:gatt_debug() Primary services found: 8
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0001, end:
0x0005, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0006, end:
0x0009, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x000a, end:
0x000e, uuid: d0611e78-bbb4-4591-a5f8-487910ae4366
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x000f, end:
0x0012, uuid: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0013, end:
0x0018, uuid: 00001805-0000-1000-8000-00805f9b34fb
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0019, end:
0x001d, uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x001e, end:
0x0027, uuid: 7905f431-b5ce-4e99-a40f-4b1e122d00d0
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0028, end:
0x0033, uuid: 89d3502b-0f36-433a-8ef4-c502ad55f8dc
bluetoothd[2976]: src/device.c:gatt_debug() Secondary service
discovery failed. ATT ECODE: 0x0a

Logs of android case:

bluetoothd[2976]: src/gatt-database.c:connect_cb() New incoming LE ATT
connection
bluetoothd[2976]: attrib/gattrib.c:g_attrib_ref() 0x1e35fe8: g_attrib_ref=1
bluetoothd[2976]: src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[2976]: src/device.c:load_gatt_db() Restoring
30:75:12:94:47:D5 gatt database from file
bluetoothd[2976]: No cache for 30:75:12:94:47:D5
bluetoothd[2976]: src/device.c:gatt_debug() MTU Exchange failed. ATT ECODE: 0x06
bluetoothd[2976]: src/device.c:gatt_debug() Primary services found: 2
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0001, end:
0x0005, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0014, end:
0xffff, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[2976]: src/device.c:gatt_debug() Secondary service
discovery failed. ATT ECODE: 0x10


It looks like if request is from an android, cannot find primary services.
How can I use a GATT service with an android?
Pls advise me.

Best Regards,
Tak
