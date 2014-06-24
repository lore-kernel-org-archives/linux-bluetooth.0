Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add a new HCI_USE_DEBUG_KEYS flag
Date: Tue, 24 Jun 2014 14:00:27 +0300
Message-Id: <1403607628-30926-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com>
References: <1403607628-30926-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To pave the way for actively using debug keys for pairing this patch
adds a new HCI_USE_DEBUG_KEYS flag for the purpose. When the flag is set
we issue a HCI_Write_SSP_Debug mode whenever HCI_Write_SSP_Mode(0x01)
has been issued as well as before issuing a HCI_Write_SSP_Mode(0x00)
command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/mgmt.c        | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ffb489e3946d..cc2e88dd20ea 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -125,6 +125,7 @@ enum {
 	HCI_PAIRABLE,
 	HCI_SERVICE_CACHE,
 	HCI_KEEP_DEBUG_KEYS,
+	HCI_USE_DEBUG_KEYS,
 	HCI_UNREGISTER,
 	HCI_USER_CHANNEL,
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 747746b0d2c4..69afbb2df133 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1877,6 +1877,10 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
+	if (!cp->val && test_bit(HCI_USE_DEBUG_KEYS, &hdev->dev_flags))
+		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE,
+			     sizeof(cp->val), &cp->val);
+
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, 1, &cp->val);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
@@ -5784,10 +5788,14 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+		if (test_bit(HCI_USE_DEBUG_KEYS, &hdev->dev_flags))
+			hci_req_add(&req, HCI_OP_WRITE_SSP_DEBUG_MODE,
+				    sizeof(enable), &enable);
 		update_eir(&req);
-	else
+	} else {
 		clear_eir(&req);
+	}
 
 	hci_req_run(&req, NULL);
 }
-- 
1.9.3

