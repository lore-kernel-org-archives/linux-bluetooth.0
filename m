Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	robh@kernel.org,
	mka@chromium.org,
	thierry.escande@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v7 5/8] Bluetooth: hci_qca: Defined wrapper functions for setting UART speeds
Date: Sat, 16 Jun 2018 11:57:15 +0530
Message-Id: <20180616062718.29844-6-bgodavar@codeaurora.org>
In-Reply-To: <20180616062718.29844-1-bgodavar@codeaurora.org>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

In qca_setup, we set initial and operating speeds for Qualcomm
Bluetooth SoC's. This block of code is common across different
Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
a wrapper function to set the speeds. So that future coming SoC's
can use these wrapper functions to set speeds.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---

Changes in v7:
	* initial patch
	* created wrapper functions for init and operating speeds.

---
 drivers/bluetooth/hci_qca.c | 64 ++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index fe62420ef838..3e09c6223baf 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -923,21 +923,10 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
-static int qca_setup(struct hci_uart *hu)
+static void qca_set_init_speed(struct hci_uart *hu)
 {
-	struct hci_dev *hdev = hu->hdev;
-	struct qca_data *qca = hu->priv;
-	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
-	int ret;
-	int soc_ver = 0;
-
-	bt_dev_info(hdev, "ROME setup");
-
-	/* Patch downloading has to be done without IBS mode */
-	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	unsigned int speed = 0;
 
-	/* Setup initial baudrate */
-	speed = 0;
 	if (hu->init_speed)
 		speed = hu->init_speed;
 	else if (hu->proto->init_speed)
@@ -945,27 +934,64 @@ static int qca_setup(struct hci_uart *hu)
 
 	if (speed)
 		host_set_baudrate(hu, speed);
+}
+
+static int qca_get_oper_speed(struct hci_uart *hu)
+{
+	unsigned int speed = 0;
 
-	/* Setup user speed if needed */
-	speed = 0;
 	if (hu->oper_speed)
 		speed = hu->oper_speed;
 	else if (hu->proto->oper_speed)
 		speed = hu->proto->oper_speed;
 
+	return speed;
+}
+
+static int qca_set_oper_speed(struct hci_uart *hu)
+{
+	unsigned int speed = 0, qca_baudrate;
+	int ret = 0;
+
+	speed = qca_get_oper_speed(hu);
 	if (speed) {
 		qca_baudrate = qca_get_baudrate_value(speed);
-
-		bt_dev_info(hdev, "Set UART speed to %d", speed);
-		ret = qca_set_baudrate(hdev, qca_baudrate);
+		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
+		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
 		if (ret) {
-			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
+			bt_dev_err(hu->hdev, "Failed to change the baud rate (%d)",
 				   ret);
 			return ret;
 		}
 		host_set_baudrate(hu, speed);
 	}
 
+	return ret;
+}
+
+static int qca_setup(struct hci_uart *hu)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct qca_data *qca = hu->priv;
+	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
+	int ret;
+	int soc_ver = 0;
+
+	bt_dev_info(hdev, "ROME setup");
+
+	/* Patch downloading has to be done without IBS mode */
+	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+
+	/* Setup initial baudrate */
+	qca_set_init_speed(hu);
+	/* Setup user speed if needed */
+	ret = qca_set_oper_speed(hu);
+	if (ret)
+		return ret;
+	speed = qca_get_oper_speed(hu);
+	if (speed)
+		qca_baudrate = qca_get_baudrate_value(speed);
+
 	/* Setup patch / NVM configurations */
 	ret = qca_uart_setup(hdev, qca_baudrate, QCA_ROME, soc_ver);
 	if (!ret) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
