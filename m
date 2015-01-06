Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 0/8] Implmenet doc/gatt-api.txt for client
Date: Mon,  5 Jan 2015 18:03:28 -0800
Message-Id: <1420509816-1376-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1: Picking up remaining patches from before the holidays:
  - Rebased on top of Luiz's modifications.
  - Fixed small bugs that appeared after the merge.
  - Addressed some of the initial comments.
  - Added StartNotify/StopNotify. I left these methods as they are.
    I'm planning to address the issue with potentially missed
    notifications in a GattProfile1 API.

Arman Uguray (8):
  core: gatt: Expose charac. extended properties.
  core: gatt: Implement GattCharacteristic1.StartNotify
  core: gatt: Implement GattCharacteristic1.StopNotify
  shared/gatt-db: Add truncate argument to write
  core: gatt: Issue long write for reliable-write
  core: gatt: Reference count chrcs and descs.
  core: gatt: Handle Service Changed.
  doc/gatt-api.txt: Update error names

 android/gatt.c           |  17 +-
 doc/gatt-api.txt         |  12 +-
 src/device.c             |   4 +-
 src/gatt-client.c        | 609 ++++++++++++++++++++++++++++++++++++++++-------
 src/shared/gatt-db.c     |  18 +-
 src/shared/gatt-db.h     |   1 +
 src/shared/gatt-server.c |   6 +-
 tools/btgatt-server.c    |   8 +-
 unit/test-gatt.c         |   6 +-
 9 files changed, 569 insertions(+), 112 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

