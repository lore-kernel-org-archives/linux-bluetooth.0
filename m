Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: hci_bcm: Add wake-up and PM runtime support
Date: Fri, 28 Aug 2015 16:31:17 +0200
Message-Id: <1440772279-9015-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add wake-up capabilities by retrieveing interruption used by BCM device in ACPI
table.

Replace spinlock by mutex to be able to use pm_runtime_...() functions.

This patches should be applied over "Bluetooth: hci_bcm: Fix crash on suspend".

Frederic Danis (2):
  Bluetooth: hci_bcm: Add wake-up capability
  Bluetooth: hci_bcm: Add suspend/resume runtime PM functions

 drivers/bluetooth/hci_bcm.c | 335 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 286 insertions(+), 49 deletions(-)

-- 
1.9.1

