Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	robh+dt@kernel.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	bjorn.andersson@linaro.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v7 3/3] Bluetooth: btqcomsmd: retrieve BD address from DT property
Date: Fri,  8 Sep 2017 15:57:55 +0200
Message-Id: <1504879075-587-3-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1504879075-587-1-git-send-email-loic.poulain@linaro.org>
References: <1504879075-587-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Retrieve BD address from the local-bd-address property.
This address must be unique and is usually added in the DT
by the bootloader which has access to the provisioned data.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: Set device as unconfigured if default address detected
     Add warning if BD addr retrieved from DT
 v3: if no addr retrieved from DT, unconditionally set
     the invalid BD addr flag.
     swap and set bdaddr in the platform probe
 v4: Add dt-bindings documentation
     split patch in two parts (setup, dt prop)
     use local-bd-address name instead of local-mac-address
 v5: remove 2/3 merged in bluetooth-next tree
     Add bluetooth.txt for common BT bindings
     expect local-bd-address in little-endian format
 v6: use of_property_read_u8_array instead of of_get_property
 v7: use dev_info instead of BT_INFO to have dev context

 drivers/bluetooth/btqcomsmd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index bd810d0..663bed6 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/rpmsg.h>
+#include <linux/of.h>
+
 #include <linux/soc/qcom/wcnss_ctrl.h>
 #include <linux/platform_device.h>
 
@@ -156,6 +158,15 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	if (IS_ERR(btq->cmd_channel))
 		return PTR_ERR(btq->cmd_channel);
 
+	/* The local-bd-address property is usually injected by the
+	 * bootloader which has access to the allocated BD address.
+	 */
+	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
+				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
+		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
+			 &btq->bdaddr);
+	}
+
 	hdev = hci_alloc_dev();
 	if (!hdev)
 		return -ENOMEM;
-- 
1.9.1
