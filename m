Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/4] Bluetooth: hci_bcm: Add wake-up and PM runtime support
Date: Fri,  4 Sep 2015 15:35:43 +0200
Message-Id: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add wake-up capabilities by retrieveing interruption used by BCM device in ACPI
table.
Add PM runtime support.

v1->v2:
- Split 1st patch between general wake-up capability and T100TA IRQ fix
- Replace multiple "if ... else if" by switch in bcm_resource()
- Move code to limit number of #ifdef
- Use DMI info to restrict IRQ to T100TA
- Split 2nd patch to prepare PM runtime support in separated patch
- Tested with and without CONFIG_PM_SLEEP and CONFIG_PM.

Frederic Danis (4):
  Bluetooth: hci_bcm: Add wake-up capability
  Bluetooth: hci_bcm: Fix IRQ polarity for T100
  Bluetooth: hci_bcm: Prepare PM runtime support
  Bluetooth: hci_bcm: Add suspend/resume runtime PM functions

 drivers/bluetooth/hci_bcm.c | 348 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 312 insertions(+), 36 deletions(-)

-- 
1.9.1

