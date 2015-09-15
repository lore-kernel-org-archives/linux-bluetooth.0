Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/5] Bluetooth: hci_bcm: Add wake-up and PM runtime support
Date: Tue, 15 Sep 2015 10:31:03 +0200
Message-Id: <1442305868-6203-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add wake-up capabilities by retrieveing interruption used by BCM device in ACPI
table.
Add PM runtime support.

v3->v4:
- Add new BT_WARN and bt_dev_warn logging macros
- Use bt_dev_warn for T100 irq polarity fix
- Rename __bcm_suspend to bcm_suspend_device,
    and __bcm_resume to bcm_resume_device
- Remove useless rx_lock spinlock. It is only used in hci_uart_tty_receive() which
    is the receive_buf ldisc callback. This is already protected by flush_to_ldisc()
    in drivers/tty/tty_buffer.c.
    This allows to use mutex in bcm_recv() and call pm_runtime_* directly
- Remove pm_work Work queue which is now useless
- Delay auto-suspend only when reception of a packet is completed

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

Frederic Danis (5):
  Bluetooth: Add BT_WARN and bt_dev_warn logging macros
  Bluetooth: hci_bcm: Fix IRQ polarity for T100
  Bluetooth: hci_bcm: Prepare PM runtime support
  Bluetooth: Remove useless rx_lock spinlock
  Bluetooth: hci_bcm: Add suspend/resume runtime PM functions

 drivers/bluetooth/hci_bcm.c       | 189 +++++++++++++++++++++++++++++++-------
 drivers/bluetooth/hci_ldisc.c     |   5 -
 drivers/bluetooth/hci_uart.h      |   1 -
 include/net/bluetooth/bluetooth.h |   3 +
 4 files changed, 159 insertions(+), 39 deletions(-)

-- 
1.9.1

