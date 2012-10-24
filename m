Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Fix unnecessary EIR update during powering on
Date: Thu, 25 Oct 2012 00:09:54 +0300
Message-Id: <1351112996-9597-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When powered on the EIR data gets updated as the last step by mgmt.
Therefore avoid an update when getting a local name update as that's
part of the normal HCI init sequence.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03dc176..9fe386f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3523,7 +3523,12 @@ send_event:
 		err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev,
 				 sizeof(ev), cmd ? cmd->sk : NULL);
 
-	update_eir(hdev);
+	/* EIR is taken care of separately when powering on the
+	 * adapter so only update them here if this is a name change
+	 * unrelated to power on.
+	 */
+	if (!test_bit(HCI_INIT, &hdev->flags))
+		update_eir(hdev);
 
 failed:
 	if (cmd)
-- 
1.7.10.4

