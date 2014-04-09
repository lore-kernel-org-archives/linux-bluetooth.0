Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 00/16] Gatt database initial implementation
Date: Wed,  9 Apr 2014 09:06:58 +0200
Message-Id: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is proposal how gatt database implementation could look and
how it can be used in Android. Current implementation contains:
 - create/destroy gatt_db
 - adding services, with given number of handles. This function returns
	service attribute andle
 - adding characteristics, descriptors and included services
 - function to start/stop service - it will be used when we expose services
	to client

Next steps in gatt_db implementation should be:
 - handling read/write callbacks
 - handling attribute's permissions
 - now we just increment available handle. We should check if we have free handles
	between existing services

Comments are welcome
Marcin Kraglak

Marcin Kraglak (16):
  gatt: Add skeleton of gatt-db
  gatt: Add services list to gatt_db struct
  gatt: Add method for creating services in gatt_db
  gatt: Remove service functionality
  gatt: Add new sharacteristic functionality
  gatt: Add characteristic descriptor method
  gatt: Add included service functionality
  android/gatt: Add service functionality
  android/gatt: Add implementation of delete service
  android/gatt: Add included service implementation
  android/gatt: Add characteristic implementation
  android/gatt: Add descriptor implementation
  gatt: Add start/stop service functionality
  android/gatt: Add handling of start service command
  android/gatt: Add stop service command handling
  android/gatt: Fix typo in event handlers array

 android/Android.mk   |   1 +
 android/Makefile.am  |   1 +
 android/gatt.c       | 242 +++++++++++++++++++++++++++++++-
 android/hal-gatt.c   |   2 +-
 src/shared/gatt-db.c | 388 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  67 +++++++++
 6 files changed, 693 insertions(+), 8 deletions(-)
 create mode 100644 src/shared/gatt-db.c
 create mode 100644 src/shared/gatt-db.h

-- 
1.8.5.3

