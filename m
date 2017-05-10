Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/10] Optimize discovery
Date: Wed, 10 May 2017 15:48:25 +0300
Message-Id: <20170510124835.17462-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reduces quite a bit the complexity of GATT discovery while
reducing the amount traffic, this is achieved by using breadth-first
like lookup.

Bellow is the traces with using Zephyr peripheral sample which
uses a somewhat small MTU (65 bytes), it probably has even better
results when using bigger MTU. 

v2: Fix failing when attribute have already been discovered, result
are pretty much the same except for the range is now adjusted properly.

Luiz Augusto von Dentz (10):
  shared/gatt-db: Add gatt_db_get_service
  shared/gatt-db: Add gatt_db_service_insert_included
  shared/gatt-client: Insert included attribute with handle
  shared/gatt-db: Add gatt_db_insert_included
  shared/gatt-client: Simplify included discovery
  unit/test-gatt: Adjust the PDUs to the new behavior
  shared/gatt-db: Add gatt_db_insert_characteristic
  shared/gatt-db: Add gatt_db_insert_descriptor
  shared/gatt-client: Simplify characteristics discovery
  unit/test-gatt: Adjust the PDUs for characteristic discovery

 src/shared/gatt-client.c | 257 ++++++++++++++---------------------------------
 src/shared/gatt-db.c     | 116 +++++++++++++++++++--
 src/shared/gatt-db.h     |  30 ++++++
 unit/test-gatt.c         |  80 ++++++---------
 4 files changed, 245 insertions(+), 238 deletions(-)

-- 
2.9.3

