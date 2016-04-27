Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Set RSSI_THRESHOLD to 2
Date: Wed, 27 Apr 2016 10:01:47 +0200
Message-Id: <1461744108-21366-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


This CL sets the RSSI_THRESHOLD value to 2 from it's original
value of 8. This is still useful for BR/EDR discovery when an
unfiltered scan is being done.

Source: https://chromium.googlesource.com/chromiumos/third_party/bluez/+/2a8288d4146a7b6f85687562ec6047564fd224a0

Francois Beaufort (1):
  Set RSSI_THRESHOLD to 2

 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.0

