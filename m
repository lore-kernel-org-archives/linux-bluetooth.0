Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unnecessary use of hci_dev_list_lock
Date: Fri, 20 May 2011 11:50:41 -0700
Message-Id: <1305917441-26680-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The get_connections function has no need to use hci_dev_list_lock. The
code was there probably because of a copy-paste mistake.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dae382c..fe835b8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1092,8 +1092,6 @@ static int get_connections(struct sock *sk, u16 index)
 
 	put_unaligned_le16(count, &rp->conn_count);
 
-	read_lock(&hci_dev_list_lock);
-
 	i = 0;
 	list_for_each(p, &hdev->conn_hash.list) {
 		struct hci_conn *c = list_entry(p, struct hci_conn, list);
@@ -1101,8 +1099,6 @@ static int get_connections(struct sock *sk, u16 index)
 		bacpy(&rp->conn[i++], &c->dst);
 	}
 
-	read_unlock(&hci_dev_list_lock);
-
 	err = cmd_complete(sk, index, MGMT_OP_GET_CONNECTIONS, rp, rp_len);
 
 unlock:
-- 
1.7.5.1

