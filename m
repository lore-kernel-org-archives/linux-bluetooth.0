Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 0/7] Implement GATT server D-Bus API
Date: Tue,  3 Mar 2015 20:30:04 -0800
Message-Id: <1425443411-11958-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v3: - Rebased remaining patches and built them into src/gatt-database.c instead
       of src/gatt-manager.c.

     - Eliminated unnecessary lookups in CCC and notification related functions.

     - Added a fake Battery Service to tools/gatt-example.

Arman Uguray (7):
  core/gatt: Make CCC addition API public
  core/gatt: Create CCC for external characteristic
  core/gatt: Send not/ind for D-Bus characteristics
  core/gatt: Create CEP for external characteristic
  core/gatt: Register descriptors
  core/gatt: Support descriptor reads/writes
  tools: Added a Python example for GATT server API

 src/gatt-database.c | 718 ++++++++++++++++++++++++++++++++++++++++++++--------
 src/gatt-database.h |  11 +
 tools/gatt-example  | 533 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1153 insertions(+), 109 deletions(-)
 create mode 100755 tools/gatt-example

-- 
2.2.0.rc0.207.ga3a616c

