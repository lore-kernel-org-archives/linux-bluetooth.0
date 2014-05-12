Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Fix reading attribute value in database
Date: Mon, 12 May 2014 15:02:30 +0200
Message-Id: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is refactor of existing server and database.
Now all functions in gatt_db for processing ATT commands are changed
to fill queue with handles of found attributes only, and no specific
data is used. There are also getters for attribute type and end
group type. Gatt_db_read is also refactored to return value of attribute
if exists or call read_cb if registered. In first case we can fill response,
otherwise we have collect data from callbacks in pending_requests queue
(in device struct) and then send response.
We also consider passing read_result_cb to gatt_db_read(), it can simplify
collecting attributes values (data will be always passed to read_result_cb).
Also functions like gatt_db_find_by_type can be replaced in future with
one "filtering" function.

Jakub Tyszkowski (2):
  android/gatt: Fix sending att responses
  shared/gatt: Make 'find_by_type_value' callback compatible

Marcin Kraglak (6):
  shared/gatt: Extend gatt_db_read function
  android/gatt: Refactor ATT read operations
  shared/gatt: Make read by type use response queue
  shared/gatt: Refactor find information
  shared/gatt: Add function to get end group handle
  shared/gatt: Refactor read_by_group_type

 android/gatt.c       | 445 ++++++++++++++++++++++++++++++++++-----------------
 src/shared/gatt-db.c | 128 +++++++--------
 src/shared/gatt-db.h |  42 ++---
 3 files changed, 372 insertions(+), 243 deletions(-)

-- 
1.8.5.3

