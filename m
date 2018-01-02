Return-Path: <lukas@wunner.de>
Message-Id: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 00/10] Bluetooth on 2015+ MacBook (Pro)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Enable UART-attached Bluetooth on 2015+ MacBook (Pro), v2.

Changes since v1:

- New patch [1/10] to make Bluetooth drivers depend on rather than select
  GPIOLIB. (Andy, Linus)

- New patch [2/10] to enforce presence of shutdown and device wake GPIO.
  (Andy, Linus, Loic)

- Split off hunks:
  to enable runtime PM despite absence of IRQ into patch [3/10],
  to validate the IRQ before using it into patch [4/10],
  to add a helper to toggle device wake GPIO into patch [5/10]. (Marcel)

- In patch [5/10], I had previously forgotten to toggle the device wake
  GPIO in bcm_gpio_set_power() on Macs, this is now fixed.

- New patch [6/10] to silence an irritating IRQ printk.

- New patch [7/10] to clean up an unnecessary #ifdef.

- New patch [8/10] to add kerneldoc for struct bcm_device.

- New patch [9/10] to add proper error handling to the driver.

- In patch [10/10]:
  add DSDT excerpt to the commit message,
  drop ternary operators for readability,
  return -EIO instead of -EFAULT if ACPI method calls fail,
  return -EOPNOTSUPP in inline stubs,
  use network subsystem comment style. (Marcel, Hans, Andy)
  Also, to accommodate to mandatory presence of the two GPIOs as per
  patch [2/10], rename bcm_apple_probe() to bcm_apple_get_resources()
  and call it from bcm_get_resources() instead of bcm_acpi_probe().

Link to v1:

https://www.spinics.net/lists/linux-bluetooth/msg73527.html

Thanks,

Lukas


Lukas Wunner (9):
  Bluetooth: Depend on rather than select GPIOLIB
  Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO
  Bluetooth: hci_bcm: Enable runtime PM despite absence of IRQ
  Bluetooth: hci_bcm: Add helper to toggle device wake GPIO
  Bluetooth: hci_bcm: Silence IRQ printk
  Bluetooth: hci_bcm: Clean up unnecessary #ifdef
  Bluetooth: hci_bcm: Document struct bcm_device
  Bluetooth: hci_bcm: Handle errors properly
  Bluetooth: hci_bcm: Support Apple GPIO handling

Ronald Tschalär (1):
  Bluetooth: hci_bcm: Validate IRQ before using it

 drivers/bluetooth/Kconfig   |   6 +-
 drivers/bluetooth/hci_bcm.c | 230 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 192 insertions(+), 44 deletions(-)

-- 
2.15.1
