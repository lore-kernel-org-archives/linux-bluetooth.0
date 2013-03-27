Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Fix hci_inquiry
Date: Wed, 27 Mar 2013 20:04:56 -0300
Message-Id: <1364425497-30944-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
References: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the HCI request framework was properly fixed, the hci_req_sync
call, in hci_inquiry, will return as soon as the HCI command completes
(not the Inquiry procedure). However, in inquiry ioctl implementation,
we want to sleep the user process until the inquiry procedure finishes.

This patch changes hci_inquiry so, in case the HCI Inquiry command
was executed successfully, it waits the HCI_INQUIRY flag to be cleared.
This way, the user process will sleep until the inquiry procedure
finishes.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c  | 13 +++++++++++++
 net/bluetooth/hci_event.c |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cfcad54..1239929 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -818,6 +818,12 @@ static void hci_inq_req(struct hci_request *req, unsigned long opt)
 	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
 }
 
+static int wait_inquiry(void *word)
+{
+	schedule();
+	return signal_pending(current);
+}
+
 int hci_inquiry(void __user *arg)
 {
 	__u8 __user *ptr = arg;
@@ -849,6 +855,13 @@ int hci_inquiry(void __user *arg)
 				   timeo);
 		if (err < 0)
 			goto done;
+
+		/* Wait until Inquiry procedure finishes (HCI_INQUIRY flag is
+		 * cleared). If it is interrupted by a signal, return -EINTR.
+		 */
+		if (wait_on_bit(&hdev->flags, HCI_INQUIRY, wait_inquiry,
+				TASK_INTERRUPTIBLE))
+			return -EINTR;
 	}
 
 	/* for unlimited number of responses we will use buffer with
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8efb9c0..7e7fbca 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -48,6 +48,8 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
+	smp_mb__after_clear_bit(); /* wake_up_bit advises about this barrier */
+	wake_up_bit(&hdev->flags, HCI_INQUIRY);
 
 	hci_dev_lock(hdev);
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -1603,6 +1605,9 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
+	smp_mb__after_clear_bit(); /* wake_up_bit advises about this barrier */
+	wake_up_bit(&hdev->flags, HCI_INQUIRY);
+
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		return;
 
-- 
1.8.1.2

