Return-Path: <lukas@wunner.de>
Message-Id: <cover.1515593773.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 10 Jan 2018 16:32:10 +0100
Subject: [PATCH v4 00/13] Bluetooth on 2015+ MacBook (Pro)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enable UART-attached Bluetooth on 2015+ MacBook (Pro), v4.

I forgot to include a changelog in each individual patch in v3,
I'm making up for it now by listing the changes since both, v3 and v2.

Changes since v3:

- In patch [07/13] ("Document struct bcm_device"):
  s/enable flow control/disable flow control/ to account for inverse
  semantics of hci_uart_set_flow_control().

- In patch [05/13] and [09/13] ("Handle errors properly"):
  Fix corner case where an unbalanced pm_runtime_disable() could occur.

- In patch [10/13] ("Support Apple GPIO handling"):
  Style fix: Unroll bcm_apple_get_resources() inline stub. (Andy)

Changes since v2:

- In patch [01/13] ("Mandate presence of shutdown and device wake GPIO"):
  Keep netdev indentation style. (Marcel)

- New patch [04/13] to fix an IRQ race on ->close.

- New patch [05/13] to fix an unbalanced pm_runtime_disable(). (Andy)

- New patch [06/13] to invalidate the IRQ if requesting it failed.

- New patch [08/13] to add callbacks to toggle GPIOs.
  This makes the subsequent addition of Mac support less intrusive.
  Replaces patch "Add helper to toggle device wake GPIO" in v2. (Andy)

- In patch [09/13] ("Handle errors properly"):
  Drop redundant assignment. (Andy)

- In patch [10/13] ("Support Apple GPIO handling"):
  Don't enable runtime PM on Macs for lack of usable host wake IRQ (Hans),
  s/BlueTooth/Bluetooth/ in kerneldoc. (Marcel)

- Move patch "Silence IRQ printk" to end of series as it's merely
  a cleanup and no longer necessary for Mac support.

- New patch [12/13] to use msleep() instead of mdelay()
  after toggling device wake pin. (Andy)

- New patch [13/13] to fix sleep mode struct ordering.

- Drop incorrect patch "Enable runtime PM despite absence of IRQ". (Hans)

Link to v3:
https://www.spinics.net/lists/linux-bluetooth/msg73705.html

Link to v2:
https://www.spinics.net/lists/linux-bluetooth/msg73628.html

Thanks,

Lukas


Lukas Wunner (12):
  Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO
  Bluetooth: hci_bcm: Clean up unnecessary #ifdef
  Bluetooth: hci_bcm: Fix race on close
  Bluetooth: hci_bcm: Fix unbalanced pm_runtime_disable()
  Bluetooth: hci_bcm: Invalidate IRQ on request failure
  Bluetooth: hci_bcm: Document struct bcm_device
  Bluetooth: hci_bcm: Add callbacks to toggle GPIOs
  Bluetooth: hci_bcm: Handle errors properly
  Bluetooth: hci_bcm: Support Apple GPIO handling
  Bluetooth: hci_bcm: Silence IRQ printk
  Bluetooth: hci_bcm: Sleep instead of spinning
  Bluetooth: btbcm: Fix sleep mode struct ordering

Ronald Tschalär (1):
  Bluetooth: hci_bcm: Validate IRQ before using it

 drivers/bluetooth/btbcm.h   |   2 +-
 drivers/bluetooth/hci_bcm.c | 228 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 190 insertions(+), 40 deletions(-)

-- 
2.15.1
