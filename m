Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: btusb: Use btbcm_setup_post()
Date: Fri, 10 Apr 2015 15:37:44 +0200
Message-Id: <1428673066-1349-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btusb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de7b236..25d490d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1309,6 +1309,22 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
 	return 0;
 }
 
+#ifdef CONFIG_BT_HCIBTUSB_BCM
+static int btusb_setup_bcm(struct hci_dev *hdev)
+{
+	int err;
+
+	err = btbcm_setup_patchram(hdev);
+	/* If there is no firmware (-ENOENT), discard the error and continue */
+	if (err == -ENOENT)
+		return 0;
+
+	err = btbcm_setup_post(hdev);
+
+	return err;
+}
+#endif
+
 static int btusb_setup_csr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_local_version *rp;
@@ -2730,7 +2746,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 #ifdef CONFIG_BT_HCIBTUSB_BCM
 	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
-		hdev->setup = btbcm_setup_patchram;
+		hdev->setup = btusb_setup_bcm;
 		hdev->set_bdaddr = btbcm_set_bdaddr;
 	}
 
-- 
1.9.1

