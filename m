Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Fix setting local name to the existing value
Date: Thu, 28 Feb 2013 14:23:15 +0200
Message-Id: <1362054195-18919-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362054195-18919-1-git-send-email-johan.hedberg@gmail.com>
References: <1362054195-18919-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If user space attempts to set the local name to the same value that's
already set we should simply return a direct command complete for this
mgmt command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b704148..9ea0505 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2382,6 +2382,17 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	/* If the old values are the same as the new ones just return a
+	 * direct command complete event.
+	 */
+	if (!memcmp(hdev->dev_name, cp->name, sizeof(hdev->dev_name)) &&
+	    !memcmp(hdev->short_name, cp->short_name,
+		    sizeof(hdev->short_name))) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
+				   data, len);
+		goto failed;
+	}
+
 	memcpy(hdev->short_name, cp->short_name, sizeof(hdev->short_name));
 
 	if (!hdev_is_powered(hdev)) {
-- 
1.7.10.4

