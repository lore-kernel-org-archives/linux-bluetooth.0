Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] Bluetooth: mgmt: Fix set_local_name and set_dev_class powered checks
Date: Tue, 21 Feb 2012 17:59:58 +0200
Message-Id: <1329840005-4977-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Both the Set Local Name and the Set Device Class commands should fail if
the adapter is not powered on.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c27481c..03a1384 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1272,6 +1272,12 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	if (!hdev_is_powered(hdev)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS,
+						MGMT_STATUS_NOT_POWERED);
+		goto unlock;
+	}
+
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
 
@@ -1288,6 +1294,7 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, 0,
 								NULL, 0);
 
+unlock:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
@@ -2076,6 +2083,12 @@ static int set_local_name(struct sock *sk, u16 index, void *data,
 
 	hci_dev_lock(hdev);
 
+	if (!hdev_is_powered(hdev)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME,
+						MGMT_STATUS_NOT_POWERED);
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, hdev, data,
 									len);
 	if (!cmd) {
-- 
1.7.9

