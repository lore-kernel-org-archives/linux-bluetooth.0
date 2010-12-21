Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 00/18] Making GATT a first class citizen
Date: Tue, 21 Dec 2010 19:26:22 -0200
Message-Id: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These are the first steps in the direction of making GATT a first
class citizen in Bluez.

For this, the first step is to move the primary service discovery
procedure to the core bluetoothd. For that we needed to move a lot of
code around, and add a few features, for example, we now are able to
store the remote device type and restore it from storage, it is useful
when deciding which medium should be used for service discovery.

While doing this, I noticed something that could cause some confusion:
in the Attribute API, both the Device Service hierarchy
([prefix]/{hci0}/{device0}/{service0}) and the Device Characteristic
([prefix]/{hci0}/{device0}/{service0}/{characteristic0}) have the same
Interface name (org.bluez.Characteristic). Is that on purpose?


Cheers,
--

Sheldon Demario (1):
  Move primary service storage to device.c

Vinicius Costa Gomes (17):
  Fix attrib plugin deregistration
  Fix memory leaks in the attrib-server
  Add a way to store the remote device type
  Add support for storing the device type
  Add support for creating devices from stored types
  Add support for creating devices from stored primary services
  Add a way to retrieve ATT primary services
  Remove GATT information when the device is removed
  Add the btd_ prefix to device_add_service
  Remove duplicated code for discovering GATT services
  Clean up the primary service DBus registration
  Add support for making LE connections to GATT client
  Add a Discover method to the GATT Client
  Remove GetCharacteristics DBus method
  Add support for adding services to the Services property
  Add GetProperties method the Service Interface
  Add a "services" command to test-device

 attrib/att.c        |    5 +
 attrib/att.h        |    7 +
 attrib/client.c     |  449 ++++++++++-----------------------------------------
 attrib/gattrib.c    |    1 +
 input/device.c      |    4 +-
 plugins/hciops.c    |    2 +-
 serial/port.c       |    2 +
 src/adapter.c       |  105 ++++++++++++
 src/attrib-server.c |    6 +
 src/device.c        |   82 +++++++++-
 src/device.h        |    6 +-
 src/glib-helper.c   |   23 ++-
 src/storage.c       |   40 +++++
 src/storage.h       |    3 +
 test/test-device    |   13 ++
 15 files changed, 366 insertions(+), 382 deletions(-)

--
1.7.3.4

