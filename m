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
Subject: [PATCH v1 1/2] Bluetooth: hci_qca: Remove serdev_device_open/close function calls
Date: Wed, 22 Aug 2018 17:50:04 +0530
Message-Id: <20180822122005.11218-2-bgodavar@codeaurora.org>
In-Reply-To: <20180822122005.11218-1-bgodavar@codeaurora.org>
References: <20180822122005.11218-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Removed serdev_device_open/close functions from qca_open/close as
they are called in hci_uart_register_device() and
hci_uart_unregister_device() functions.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e182f6019f68..a740d5703914 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -499,7 +499,6 @@ static int qca_open(struct hci_uart *hu)
 	hu->priv = qca;
 
 	if (hu->serdev) {
-		serdev_device_open(hu->serdev);
 
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->btsoc_type != QCA_WCN3990) {
@@ -613,7 +612,6 @@ static int qca_close(struct hci_uart *hu)
 		else
 			gpiod_set_value_cansleep(qcadev->bt_en, 0);
 
-		serdev_device_close(hu->serdev);
 	}
 
 	kfree_skb(qca->rx_skb);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
