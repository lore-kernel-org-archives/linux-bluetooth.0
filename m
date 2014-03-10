Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 00/16] Add basic GATT characteristics
Date: Mon, 10 Mar 2014 15:50:29 -0300
Message-Id: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds the following features:
  * register external characteristics
  * basic read or write external characteristics

Usage of glib is being avoided inside src/gatt.c. Properties/flags is not
implemented yet.

How to test:
It is possible to test the implemented features using a modified
gatttool version. Unix socket is used as transport to allow basic
ATT operations: 
git://git.infradead.org/users/cktakahasi/bluez.git gatt-api-forupstream-group2-patchv0-testing

$gatttool -I -L
[LOCAL][LE]> connect
Local connection
Connection successful
[LOCAL][LE]> primary
attr handle: 0x0001, end grp handle: 0x0003 uuid: 000034fb-0000-1000-8000-00805f9b34fb
[LOCAL][LE]> characteristics
handle: 0x0002, char properties: 0x00, char value handle: 0x0003, uuid: 00002a06-0000-1000-8000-00805f9b34fb
[LOCAL][LE]> char-read-hnd 0x0003
Characteristic value/descriptor: 00 
[LOCAL][LE]> char-write-req 0x0003 02
Characteristic value was written successfully
[LOCAL][LE]> char-read-hnd 0x0003
Characteristic value/descriptor: 02 

Alvaro Silva (3):
  tools: Add Alert Level characteristic to gatt-service
  tools: Add reading Value property of gatt-service
  tools: Add setting Value property of gatt-service

Andre Guedes (2):
  gatt: Add function to create constant attributes
  gatt: Add helper for creating GATT characteristics

Claudio Takahasi (11):
  gatt: Add characteristic to the database
  gatt: Add hash table of GDBusProxy objects
  gatt: Add read callback to btd_gatt_add_char helper
  gatt: Assign read callback for external services
  gatt: Add helper for reading characteristics
  gatt: Add write callback to btd_gatt_add_char helper
  gdbus: Add g_dbus_proxy_set_property_array
  gatt: Assign write callback for external services
  gatt: Add result callback for Write Request
  gatt: Add Write Request handling for GDBusProxy
  tools: Emit property changed when Value changes

 gdbus/client.c       |  85 +++++++++++++++++++++++
 gdbus/gdbus.h        |   5 ++
 src/gatt-dbus.c      | 189 +++++++++++++++++++++++++++++++++++++++++++++++++--
 src/gatt.c           | 138 +++++++++++++++++++++++++++++++++++--
 src/gatt.h           |  52 ++++++++++++++
 tools/gatt-service.c | 157 ++++++++++++++++++++++++++++++++++++++----
 6 files changed, 604 insertions(+), 22 deletions(-)

-- 
1.8.3.1

