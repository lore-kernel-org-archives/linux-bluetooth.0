Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/4] Gatt attributes database skeleton
Date: Wed, 16 Apr 2014 09:19:03 +0200
Message-Id: <1397632747-13308-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set introduce gatt database skeleton for storing local attributes.
Now functionality for creating, destroying database and adding/removing
services is provided.
In comparision to RFC version, comments are added in header file, and type
of sevice enum was replaced with bool "primary".

Comments are welcome

Marcin Kraglak (4):
  gatt: Add skeleton of gatt-db
  gatt: Add services list to gatt_db struct
  gatt: Add method for creating services in gatt_db
  gatt: Add remove_service function to gatt-db

 android/Android.mk   |   1 +
 android/Makefile.am  |   1 +
 src/shared/gatt-db.c | 189 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  63 +++++++++++++++++
 4 files changed, 254 insertions(+)
 create mode 100644 src/shared/gatt-db.c
 create mode 100644 src/shared/gatt-db.h

-- 
1.8.5.3

