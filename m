Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/3] Bluetooth: hci_bcm: Add wake-up and PM runtime support
Date: Wed,  9 Sep 2015 09:54:43 +0200
Message-Id: <1441785286-5840-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add wake-up capabilities by retrieveing interruption used by BCM device in ACPI
table.
Add PM runtime support.

v2->v3:
- Use DMI_EXACT_MATCH instead of DMI_MATCH
- Fix IRQ polarity for T100TA in driver_data of dmi_system_id struct
- Use dmi_first_match() instead of dmi_check_system()

v1->v2:
- Split 1st patch between general wake-up capability and T100TA IRQ fix
- Replace multiple "if ... else if" by switch in bcm_resource()
- Move code to limit number of #ifdef
- Use DMI info to restrict IRQ to T100TA
- Split 2nd patch to prepare PM runtime support in separated patch
- Tested with and without CONFIG_PM_SLEEP and CONFIG_PM.

Frederic Danis (3):
  Bluetooth: hci_bcm: Fix IRQ polarity for T100
  Bluetooth: hci_bcm: Prepare PM runtime support
  Bluetooth: hci_bcm: Add suspend/resume runtime PM functions

 drivers/bluetooth/hci_bcm.c | 203 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 171 insertions(+), 32 deletions(-)

-- 
1.9.1

