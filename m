Return-Path: <baolex.ni@intel.com>
From: Baole Ni <baolex.ni@intel.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	gregkh@linuxfoundation.org,
	hpa@zytor.com,
	x86@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com,
	baolex.ni@intel.com,
	martin.petersen@oracle.com,
	kent.overstreet@gmail.com
Subject: [PATCH 0098/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:40:29 +0800
Message-Id: <20160802104029.20289-1-baolex.ni@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/bluetooth/hci_bcsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index d7d23ce..917751b 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -764,8 +764,8 @@ int __exit bcsp_deinit(void)
 	return hci_uart_unregister_proto(&bcsp);
 }
 
-module_param(txcrc, bool, 0644);
+module_param(txcrc, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(txcrc, "Transmit CRC with every BCSP packet");
 
-module_param(hciextn, bool, 0644);
+module_param(hciextn, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(hciextn, "Convert HCI Extensions into BCSP packets");
-- 
2.9.2
