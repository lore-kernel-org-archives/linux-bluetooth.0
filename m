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
Subject: [PATCH 0099/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:40:34 +0800
Message-Id: <20160802104034.20355-1-baolex.ni@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index aba3121..db4f808 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -393,7 +393,7 @@ static void __exit vhci_exit(void)
 module_init(vhci_init);
 module_exit(vhci_exit);
 
-module_param(amp, bool, 0644);
+module_param(amp, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(amp, "Create AMP controller device");
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
-- 
2.9.2
