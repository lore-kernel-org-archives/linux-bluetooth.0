Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 08/16] Bluetooth: Fix stop_discovery()
Date: Mon, 11 Jul 2011 18:11:51 -0300
Message-Id: <1310418719-12296-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
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
   MGMT_OP_START_DISCOVERY. The controller didn't send the inquiry
   command status yet therefore the HCI_INQUIRY flag is not set. Thus,
   stop_discovery() will send no inquiry cancel command and the
   discovery procedure won't be stopped. This race is addressed by
   checking for pending MGMT_OP_STOP_DISCOVERY command in inquiry
   command status event handler.

2. While the MGMT_OP_STOP_DISCOVERY is being processed the controller
   sends the inquiry complete event and the HCI_INQUIRY flag is
   cleared. stop_discovery() will add a pending MGMT_OP_STOP_DISCOVERY
   command which won't be removed since there is no ongoing discovery.
   This race is addressed by synchronizing stop_discovery and inquiry
   complete event handler threads.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_event.c        |   10 ++++++++++
 net/bluetooth/mgmt.c             |   25 ++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0ccd724..1ff59f2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -861,6 +861,8 @@ int mgmt_start_discovery_complete(u16 index);
 int mgmt_start_discovery_failed(u16 index, u8 status);
 int mgmt_stop_discovery_complete(u16 index);
 int mgmt_stop_discovery_failed(u16 index, u8 status);
+int mgmt_has_pending_stop_discov(u16 index);
+int mgmt_cancel_discovery(u16 index);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea9e105..c75211c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -963,6 +963,11 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 
 	set_bit(HCI_INQUIRY, &hdev->flags);
 
+	if (mgmt_has_pending_stop_discov(hdev->id)) {
+		mgmt_cancel_discovery(hdev->id);
+		return;
+	}
+
 	mgmt_discovering(hdev->id, 1);
 }
 
@@ -1356,7 +1361,12 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
 	mgmt_discovering(hdev->id, 0);
+
+	hci_dev_lock(hdev);
+
 	mgmt_start_discovery_complete(hdev->id);
+
+	hci_dev_unlock(hdev);
 }
 
 static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e43940e..bbb0daa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1670,6 +1670,21 @@ static int cancel_inquiry(struct hci_dev *hdev)
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 }
 
+int mgmt_cancel_discovery(u16 index)
+{
+	struct hci_dev *hdev;
+	int res = 0;
+
+	hdev = hci_dev_get(index);
+
+	if (test_bit(HCI_INQUIRY, &hdev->flags))
+		res = cancel_inquiry(hdev);
+
+	hci_dev_put(hdev);
+
+	return res;
+}
+
 static int stop_discovery(struct sock *sk, u16 index)
 {
 	struct hci_dev *hdev;
@@ -1701,7 +1716,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	err = cancel_inquiry(hdev);
+	err = mgmt_cancel_discovery(index);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -2393,3 +2408,11 @@ int mgmt_stop_discovery_failed(u16 index, u8 status)
 
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

