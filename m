Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v2 2/3] Bluetooth: hci_intel: Add Device configuration
Date: Fri,  4 Sep 2015 17:54:35 +0200
Message-Id: <1441382076-7737-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1441382076-7737-1-git-send-email-loic.poulain@intel.com>
References: <1441382076-7737-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Apply DDC parameters once controller is in operational mode.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: use fwname instead of additional dedicated buffer

 drivers/bluetooth/hci_intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index b4dc3c5..556d2e6 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -735,6 +735,10 @@ static int intel_setup(struct hci_uart *hu)
 
 	bt_dev_info(hdev, "Found device firmware: %s", fwname);
 
+	/* Save the DDC file name for later */
+	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.ddc",
+		 le16_to_cpu(params->dev_revid));
+
 	kfree_skb(skb);
 
 	if (fw->size < 644) {
@@ -927,6 +931,9 @@ done:
 	set_bit(STATE_LPM_ENABLED, &intel->flags);
 
 no_lpm:
+	/* Ignore ddc error, device can work without DDC parameters */
+	btintel_load_ddc_config(hdev, fwname);
+
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
-- 
1.9.1
