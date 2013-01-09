Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: Fix missing command complete for mgmt_load_long_term_keys
Date: Wed,  9 Jan 2013 15:29:34 +0200
Message-Id: <1357738180-4128-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All management events are expected to indicate successful completion
through a command complete event, however  the load long term keys
command was missing this. This patch adds the missing event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3bcb63e..aaf9ce6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2665,7 +2665,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_load_long_term_keys *cp = cp_data;
 	u16 key_count, expected_len;
-	int i;
+	int i, err;
 
 	key_count = __le16_to_cpu(cp->key_count);
 
@@ -2699,9 +2699,12 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			    key->enc_size, key->ediv, key->rand);
 	}
 
+	err = cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS, 0,
+			   NULL, 0);
+
 	hci_dev_unlock(hdev);
 
-	return 0;
+	return err;
 }
 
 static const struct mgmt_handler {
-- 
1.7.10.4

