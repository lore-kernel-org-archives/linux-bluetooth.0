Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/3] Fix for handling unpaired devices
Date: Thu, 28 Aug 2014 10:37:19 +0200
Message-Id: <1409215042-11313-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches fix scenario when remote device is unpaired and
paired again. Issue found when testing HOG where basically after
re-pair HOG was not functional.

v2:
* bt_unpaired_register returns bool
* unpaired callback provides also bdaddr type



Lukasz Rymanowski (3):
  android/bluetooth: Add unpaired device callback
  android/hidhost: Add remove bond handling
  android/gatt: Add remove bond handling

 android/bluetooth.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 android/bluetooth.h |  3 +++
 android/gatt.c      | 24 ++++++++++++++++++++++++
 android/hidhost.c   | 23 +++++++++++++++++++++++
 4 files changed, 92 insertions(+), 3 deletions(-)

-- 
1.8.4

