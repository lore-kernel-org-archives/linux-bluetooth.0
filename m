Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 5/5] Bluetooth: mgmt: Remove unwanted goto statement
Date: Thu, 12 Apr 2012 20:33:21 +0530
Message-id: <1334243001-17016-31-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/mgmt.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4e7a01f..7bb3af8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1247,10 +1247,8 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
 			   &hci_cp);
-	if (err < 0) {
+	if (err < 0)
 		mgmt_pending_remove(cmd);
-		goto unlock;
-	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -1300,10 +1298,8 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_UUID, hdev, data, len);
-	if (!cmd) {
+	if (!cmd)
 		err = -ENOMEM;
-		goto failed;
-	}
 
 failed:
 	hci_dev_unlock(hdev);
@@ -1388,10 +1384,8 @@ update_class:
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_UUID, hdev, data, len);
-	if (!cmd) {
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -1442,10 +1436,8 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DEV_CLASS, hdev, data, len);
-	if (!cmd) {
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
1.7.4.1

