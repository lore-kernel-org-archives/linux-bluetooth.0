Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 00/15] Refactor read attribute values
Date: Wed, 14 May 2014 12:18:04 +0200
Message-Id: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will fix reading attributes values.
Changes comparing to v1:
 - Patches are splited to smaller parts
 - Coding style fixes pointed by Szymon
 - Fixes for sending values with different size (possible
	memory corruption)

Jakub Tyszkowski (1):
  android/gatt: Add find by type and value handler

Marcin Kraglak (14):
  shared/gatt: Extend gatt_db_read function
  android/gatt: Refactor ATT read operations
  shared/gatt: Modify gatt_db_read_by_type to return handles only
  android/gatt: Change handling read_by_type requests
  shared/gatt: Remove unused structure
  shared/gatt: Moify gatt_db_find_information to return list of handles
  shared/gatt: Add helper function to get attribute type
  android/gatt: Change handling of find_information requests
  shared/gatt: Remove unused structure
  shared/gatt: Add function to get end group handle
  shared/gatt: Retun list of handles in gatt_db_read_by_group_type
  android/gatt: Change handling of read_by_group_type requests
  shared/gatt: Remove unused structure
  shared/gatt: Make 'find_by_type_value' callback compatible

 android/gatt.c       | 613 ++++++++++++++++++++++++++++++++++++++++-----------
 src/shared/gatt-db.c | 135 ++++++------
 src/shared/gatt-db.h |  38 +---
 3 files changed, 562 insertions(+), 224 deletions(-)

-- 
1.9.0

