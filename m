Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_h5: Add Kconfig dependencies on SERDEV and GPIOLIB
Date: Wed,  8 Aug 2018 10:48:25 +0200
Message-Id: <20180808084825.12120-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

After the recent changes for RTL serdev devices support the h5 code now
depends on the hci_serdev code and on gpiolib at dependencies to Kconfig
to properly reflect this.

Reported-by: kbuild-all@01.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index f3c643a0473c..8969d3d5d86c 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -159,6 +159,8 @@ config BT_HCIUART_LL
 config BT_HCIUART_3WIRE
 	bool "Three-wire UART (H5) protocol support"
 	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
+	depends on GPIOLIB
 	help
 	  The HCI Three-wire UART Transport Layer makes it possible to
 	  user the Bluetooth HCI over a serial port interface. The HCI
-- 
2.18.0
