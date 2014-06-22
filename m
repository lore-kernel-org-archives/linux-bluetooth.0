Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/7] android: Add support for RPA resolution
Date: Sun, 22 Jun 2014 22:47:00 +0200
Message-Id: <1403470027-24720-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This adds support for handling RPA. Android HAL API has no means for
notifying address change. When new ID address is resolved it is stored
and map to RPA. Android HALs can still use RPA for connecting,
unpairing etc. When bluetoothd is restarted device is advertised to
Framework with ID address. This makes whole RPA Resolution Procedure
transparent to Android.

Tested with iOS 7.1.1 and LightBlue application.

Comments are welcome.

BR
Szymon Janc

Szymon Janc (7):
  android/bluetooth: Add helper for finding device with android address
  android/bluetooth: Pass device to send_bond_state_change function
  android/bluetooth: Fix passing address type to SSP replies
  android/bluetooth: Add get_device_android_addr helper
  android/bluetooth: Map RPA to Identity address on New IRK event
  android/gatt: Use proper address when connecting
  android/bluetooth: Log error if loading LTKs or IRKs failed

 android/bluetooth.c | 247 +++++++++++++++++++++++++++++++++++++++-------------
 android/bluetooth.h |   2 +
 android/gatt.c      |  16 +++-
 3 files changed, 201 insertions(+), 64 deletions(-)

-- 
1.9.3

