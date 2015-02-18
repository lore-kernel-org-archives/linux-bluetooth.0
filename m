Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 0/8] Rewrite local GATT server using shared/gatt
Date: Wed, 18 Feb 2015 00:18:31 -0800
Message-Id: <1424247519-21684-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v2: Rebased remaining patches.

*v1: Addressed comments by jamuraa and vudentz:
  - Now passing bt_att instead of bdaddr_t in gatt_db callbacks and functions.
    I have not run the tests on the android side here, so I would appreciate it
    if you can run them.
  - Renamed src/gatt-server to src/gatt-database for now. Added TODO item for
    refactoring this later.
  - Updated the TODO items for GATT.

This patch set includes patches that rewrite the local GATT server using
shared/gatt. This in effect invalidates the existing src/attrib-server in
favor of a new src/gatt-server.


Arman Uguray (8):
  core: adapter: Initialize GATT database
  core: Attach gatt-server to bt_att
  core: Add GATT UUIDs to Adapter1.UUIDs
  core: device: Add getter for GATT server
  core: gatt: Send not/ind to devices
  core: adapter: Send UUIDs changed for GATT services
  shared/gatt: Don't incorrectly terminate discovery
  TODO: Update GATT items.

 TODO                     | 54 ++++++++++++++++++---------------
 src/adapter.c            | 77 +++++++++++++++++++++++++++++++++++++++++-------
 src/adapter.h            |  2 ++
 src/device.c             | 55 ++++++++++++++++++++++++----------
 src/device.h             |  1 +
 src/gatt-database.c      | 25 ++++++++++++++--
 src/shared/gatt-client.c |  3 +-
 7 files changed, 162 insertions(+), 55 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

