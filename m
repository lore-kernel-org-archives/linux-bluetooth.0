Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 4/5] Bluetooth: hci_uart: Update Broadcom UART setup
Date: Wed, 20 May 2015 17:46:09 +0200
Message-Id: <1432136770-13328-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
References: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use btbcm helpers to perform controller setup.
Perform host UART reset to init speed between btbcm_patchram() and
btbcm_finalize(). This may be need because firmware loading may have
reseted controller UART to init speed.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1ec0b4a..cede445 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -79,11 +79,28 @@ static int bcm_flush(struct hci_uart *hu)
 
 static int bcm_setup(struct hci_uart *hu)
 {
+	char fw_name[64];
+	int err;
+
 	BT_DBG("hu %p", hu);
 
 	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
 
-	return btbcm_setup_patchram(hu->hdev);
+	err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name));
+	if (err)
+		return err;
+
+	err = btbcm_patchram(hu->hdev, fw_name);
+	/* If there is no firmware (-ENOENT), discard the error and continue */
+	if (err == -ENOENT)
+		return 0;
+
+	if (hu->proto->init_speed)
+		hci_uart_set_baudrate(hu, hu->proto->init_speed);
+
+	err = btbcm_finalize(hu->hdev);
+
+	return err;
 }
 
 static const struct h4_recv_pkt bcm_recv_pkts[] = {
-- 
1.9.1

