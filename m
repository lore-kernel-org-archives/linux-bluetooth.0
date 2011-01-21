Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 21 Jan 2011 00:51:34 -0500
Message-ID: <AANLkTi=z1DPguiO7B39CRoj-wqi5r3nXLixCe3Yo34aV@mail.gmail.com>
Subject: How to close bluetooth? Using rfkill?
From: zhangfei gao <zhangfei.gao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Is there any general method to open/close bluetooth, using rfkill or
pm_runtime_get/put_* API.

Currently we use rfkill to close bluetooth, however we met dead lock
issue, for mutex_lock(&rfkill_global_mutex).
So we use workaround to rmmod bt.ko first, or revert the rfkill patch
in hci_core.c.

BT/WIFI device have chip select pin, we register one rfkill with
sd8x_set_block, and control chip select pin to open/close bt/wifi/fm.
for example:
rfkill unblock bluetooth to open bt
rfkill block bluetooth to close bt

When "rfkill block bluetooth",
rfkill_fop_write->mutex_lock(&rfkill_global_mutex)->rfkill_set_block->sd8x_set_block->waiting
for card is freed.
BT driver will call
hci_unregister_dev->rfkill_unregister->mutex_lock(&rfkill_global_mutex);
So mutex_lock(&rfkill_global_mutex) will be dead locked.

If so, do we have to use other method to control chip select pin to
control bt power, such as pm_runtime_get/put_* API.

Thanks in advance.
