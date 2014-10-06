Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 0/5] Introduce shared/gatt-server.
Date: Mon,  6 Oct 2014 14:01:40 -0700
Message-Id: <1412629304-3391-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1:
  - Make gatt-db external to gatt-server, as initially discussed.
  - Also implement Read By Group Type request.

Arman Uguray (5):
  Revert "plugins/sixaxis: Add a set_leds_sysfs() function"
  shared/att: Drop the connection is a request is received while one is
    pending.
  shared/gatt-server: Introduce shared/gatt-server.
  shared/gatt-server: Support Exchange MTU request.
  shared/gatt-server: Support Read By Group Type request.

 Makefile.am              |   1 +
 configure.ac             |   4 +-
 plugins/sixaxis.c        |  89 +-----------
 src/shared/att.c         | 101 ++++++++------
 src/shared/gatt-server.c | 347 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-server.h |  40 ++++++
 6 files changed, 455 insertions(+), 127 deletions(-)
 create mode 100644 src/shared/gatt-server.c
 create mode 100644 src/shared/gatt-server.h

-- 
2.1.0.rc2.206.gedb03e5

