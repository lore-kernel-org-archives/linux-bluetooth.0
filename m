Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 22 Sep 2010 16:37:15 -0400
Message-ID: <AANLkTimxWsv_6809nrodxcPkhwdcuc8kVFCWM5JcYv68@mail.gmail.com>
Subject: Pull request: git://gitorious.org/~lizardo/bluez/lizardo-bluez.git for-upstream
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following changes since commit a5e1be914ba5480f9eae7ab9dc31e30524f74182:
  Claudio Takahasi (1):
        Fix uninitialised value warning

are available in the git repository at:

  git://gitorious.org/~lizardo/bluez/lizardo-bluez.git for-upstream

Claudio Takahasi (13):
      Add g_attrib_set_destroy_function in gattrib
      Use the destroy function to reset the GAttrib reference
      Increment GAttrib reference for each GATT/ATT request
      Fix disconnection when multiple watchers are registered
      Fix seg fault if the watcher exit before the connection complete
      Add UnregisterCharacteristicsWatcher implementation
      Unregister the primary and characteristic objects
      Fix memory leak of characteristic and primary service lists
      Remove the timeout source function when the example server exits
      Delete all stored data related to GATT/ATT when the device is removed
      Fix wrong D-Bus object path for Device Service
      Add a new property "Services" on the Device object
      Fix coding style issues in attribute client code

 attrib/client.c       |  278 +++++++++++++++++++++++++++++++------------------
 attrib/example.c      |    9 ++-
 attrib/example.h      |    1 +
 attrib/gattrib.c      |   35 ++++--
 attrib/gattrib.h      |    3 +
 attrib/manager.c      |    1 +
 doc/attribute-api.txt |    3 +-
 doc/device-api.txt    |    4 +
 src/attrib-server.c   |   11 ++-
 src/device.c          |    1 +
 src/storage.c         |   68 ++++++++++++
 src/storage.h         |    1 +
 12 files changed, 297 insertions(+), 118 deletions(-)

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
