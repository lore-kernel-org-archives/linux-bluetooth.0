Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: mka@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v2 1/1] Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990
Date: Wed, 19 Sep 2018 20:51:13 +0530
Message-Id: <20180919152113.7611-2-bgodavar@codeaurora.org>
In-Reply-To: <20180919152113.7611-1-bgodavar@codeaurora.org>
References: <20180919152113.7611-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables power off support for hci down and power on support
for hci up. As wcn3990 power sources are ignited by regulators, we will
turn off them during hci down, i.e. an complete power off of wcn3990.
So while hci up, we will call vendor specific open/close and setup which
will turn on the regulators, requests BT chip version and download the
firmware.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 74f5fede0274..c3038afa42af 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -168,6 +168,7 @@ struct qca_serdev {
 
 static int qca_power_setup(struct hci_uart *hu, bool on);
 static void qca_power_shutdown(struct hci_uart *hu);
+static int qca_power_off(struct hci_dev *hdev);
 
 static void __serial_clock_on(struct tty_struct *tty)
 {
@@ -1099,8 +1100,26 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
+	struct qca_serdev *qcadev;
 	int ret;
 
+	/* Check for vregs status, may be hci0 down has turned
+	 * off the vregs.
+	 */
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+	if (qcadev->bt_power->vregs_on == false) {
+		serdev_device_close(hu->serdev);
+		ret = qca_power_setup(hu, true);
+		if (ret)
+			return ret;
+
+		ret = serdev_device_open(hu->serdev);
+		if (ret) {
+			bt_dev_err(hu->hdev, "failed to open port");
+			return ret;
+		}
+	}
+
 	/* Forcefully enable wcn3990 to enter in to boot mode. */
 	host_set_baudrate(hu, 2400);
 	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
@@ -1152,6 +1171,12 @@ static int qca_setup(struct hci_uart *hu)
 
 	if (qcadev->btsoc_type == QCA_WCN3990) {
 		bt_dev_info(hdev, "setting up wcn3990");
+
+		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
+		 * setup for every hci0 up.
+		 */
+		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+		hu->hdev->shutdown = qca_power_off;
 		ret = qca_wcn3990_init(hu);
 		if (ret)
 			return ret;
@@ -1242,6 +1267,14 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	qca_power_setup(hu, false);
 }
 
+static int qca_power_off(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	qca_power_shutdown(hu);
+	return 0;
+}
+
 static int qca_enable_regulator(struct qca_vreg vregs,
 				struct regulator *regulator)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
