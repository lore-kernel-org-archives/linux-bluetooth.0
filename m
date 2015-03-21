Return-Path: <cyrus@holtmann.org>
From: Gigi Joseph <gigi.joseph@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gigi Joseph <gigi.joseph@ti.com>,
	Eyal Reizer <eyalr@ti.com>,
	bvijay <bvijay@ti.com>
Subject: [PATCH v2 3/6] btwilink: add minimal device tree support
Date: Sat, 21 Mar 2015 05:17:48 +0000
Message-Id: <1426915068-10371-1-git-send-email-gigi.joseph@ti.com>
In-Reply-To: <C03A9F83-A4A3-424A-B50C-D6A9630705C8@holtmann.org>
References: <C03A9F83-A4A3-424A-B50C-D6A9630705C8@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Add minimal device tree support to the btwilink driver that is used
for binding bluetooth with the ti-st shared transport driver.

Signed-off-by: Eyal Reizer <eyalr@ti.com>
Signed-off-by: bvijay <bvijay@ti.com>
Signed-off-by: Gigi Joseph <gigi.joseph@ti.com>
---
Changes in v2:
	* Reformat device_id table to match other drivers
	* Add empty line before MODULE_DEVICE_TABLE

 drivers/bluetooth/btwilink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 55c135b..ae64b2b 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -30,6 +30,7 @@
 
 #include <linux/ti_wilink_st.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 /* Bluetooth Driver Version */
 #define VERSION               "1.0"
@@ -286,6 +287,14 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static const struct of_device_id btwilink_of_match[] = {
+	{ .compatible = "btwilink" },
+
+	{ }	/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(of, btwilink_of_match);
+
 static int bt_ti_probe(struct platform_device *pdev)
 {
 	static struct ti_st *hst;
@@ -349,6 +358,8 @@ static struct platform_driver btwilink_driver = {
 	.remove = bt_ti_remove,
 	.driver = {
 		.name = "btwilink",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(btwilink_of_match),
 	},
 };
 
-- 
1.9.1
