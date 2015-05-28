Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 5/6] Bluetooth: hci_uart: Update Broadcom UART setup
Date: Thu, 28 May 2015 11:25:05 +0200
Message-Id: <1432805106-25719-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com>
References: <1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use btbcm helpers to perform controller setup.
Perform host UART reset to init speed between btbcm_patchram() and
btbcm_finalize(). This may be need because firmware loading may have
reseted controller UART to init speed.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1ec0b4a..6c34135 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -79,11 +79,39 @@ static int bcm_flush(struct hci_uart *hu)
 
 static int bcm_setup(struct hci_uart *hu)
 {
+	char fw_name[64];
+	const struct firmware *fw;
+	int err;
+
 	BT_DBG("hu %p", hu);
 
 	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
 
-	return btbcm_setup_patchram(hu->hdev);
+	err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name));
+	if (err)
+		return err;
+
+	err = request_firmware(&fw, fw_name, &hu->hdev->dev);
+	if (err < 0) {
+		BT_INFO("%s: BCM: Patch %s not found", hu->hdev->name, fw_name);
+		return 0;
+	}
+
+	err = btbcm_patchram(hu->hdev, fw);
+	if (err) {
+		BT_INFO("%s: BCM: Patch failed (%d)", hu->hdev->name, err);
+		goto finalize;
+	}
+
+	if (hu->proto->init_speed)
+		hci_uart_set_baudrate(hu, hu->proto->init_speed);
+
+finalize:
+	release_firmware(fw);
+
+	err = btbcm_finalize(hu->hdev);
+
+	return err;
 }
 
 static const struct h4_recv_pkt bcm_recv_pkts[] = {
-- 
1.9.1

