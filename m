Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/8] Bluetooth: Create SMP device structure for local crypto context
Date: Mon, 16 Mar 2015 01:10:19 -0700
Message-Id: <1426493425-7427-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Every Bluetooth Low Energy controller requires a local crypto context
to handle the resolvable private addresses. At the moment this is just
a single crypto context, but for out-of-band data generation it will
require an additional. To facility this, create a struct smp_dev that
will hold all the extra information. This patch is just the refactoring
in preparation for future changes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a2be6fcc3c51..952ba6376e1c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -73,6 +73,10 @@ enum {
 	SMP_FLAG_OOB,
 };
 
+struct smp_dev {
+	struct crypto_blkcipher	*tfm_aes;
+};
+
 struct smp_chan {
 	struct l2cap_conn	*conn;
 	struct delayed_work	security_timer;
@@ -478,18 +482,18 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 		     const bdaddr_t *bdaddr)
 {
 	struct l2cap_chan *chan = hdev->smp_data;
-	struct crypto_blkcipher *tfm;
+	struct smp_dev *smp;
 	u8 hash[3];
 	int err;
 
 	if (!chan || !chan->data)
 		return false;
 
-	tfm = chan->data;
+	smp = chan->data;
 
 	BT_DBG("RPA %pMR IRK %*phN", bdaddr, 16, irk);
 
-	err = smp_ah(tfm, irk, &bdaddr->b[3], hash);
+	err = smp_ah(smp->tfm_aes, irk, &bdaddr->b[3], hash);
 	if (err)
 		return false;
 
@@ -499,20 +503,20 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa)
 {
 	struct l2cap_chan *chan = hdev->smp_data;
-	struct crypto_blkcipher *tfm;
+	struct smp_dev *smp;
 	int err;
 
 	if (!chan || !chan->data)
 		return -EOPNOTSUPP;
 
-	tfm = chan->data;
+	smp = chan->data;
 
 	get_random_bytes(&rpa->b[3], 3);
 
 	rpa->b[5] &= 0x3f;	/* Clear two most significant bits */
 	rpa->b[5] |= 0x40;	/* Set second most significant bit */
 
-	err = smp_ah(tfm, irk, &rpa->b[3], rpa->b);
+	err = smp_ah(smp->tfm_aes, irk, &rpa->b[3], rpa->b);
 	if (err < 0)
 		return err;
 
@@ -2930,27 +2934,36 @@ static const struct l2cap_ops smp_root_chan_ops = {
 static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 {
 	struct l2cap_chan *chan;
-	struct crypto_blkcipher	*tfm_aes;
+	struct smp_dev *smp;
+	struct crypto_blkcipher *tfm_aes;
 
 	if (cid == L2CAP_CID_SMP_BREDR) {
-		tfm_aes = NULL;
+		smp = NULL;
 		goto create_chan;
 	}
 
-	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, 0);
+	smp = kzalloc(sizeof(*smp), GFP_KERNEL);
+	if (!smp)
+		return ERR_PTR(-ENOMEM);
+
+	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(tfm_aes)) {
-		BT_ERR("Unable to create crypto context");
+		BT_ERR("Unable to create ECB crypto context");
+		kzfree(smp);
 		return ERR_CAST(tfm_aes);
 	}
 
+	smp->tfm_aes = tfm_aes;
+
 create_chan:
 	chan = l2cap_chan_create();
 	if (!chan) {
-		crypto_free_blkcipher(tfm_aes);
+		crypto_free_blkcipher(smp->tfm_aes);
+		kzfree(smp);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	chan->data = tfm_aes;
+	chan->data = smp;
 
 	l2cap_add_scid(chan, cid);
 
@@ -2983,14 +2996,16 @@ create_chan:
 
 static void smp_del_chan(struct l2cap_chan *chan)
 {
-	struct crypto_blkcipher	*tfm_aes;
+	struct smp_dev *smp;
 
 	BT_DBG("chan %p", chan);
 
-	tfm_aes = chan->data;
-	if (tfm_aes) {
+	smp = chan->data;
+	if (smp) {
 		chan->data = NULL;
-		crypto_free_blkcipher(tfm_aes);
+		if (smp->tfm_aes)
+			crypto_free_blkcipher(smp->tfm_aes);
+		kzfree(smp);
 	}
 
 	l2cap_chan_put(chan);
-- 
2.1.0

