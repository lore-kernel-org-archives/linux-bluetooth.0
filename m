Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix hci_connect error return values
Date: Sun, 19 Feb 2012 14:11:03 +0200
Message-Id: <1329653463-29799-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_connect function should either return a valid hci_conn pointer
or a ERR_PTR() but never NULL. This patch fixes the two places where
hci_conn_add failures would have caused a NULL return. The only reason
for failure with hci_conn_add is memory allocation so ENOMEM seems to be
a good choice here.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7ee6895..8549d04 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -551,7 +551,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst);
 		if (!acl)
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 	}
 
 	hci_conn_hold(acl);
@@ -571,7 +571,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		sco = hci_conn_add(hdev, type, dst);
 		if (!sco) {
 			hci_conn_put(acl);
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 		}
 	}
 
-- 
1.7.9

