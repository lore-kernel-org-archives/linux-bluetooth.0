Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Fix checking for valid device class values
Date: Wed,  9 Jan 2013 15:29:35 +0200
Message-Id: <1357738180-4128-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The two lowest bits of the minor device class value are reserved and
should be zero, and the three highest bits of the major device class
likewise. The management code should therefore test for this and return
a proper "invalid params" error if the condition is not met.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aaf9ce6..2785de2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1430,6 +1430,12 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	if ((cp->minor & 0x03) != 0 || (cp->major & 0xe0) != 0) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				 MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
 
-- 
1.7.10.4

