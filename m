Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/4] Gatt database skeleton
Date: Thu, 24 Apr 2014 13:23:43 +0200
Message-Id: <1398338627-32588-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes in v2:
 - removed doxygen comments
 - in new_service method num_handle must be 1 or greater
 - removed coding-style errors

Marcin Kraglak (4):
  gatt: Add skeleton of gatt-db
  gatt: Add services list to gatt_db struct
  gatt: Add method for creating services in gatt_db
  gatt: Add remove_service function to gatt-db

 android/Android.mk   |   1 +
 android/Makefile.am  |   1 +
 src/shared/gatt-db.c | 193 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  31 +++++++++
 4 files changed, 226 insertions(+)
 create mode 100644 src/shared/gatt-db.c
 create mode 100644 src/shared/gatt-db.h

-- 
1.8.5.3

