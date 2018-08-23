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
Subject: [PATCH v1 1/1] Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990
Date: Thu, 23 Aug 2018 16:59:35 +0530
Message-Id: <20180823112935.17342-2-bgodavar@codeaurora.org>
In-Reply-To: <20180823112935.17342-1-bgodavar@codeaurora.org>
References: <20180823112935.17342-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables power off support for hci down and power on support
for hci up. As wcn3990 power sources are ignited by regulators, we will
turn off them during hci down, i.e. an complete power off of wcn3990.
So while hci up, we will call vendor specific open/close and setup which
will turn on the regulators, requests BT chip version and download the
firmware.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e182f6019f68..98d33c6b8909 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -595,6 +595,9 @@ static int qca_close(struct hci_uart *hu)
 	struct qca_serdev *qcadev;
 	struct qca_data *qca = hu->priv;
 
+	if (!qca)
+		return 0;
+
 	BT_DBG("hu %p qca close", hu);
 
 	serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
@@ -1098,6 +1101,32 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 	return 0;
 }
 
+static int hci_uart_open(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	BT_DBG("%s %p", hdev->name, hdev);
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+
+	return qca_open(hu);
+}
+
+static int hci_uart_close(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	BT_DBG("%s %p", hdev->name, hdev);
+
+	/* After this step, we should not allow Tx and Rx work
+	 * function to execute. As we are freeing qca tx and rx
+	 * buffers which may cause kernel crash.
+	 */
+	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+	qca_close(hu);
+
+	return 0;
+}
+
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -1154,6 +1183,11 @@ static int qca_setup(struct hci_uart *hu)
 
 	if (qcadev->btsoc_type == QCA_WCN3990) {
 		bt_dev_info(hdev, "setting up wcn3990");
+
+		hdev->open  = hci_uart_open;
+		hdev->close = hci_uart_close;
+		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+
 		ret = qca_wcn3990_init(hu);
 		if (ret)
 			return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
