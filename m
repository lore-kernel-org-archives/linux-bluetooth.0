Return-Path: <mka@chromium.org>
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()
Date: Thu, 20 Sep 2018 15:34:36 -0700
Message-Id: <20180920223436.202454-3-mka@chromium.org>
In-Reply-To: <20180920223436.202454-1-mka@chromium.org>
References: <20180920223436.202454-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Use the new API to get the BD address instead of reading it directly
from the device tree.

Also remove an unncessary pair of braces in the same area of code.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqcomsmd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e..1f2de6aeb3dd 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -172,11 +172,10 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	/* The local-bd-address property is usually injected by the
 	 * bootloader which has access to the allocated BD address.
 	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
+	if (!device_get_bd_address(&pdev->dev, (u8 *)&btq->bdaddr,
+				   sizeof(bdaddr_t)))
 		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
 			 &btq->bdaddr);
-	}
 
 	hdev = hci_alloc_dev();
 	if (!hdev)
-- 
2.19.0.444.g18242da7ef-goog
