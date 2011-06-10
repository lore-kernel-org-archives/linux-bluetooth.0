Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 06/16] Bluetooth: Fix stop_discovery()
Date: Fri, 10 Jun 2011 16:36:03 -0300
Message-Id: <1307734573-1630-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the Bluetooth spec, the inquiry cancel command should
only be issued after the inquiry command has been issued, a command
status event has been received for the inquiry command, and before
the inquiry complete event occurs.

As HCI_INQUIRY flag is only set just after an inquiry command status
event occurs and it is cleared just after an inquiry complete event
occurs, the inquiry cancel command should be issued only if HCI_INQUIRY
flag is set.

This spec constraint raises two possible race condition we must handle.

1. A MGMT_OP_STOP_DISCOVERY command is issued just after a
   MGMT_OP_START_DISCOVERY. The controller haven't sent the inquiry
   command status yet so the HCI_INQUIRY flag is not set.

2. While the MGMT_OP_STOP_DISCOVERY is being processed the controller
   sends the inquiry complete event and the HCI_INQUIRY flag is
   cleared.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |   15 +++++++++++++--
 net/bluetooth/mgmt.c             |   14 ++++++++++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bfa5f0b..9bfcbb5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -830,6 +830,7 @@ int mgmt_start_discovery_complete(u16 index);
 int mgmt_start_discovery_failed(u16 index);
 int mgmt_stop_discovery_complete(u16 index);
 int mgmt_stop_discovery_failed(u16 index);
+int mgmt_has_pending_stop_discov(u16 index);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0f8126d..540beb7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -882,7 +882,10 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 
 	set_bit(HCI_INQUIRY, &hdev->flags);
 
-	mgmt_discovering(hdev->id, 1);
+	if (mgmt_has_pending_stop_discov(hdev->id))
+		hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+	else
+		mgmt_discovering(hdev->id, 1);
 }
 
 static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
@@ -1269,8 +1272,16 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
+	hci_dev_lock(hdev);
+
 	mgmt_discovering(hdev->id, 0);
-	mgmt_start_discovery_complete(hdev->id);
+
+	if (mgmt_has_pending_stop_discov(hdev->id))
+		mgmt_stop_discovery_complete(hdev->id);
+	else
+		mgmt_start_discovery_complete(hdev->id);
+
+	hci_dev_unlock(hdev);
 }
 
 static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 70c7c77..12b7fcb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1645,7 +1645,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 {
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
-	int err;
+	int err = 0;
 
 	BT_DBG("hci%u", index);
 
@@ -1672,7 +1672,9 @@ static int stop_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+	if (test_bit(HCI_INQUIRY, &hdev->flags))
+		err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -2271,3 +2273,11 @@ int mgmt_stop_discovery_failed(u16 index)
 
 	return err;
 }
+
+int mgmt_has_pending_stop_discov(u16 index)
+{
+	if (mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index))
+		return 1;
+
+	return 0;
+}
-- 
1.7.4.1

