Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 0/8] Implement doc/gatt-api.txt for client
Date: Tue, 13 Jan 2015 19:30:59 -0800
Message-Id: <1421206267-26369-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v3:
  - Fixed broken GATT service UUID management in its own patch.
  - Other small fixes.

Arman Uguray (8):
  shared/gatt-db: Add service getter by UUID
  core: device: Fix GATT profile probing
  core: device: Fix broken GATT UUID management
  profiles/gap: Fix probe/accept behavior.
  core: service: Remove GATT handle logic
  shared/gatt-db: Add "claimed" field to services
  core: gatt: Use "claimed" instead of "active"
  doc/gatt-api.txt: Update error names

 doc/gatt-api.txt     |  12 +-
 plugins/sixaxis.c    |   2 +-
 profiles/gap/gas.c   | 127 +++++++------
 src/adapter.c        |   8 +-
 src/device.c         | 498 +++++++++++++++++++++++++++++----------------------
 src/device.h         |   6 +-
 src/gatt-client.c    |   9 +-
 src/service.c        |  38 ----
 src/service.h        |   7 -
 src/shared/gatt-db.c |  46 +++++
 src/shared/gatt-db.h |   7 +
 11 files changed, 428 insertions(+), 332 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

