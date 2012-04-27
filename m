Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH RFC 0/4] Reference implementation for DBUS.Properties
Date: Fri, 27 Apr 2012 18:54:02 -0300
Message-Id: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reference implementation for org.freedesktop.DBus.Properties.* in
manager, device, adapter and thermometer using de Marchi's getter/setter
implementation.

Notes:
* Current GetProperties/SetPropety implementations flagged as deprecated
* Current implementation for the "Icon" property in device.c has a potential
assignment to an uninitialized value (when both read_remote_class and
read_remote_appearance return error). In the new implementation, this case
is handled as a non existent property.
* The new implementation separates the exists() logic from the actual
read/write and since the "Icon" and "Class" properties in device.c are read
from a file, the new implementation reads the file twice. If it's better
(and safe) to move the properties to some allocated structure, I can change
the code.
* In functions that return arrays (get_property_uuids, get_property_services,
etc) I keep the extra array allocation from the current code, but if it's not
desired, I can remove it.


Henrique Dante de Almeida (4):
  manager: implement support for DBus.Properties.Get
  thermometer: implement support for DBus.Properties.Get and
    DBus.Properties.Set
  adapter: implement DBus.Properties
  device: implement DBus.Properties

 src/adapter.c             |  280 +++++++++++++++++++++++++++++++++
 src/device.c              |  384 ++++++++++++++++++++++++++++++++++++++++++++-
 src/manager.c             |   31 ++++-
 thermometer/thermometer.c |   86 ++++++++++-
 4 files changed, 772 insertions(+), 9 deletions(-)

-- 
1.7.5.4

