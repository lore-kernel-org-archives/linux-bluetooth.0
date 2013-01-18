Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Bluetooth: Fix checking for valid disconnect parameters in unpair_device
Date: Fri, 18 Jan 2013 15:25:56 +0200
Message-Id: <1358515558-17861-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The valid values for the Disconnect parameter in the Unpair Device
command are 0x00 and 0x01. If any other value is encountered the command
should fail with the appropriate invalid params response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3de4bc2..8ec3c4f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1591,6 +1591,11 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 				    MGMT_STATUS_INVALID_PARAMS,
 				    &rp, sizeof(rp));
 
+	if (cp->disconnect != 0x00 && cp->disconnect != 0x01)
+		return cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &rp, sizeof(rp));
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-- 
1.7.10.4

