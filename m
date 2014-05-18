Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/5] android: Pairing improvements
Date: Sun, 18 May 2014 13:53:55 +0200
Message-Id: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This improves (fix) the way dual mode devices are handled. Bearer type is
now tracked and allows to use correct one for dual mode device.

This also adds tracking if remote device was bonded or not. This is in
preparation for fixing no bond pairing. Android HAL does not distinguish
between pairing and bonding and appears to be ignoring bond state change
bonded->no_bond from stack. This leads to situation when device is no longer
paired (after being disconnected) but still being listed as bonded in
Android Framework. Possible solution would be to not call bond_state change
to bonded for no bond case (this seems to be what Bluedroid is doing [1])
but this still needs further analyze and testing.

BR
Szymon Janc


[1] http://androidxref.com/4.4.2_r1/xref/external/bluetooth/bluedroid/btif/src/btif_dm.c#338

Szymon Janc (5):
  android/bluetooth: Track device last connected bearer
  android/bluetooth: Fix pairing of dual mode devices
  android/bluetooth: Fix unpairing dual mode device
  android/bluetooth: Track if paired device is bonded
  android/bluetooth: Simplify check if device type changed

 android/bluetooth.c | 315 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 233 insertions(+), 82 deletions(-)

-- 
1.9.0

