Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 00/15] Refactor reading attributes type
Date: Thu, 15 May 2014 15:02:22 +0200
Message-Id: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes in v4:
 - fixed function names and coding style issues
 - Added macros with state of reading operation: READ_INIT,
        READ_PENDING and READ_DONE and READ_FAILED

Jakub Tyszkowski (1):
  android/gatt: Add find by type and value handler

Marcin Kraglak (14):
  shared/gatt: Extend gatt_db_read function
  android/gatt: Refactor ATT read operations
  shared/gatt: Modify gatt_db_read_by_type to return handles only
  android/gatt: Change handling read_by_type requests
  shared/gatt: Remove unused structure
  shared/gatt: Modify gatt_db_find_information to return list of handles
  shared/gatt: Add helper function to get attribute type
  android/gatt: Change handling of find_information requests
  shared/gatt: Remove unused structure
  shared/gatt: Add function to get end group handle
  shared/gatt: Retun list of handles in gatt_db_read_by_group_type
  android/gatt: Change handling of read_by_group_type requests
  shared/gatt: Remove unused structure
  shared/gatt: Make 'find_by_type_value' callback compatible

 android/gatt.c       | 667 +++++++++++++++++++++++++++++++++++++++------------
 src/shared/gatt-db.c | 135 ++++++-----
 src/shared/gatt-db.h |  38 +--
 3 files changed, 591 insertions(+), 249 deletions(-)

-- 
1.9.0

