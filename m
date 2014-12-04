Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/2] unit/gatt: Replace custom structs with gatt_db
Date: Thu,  4 Dec 2014 09:03:53 -0800
Message-Id: <1417712635-12428-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches replace the custom structs in test-gatt with building an
appropriate gatt_db and comparing the rebuilt client gatt_db with the source.

This set replaces service_data_1 with a gatt_db made by make_service_1_db(),
which is still closely tied to the SERVICE_DATA_1_PDU.

Michael Janssen (2):
  unit/gatt: Use gatt_db for test data
  Remove unused old test db structures

 unit/test-gatt.c | 425 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 226 insertions(+), 199 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

