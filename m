Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Track local vs remote OOB data availability
Date: Mon, 16 Mar 2015 11:45:44 +0200
Message-Id: <1426499146-11959-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
References: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several decisions in the SMP logic that depend not only on
whether we're doing SMP or not, but also whether local and/or remote OOB
data is present. This patch splits the existing SMP_FLAG_OOB into two
new flags to track local and remote OOB data respectively.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1cc15de6ff1e..c8382f4fcd5c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -70,7 +70,8 @@ enum {
 	SMP_FLAG_DEBUG_KEY,
 	SMP_FLAG_WAIT_USER,
 	SMP_FLAG_DHKEY_PENDING,
-	SMP_FLAG_OOB,
+	SMP_FLAG_REMOTE_OOB,
+	SMP_FLAG_LOCAL_OOB,
 };
 
 struct smp_dev {
@@ -680,7 +681,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		oob_data = hci_find_remote_oob_data(hdev, &hcon->dst,
 						    bdaddr_type);
 		if (oob_data && oob_data->present) {
-			set_bit(SMP_FLAG_OOB, &smp->flags);
+			set_bit(SMP_FLAG_REMOTE_OOB, &smp->flags);
 			oob_flag = SMP_OOB_PRESENT;
 			memcpy(smp->rr, oob_data->rand256, 16);
 			memcpy(smp->pcnf, oob_data->hash256, 16);
@@ -1820,7 +1821,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 
 	BT_DBG("");
 
-	if (test_bit(SMP_FLAG_OOB, &smp->flags)) {
+	if (test_bit(SMP_FLAG_LOCAL_OOB, &smp->flags)) {
 		struct l2cap_chan *chan = hdev->smp_data;
 		struct smp_dev *smp_dev;
 
@@ -2453,7 +2454,8 @@ static u8 sc_select_method(struct smp_chan *smp)
 	struct smp_cmd_pairing *local, *remote;
 	u8 local_mitm, remote_mitm, local_io, remote_io, method;
 
-	if (test_bit(SMP_FLAG_OOB, &smp->flags))
+	if (test_bit(SMP_FLAG_REMOTE_OOB, &smp->flags) ||
+	    test_bit(SMP_FLAG_LOCAL_OOB, &smp->flags))
 		return REQ_OOB;
 
 	/* The preq/prsp contain the raw Pairing Request/Response PDUs
-- 
2.1.0

