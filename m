Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/8] Bluetooth: Add function for generating LE SC out-of-band data
Date: Mon, 16 Mar 2015 01:10:22 -0700
Message-Id: <1426493425-7427-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a smp_generate_oob function that allows to create
local out-of-band data that can be used for pairing and also provides
the confirmation and random value.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/smp.h |  1 +
 2 files changed, 54 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 12e9c833885b..1669e7127e2e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -74,6 +74,12 @@ enum {
 };
 
 struct smp_dev {
+	/* Secure Connections OOB data */
+	u8			local_pk[64];
+	u8			local_sk[32];
+	u8			local_rr[16];
+	bool			debug_key;
+
 	struct crypto_blkcipher	*tfm_aes;
 	struct crypto_hash	*tfm_cmac;
 };
@@ -526,6 +532,53 @@ int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa)
 	return 0;
 }
 
+int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16])
+{
+	struct l2cap_chan *chan = hdev->smp_data;
+	struct smp_dev *smp;
+	int err;
+
+	if (!chan || !chan->data)
+		return -EOPNOTSUPP;
+
+	smp = chan->data;
+
+	if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS)) {
+		BT_DBG("Using debug keys");
+		memcpy(smp->local_pk, debug_pk, 64);
+		memcpy(smp->local_sk, debug_sk, 32);
+		smp->debug_key = true;
+	} else {
+		while (true) {
+			/* Generate local key pair for Secure Connections */
+			if (!ecc_make_key(smp->local_pk, smp->local_sk))
+				return -EIO;
+
+			/* This is unlikely, but we need to check that
+			 * we didn't accidentially generate a debug key.
+			 */
+			if (memcmp(smp->local_sk, debug_sk, 32))
+				break;
+		}
+		smp->debug_key = false;
+	}
+
+	SMP_DBG("OOB Public Key X: %32phN", smp->local_pk);
+	SMP_DBG("OOB Public Key Y: %32phN", smp->local_pk + 32);
+	SMP_DBG("OOB Private Key:  %32phN", smp->local_sk);
+
+	get_random_bytes(smp->local_rr, 16);
+
+	err = smp_f4(smp->tfm_cmac, smp->local_pk, smp->local_pk,
+		     smp->local_rr, 0, hash);
+	if (err < 0)
+		return err;
+
+	memcpy(rand, smp->local_rr, 16);
+
+	return 0;
+}
+
 static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 {
 	struct l2cap_chan *chan = conn->smp;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 60c5b73fcb4b..6cf872563ea7 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -188,6 +188,7 @@ int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 		     const bdaddr_t *bdaddr);
 int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
+int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16]);
 
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);
-- 
2.1.0

