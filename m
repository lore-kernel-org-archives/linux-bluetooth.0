Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Make AES crypto context private to SMP
Date: Fri,  8 Aug 2014 09:37:17 +0300
Message-Id: <1407479838-5652-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that we have per-adapter SMP data thanks to the root SMP L2CAP
channel we can take advantage of it and attach the AES crypto context
(only used for SMP) to it. This means that the smp_irk_matches() and
smp_generate_rpa() function can be converted to internally handle the
AES context.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 13 ++-----------
 net/bluetooth/smp.c              | 41 +++++++++++++++++++++++++++-------------
 net/bluetooth/smp.h              |  5 ++---
 4 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2571fc1cb1c5..5f0b77b71b45 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -302,7 +302,6 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 
-	struct crypto_blkcipher	*tfm_aes;
 	void			*smp_data;
 
 	struct discovery_state	discovery;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 88575a633601..abeb5e47311e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3234,11 +3234,8 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 			return irk;
 	}
 
-	if (!hdev->tfm_aes)
-		return NULL;
-
 	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
-		if (smp_irk_matches(hdev->tfm_aes, irk->val, rpa)) {
+		if (smp_irk_matches(hdev, irk->val, rpa)) {
 			bacpy(&irk->rpa, rpa);
 			return irk;
 		}
@@ -3887,13 +3884,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		    !bacmp(&hdev->random_addr, &hdev->rpa))
 			return 0;
 
-		if (!hdev->tfm_aes) {
-			BT_ERR("%s crypto not available to generate RPA",
-			       hdev->name);
-			return -EOPNOTSUPP;
-		}
-
-		err = smp_generate_rpa(hdev->tfm_aes, hdev->irk, &hdev->rpa);
+		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
 		if (err < 0) {
 			BT_ERR("%s failed to generate new RPA", hdev->name);
 			return err;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2362ae35a4d5..6925fc4caaee 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -139,12 +139,18 @@ static int smp_ah(struct crypto_blkcipher *tfm, u8 irk[16], u8 r[3], u8 res[3])
 	return 0;
 }
 
-bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
-		     bdaddr_t *bdaddr)
+bool smp_irk_matches(struct hci_dev *hdev, u8 irk[16], bdaddr_t *bdaddr)
 {
+	struct l2cap_chan *chan = hdev->smp_data;
+	struct crypto_blkcipher *tfm;
 	u8 hash[3];
 	int err;
 
+	if (!chan || !chan->data)
+		return false;
+
+	tfm = chan->data;
+
 	BT_DBG("RPA %pMR IRK %*phN", bdaddr, 16, irk);
 
 	err = smp_ah(tfm, irk, &bdaddr->b[3], hash);
@@ -154,10 +160,17 @@ bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
 	return !memcmp(bdaddr->b, hash, 3);
 }
 
-int smp_generate_rpa(struct crypto_blkcipher *tfm, u8 irk[16], bdaddr_t *rpa)
+int smp_generate_rpa(struct hci_dev *hdev, u8 irk[16], bdaddr_t *rpa)
 {
+	struct l2cap_chan *chan = hdev->smp_data;
+	struct crypto_blkcipher *tfm;
 	int err;
 
+	if (!chan || !chan->data)
+		return -EOPNOTSUPP;
+
+	tfm = chan->data;
+
 	get_random_bytes(&rpa->b[3], 3);
 
 	rpa->b[5] &= 0x3f;	/* Clear two most significant bits */
@@ -1555,25 +1568,25 @@ static const struct l2cap_ops smp_root_chan_ops = {
 int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
+	struct crypto_blkcipher	*tfm_aes;
 
 	BT_DBG("%s", hdev->name);
 
-	hdev->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0,
-					       CRYPTO_ALG_ASYNC);
-	if (IS_ERR(hdev->tfm_aes)) {
-		int err = PTR_ERR(hdev->tfm_aes);
+	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm_aes)) {
+		int err = PTR_ERR(tfm_aes);
 		BT_ERR("Unable to create crypto context");
-		hdev->tfm_aes = NULL;
 		return err;
 	}
 
 	chan = l2cap_chan_create();
 	if (!chan) {
-		crypto_free_blkcipher(hdev->tfm_aes);
-		hdev->tfm_aes = NULL;
+		crypto_free_blkcipher(tfm_aes);
 		return -ENOMEM;
 	}
 
+	chan->data = tfm_aes;
+
 	/* FIXME: Using reserved 0x1f value for now - to be changed to
 	 * L2CAP_CID_SMP once all functionality is in place.
 	 */
@@ -1596,15 +1609,17 @@ int smp_register(struct hci_dev *hdev)
 void smp_unregister(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan = hdev->smp_data;
+	struct crypto_blkcipher *tfm_aes;
 
 	if (!chan)
 		return;
 
 	BT_DBG("%s chan %p", hdev->name, chan);
 
-	if (hdev->tfm_aes) {
-		crypto_free_blkcipher(hdev->tfm_aes);
-		hdev->tfm_aes = NULL;
+	tfm_aes = chan->data;
+	if (tfm_aes) {
+		chan->data = NULL;
+		crypto_free_blkcipher(tfm_aes);
 	}
 
 	hdev->smp_data = NULL;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 6e29359f60a3..d3f6bd617940 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -132,9 +132,8 @@ int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
 void smp_chan_destroy(struct l2cap_conn *conn);
 
-bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
-		     bdaddr_t *bdaddr);
-int smp_generate_rpa(struct crypto_blkcipher *tfm, u8 irk[16], bdaddr_t *rpa);
+bool smp_irk_matches(struct hci_dev *hdev, u8 irk[16], bdaddr_t *bdaddr);
+int smp_generate_rpa(struct hci_dev *hdev, u8 irk[16], bdaddr_t *rpa);
 
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);
-- 
1.9.3

