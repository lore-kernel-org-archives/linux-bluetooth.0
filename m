Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH] Bluetooth: Send Discovery Stopped event when discovery fails
Date: Thu, 5 Apr 2012 10:48:49 +0530
Message-ID: <1333603129-18813-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sends MGMT_EV_DISCOVERING event to manamgement interface of
BlueZ to indicate that discovery is stopped in case of discovery failure.
Without this patch discovery session of BlueZ was not getting freed.
This event was not sent from kernel in case discovery state is still
DISCOVERY_STARTING.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/hci_core.c |    2 +-
 net/bluetooth/mgmt.c     |   16 +---------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9629645..b97a7dc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -384,7 +384,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
-		if (hdev->discovery.state != DISCOVERY_STARTING)
+		if (hdev->discovery.state != DISCOVERY_STOPPED)
 			mgmt_discovering(hdev, 0);
 		break;
 	case DISCOVERY_STARTING:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b4f7e32..5a95a7a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3572,23 +3572,9 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 {
-	struct pending_cmd *cmd;
-	u8 type;
-	int err;
-
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
-	if (!cmd)
-		return -ENOENT;
-
-	type = hdev->discovery.type;
-
-	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
-			   &type, sizeof(type));
-	mgmt_pending_remove(cmd);
-
-	return err;
+	return 0;
 }
 
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
-- 
1.7.0.4

