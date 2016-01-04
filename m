Return-Path: <heikki.krogerus@linux.intel.com>
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: hci_bcm: drop BCM43241 support from rfkill_gpio
Date: Mon,  4 Jan 2016 14:23:20 +0200
Message-Id: <1451910202-42401-1-git-send-email-heikki.krogerus@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Now that drivers/bluetooth/hci_bcm.c is able to handle the GPIOs
assigned to BCM43241, there is absolutely no reason to continue
supporting the module in rfkill_gpio.


Heikki Krogerus (2):
  Bluetooth: hci_bcm/rfkill-gpio: move all Broadcom ACPI IDs to BCM HCI
    driver
  Bluetooth: hci_bcm: new ACPI IDs

 drivers/bluetooth/hci_bcm.c | 7 +++++++
 net/rfkill/rfkill-gpio.c    | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.6.4
