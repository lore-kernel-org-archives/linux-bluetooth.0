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
Subject: [PATCH 0097/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:40:25 +0800
Message-Id: <20160802104025.20223-1-baolex.ni@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/bluetooth/btusb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a3be65e..ac96e89 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3174,13 +3174,13 @@ static struct usb_driver btusb_driver = {
 
 module_usb_driver(btusb_driver);
 
-module_param(disable_scofix, bool, 0644);
+module_param(disable_scofix, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(disable_scofix, "Disable fixup of wrong SCO buffer size");
 
-module_param(force_scofix, bool, 0644);
+module_param(force_scofix, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
 
-module_param(reset, bool, 0644);
+module_param(reset, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
-- 
2.9.2
