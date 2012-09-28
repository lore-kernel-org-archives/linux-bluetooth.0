Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 0/4] Fix losing Service Changed indication
Date: Fri, 28 Sep 2012 11:47:50 -0300
Message-Id: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Apply after:
"gatt: Remove reading Service Changed characteristic after connected"
sent from Andrzej Kaczmarek

This patch series adds Service Changed characteristic handle storage
allowing GATT service to manage Service Changed indication when the
connection is established.

The patch to remove the entry from "gatt" file will be sent in the next
patch series. It is unclear to me if we need to extend the device or
profile drive to indicate that the device is being removed/purged from
the system or if the expected implementation is to move to per-device
storage(TODO file). At the moment, it is not possible to detect in the
drivers remove callback if the device is being removed from the system
or if it bluetoothd is exiting.


Claudio Takahasi (4):
  gatt: Remove unneeded handle range check
  gatt: Ignore Service Changed if not bonded
  gatt: Add storing Service Changed handle
  gatt: Add reading stored Service Changed handle

 profiles/gatt/gas.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 7 deletions(-)

-- 
1.7.12

