Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] Bluetooth: Refactor valid LTK data testing into its own function
Date: Fri, 18 Jan 2013 15:25:52 +0200
Message-Id: <1358515558-17861-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch refactors valid LTK data testing into its own function. This
will help keep the code readable since there are several tests still
missing that need to be done on the LTK data.
---
 net/bluetooth/mgmt.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5388151..3634907 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2701,6 +2701,13 @@ done:
 	return err;
 }
 
+static bool ltk_is_valid(struct mgmt_ltk_info *key)
+{
+	if (key->master != 0x00 && key->master != 0x01)
+		return false;
+	return true;
+}
+
 static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			       void *cp_data, u16 len)
 {
@@ -2729,7 +2736,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type;
 
-		if (key->master != 0x00 && key->master != 0x01) {
+		if (!ltk_is_valid(key)) {
 			hci_smp_ltks_clear(hdev);
 			err = cmd_status(sk, hdev->id,
 					 MGMT_OP_LOAD_LONG_TERM_KEYS,
-- 
1.7.10.4

