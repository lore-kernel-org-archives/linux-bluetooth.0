Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 42/49] Bluetooth: Set SMP OOB flag if OOB data is available
Date: Wed,  3 Dec 2014 17:02:36 +0200
Message-Id: <1417618963-18010-43-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we have OOB data available for the remote device in question we
should set the OOB flag appropriately in the SMP pairing request or
response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3a4579b3ab06..a38541d079f5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -57,6 +57,7 @@ enum {
 	SMP_FLAG_DEBUG_KEY,
 	SMP_FLAG_WAIT_USER,
 	SMP_FLAG_DHKEY_PENDING,
+	SMP_FLAG_OOB,
 };
 
 struct smp_chan {
@@ -562,7 +563,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
-	u8 local_dist = 0, remote_dist = 0;
+	u8 local_dist = 0, remote_dist = 0, oob_flag = SMP_OOB_NOT_PRESENT;
 
 	if (test_bit(HCI_BONDABLE, &conn->hcon->hdev->dev_flags)) {
 		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
@@ -578,19 +579,37 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
 		local_dist |= SMP_DIST_ID_KEY;
 
-	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
-		if ((authreq & SMP_AUTH_SC) &&
-		    test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
+	    (authreq & SMP_AUTH_SC)) {
+		struct oob_data *oob_data;
+		u8 bdaddr_type;
+
+		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 			local_dist |= SMP_DIST_LINK_KEY;
 			remote_dist |= SMP_DIST_LINK_KEY;
 		}
+
+		if (hcon->dst_type == ADDR_LE_DEV_PUBLIC)
+			bdaddr_type = BDADDR_LE_PUBLIC;
+		else
+			bdaddr_type = BDADDR_LE_RANDOM;
+
+		oob_data = hci_find_remote_oob_data(hdev, &hcon->dst,
+						    bdaddr_type);
+		if (oob_data) {
+			set_bit(SMP_FLAG_OOB, &smp->flags);
+			oob_flag = SMP_OOB_PRESENT;
+			memcpy(smp->rrnd, oob_data->rand256, 16);
+			memcpy(smp->pcnf, oob_data->hash256, 16);
+		}
+
 	} else {
 		authreq &= ~SMP_AUTH_SC;
 	}
 
 	if (rsp == NULL) {
 		req->io_capability = conn->hcon->io_capability;
-		req->oob_flag = SMP_OOB_NOT_PRESENT;
+		req->oob_flag = oob_flag;
 		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
 		req->init_key_dist = local_dist;
 		req->resp_key_dist = remote_dist;
@@ -601,7 +620,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	}
 
 	rsp->io_capability = conn->hcon->io_capability;
-	rsp->oob_flag = SMP_OOB_NOT_PRESENT;
+	rsp->oob_flag = oob_flag;
 	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
 	rsp->init_key_dist = req->init_key_dist & remote_dist;
 	rsp->resp_key_dist = req->resp_key_dist & local_dist;
-- 
2.1.0

