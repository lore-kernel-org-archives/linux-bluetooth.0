Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/8] core/gatt: Introduce encryption flags
Date: Mon, 27 Apr 2015 16:14:27 +0300
Message-Id: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set introduce encryption flags to GattCharacteristic and
GattDescriptor along with the necessary changes to bt_gatt_server to
honor them.

In addition to that example-gatt-server has been updated to include
attributes that makes use of the new flags.

The following is the output using bluetoothctl to navigate in the new
attributes introduced to example-gatt-server:

[Vudentz's T440s:/service0016/char001c]# attribute-info 
Characteristic - Vendor specific
	UUID: 12345678-1234-5678-1234-56789abcdef1
	Service: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016
	Notifying: no
	Flags: read
	Flags: write
	Flags: extended-properties
	Flags: writable-auxiliaries
	Descriptors: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char001c/desc001e
	Descriptors: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char001c/desc001f
	Descriptors: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char001c/desc0020
[Vudentz's T440s:/service0016/char001c]# select-attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017
[Vudentz's T440s:/service0016/char0017]# attribute-info 
Characteristic - Vendor specific
	UUID: 12345678-1234-5678-1234-56789abcdef3
	Service: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016
	Notifying: no
	Flags: read
	Flags: write
	Flags: extended-properties
	Descriptors: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017/desc0019
	Descriptors: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017/desc001a
	Descriptors: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017/desc001b
[Vudentz's T440s:/service0016/char0017]# read
Attempting to read /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017
Failed to read: org.bluez.Error.NotPermitted
[Vudentz's T440s:/service0016/char0017]# write 00
Attempting to write /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017
Failed to write: org.bluez.Error.NotPermitted
[Vudentz's T440s:/service0016/char0017]# select-attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017/desc001a
[Vudentz's T440s:/service0016/char0017/desc001a]# attribute-info 
Descriptor - Vendor specific
	UUID: 12345678-1234-5678-1234-56789abcdef4
	Characteristic: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017
[Vudentz's T440s:/service0016/char0017/desc001a]# read
Attempting to read /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017/desc001a
Failed to read: org.bluez.Error.NotPermitted
[Vudentz's T440s:/service0016/char0017/desc001a]# write 00
Attempting to write /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0016/char0017/desc001a
Failed to write: org.bluez.Error.NotPermitted

Luiz Augusto von Dentz (8):
  doc/gatt-api: Add encryption flags
  core/gatt: Add support for encryption flags
  shared/att: Add own security definitions
  shared/gatt-server: Check attribute permissions
  doc/gatt-api: Add Flags property to GattDescriptor
  shared/gatt: Drop CHRC term of properties define
  core/gatt: Add Flags property to GattDescriptor
  test/example-gatt-server: Add encrypt attributes

 doc/gatt-api.txt         |  18 +++++
 src/gatt-client.c        |  32 ++++----
 src/gatt-database.c      | 185 +++++++++++++++++++++++++++++++++++------------
 src/shared/att-types.h   |  51 +++++++++----
 src/shared/att.c         |   2 +-
 src/shared/gatt-client.c |   4 +-
 src/shared/gatt-server.c |  93 +++++++++++++-----------
 test/example-gatt-server |  52 ++++++++++++-
 tools/btgatt-server.c    |  14 ++--
 unit/test-gatt.c         | 148 ++++++++++++++++++-------------------
 10 files changed, 392 insertions(+), 207 deletions(-)

-- 
2.1.0

