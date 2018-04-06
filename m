Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/3] Add support to power Bluetooth QCA chips attached to MSM
Date: Fri,  6 Apr 2018 17:22:25 +0530
Message-Id: <1523015546-994-3-git-send-email-bgodavar@codeaurora.org>
In-Reply-To: <1523015546-994-1-git-send-email-bgodavar@codeaurora.org>
References: <1523015546-994-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rupesh Tatiya <rtatiya@codeaurora.org>

Add support to set voltage/current of various regulators to power up/down
BT QCA chips attached to MSM.

Change-Id: I3600dd7bc97c753bc9cf7f8ac39d7b90bc21c67d
Signed-off-by: Rupesh Tatiya <rtatiya@codeaurora.org>
---
 drivers/bluetooth/Makefile      |   5 +-
 drivers/bluetooth/btqca_power.c | 177 ++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqca_power.h |  71 ++++++++++++++++
 3 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bluetooth/btqca_power.c
 create mode 100644 drivers/bluetooth/btqca_power.h

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 4e4e44d..f963909 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -24,8 +24,9 @@ obj-$(CONFIG_BT_WILINK)		+= btwilink.o
 obj-$(CONFIG_BT_QCOMSMD)	+= btqcomsmd.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
 obj-$(CONFIG_BT_RTL)		+= btrtl.o
-obj-$(CONFIG_BT_QCA)		+= btqca.o
-
+obj-$(CONFIG_BT_QCA)		+= btqca_uart.o
+btqca_uart-$(CONFIG_BT_QCA)	+= btqca.o
+btqca_uart-$(CONFIG_BT_QCA)	+= btqca_power.o
 obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
 
 btmrvl-y			:= btmrvl_main.o
diff --git a/drivers/bluetooth/btqca_power.c b/drivers/bluetooth/btqca_power.c
new file mode 100644
index 0000000..a189ff1
--- /dev/null
+++ b/drivers/bluetooth/btqca_power.c
@@ -0,0 +1,177 @@
+/* Copyright (c) 2009-2010, 2013-2018 The Linux Foundation.
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+/*
+ * Bluetooth Power Switch Module
+ * controls power to external Bluetooth device
+ * with interface to power management device
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of_device.h>
+#include <net/bluetooth/bluetooth.h>
+
+#include "btqca_power.h"
+
+static struct btqca_power *qca;
+
+static const struct btqca_vreg_data cherokee_data = {
+	.soc_type = BTQCA_CHEROKEE,
+	.vregs = (struct btqca_vreg []) {
+		{ "vddio",   1352000, 1352000,  0 },
+		{ "vddxtal", 1904000, 2040000,  0 },
+		{ "vddcore", 1800000, 1800000,  1 },
+		{ "vddpa",   130400,  1304000,  1 },
+		{ "vddldo",  3000000, 3312000,  1 },
+		{ "vddpwd",  3312000, 3600000,  0 },
+	},
+	.num_vregs = 6,
+};
+
+static const struct of_device_id btqca_power_match_table[] = {
+	{ .compatible = "qca,wcn3990", .data = &cherokee_data},
+	{}
+};
+
+int btqca_get_soc_type(enum btqca_soc_t *type)
+{
+	if (!qca || !qca->vreg_data)
+		return -EINVAL;
+
+	*type = qca->vreg_data->soc_type;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btqca_get_soc_type);
+
+int btqca_power_setup(int on)
+{
+	int ret = 0;
+	int i;
+	struct btqca_vreg *vregs;
+
+	if (!qca || !qca->vreg_data || !qca->vreg_bulk)
+		return -EINVAL;
+	vregs = qca->vreg_data->vregs;
+
+	BT_DBG("on: %d", on);
+
+	if (on) {
+		for (i = 0; i < qca->vreg_data->num_vregs; i++) {
+			regulator_set_voltage(qca->vreg_bulk[i].consumer,
+					      vregs[i].min_v,
+					      vregs[i].max_v);
+
+			if (vregs[i].load_ua)
+				regulator_set_load(qca->vreg_bulk[i].consumer,
+						   vregs[i].load_ua);
+
+			regulator_enable(qca->vreg_bulk[i].consumer);
+		}
+	} else {
+		for (i = 0; i < qca->vreg_data->num_vregs; i++) {
+			regulator_disable(qca->vreg_bulk[i].consumer);
+
+			regulator_set_voltage(qca->vreg_bulk[i].consumer,
+						0, vregs[i].max_v);
+
+			regulator_set_load(qca->vreg_bulk[i].consumer, 0);
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(btqca_power_setup);
+
+static int init_regulators(struct btqca_power *qca,
+			   const struct btqca_vreg *vregs,
+			   size_t num_vregs)
+{
+	int i, ret;
+
+	qca->vreg_bulk = devm_kzalloc(qca->dev, num_vregs *
+					sizeof(struct regulator_bulk_data),
+					GFP_KERNEL);
+	if (!qca->vreg_bulk)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vregs; i++)
+		qca->vreg_bulk[i].supply = vregs[i].name;
+
+	return devm_regulator_bulk_get(qca->dev, num_vregs, qca->vreg_bulk);
+}
+
+static int btqca_power_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	const struct btqca_vreg_data *data;
+
+	BT_DBG("");
+
+	qca = kzalloc(sizeof(struct btqca_power), GFP_KERNEL);
+	if (!qca)
+		return -ENOMEM;
+	qca->pdev = pdev;
+	qca->dev = &pdev->dev;
+
+	data = of_device_get_match_data(&pdev->dev);
+	qca->vreg_data = data;
+	ret = init_regulators(qca, data->vregs, data->num_vregs);
+	if (ret)
+		goto out;
+
+	return 0;
+
+out:
+	kfree(qca);
+	return ret;
+}
+
+static int btqca_power_remove(struct platform_device *pdev)
+{
+	BT_DBG("");
+
+	btqca_power_setup(0);
+	kfree(qca);
+
+	return 0;
+}
+
+static struct platform_driver btqca_power_driver = {
+	.probe = btqca_power_probe,
+	.remove = btqca_power_remove,
+	.driver = {
+		.name = "btqca_power",
+		.owner = THIS_MODULE,
+		.of_match_table = btqca_power_match_table,
+	},
+};
+
+static int __init btqca_power_init(void)
+{
+	return platform_driver_register(&btqca_power_driver);
+}
+
+static void __exit btqca_power_exit(void)
+{
+	platform_driver_unregister(&btqca_power_driver);
+}
+
+module_init(btqca_power_init);
+module_exit(btqca_power_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MSM Bluetooth power control driver for Atheros family");
diff --git a/drivers/bluetooth/btqca_power.h b/drivers/bluetooth/btqca_power.h
new file mode 100644
index 0000000..0569760
--- /dev/null
+++ b/drivers/bluetooth/btqca_power.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2013-2018 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __BTQCA_POWER_H
+#define __BTQCA_POWER_H
+
+enum btqca_soc_t {
+	BTQCA_INVALID = -1,
+	BTQCA_AR3002,
+	BTQCA_ROME,
+	BTQCA_CHEROKEE
+};
+
+/*
+ * voltage regulator information required for configuring the
+ * QCA bluetooth chipset
+ */
+struct btqca_vreg {
+	const char *name;
+	unsigned int min_v;
+	unsigned int max_v;
+	unsigned int load_ua;
+};
+
+struct btqca_vreg_data {
+	enum btqca_soc_t soc_type;
+	struct btqca_vreg *vregs;
+	size_t num_vregs;
+};
+
+/*
+ * Platform data for the QCA bluetooth power driver.
+ */
+struct btqca_power {
+	struct platform_device *pdev;
+	struct device *dev;
+	struct btqca_vreg_data *vreg_data;
+	struct regulator_bulk_data *vreg_bulk;
+};
+
+#if IS_ENABLED(CONFIG_BT_QCA)
+
+int btqca_power_setup(int on);
+int btqca_get_soc_type(enum btqca_soc_t *type);
+
+#else
+
+static inline int btqca_power_setup(int on)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int btqca_get_soc_type(enum btqca_soc_t *type)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
+
+#endif /* __BTQCA_POWER_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
