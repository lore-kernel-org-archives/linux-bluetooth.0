Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 00/10] shared/gatt-client: Move GATT read/write functions.
Date: Wed,  3 Sep 2014 12:46:01 -0700
Message-Id: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set moves GATT read/write functions from shared/gatt-helpers to
shared/gatt-client. The following new functions are now available:

  bt_gatt_client_read_value
  bt_gatt_client_read_long_value
  bt_gatt_client_write_without_response
  bt_gatt_client_write_value
  bt_gatt_client_write_long_value

This patch set also adds new commands to tools/btgatt-client which map to the
functions above.

Arman Uguray (10):
  shared/gatt-client: Added bt_gatt_client_read_value.
  shared/gatt-client: Added bt_gatt_client_read_long_value.
  shared/gatt-client: Added simple write operations.
  shared/gatt-client: Added bt_gatt_client_write_long_value.
  TODO: GATT read/write functions moved to shared/gatt-client.
  tools/btgatt-client: Added the "read-value" command.
  tools/btgatt-client: Added the "read-long-value" command.
  tools/btgatt-client: Added the "write-value" command.
  tools/btgatt-client: Added the "write-long-value" command.
  TODO: tools/btgatt-client introduced

 TODO                      |  13 -
 src/shared/gatt-client.c  | 774 ++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-client.h  |  36 +++
 src/shared/gatt-helpers.c | 625 -------------------------------------
 src/shared/gatt-helpers.h |  30 --
 tools/btgatt-client.c     | 396 +++++++++++++++++++++++-
 6 files changed, 1160 insertions(+), 714 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

