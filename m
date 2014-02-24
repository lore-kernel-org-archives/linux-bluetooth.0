Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Add convenience function for getting total connection count
Date: Mon, 24 Feb 2014 14:52:16 +0200
Message-Id: <1393246342-27980-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
References: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a convenience function to return the number of
connections in the conn_hash list. This will be useful once we update
the power off procedure to disconnect any open connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fb3b677ff8a6..d2d756753714 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -561,6 +561,13 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	}
 }
 
+static inline unsigned int hci_conn_count(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *c = &hdev->conn_hash;
+
+	return c->acl_num + c->amp_num + c->sco_num + c->le_num;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 								__u16 handle)
 {
-- 
1.8.5.3

