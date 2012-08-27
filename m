Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 00/33] Broadcaster/Observer implementation
Date: Mon, 27 Aug 2012 13:02:52 -0400
Message-Id: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series contains the implementation for Broadcaster/Observer roles. It has
changes for adapter API, userspace implementation for MGMT API and new commands
in btmgmt tool.

The kernel patches for new MGMT commands were sent few weeks ago by Jefferson
Delfes: http://thread.gmane.org/gmane.linux.bluez.kernel/28228.

For now, only Service Data and Manufacturer Specific Data can be
broadcasted/observed. All other data types defined by BT SIG are not
appropriate for general application use, and should be managed by BlueZ itself.

For Observer role, we have:
* Two methods to register watchers: RegisterServiceObserver() and
  RegisterManufacturerObserver().
* Respective methods to unregister watchers: UnregisterServiceObserver() and
  UnregisterManufacturerObserver()
* The data received are sent to application through ServiceReceived() and/or
  ManufacturerReceived().

An application can register only a observer watcher for each type: one for
Service Data and one for Manufacturer Specific Data. Both types can be enabled
for the same watcher.

For Broadcaster role, we have:
* Two methods to set data in controller: SetServiceData() and
  SetManufacturerData().
* One method for releasing any previously set Advertising data:
  ClearBroadcastData().

The same application can set a new Service Data and a new Manufacturer Specific
Data. To update any data set previously, the application should use
SetServiceData() or SetManufacturerData() using same Service UUID or Company
Identifier Code, respectively. Using ClearBroadcastData() will clean all data
set by application.

For MGMT API, new functions were implemented for Set Observer, Set Broadcaster,
Set Controller Data and Unset Controller Data (see doc/mgmt-api.txt for
details).


Anderson Lizardo (1):
  mgmt-api: Broadcaster/Observer management API

Bruna Moreira (18):
  lib: Add set broadcaster operation
  btmgmt: Add set observer command
  btmgmt: Add set controller data support
  btmgmt: Add unset controller data support
  doc: Add Observer D-Bus API documentation
  observer: Add UnregisterServiceObserver() D-Bus method
  observer: Add RegisterManufacturerObserver() D-Bus method
  observer: Add UnregisterManufacturerObserver() D-Bus method
  observer: Add watchers and filters for observers
  observer: Add ServiceReceived() and ManufacturerReceived() D-Bus
    method
  observer: Add python test script
  doc: Add Broadcaster D-Bus API documentation
  lib: Maximum value to advertising and scan response
  broadcaster: Add SetManufacturerData() D-Bus method
  broadcaster: Build and send ADV/EIR data blob to kernel
  broadcaster: Add ClearBroadcastData() D-Bus method
  broadcaster: Update some data of already broadcast value
  broadcaster: Add python test script

Jefferson Delfes (14):
  lib: Add set controller data operation
  lib: Add unset controller data operation
  lib: Add set observer operation
  btmgmt: Add set broadcaster support
  mgmt: Add set observer command
  mgmt: Add set broadcaster command
  mgmt: Add set controller data command
  mgmt: Add unset controller data command
  adapter: Add D-Bus API for Observer GAP Role
  observer: Add RegisterServiceObserver() D-Bus method
  eir: Add manufacturer and service data fields
  adapter: Add D-Bus API for Broadcaster GAP Role
  broadcaster: Add SetServiceData() D-Bus method
  broadcaster: Add list of broadcasters session

 doc/adapter-api.txt   |  120 ++++++++
 doc/mgmt-api.txt      |   64 ++++
 lib/hci.h             |    6 +-
 lib/mgmt.h            |   26 ++
 src/adapter.c         |  775 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/bluetooth.conf    |    1 +
 src/eir.c             |   43 +++
 src/eir.h             |   19 ++
 src/mgmt.c            |   64 ++++
 src/mgmt.h            |    6 +
 test/test-broadcaster |   76 +++++
 test/test-observer    |   87 ++++++
 tools/btmgmt.c        |  136 +++++++++
 13 files changed, 1421 insertions(+), 2 deletions(-)
 create mode 100755 test/test-broadcaster
 create mode 100755 test/test-observer

-- 
1.7.9.5

