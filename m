Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/4] Bluetooth: Merge INQUIRY and LE_SCAN discovery states
Date: Thu, 16 Feb 2012 18:50:40 -0300
Message-Id: <1329429041-30715-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch merges DISCOVERY_INQUIRY and DISCOVERY_LE_SCAN states
into a new state called DISCOVERY_FINDING.

>From the discovery perspective, we are pretty much worried about
to know just if we are finding devices than what exactly phase of
"finding devices" (inquiry or LE scan) we are currently running.
Besides, to know if the controller is performing inquiry or LE scan
we should check HCI_INQUIRY or HCI_LE_SCAN bits in hdev flags.

Moreover, merging this two states will simplify the discovery state
machine and will keep interleaved discovery implementation simpler.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    3 +--
 net/bluetooth/hci_core.c         |    6 ++----
 net/bluetooth/hci_event.c        |    6 +++---
 net/bluetooth/mgmt.c             |    2 +-
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3a62f93..ee4dba5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -65,8 +65,7 @@ struct discovery_state {
 	enum {
 		DISCOVERY_STOPPED,
 		DISCOVERY_STARTING,
-		DISCOVERY_INQUIRY,
-		DISCOVERY_LE_SCAN,
+		DISCOVERY_FINDING,
 		DISCOVERY_RESOLVING,
 		DISCOVERY_STOPPING,
 	} state;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 29a9b01..fabca08 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -361,8 +361,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
 	struct discovery_state *discov = &hdev->discovery;
 
 	switch (discov->state) {
-	case DISCOVERY_INQUIRY:
-	case DISCOVERY_LE_SCAN:
+	case DISCOVERY_FINDING:
 	case DISCOVERY_RESOLVING:
 		return true;
 
@@ -387,8 +386,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 		break;
 	case DISCOVERY_STARTING:
 		break;
-	case DISCOVERY_INQUIRY:
-	case DISCOVERY_LE_SCAN:
+	case DISCOVERY_FINDING:
 		mgmt_discovering(hdev, 1);
 		break;
 	case DISCOVERY_RESOLVING:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b0784ee..d68e4cc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1073,7 +1073,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_LE_SCAN);
+		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		hci_dev_unlock(hdev);
 		break;
 
@@ -1152,7 +1152,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	set_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_dev_lock(hdev);
-	hci_discovery_set_state(hdev, DISCOVERY_INQUIRY);
+	hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 	hci_dev_unlock(hdev);
 }
 
@@ -1638,7 +1638,7 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	hci_dev_lock(hdev);
 
-	if (discov->state != DISCOVERY_INQUIRY)
+	if (discov->state != DISCOVERY_FINDING)
 		goto unlock;
 
 	if (list_empty(&discov->resolve)) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e71564e..7165d66 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2130,7 +2130,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 		goto unlock;
 	}
 
-	if (hdev->discovery.state == DISCOVERY_INQUIRY) {
+	if (hdev->discovery.state == DISCOVERY_FINDING) {
 		err = hci_cancel_inquiry(hdev);
 		if (err < 0)
 			mgmt_pending_remove(cmd);
-- 
1.7.9.1

