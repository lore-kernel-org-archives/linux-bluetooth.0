Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 07/15] Bluetooth: Handle race condition in Discovery
Date: Wed,  5 Oct 2011 20:20:39 -0300
Message-Id: <1317856847-28167-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If MGMT_OP_STOP_DISCOVERY command is issued before the kernel
receives the HCI Inquiry Command Status Event from the controller
then that command will fail and the discovery procedure won't be
stopped. This situation may occur if a MGMT_OP_STOP_DISCOVERY
command is issued just after a MGMT_OP_START_DISCOVERY.

This race condition can be handled by checking for pending
MGMT_OP_STOP_DISCOVERY command in inquiry command status event
handler. If we have a pending MGMT_OP_STOP_DISCOVERY command we
cancel the ongoing discovery.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    3 +++
 net/bluetooth/mgmt.c             |   14 +++++++++++++-
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4a79a50..36e15cc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -876,6 +876,7 @@ int mgmt_discovering(u16 index, u8 discovering);
 int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
 int mgmt_discovery_complete(u16 index, u8 status);
+int mgmt_has_pending_stop_discov(u16 index);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1d890e1..08f7712 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -962,6 +962,9 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	set_bit(HCI_INQUIRY, &hdev->flags);
 
 	mgmt_discovering(hdev->id, 1);
+
+	if (mgmt_has_pending_stop_discov(hdev->id))
+		hci_cancel_inquiry(hdev);
 }
 
 static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d84f242..58cf33a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1674,7 +1674,11 @@ static int stop_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	err = hci_cancel_inquiry(hdev);
+	if (test_bit(HCI_INQUIRY, &hdev->flags))
+		err = hci_cancel_inquiry(hdev);
+	else
+		err = 0;
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -2419,3 +2423,11 @@ int mgmt_discovery_complete(u16 index, u8 status)
 
 	return 0;
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
1.7.5.2

