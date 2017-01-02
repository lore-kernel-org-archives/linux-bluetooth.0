Return-Path: <javier@osg.samsung.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btqcomsmd: Fix module autoload
Date: Mon,  2 Jan 2017 10:09:56 -0300
Message-Id: <1483362596-7843-1-git-send-email-javier@osg.samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/bluetooth/btqcomsmd.ko | grep alias
$

After this patch:

$ modinfo drivers/bluetooth/btqcomsmd.ko | grep alias
alias:          of:N*T*Cqcom,wcnss-btC*
alias:          of:N*T*Cqcom,wcnss-bt

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/bluetooth/btqcomsmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 08c2c93887c1..8d4868af9bbd 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -165,6 +165,7 @@ static const struct of_device_id btqcomsmd_of_match[] = {
 	{ .compatible = "qcom,wcnss-bt", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, btqcomsmd_of_match);
 
 static struct platform_driver btqcomsmd_driver = {
 	.probe = btqcomsmd_probe,
-- 
2.7.4
