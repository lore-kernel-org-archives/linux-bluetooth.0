Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/3] Fix for handling unpaired devices
Date: Wed, 27 Aug 2014 22:47:41 +0200
Message-Id: <1409172464-30369-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches fix scenario when remote device is unpaired and
paired again. Issue found when testing HOG where basically after
re-pair HOG was not functional.

Lukasz Rymanowski (3):
  android/bluetooth: Add unpaired device callback
  android/hidhost: Add remove bond handling
  android/gatt: Add remove bond handling

 android/bluetooth.c | 38 ++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |  3 +++
 android/gatt.c      | 18 ++++++++++++++++++
 android/hidhost.c   | 20 ++++++++++++++++++++
 4 files changed, 79 insertions(+)

-- 
1.8.4

