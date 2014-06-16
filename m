Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] Bluetooth: Remove unnecessary SMP STK define
Date: Mon, 16 Jun 2014 19:25:15 +0300
Message-Id: <1402935919-32348-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402935919-32348-1-git-send-email-johan.hedberg@gmail.com>
References: <1402935919-32348-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We never store the "master" type of STKs since we request encryption
directly with them so we only need one STK type (the one that's
looked-up on the slave side). Simply remove the unnecessary define and
rename the _SLAVE one to the shorter form.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 1 -
 net/bluetooth/hci_event.c   | 2 +-
 net/bluetooth/smp.c         | 6 +++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 16587dcd6a91..98f7520d2f57 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -349,7 +349,6 @@ enum {
 #define HCI_LK_AUTH_COMBINATION_P256	0x08
 /* The spec doesn't define types for SMP keys, the _MASTER suffix is implied */
 #define HCI_SMP_STK			0x80
-#define HCI_SMP_STK_SLAVE		0x81
 #define HCI_SMP_LTK			0x82
 #define HCI_SMP_LTK_SLAVE		0x83
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3d52be1d695d..8dde40430b5f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4241,7 +4241,7 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * distribute the keys. Later, security can be re-established
 	 * using a distributed LTK.
 	 */
-	if (ltk->type == HCI_SMP_STK_SLAVE) {
+	if (ltk->type == HCI_SMP_STK) {
 		list_del(&ltk->list);
 		kfree(ltk);
 	}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e779e5298ebf..4fb9f9aa0cea 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -561,8 +561,12 @@ static u8 smp_random(struct smp_chan *smp)
 		else
 			auth = 0;
 
+		/* Even though there's no _SLAVE suffix this is the
+		 * slave STK we're adding for later lookup (the master
+		 * STK never needs to be stored).
+		 */
 		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-			    HCI_SMP_STK_SLAVE, auth, stk, smp->enc_key_size,
+			    HCI_SMP_STK, auth, stk, smp->enc_key_size,
 			    ediv, rand);
 	}
 
-- 
1.9.3

