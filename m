Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v6 5/5] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990.
Date: Thu, 24 May 2018 21:30:51 +0530
Message-Id: <20180524160051.29966-6-bgodavar@codeaurora.org>
In-Reply-To: <20180524160051.29966-1-bgodavar@codeaurora.org>
References: <20180524160051.29966-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support to set voltage/current of various regulators
to power up/down Bluetooth chip wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---

Changes in v6:
	* Hooked up qca_power to qca_serdev.	
	* renamed all the naming inconsistency functions with qca_*
	* leveraged common code of ROME for wcn3990.
	* created wrapper functions for re-usable blocks.
	* updated function of _*regulator_enable and _*regualtor_disable.  
	* removed redundant comments and functions.
	* addressed review comments.

Changes in v5:
	* updated regulator vddpa min_uV to 1304000.
  	* addressed review comments.
 
Changes in v4:
	* Segregated the changes of btqca from hci_qca
	* rebased all changes on top of bluetooth-next.
	* addressed review comments.

---
 drivers/bluetooth/btqca.h   |   6 +
 drivers/bluetooth/hci_qca.c | 419 ++++++++++++++++++++++++++++++++----
 2 files changed, 381 insertions(+), 44 deletions(-)

diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index e93e0660cf6c..2e551b029970 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -37,6 +37,9 @@
 #define EDL_TAG_ID_HCI			(17)
 #define EDL_TAG_ID_DEEP_SLEEP		(27)
 
+#define CHEROKEE_POWERON_PULSE          0xFC
+#define CHEROKEE_POWEROFF_PULSE         0xC0
+
 enum qca_bardrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
@@ -124,6 +127,9 @@ struct tlv_type_hdr {
 	__u8   data[0];
 } __packed;
 
+int qca_btsoc_power_setup(struct hci_uart *hu, bool on);
+int qca_btsoc_shutdown(struct hci_dev *hdev);
+
 #if IS_ENABLED(CONFIG_BT_QCA)
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index cb1034998040..e235be0e5202 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -5,7 +5,7 @@
  *  protocol extension to H4.
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
- *  Copyright (c) 2010, 2012 The Linux Foundation. All rights reserved.
+ *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
  *
  *  Acknowledgements:
  *  This file is based on hci_ll.c, which was...
@@ -31,9 +31,14 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -119,10 +124,48 @@ struct qca_data {
 	u64 votes_off;
 };
 
+enum qca_btsoc_type {
+	BTQCA_INVALID = -1,
+	BTQCA_AR3002,
+	BTQCA_ROME,
+	BTQCA_CHEROKEE
+};
+
+/*
+ * Voltage regulator information required for configuring the
+ * QCA Bluetooth chipset
+ */
+struct qca_vreg {
+	const char *name;
+	unsigned int min_uV;
+	unsigned int max_uV;
+	unsigned int load_uA;
+};
+
+struct qca_vreg_data {
+	enum qca_btsoc_type soc_type;
+	struct qca_vreg *vregs;
+	size_t num_vregs;
+};
+
+/*
+ * Platform data for the QCA Bluetooth power driver.
+ */
+struct qca_power {
+	struct device *dev;
+	const struct qca_vreg_data *vreg_data;
+	struct regulator_bulk_data *vreg_bulk;
+	bool vregs_on;
+};
+
 struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct clk	 *susclk;
+	enum qca_btsoc_type btsoc_type;
+	struct qca_power *bt_power;
+	u32 init_speed;
+	u32 oper_speed;
 };
 
 static void __serial_clock_on(struct tty_struct *tty)
@@ -402,6 +445,7 @@ static int qca_open(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
 	struct qca_data *qca;
+	int ret = 0;
 
 	BT_DBG("hu %p qca_open", hu);
 
@@ -463,13 +507,19 @@ static int qca_open(struct hci_uart *hu)
 		serdev_device_open(hu->serdev);
 
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		gpiod_set_value_cansleep(qcadev->bt_en, 1);
+		if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
+			hu->init_speed = qcadev->init_speed;
+			hu->oper_speed = qcadev->oper_speed;
+			ret = qca_btsoc_power_setup(hu, true);
+		} else {
+			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+		}
 	}
 
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
 	       qca->tx_idle_delay, qca->wake_retrans);
 
-	return 0;
+	return ret;
 }
 
 static void qca_debugfs_init(struct hci_dev *hdev)
@@ -552,7 +602,10 @@ static int qca_close(struct hci_uart *hu)
 		serdev_device_close(hu->serdev);
 
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		gpiod_set_value_cansleep(qcadev->bt_en, 0);
+		if (qcadev->btsoc_type == BTQCA_CHEROKEE)
+			qca_btsoc_shutdown(hu->hdev);
+		else
+			gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}
 
 	kfree_skb(qca->rx_skb);
@@ -925,20 +978,36 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
-static int qca_setup(struct hci_uart *hu)
+static int qca_send_vendor_cmd(struct hci_dev *hdev, u8 cmd)
 {
-	struct hci_dev *hdev = hu->hdev;
+	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
-	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
-	int ret;
+	struct sk_buff *skb;
 
-	bt_dev_info(hdev, "ROME setup");
+	bt_dev_dbg(hdev, "sending command %02x to SoC", cmd);
 
-	/* Patch downloading has to be done without IBS mode */
-	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate memory for skb packet");
+		return -ENOMEM;
+	}
+
+	skb_put_data(skb, &cmd, sizeof(cmd));
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+
+	skb_queue_tail(&qca->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	/* Wait for 100 uS for SoC to settle down */
+	usleep_range(100, 200);
+
+	return 0;
+}
+
+static void qca_set_init_speed(struct hci_uart *hu)
+{
+	unsigned int speed = 0;
 
-	/* Setup initial baudrate */
-	speed = 0;
 	if (hu->init_speed)
 		speed = hu->init_speed;
 	else if (hu->proto->init_speed)
@@ -946,29 +1015,136 @@ static int qca_setup(struct hci_uart *hu)
 
 	if (speed)
 		host_set_baudrate(hu, speed);
+}
+
+static int qca_set_operating_speed(struct hci_uart *hu, u32 *qca_baudrate)
+{
+	unsigned int speed = 0;
+	int ret;
 
-	/* Setup user speed if needed */
-	speed = 0;
 	if (hu->oper_speed)
 		speed = hu->oper_speed;
 	else if (hu->proto->oper_speed)
 		speed = hu->proto->oper_speed;
 
 	if (speed) {
-		qca_baudrate = qca_get_baudrate_value(speed);
-
-		bt_dev_info(hdev, "Set UART speed to %d", speed);
-		ret = qca_set_baudrate(hdev, qca_baudrate);
+		*qca_baudrate = qca_get_baudrate_value(speed);
+		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
+		ret = qca_set_baudrate(hu->hdev, *qca_baudrate);
 		if (ret) {
-			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
+			bt_dev_err(hu->hdev, "Failed to change the baud rate (%d)",
 				   ret);
 			return ret;
 		}
 		host_set_baudrate(hu, speed);
 	}
 
-	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup_rome(hdev, qca_baudrate);
+	return ret;
+}
+
+int qca_btsoc_shutdown(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	/* change host baud rate before sending power off command */
+	host_set_baudrate(hu, 2400);
+	qca_send_vendor_cmd(hdev, CHEROKEE_POWEROFF_PULSE);
+	/* turn off btsoc */
+	return qca_btsoc_power_setup(hu, false);
+}
+
+static int qca_setup(struct hci_uart *hu)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct qca_data *qca = hu->priv;
+	struct qca_serdev *qcadev;
+	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
+	int ret;
+	int soc_ver;
+
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+
+	switch (qcadev->btsoc_type) {
+	case BTQCA_CHEROKEE:
+		bt_dev_dbg(hdev, "setting up wcn3990");
+		/* Patch downloading has to be done without IBS mode */
+		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+		qca_set_init_speed(hu);
+		hci_uart_set_flow_control(hu, true);
+		ret = qca_send_vendor_cmd(hdev, CHEROKEE_POWERON_PULSE);
+		if (ret) {
+			bt_dev_err(hdev, "failed to send power on command");
+			return ret;
+		}
+
+		/* Close and re-open the port */
+		serdev_device_close(hu->serdev);
+		ret = serdev_device_open(hu->serdev);
+		if (ret) {
+			bt_dev_err(hdev, "failed to open port");
+			return ret;
+		}
+
+		qca_set_init_speed(hu);
+		hci_uart_set_flow_control(hu, false);
+		msleep(100);
+		ret = qca_patch_ver_req(hdev, &soc_ver);
+		if (ret < 0 || soc_ver == 0) {
+			bt_dev_err(hdev, "Failed to get version 0x%x", ret);
+			return ret;
+		}
+
+		bt_dev_info(hdev, "wcn3990 controller version 0x%08x", soc_ver);
+		hci_uart_set_flow_control(hu, true);
+		ret = qca_set_operating_speed(hu, &qca_baudrate);
+		if (ret)
+			return ret;
+		hci_uart_set_flow_control(hu, false);
+		/* Setup patch and NVM configurations */
+		ret = qca_uart_setup_cherokee(hdev, qca_baudrate, &soc_ver);
+
+		break;
+
+	default:
+		bt_dev_info(hdev, "ROME setup");
+
+		/* Patch downloading has to be done without IBS mode */
+		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+
+		/* Setup initial baudrate */
+		speed = 0;
+		if (hu->init_speed)
+			speed = hu->init_speed;
+		else if (hu->proto->init_speed)
+			speed = hu->proto->init_speed;
+
+		if (speed)
+			host_set_baudrate(hu, speed);
+
+		/* Setup user speed if needed */
+		speed = 0;
+		if (hu->oper_speed)
+			speed = hu->oper_speed;
+		else if (hu->proto->oper_speed)
+			speed = hu->proto->oper_speed;
+
+		if (speed) {
+			qca_baudrate = qca_get_baudrate_value(speed);
+
+			bt_dev_info(hdev, "Set UART speed to %d", speed);
+			ret = qca_set_baudrate(hdev, qca_baudrate);
+			if (ret) {
+				bt_dev_err(hdev, "Failed to change the baud rate (%d)",
+					    ret);
+				return ret;
+			}
+			host_set_baudrate(hu, speed);
+		}
+
+		/* Setup patch / NVM configurations */
+		ret = qca_uart_setup_rome(hdev, qca_baudrate);
+	}
+
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
@@ -1004,9 +1180,120 @@ static struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
+static const struct qca_vreg_data qca_cherokee_data = {
+	.soc_type = BTQCA_CHEROKEE,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio",   1352000, 1352000,  0 },
+		{ "vddxtal", 1904000, 2040000,  0 },
+		{ "vddcore", 1800000, 1800000,  1 },
+		{ "vddpa",   1304000, 1304000,  1 },
+		{ "vddldo",  3000000, 3312000,  1 },
+	},
+	.num_vregs = 5,
+};
+
+static int qca_enable_regulator(struct qca_vreg vregs,
+				struct regulator *regulator)
+{
+	int ret;
+
+	ret = regulator_set_voltage(regulator, vregs.min_uV,
+				    vregs.max_uV);
+	if (ret)
+		goto out;
+
+	if (vregs.load_uA)
+		ret = regulator_set_load(regulator,
+					 vregs.load_uA);
+
+	if (ret)
+		goto out;
+
+	ret = regulator_enable(regulator);
+
+out:
+	return ret;
+
+}
+
+static void qca_disable_regulator(struct qca_vreg vregs,
+				  struct regulator *regulator)
+{
+	/* Disable the regulator if requested by user
+	 * or when fault to enable any regulator.
+	 */
+	regulator_disable(regulator);
+	regulator_set_voltage(regulator, 0, vregs.max_uV);
+	if (vregs.load_uA)
+		regulator_set_load(regulator, 0);
+
+}
+
+int qca_btsoc_power_setup(struct hci_uart *hu, bool on)
+{
+	struct qca_vreg *vregs;
+	struct regulator_bulk_data *vreg_bulk;
+	struct qca_serdev *qcadev;
+	int i, num_vregs, ret = 0;
+
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+	if (!qcadev || !qcadev->bt_power || !qcadev->bt_power->vreg_data ||
+	    !qcadev->bt_power->vreg_bulk)
+		return -EINVAL;
+
+	vregs = qcadev->bt_power->vreg_data->vregs;
+	vreg_bulk = qcadev->bt_power->vreg_bulk;
+	num_vregs = qcadev->bt_power->vreg_data->num_vregs;
+	BT_DBG("on: %d", on);
+	if (on  && !qcadev->bt_power->vregs_on) {
+		for (i = 0; i < num_vregs; i++) {
+			ret = qca_enable_regulator(vregs[i],
+						   vreg_bulk[i].consumer);
+			if (ret)
+				break;
+		}
+		/* regulators failed */
+		if (ret) {
+			BT_ERR("failed to enable regulator:%s", vregs[i].name);
+			/* turn off regulators which are enabled */
+			for (i = i - 1; i >= 0; i--)
+				qca_disable_regulator(vregs[i],
+						      vreg_bulk[i].consumer);
+		} else {
+			qcadev->bt_power->vregs_on = true;
+		}
+	} else if (!on && qcadev->bt_power->vregs_on) {
+		/* turn off regulator in reverse order */
+		i = qcadev->bt_power->vreg_data->num_vregs - 1;
+		for ( ; i >= 0; i--)
+			qca_disable_regulator(vregs[i], vreg_bulk[i].consumer);
+		qcadev->bt_power->vregs_on = false;
+	}
+
+	return ret;
+}
+
+static int qca_init_regulators(struct qca_power *qca,
+			       const struct qca_vreg *vregs, size_t num_vregs)
+{
+	int i;
+
+	qca->vreg_bulk = devm_kzalloc(qca->dev, num_vregs *
+				      sizeof(struct regulator_bulk_data),
+				      GFP_KERNEL);
+	if (!qca->vreg_bulk)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vregs; i++)
+		qca->vreg_bulk[i].supply = vregs[i].name;
+
+	return devm_regulator_bulk_get(qca->dev, num_vregs, qca->vreg_bulk);
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
+	const struct qca_vreg_data *data;
 	int err;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
@@ -1014,34 +1301,72 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	qcadev->serdev_hu.serdev = serdev;
+	data = of_device_get_match_data(&serdev->dev);
+	if (data && data->soc_type == BTQCA_CHEROKEE)
+		qcadev->btsoc_type = BTQCA_CHEROKEE;
+	else
+		qcadev->btsoc_type = BTQCA_ROME;
+
 	serdev_device_set_drvdata(serdev, qcadev);
+	if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
+		qcadev->bt_power = devm_kzalloc(&serdev->dev,
+						sizeof(struct qca_power),
+						GFP_KERNEL);
+		if (!qcadev->bt_power)
+			return -ENOMEM;
+
+		qcadev->bt_power->dev = &serdev->dev;
+		qcadev->bt_power->vreg_data = data;
+		err = qca_init_regulators(qcadev->bt_power, data->vregs,
+					  data->num_vregs);
+		if (err) {
+			BT_ERR("Failed to init regulators:%d", err);
+			devm_kfree(&serdev->dev, qcadev->bt_power->vreg_bulk);
+			devm_kfree(&serdev->dev, qcadev->bt_power);
+			goto out;
+		}
 
-	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
-				       GPIOD_OUT_LOW);
-	if (IS_ERR(qcadev->bt_en)) {
-		dev_err(&serdev->dev, "failed to acquire enable gpio\n");
-		return PTR_ERR(qcadev->bt_en);
-	}
+		qcadev->bt_power->vregs_on = false;
+		device_property_read_u32(&serdev->dev, "max-speed",
+					 &qcadev->oper_speed);
+		if (!qcadev->oper_speed)
+			BT_INFO("UART will pick default operating speed");
+		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+		if (err) {
+			BT_ERR("wcn3990 serdev registration failed");
+			devm_kfree(&serdev->dev, qcadev->bt_power->vreg_bulk);
+			devm_kfree(&serdev->dev, qcadev->bt_power);
+			goto out;
+		}
+	} else {
+		qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
+					       GPIOD_OUT_LOW);
+		if (IS_ERR(qcadev->bt_en)) {
+			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+			return PTR_ERR(qcadev->bt_en);
+		}
 
-	qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
-	if (IS_ERR(qcadev->susclk)) {
-		dev_err(&serdev->dev, "failed to acquire clk\n");
-		return PTR_ERR(qcadev->susclk);
-	}
+		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
+		if (IS_ERR(qcadev->susclk)) {
+			dev_err(&serdev->dev, "failed to acquire clk\n");
+			return PTR_ERR(qcadev->susclk);
+		}
 
-	err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
-	if (err)
-		return err;
+		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
+		if (err)
+			return err;
 
-	err = clk_prepare_enable(qcadev->susclk);
-	if (err)
-		return err;
+		err = clk_prepare_enable(qcadev->susclk);
+		if (err)
+			return err;
 
-	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-	if (err)
-		clk_disable_unprepare(qcadev->susclk);
+		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+		if (err)
+			clk_disable_unprepare(qcadev->susclk);
+	}
+
+out:	return err;
 
-	return err;
 }
 
 static void qca_serdev_remove(struct serdev_device *serdev)
@@ -1050,11 +1375,17 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 
-	clk_disable_unprepare(qcadev->susclk);
+	if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
+		devm_kfree(&serdev->dev, qcadev->bt_power->vreg_bulk);
+		devm_kfree(&serdev->dev, qcadev->bt_power);
+	} else {
+		clk_disable_unprepare(qcadev->susclk);
+	}
 }
 
 static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
+	{ .compatible = "qcom,wcn3990-bt", .data = &qca_cherokee_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
