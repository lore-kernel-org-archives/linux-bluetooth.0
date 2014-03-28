Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/9] android/gatt: Characteristic/Descriptors read and write
Date: Fri, 28 Mar 2014 19:54:36 +0100
Message-Id: <1396032885-32077-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set contains gatt characteristic and descriptors handling.

It start with gatt status reporting fix, as expected by Android GATT_FAILURE
does not map directly to HAL_STATUS.

Next two v2 patches are Gregorz's patches for characteristic read and write
rebased on top of the gatt status reporting fix.

Next goes descriptors get, read, write handling. The last patch is just
simple cleanup.

Grzegorz Kolodziejczyk (2):
  android/gatt: Handle read characteristic client command
  android/gatt: Handle write characteristic client command

Jakub Tyszkowski (7):
  android/gatt: Use proper GATT status
  android/gatt: Add queue for characteristic descriptors caching
  android/gatt: Handle get descriptor client command
  android/gatt: Search for descriptors and notify
  android/gatt: Add client read descriptor handler
  android/gatt: Add client write descriptor handler
  android/gatt: Simplify matching functions

 android/gatt.c | 805 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 777 insertions(+), 28 deletions(-)

--
1.9.0

