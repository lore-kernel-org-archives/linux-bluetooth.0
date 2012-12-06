Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 3/3 v1] Bluetooth: Fix stop discovery while in STARTING state
Date: Thu, 06 Dec 2012 16:35:58 +0530
Message-id: <1354791958-28334-4-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1354791958-28334-1-git-send-email-jaganath.k@samsung.com>
References: <1354791958-28334-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If stop_discovery() is called when discovery state is STARTING, it
will be failed currently. This patch fixes this.

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    9 ++++++++-
 net/bluetooth/hci_event.c        |   15 +++++++++++++--
 net/bluetooth/mgmt.c             |    9 +++++++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bd63a9f..d09777a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -64,6 +64,7 @@ struct discovery_state {
 		DISCOVERY_RESOLVING,
 		DISCOVERY_STOPPING,
 	} state;
+	int prev_state;
 	struct list_head	all;	/* All devices found during inquiry */
 	struct list_head	unknown;	/* Name state not known */
 	struct list_head	resolve;	/* Name needs to be resolved */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c6c67b2..93d0261 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -391,7 +391,13 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
-		if (hdev->discovery.state != DISCOVERY_STARTING)
+		if (hdev->discovery.state == DISCOVERY_STARTING)
+			break;
+
+		if (hdev->discovery.state == DISCOVERY_STOPPING &&
+		    hdev->discovery.prev_state == DISCOVERY_STARTING)
+			mgmt_stop_discovery_complete(hdev, 0);
+		else
 			mgmt_discovering(hdev, 0);
 		break;
 	case DISCOVERY_STARTING:
@@ -405,6 +411,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 		break;
 	}
 
+	hdev->discovery.prev_state = hdev->discovery.state;
 	hdev->discovery.state = state;
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1fadba5..3f9f317 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1085,6 +1085,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		if (status) {
 			hci_dev_lock(hdev);
 			mgmt_start_discovery_failed(hdev, status);
+			if (hdev->discovery.state == DISCOVERY_STOPPING)
+				mgmt_stop_discovery_complete(hdev, status);
 			hci_dev_unlock(hdev);
 			return;
 		}
@@ -1092,7 +1094,10 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		hci_dev_lock(hdev);
-		hci_discovery_set_state(hdev, DISCOVERY_FINDING);
+		if (hdev->discovery.state == DISCOVERY_STOPPING)
+			hci_cancel_le_scan(hdev);
+		else
+			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		hci_dev_unlock(hdev);
 		break;
 
@@ -1180,8 +1185,11 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
 		hci_dev_lock(hdev);
-		if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
 			mgmt_start_discovery_failed(hdev, status);
+			if (hdev->discovery.state == DISCOVERY_STOPPING)
+				mgmt_stop_discovery_complete(hdev, status);
+		}
 		hci_dev_unlock(hdev);
 		return;
 	}
@@ -1189,6 +1197,9 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	set_bit(HCI_INQUIRY, &hdev->flags);
 
 	hci_dev_lock(hdev);
+	if (hdev->discovery.state == DISCOVERY_STOPPING)
+		hci_cancel_inquiry(hdev);
+	else
 	hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 332152b..a645494 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2387,6 +2387,11 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	if (hdev->discovery.state == DISCOVERY_STARTING) {
+		err = 0;
+		goto proceed;
+	}
+
 	if (!hci_discovery_active(hdev)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
 				   MGMT_STATUS_REJECTED, &mgmt_cp->type,
@@ -2401,6 +2406,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+proceed:
 	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
@@ -2435,6 +2441,9 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		break;
 
+	case DISCOVERY_STARTING:
+		break;
+
 	default:
 		BT_DBG("unknown discovery state %u", hdev->discovery.state);
 		err = -EFAULT;
-- 
1.7.9.5

