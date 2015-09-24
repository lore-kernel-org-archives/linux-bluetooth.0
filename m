Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v5 0/5] Bluetooth: hci_bcm: Add wake-up and PM runtime support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 24 Sep 2015 16:35:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FE05BE0F-96DF-4C7A-B543-23716400E65E@holtmann.org>
References: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add wake-up capabilities by retrieveing interruption used by BCM device in ACPI
> table.
> Add PM runtime support.
> 
> v4->v5:
> - Add bt_warn to to unify Bluetooth traces in BT_WARN
> - Change bcm_suspend_device/bcm_resume_device prototype to be usable directly
>  in SET_RUNTIME_PM_OPS. This allows to remove bcm_runtime_suspend/bcm_runtime_resume
>  which just call bcm_suspend_device/bcm_resume_device.
> - Update commit message and add comment in hci_uart_tty_receive to explain 
>  why spin_lock is not requested
> 
> v3->v4:
> - Add new BT_WARN and bt_dev_warn logging macros
> - Use bt_dev_warn for T100 irq polarity fix
> - Rename __bcm_suspend to bcm_suspend_device,
>    and __bcm_resume to bcm_resume_device
> - Remove useless rx_lock spinlock. It is only used in hci_uart_tty_receive() which
>    is the receive_buf ldisc callback. This is already protected by flush_to_ldisc()
>    in drivers/tty/tty_buffer.c.
>    This allows to use mutex in bcm_recv() and call pm_runtime_* directly
> - Remove pm_work Work queue which is now useless
> - Delay auto-suspend only when reception of a packet is completed
> 
> v2->v3:
> - Use DMI_EXACT_MATCH instead of DMI_MATCH
> - Fix IRQ polarity for T100TA in driver_data of dmi_system_id struct
> - Use dmi_first_match() instead of dmi_check_system()
> 
> v1->v2:
> - Split 1st patch between general wake-up capability and T100TA IRQ fix
> - Replace multiple "if ... else if" by switch in bcm_resource()
> - Move code to limit number of #ifdef
> - Use DMI info to restrict IRQ to T100TA
> - Split 2nd patch to prepare PM runtime support in separated patch
> - Tested with and without CONFIG_PM_SLEEP and CONFIG_PM.
> 
> Frederic Danis (5):
>  Bluetooth: Add BT_WARN and bt_dev_warn logging macros
>  Bluetooth: hci_bcm: Fix IRQ polarity for T100
>  Bluetooth: hci_bcm: Prepare PM runtime support
>  Bluetooth: Remove useless rx_lock spinlock
>  Bluetooth: hci_bcm: Add suspend/resume runtime PM functions
> 
> drivers/bluetooth/hci_bcm.c       | 171 +++++++++++++++++++++++++++++++-------
> drivers/bluetooth/hci_ldisc.c     |   8 +-
> drivers/bluetooth/hci_uart.h      |   1 -
> include/net/bluetooth/bluetooth.h |   5 ++
> net/bluetooth/lib.c               |  16 ++++
> 5 files changed, 164 insertions(+), 37 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

