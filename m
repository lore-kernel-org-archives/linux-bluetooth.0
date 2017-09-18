Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/10] gatt:  Add server support for AcquireWrite and AcquireNotify
Date: Mon, 18 Sep 2017 15:39:51 +0300
Message-Id: <20170918124001.2617-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements similar mechanist to use dedicated file descriptors
for IO bypassing D-Bus.

Note: The current implementation opens just one fd per characteristic,
though it could be possible to have one fd per device.

Luiz Augusto von Dentz (10):
  gatt: Remove useless debug
  client: Rework variables for AcquireWrite/AcquireNotify
  doc/gatt-api: Add server support for AcquireWrite and AcquireNotify
  shared/gatt-server: Add bt_gatt_server_get_mtu
  shared/gatt-db: Add gatt_db_attribute_get_user_data
  gatt: Implement AcquireWrite for server
  client: Implement AcquireWrite for server
  gatt: Implement AcquireNotify for server
  client: Implement AcquireNotify for server
  gatt: Update signature of AcquireWrite and AcquireNotify

 client/gatt.c            | 319 ++++++++++++++++++++++++++++++++++++++++-------
 doc/gatt-api.txt         |  22 +++-
 mesh/gatt.c              |  23 +++-
 src/gatt-client.c        |   8 +-
 src/gatt-database.c      | 260 +++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-db.c     |   8 ++
 src/shared/gatt-db.h     |   2 +
 src/shared/gatt-server.c |   8 ++
 src/shared/gatt-server.h |   1 +
 9 files changed, 590 insertions(+), 61 deletions(-)

-- 
2.13.5

