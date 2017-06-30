Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 0/9] client: Add GATT application support
Date: Fri, 30 Jun 2017 13:18:26 +0300
Message-Id: <20170630101834.23095-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds necessary commands to create GATT services which can then
be registered with bluetoothd:

[bluetooth]# register-service 00001802-0000-1000-8000-00805f9b34fb
[NEW] Primary Service
	/org/bluez/app/service0x902610
	00001802-0000-1000-8000-00805f9b34fb
	Immediate Alert
[bluetooth]# register-characteristic 00002a06-0000-1000-8000-00805f9b34fb write-without-response
[NEW] Characteristic
	/org/bluez/app/service0x902610/chrc0x91d690
	00002a06-0000-1000-8000-00805f9b34fb
	Alert Level
[/org/bluez/app/service0x902610/chrc0x91d690] Enter value:  
[bluetooth]# register-descriptor 8260c653-1a54-426b-9e36-e84c238bc669 read,write
[NEW] Descriptor
	/org/bluez/app/service0x902610/chrc0x91d690/desc0x9095a0
	8260c653-1a54-426b-9e36-e84c238bc669
	Vendor specific
[/org/bluez/app/service0x902610/chrc0x91d690/desc0x9095a0] Enter value:  
[bluetooth]# register-application
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 00001112-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 0000112d-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[CHG] Controller B8:8A:60:D8:17:D7 UUIDs: 00001802-0000-1000-8000-00805f9b34fb
Application registered


bluetoothd[7704]: src/gatt-database.c:manager_register_app() Registering application: :1.79:/
bluetoothd[7704]: src/gatt-database.c:proxy_added_cb() Object received: /org/bluez/app/service0x902610, iface: org.bluez.GattService1
bluetoothd[7704]: src/gatt-database.c:proxy_added_cb() Object received: /org/bluez/app/service0x902610/chrc0x91d690, iface: org.bluez.GattCharacteristic1
bluetoothd[7704]: src/gatt-database.c:proxy_added_cb() Object received: /org/bluez/app/service0x902610/chrc0x91d690/desc0x9095a0, iface: org.bluez.GattDescriptor1

v2: Fix memory leaks pointed out by Eramoto, make register-service ask for primary
property.

Luiz Augusto von Dentz (9):
  client: Allow register-application without any UUID
  client: Add register-service command
  client: Add unregister-service command
  client: Add register-characteristic command
  client: Add unregister-characteristic command
  client: Add generic way to request input from user
  client: Ask user the characteristic value
  client: Add register-descriptor command
  client: Add unregister-descriptor command

 client/display.c |  58 ++++
 client/display.h |   5 +
 client/gatt.c    | 833 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 client/gatt.h    |  13 +
 client/main.c    | 154 +++++++++-
 5 files changed, 1000 insertions(+), 63 deletions(-)

-- 
2.9.4

