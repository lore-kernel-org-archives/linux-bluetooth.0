Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v4 2/3] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990.
Date: Fri,  4 May 2018 21:05:05 +0530
Message-Id: <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
In-Reply-To: <1525448106-18616-1-git-send-email-bgodavar@codeaurora.org>
References: <1525448106-18616-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support to set voltage/current of various regulators
to power up/down Bluetooth chip wcn3990.
Add support to read baudrate from dts.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 555 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 483 insertions(+), 72 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f05382b..075fab7 100644
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
@@ -35,6 +35,10 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/serdev.h>
+#include <asm-generic/delay.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of_device.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -119,12 +123,51 @@ struct qca_data {
 	u64 votes_off;
 };
 
+enum btqca_soc_t {
+	BTQCA_INVALID = -1,
+	BTQCA_AR3002,
+	BTQCA_ROME,
+	BTQCA_CHEROKEE
+};
+
 struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct clk	 *susclk;
+	enum btqca_soc_t btsoc_type;
+	u32 init_speed;
+	u32 oper_speed;
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
 };
 
+/*
+ * Platform data for the QCA bluetooth power driver.
+ */
+struct btqca_power {
+	struct device *dev;
+	const struct btqca_vreg_data *vreg_data;
+	struct regulator_bulk_data *vreg_bulk;
+	bool vreg_status;
+};
+
+static struct btqca_power *qca;
+
 static void __serial_clock_on(struct tty_struct *tty)
 {
 	/* TODO: Some chipset requires to enable UART clock on client
@@ -463,7 +506,12 @@ static int qca_open(struct hci_uart *hu)
 		serdev_device_open(hu->serdev);
 
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		gpiod_set_value_cansleep(qcadev->bt_en, 1);
+		if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
+			hu->init_speed = qcadev->init_speed;
+			hu->oper_speed = qcadev->oper_speed;
+			btqca_power_setup(true);
+		} else
+			gpiod_set_value_cansleep(qcadev->bt_en, 1);
 	}
 
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
@@ -552,7 +600,10 @@ static int qca_close(struct hci_uart *hu)
 		serdev_device_close(hu->serdev);
 
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		gpiod_set_value_cansleep(qcadev->bt_en, 0);
+		if (qcadev->btsoc_type == BTQCA_CHEROKEE)
+			qca_btsoc_cleanup(hu->hdev);
+		else
+			gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}
 
 	kfree_skb(qca->rx_skb);
@@ -872,6 +923,8 @@ static uint8_t qca_get_baudrate_value(int speed)
 		return QCA_BAUDRATE_2000000;
 	case 3000000:
 		return QCA_BAUDRATE_3000000;
+	case 3200000:
+		return QCA_BAUDRATE_3200000;
 	case 3500000:
 		return QCA_BAUDRATE_3500000;
 	default:
@@ -886,7 +939,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	struct sk_buff *skb;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
-	if (baudrate > QCA_BAUDRATE_3000000)
+	if (baudrate > QCA_BAUDRATE_3200000)
 		return -EINVAL;
 
 	cmd[4] = baudrate;
@@ -923,68 +976,292 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
+static int qca_send_poweron_cmd(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	struct sk_buff *skb;
+	u8 cmd;
+
+	BT_DBG("%s sending power on command to btsoc", hdev->name);
+	/* By sending 0xFC host is trying to power up the soc */
+	cmd = CHEROKEE_POWERON_PULSE;
+	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("Failed to allocate memory for skb  packet");
+		return -ENOMEM;
+	}
+
+	skb_put_data(skb, &cmd, sizeof(cmd));
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+
+	skb_queue_tail(&qca->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	/* Wait for 100 us for soc to settle down */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(usecs_to_jiffies(100));
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	return 0;
+}
+
+static int qca_send_poweroff_cmd(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	struct sk_buff *skb;
+	u8 cmd;
+
+	BT_DBG("%s sending power off command to btsoc", hdev->name);
+	/* By sending 0xC0 host is trying to power off the soc */
+	cmd = CHEROKEE_POWEROFF_PULSE;
+	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("Failed to allocate memory for skb  packet");
+		return -ENOMEM;
+	}
+
+	skb_put_data(skb, &cmd, sizeof(cmd));
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+
+	skb_queue_tail(&qca->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	/* Wait for 100 us for soc to settle down */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(usecs_to_jiffies(100));
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	return 0;
+}
+
+static int qca_serdev_open(struct hci_uart *hu)
+{
+	int ret = 0;
+
+	if (hu->serdev)
+		serdev_device_open(hu->serdev);
+	else {
+		bt_dev_err(hu->hdev, "open operation not supported");
+		ret = 1;
+	}
+
+	return ret;
+}
+
+int qca_btsoc_cleanup(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	/* change host baud rate before sending power off command */
+	host_set_baudrate(hu, 2400);
+	/* send 0xC0 command to btsoc before turning off regulators */
+	qca_send_poweroff_cmd(hdev);
+	/* turn off btsoc */
+	return btqca_power_setup(false);
+}
+
+static int qca_serdev_close(struct hci_uart *hu)
+{
+	int ret = 0;
+
+	if (hu->serdev)
+		serdev_device_close(hu->serdev);
+	else {
+		bt_dev_err(hu->hdev, "close operation not supported");
+		ret = 1;
+	}
+
+	return ret;
+}
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
 	struct qca_data *qca = hu->priv;
+	struct qca_serdev *qcadev;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
 	int ret;
+	int soc_ver;
+
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+
+	switch (qcadev->btsoc_type) {
+	case BTQCA_CHEROKEE:
+		bt_dev_info(hdev, "setting up wcn3990");
+		/* Patch downloading has to be done without IBS mode */
+		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+		/* Setup initial baudrate */
+		speed = 0;
+		if (hu->init_speed)
+			speed = hu->init_speed;
+		else if (hu->proto->init_speed)
+			speed = hu->proto->init_speed;
+
+		if (speed)
+			host_set_baudrate(hu, speed);
+		else {
+			bt_dev_err(hdev, "initial speed %u", speed);
+			return -1;
+		}
 
-	bt_dev_info(hdev, "ROME setup");
+		/* disable flow control, as chip is still not turned on */
+		hci_uart_set_flow_control(hu, true);
+		/* send poweron command to btsoc */
+		ret = qca_send_poweron_cmd(hdev);
+		if (ret) {
+			bt_dev_err(hdev, "Failed to send power on command");
+			return ret;
+		}
 
-	/* Patch downloading has to be done without IBS mode */
-	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+		/* close serial port */
+		ret = qca_serdev_close(hu);
+		if (ret)
+			return ret;
+		/* open serial port */
+		ret = qca_serdev_open(hu);
+		if (ret)
+			return ret;
 
-	/* Setup initial baudrate */
-	speed = 0;
-	if (hu->init_speed)
-		speed = hu->init_speed;
-	else if (hu->proto->init_speed)
-		speed = hu->proto->init_speed;
+		/* Setup initial baudrate */
+		speed = 0;
+		if (hu->init_speed)
+			speed = hu->init_speed;
+		else if (hu->proto->init_speed)
+			speed = hu->proto->init_speed;
+		if (speed)
+			host_set_baudrate(hu, speed);
+		else {
+			BT_ERR("%s:initial speed %u", hdev->name, speed);
+			return -1;
+		}
 
-	if (speed)
-		host_set_baudrate(hu, speed);
+		/* Enable flow control */
+		hci_uart_set_flow_control(hu, false);
+		/*  wait until flow control settled */
+		mdelay(100);
+		bt_dev_info(hdev, "wcn3990 Patch Version Request");
+		ret = rome_patch_ver_req(hdev, &soc_ver);
+		if (ret < 0 || soc_ver == 0) {
+			BT_ERR("%s: Failed to get version 0x%x", hdev->name,
+				ret);
+			return ret;
+		}
 
-	/* Setup user speed if needed */
-	speed = 0;
-	if (hu->oper_speed)
-		speed = hu->oper_speed;
-	else if (hu->proto->oper_speed)
-		speed = hu->proto->oper_speed;
+		bt_dev_info(hdev, "wcn3990 controller version 0x%08x", soc_ver);
+
+		/* clear flow control */
+		hci_uart_set_flow_control(hu, true);
+		/* set operating speed */
+		speed = 0;
+		if (hu->oper_speed)
+			speed = hu->oper_speed;
+		else if (hu->proto->oper_speed)
+			speed = hu->proto->oper_speed;
+		if (speed) {
+			qca_baudrate = qca_get_baudrate_value(speed);
+			bt_dev_info(hdev, "Set UART speed to %d", speed);
+			ret = qca_set_baudrate(hdev, qca_baudrate);
+			if (ret) {
+				BT_ERR("%s:Failed to change the baud rate(%d)",
+					hdev->name, ret);
+				return ret;
+			}
+			if (speed)
+				host_set_baudrate(hu, speed);
+			else {
+				BT_ERR("%s:Error in setting operator speed:%u",
+					hdev->name, speed);
+				return -1;
+			}
+		}
 
-	if (speed) {
-		qca_baudrate = qca_get_baudrate_value(speed);
+		/* Set flow control */
+		hci_uart_set_flow_control(hu, false);
+		/*Setup patch and  NVM configurations */
+		ret = qca_uart_setup_cherokee(hdev, qca_baudrate, &soc_ver);
+		if (!ret) {
+			set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+			qca_debugfs_init(hdev);
+		} else if (ret == -ENOENT) {
+			/* No patch/nvm-config found, run with original
+			 * fw/config.
+			 */
+			ret = 0;
+		} else if (ret == -EAGAIN) {
+			/*
+			 * Userspace firmware loader will return -EAGAIN in
+			 * case no patch/nvm-config is found, so run with
+			 * original fw/config.
+			 */
+			ret = 0;
+		}
 
-		bt_dev_info(hdev, "Set UART speed to %d", speed);
-		ret = qca_set_baudrate(hdev, qca_baudrate);
-		if (ret) {
-			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
-				   ret);
+		/* Setup wcn3990 bdaddr */
+		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
+
+		return ret;
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
+					   ret);
 			return ret;
+			}
+			host_set_baudrate(hu, speed);
 		}
-		host_set_baudrate(hu, speed);
-	}
 
-	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup_rome(hdev, qca_baudrate);
-	if (!ret) {
-		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
-		qca_debugfs_init(hdev);
-	} else if (ret == -ENOENT) {
-		/* No patch/nvm-config found, run with original fw/config */
-		ret = 0;
-	} else if (ret == -EAGAIN) {
-		/*
-		 * Userspace firmware loader will return -EAGAIN in case no
-		 * patch/nvm-config is found, so run with original fw/config.
-		 */
-		ret = 0;
-	}
+		/* Setup patch / NVM configurations */
+		ret = qca_uart_setup_rome(hdev, qca_baudrate);
+		if (!ret) {
+			set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+			qca_debugfs_init(hdev);
+		} else if (ret == -ENOENT) {
+			/* No patch/nvm-config found, run with original
+			 * fw/config
+			 */
+			ret = 0;
+		} else if (ret == -EAGAIN) {
+			/*
+			 * Userspace firmware loader will return -EAGAIN in
+			 * case no patch/nvm-config is found, so run with
+			 * original fw/config.
+			 */
+			ret = 0;
+		}
 
-	/* Setup bdaddr */
-	hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
+		/* Setup bdaddr */
+		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
 
-	return ret;
+		return ret;
+	}
 }
 
 static struct hci_uart_proto qca_proto = {
@@ -1002,44 +1279,174 @@ static int qca_setup(struct hci_uart *hu)
 	.dequeue	= qca_dequeue,
 };
 
+static const struct btqca_vreg_data cherokee_data = {
+	.soc_type = BTQCA_CHEROKEE,
+	.vregs = (struct btqca_vreg []) {
+		{ "vddio",   1352000, 1352000,  0 },
+		{ "vddxtal", 1904000, 2040000,  0 },
+		{ "vddcore", 1800000, 1800000,  1 },
+		{ "vddpa",   130400,  1304000,  1 },
+		{ "vddldo",  3000000, 3312000,  1 },
+	},
+	.num_vregs = 5,
+};
+
+void btqca_disable_regulators(int reg_nu, struct btqca_vreg *vregs)
+{
+	/* disable the regulator if requested by user
+	 * or when fault in any regulator.
+	 */
+	for (reg_nu = reg_nu - 1; reg_nu >= 0 ; reg_nu--) {
+		regulator_disable(qca->vreg_bulk[reg_nu].consumer);
+		regulator_set_voltage(qca->vreg_bulk[reg_nu].consumer, 0,
+				      vregs[reg_nu].max_v);
+		if (vregs[reg_nu].load_ua)
+			regulator_set_load(qca->vreg_bulk[reg_nu].consumer, 0);
+	}
+}
+
+int btqca_power_setup(bool on)
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
+	/* turn on if regualtors are off */
+	if (on == true && qca->vreg_status == false) {
+		qca->vreg_status = true;
+		for (i = 0; ret == 0 && i < qca->vreg_data->num_vregs; i++) {
+			regulator_set_voltage(qca->vreg_bulk[i].consumer,
+					      vregs[i].min_v,
+					      vregs[i].max_v);
+
+			if (vregs[i].load_ua)
+				regulator_set_load(qca->vreg_bulk[i].consumer,
+						   vregs[i].load_ua);
+
+			ret = regulator_enable(qca->vreg_bulk[i].consumer);
+	}
+	} else if (on == false && qca->vreg_status == true) {
+		qca->vreg_status = false;
+		/* turn of regualtor in reverse order */
+		btqca_disable_regulators(qca->vreg_data->num_vregs, vregs);
+	}
+
+	/* regulatos fails to enable */
+	if (ret) {
+		qca->vreg_status = false;
+		BT_ERR("failed to enable regualtor:%s", vregs[i].name);
+		/* set regulator voltage and load to zero */
+		regulator_set_voltage(qca->vreg_bulk[i].consumer,
+				      0, vregs[i].max_v);
+		if (vregs[i].load_ua)
+			regulator_set_load(qca->vreg_bulk[i].consumer, 0);
+			/* turn off regulators which are enabled */
+			btqca_disable_regulators(i+1, vregs);
+	}
+
+	return ret;
+}
+
+static int init_regulators(struct btqca_power *qca,
+			   const struct btqca_vreg *vregs,
+			   size_t num_vregs)
+{
+	int i;
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
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
-	int err;
+	const struct btqca_vreg_data *data;
+	int err = 0;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
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
+		qca = kzalloc(sizeof(struct btqca_power), GFP_KERNEL);
+		if (!qca)
+			return -ENOMEM;
+
+		qca->dev = &serdev->dev;
+		qca->vreg_data = data;
+		err = init_regulators(qca, data->vregs, data->num_vregs);
+		if (err) {
+			BT_ERR("Failed to init regualtors:%d", err);
+			kfree(qca);
+			goto out;
+		}
 
-	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
-				       GPIOD_OUT_LOW);
-	if (IS_ERR(qcadev->bt_en)) {
-		dev_err(&serdev->dev, "failed to acquire enable gpio\n");
-		return PTR_ERR(qcadev->bt_en);
-	}
+		/* set voltage regulator status as false */
+		qca->vreg_status = false;
+		/* get operating speed */
+		device_property_read_u32(&serdev->dev, "oper-speed",
+					 &qcadev->oper_speed);
+		device_property_read_u32(&serdev->dev, "init-speed",
+					 &qcadev->init_speed);
+		if (!qcadev->oper_speed)
+			BT_INFO("DTS entry for operating speed is disabled");
+		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+		if (err) {
+			BT_ERR("wcn3990 serdev registration failed");
+			kfree(qca);
+			goto out;
+		}
 
-	qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
-	if (IS_ERR(qcadev->susclk)) {
-		dev_err(&serdev->dev, "failed to acquire clk\n");
-		return PTR_ERR(qcadev->susclk);
-	}
+	} else {
+		qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
+					       GPIOD_OUT_LOW);
+		if (IS_ERR(qcadev->bt_en)) {
+			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+			return PTR_ERR(qcadev->bt_en);
+		}
 
-	err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
-	if (err)
-		return err;
+		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
+		if (IS_ERR(qcadev->susclk)) {
+			dev_err(&serdev->dev, "failed to acquire clk\n");
+			return PTR_ERR(qcadev->susclk);
+		}
 
-	err = clk_prepare_enable(qcadev->susclk);
-	if (err)
-		return err;
+		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
+		if (err)
+			return err;
 
-	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-	if (err)
-		clk_disable_unprepare(qcadev->susclk);
+		err = clk_prepare_enable(qcadev->susclk);
+		if (err)
+			return err;
+
+		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+		if (err)
+			clk_disable_unprepare(qcadev->susclk);
+	}
+
+out:	return err;
 
-	return err;
 }
 
 static void qca_serdev_remove(struct serdev_device *serdev)
@@ -1047,12 +1454,16 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);
-
-	clk_disable_unprepare(qcadev->susclk);
+	if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
+		btqca_power_setup(false);
+		kfree(qca);
+	} else
+		clk_disable_unprepare(qcadev->susclk);
 }
 
 static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
+	{ .compatible = "qcom,wcn3990-bt", .data = &cherokee_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
